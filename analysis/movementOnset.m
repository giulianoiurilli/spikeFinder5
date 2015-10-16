load('ADC1.mat');
load('valveOnsets.mat');
load('parameters.mat');




%find inhalation onsets
%[inhal_on, movement] = respirationFilter(ADC, 0.1, 100, 20000); 


newFs = 1000;
n = 4;
movement = downsample(ADC, fs/newFs);

[b,a] = butter(n,[20 100]*2/newFs);

movement = filtfilt(b,a,movement);


move = zeros(n_trials, (pre+post)*newFs, odors);
for idxOdor = 1:odors   %cycles through odors
    for idxTrial = 1:10     %cycles through trials
        startOdor = sec_on_rsp(idxTrial, idxOdor);
        row_move = movement(floor((startOdor - pre)*newFs) : floor((startOdor + post)*newFs));
        row_move1 = row_move(1:(pre+post)*newFs);
        move(idxTrial,:,idxOdor) = row_move1; %- floor(app_sec(i,k)*fs)
    end
end

save('movement.mat', 'move'); 


