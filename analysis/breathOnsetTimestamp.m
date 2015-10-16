
load('ADC0.mat');
load('valveOnsets.mat');
load('parameters.mat');


to_remove = [];

%find inhalation onsets
%ADC = -ADC;
[inhal_on, exhal_on, respiration] = respirationFilter(ADC); 
inhal_on = inhal_on/fs;
exhal_on = exhal_on/fs;
if inhal_on(1) > exhal_on(1)
    in_prec = 0;
else
    in_prec = 1;
end

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
app_on_rsp = inhal_on(idx)';
for i = 1:length(idx)
    dd = dig_supra_thresh(i) - app_on_rsp(i);
    if dd > 0.120
        app_on_rsp(i) = inhal_on(idx(i) + 1);        
        app_off_rsp1(i) = inhal_on(idx(i) + 2);
        app_off_rsp2(i) = inhal_on(idx(i) + 3);
        app_off_rsp3(i) = inhal_on(idx(i) + 4);
        app_on_bsl(i) = inhal_on(idx(i) - 3);
        app_off_bsl1(i) = inhal_on(idx(i) - 2);
        app_off_bsl2(i) = inhal_on(idx(i) - 1);
        app_off_bsl3(i) = inhal_on(idx(i));
    else
        app_on_rsp(i) = inhal_on(idx(i));        
        app_off_rsp1(i) = inhal_on(idx(i) + 1);
        app_off_rsp2(i) = inhal_on(idx(i) + 2);
        app_off_rsp3(i) = inhal_on(idx(i) + 3);
        app_on_bsl(i) = inhal_on(idx(i) - 4);
        app_off_bsl1(i) = inhal_on(idx(i) - 3);
        app_off_bsl2(i) = inhal_on(idx(i) - 2);
        app_off_bsl3(i) = inhal_on(idx(i) - 1);
    end
end
        
%here I try to fix the instances when the respiration signal suddenly fails
%during the recording
delay_on = app_on_rsp - dig_supra_thresh;
bin_delay = 0:0.01:2;
figure; histogram(delay_on, bin_delay)
%if delay_on > max_delay
% delay_on(delay_on > max_delay) = nan;
% n_nan = length(delay_on(isnan(delay_on)));
% delay_on(isnan(delay_on)) = exprnd(nanmean(delay_on), [1, n_nan]); % I assign a random delay chosen from an exponential distribution when the inhalation onset is > of some delay
% figure; histogram(delay_on, bin_delay)
%end
sec_on_rsp = dig_supra_thresh + delay_on;
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

app_del = [delay_on' double(trial_odor)];
app_del = sortrows(app_del, 2);
delay_on = app_del(:,1)';


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
delay_on = reshape(delay_on,n_trials_app,odors);
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