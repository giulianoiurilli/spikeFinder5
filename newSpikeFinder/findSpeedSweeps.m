function findSpeedSweeps(n_odors, n_trials)

currentFolder = pwd;
s = dir('*.mat'); 
filename = char({s(1).name});
load(filename)

thresTTL = 0.5;
samplingFrequency = Fs;
triggerToOnsetDelay = 3;

ttlSignal = data(2,:); 
wheelData = data(3,:);

figureOn = 0;

%% find valve onsets
dig_supra_thresh_app = valve_onset(ttlSignal, thresTTL); 
dig_supra_thresh_app = round(dig_supra_thresh_app./samplingFrequency, 3) + triggerToOnsetDelay; %convert to seconds and add to 3 seconds 
dig_supra_thresh = dig_supra_thresh_app(1:150);
%% find speed
counterNBits = 32;
signedThreshold = 2^(counterNBits-1);
signedData = wheelData;
signedData(signedData > signedThreshold) = signedData(signedData > signedThreshold) - 2^counterNBits;
signedData = -signedData;
circumph = 31.5; %cm
rotaryRes = 1024; %pulses per full cycle

datacm = signedData/rotaryRes * circumph;
distance = datacm(1:200:end);
time = data(1,1:200:end);
app = diff(distance) ./ diff(time);
speed = [0 app];

newSamplingFrequency = 20;

%% re-sort the odor onsets according to odors and trials
cd ..
s = dir('*.asc'); 
filename = char({s.name});
fileID = fopen(filename);
trial_log = textscan(fileID, '%d,%d,%d,%f,%f,%d,%f,%f,%s');
fclose(fileID);
trial_odor = trial_log{3} - 1;

app_dig_supra_thresh = [dig_supra_thresh' double(trial_odor)];
app_dig_supra_thresh = sortrows(app_dig_supra_thresh, 2);
dig_supra_thresh = app_dig_supra_thresh(:,1)';


preOnset = 4;
postOnset = 6;
dig_supra_thresh = reshape(dig_supra_thresh,n_trials,n_odors);

row_speed = zeros(1, (preOnset+postOnset)*newSamplingFrequency);
speedSweeps = zeros(n_trials, (preOnset+postOnset)*newSamplingFrequency, n_odors);

for idxOdor = 1:n_odors   
    for idxTrial = 1:n_trials     
        row_speed = speed(floor((dig_supra_thresh(idxTrial,idxOdor) - preOnset)*newSamplingFrequency) : floor((dig_supra_thresh(idxTrial,idxOdor) + postOnset)*newSamplingFrequency));
        row_speed1 = row_speed(1:(preOnset+postOnset)*newSamplingFrequency);
        speedSweeps(idxTrial,:,idxOdor) = row_speed1; 
    end
end

%%
if figureOn
    
    close all
    
    for idxOdor = 1:n_odors
        figure
        set(gcf,'Position',[125 70 560 735]);
        for idxTrial = 1:n_trials
            subplot(n_trials,1, idxTrial)
            plot(squeeze(speedSweeps(idxTrial,:,idxOdor)))
            ylim([-20 20])
        end
    end
    
end

%

cd(currentFolder)
cd ..
cd('ephys')
save('speed.mat', 'speedSweeps')