
load('ADC0.mat');
load('valveOnsets.mat');
load('parameters.mat');


to_remove = [];

%find inhalation onsets
%ADC = -ADC;
[inhal_on, exhal_on, respiration] = respirationFilter(ADC, fs); 

% transform in seconds
inhal_on = inhal_on/fs;
exhal_on = exhal_on/fs;

% check if the timestamos series starts with an inhalation (in_prec = 1) or
% an exhalation
if inhal_on(1) > exhal_on(1)
    in_prec = 0;
else
    in_prec = 1;
end
%remove false inhalations. When two consecutive inhalations are separated
%by less than 50 ms, take only the biggest inhalation
app_inhal_on = inhal_on;
isi = diff(inhal_on);
refr = find(isi<0.05);
for idxInhal = 1:length(refr)
    if min(respiration(refr(idxInhal)+1:refr(idxInhal)+2)) < min(respiration(refr(idxInhal):refr(idxInhal)+1))
        to_remove = [to_remove refr(idxInhal)];% inhal_on(refr(i)+1) = [];
    else  to_remove = [to_remove refr(idxInhal)+1];
    end
end
inhal_on(to_remove) = [];



interInhalationDelay = diff(inhal_on);
figure; histogram(interInhalationDelay, 20)

app_on_rsp =  [];
app_off_rsp1 = [];
app_off_rsp2 = [];
app_off_rsp3 = [];
app_on_bsl = [];
app_off_bsl1 = [];
app_off_bsl2 = [];
app_off_bsl3 = [];
%find the first inhalation onset after the valve onset + a delay
%[~,idx] = histc(dig_supra_thresh + delay, inhal_on);
[~,idx] = histc(dig_supra_thresh, inhal_on);
app_on_rsp = inhal_on(idx+1)';
for i = 1:length(idx)
    dd = app_on_rsp(i) - dig_supra_thresh(i);
    if dd > 0.100 %delay of the valve onset from the first inhalation; if the inhalation follows the valve by less than 100 ms, take the next inhalation as onset 
        app_on_rsp(i) = inhal_on(idx(i)+1);        
        app_off_rsp1(i) = inhal_on(idx(i) + 2);
        app_off_rsp2(i) = inhal_on(idx(i) + 3);
        app_off_rsp3(i) = inhal_on(idx(i) + 4);
        app_on_bsl(i) = inhal_on(idx(i) - 3);
        app_off_bsl1(i) = inhal_on(idx(i) - 2);
        app_off_bsl2(i) = inhal_on(idx(i) - 1);
        app_off_bsl3(i) = inhal_on(idx(i));
    else
        app_on_rsp(i) = inhal_on(idx(i) + 2);        
        app_off_rsp1(i) = inhal_on(idx(i) + 3);
        app_off_rsp2(i) = inhal_on(idx(i) + 4);
        app_off_rsp3(i) = inhal_on(idx(i) + 5);
        app_on_bsl(i) = inhal_on(idx(i) - 2);
        app_off_bsl1(i) = inhal_on(idx(i) - 1);
        app_off_bsl2(i) = inhal_on(idx(i));
        app_off_bsl3(i) = inhal_on(idx(i) + 1);
    end
end
        
%here I try to fix the instances when the respiration signal suddenly fails
%during the recording
delay_on = app_on_rsp - dig_supra_thresh;
bin_delay = 0:0.01:2;
figure; histogram(delay_on, bin_delay)
%if the inhalation follows the valve by more than the average respiration cycle + 1.5 std than fix the onset as the valve onset + 100 ms 
max_delay = mean(interInhalationDelay) + 1.5*std(interInhalationDelay);
idxMaxExceeded = find((delay_on > max_delay));
app_on_rsp(idxMaxExceeded) = dig_supra_thresh(idxMaxExceeded) + 0.1;
sec_on_rsp = app_on_rsp;
clear idx;


%re-sort the inhalation onsets according to odors and trials

s = dir('*.asc'); 
filename = char({s.name});
%filename = uigetfile('*.asc');
%exp_log = sprintf('%s', filename)
fileID = fopen(filename);
trial_log = textscan(fileID, '%d,%d,%d,%f,%f,%d,%f,%f,%s');
fclose(fileID);
trial_odor = trial_log{3} - 1;

app_on_rsp = [sec_on_rsp' double(trial_odor)];
app_on_rsp = sortrows(app_on_rsp, 2);
sec_on_rsp = app_on_rsp(:,1)';




app_off_rsp1 = [app_off_rsp1' double(trial_odor)];
app_off_rsp1 = sortrows(app_off_rsp1, 2);
sec_off_rsp1 = app_off_rsp1(:,1)';

app_off_rsp2 = [app_off_rsp2' double(trial_odor)];
app_off_rsp2 = sortrows(app_off_rsp2, 2);
sec_off_rsp2 = app_off_rsp2(:,1)';

app_off_rsp3 = [app_off_rsp3' double(trial_odor)];
app_off_rsp3 = sortrows(app_off_rsp3, 2);
sec_off_rsp3 = app_off_rsp3(:,1)';

app_on_bsl = [app_on_bsl' double(trial_odor)];
app_on_bsl = sortrows(app_on_bsl, 2);
sec_on_bsl = app_on_bsl(:,1)';

app_off_bsl1 = [app_off_bsl1' double(trial_odor)];
app_off_bsl1 = sortrows(app_off_bsl1, 2);
sec_off_bsl1 = app_off_bsl1(:,1)';

app_off_bsl2 = [app_off_bsl2' double(trial_odor)];
app_off_bsl2 = sortrows(app_off_bsl2, 2);
sec_off_bsl2 = app_off_bsl2(:,1)';

app_off_bsl3 = [app_off_bsl3' double(trial_odor)];
app_off_bsl3 = sortrows(app_off_bsl3, 2);
sec_off_bsl3 = app_off_bsl3(:,1)';



n_trials_app = floor(length(sec_on_rsp)/odors);
sec_on_rsp = reshape(sec_on_rsp,n_trials_app,odors);

sec_off_rsp{1} = reshape(sec_off_rsp1,n_trials_app,odors);
sec_off_rsp{2} = reshape(sec_off_rsp2,n_trials_app,odors);
sec_off_rsp{3} = reshape(sec_off_rsp3,n_trials_app,odors);
sec_on_bsl = reshape(sec_on_bsl,n_trials_app,odors);
sec_off_bsl{1} = reshape(sec_off_bsl1,n_trials_app,odors);
sec_off_bsl{2} = reshape(sec_off_bsl2,n_trials_app,odors);
sec_off_bsl{3} = reshape(sec_off_bsl3,n_trials_app,odors);




row_breath = zeros(1, (pre+post)*fs);
breath = zeros(n_trials_app, (pre+post)*fs, odors);

for idxOdor = 1:odors   %cycles through odors
    for idxTrial = 1:n_trials_app     %cycles through trials
        row_breath = respiration(floor((sec_on_rsp(idxTrial,idxOdor) - pre)*fs) : floor((sec_on_rsp(idxTrial,idxOdor) + post)*fs));
        row_breath1 = row_breath(1:(pre+post)*fs);
        breath(idxTrial,:,idxOdor) = row_breath1; %- floor(app_sec(i,k)*fs)
        sniffs(idxOdor).trial(idxTrial).sniffPower = findSniffs(row_breath1, pre, fs);
    end
end

% for k = 1:odors
%     X = breath(:,:,k);
%     y = hilbert(X');
%     sigphase(:,:,k) = angle(y);
% end

save('breathing.mat', 'respiration','sec_on_rsp', 'sec_on_bsl', 'sec_off_rsp', 'sec_off_bsl', 'breath', 'interInhalationDelay', 'inhal_on', 'sniffs', 'delay_on'); 