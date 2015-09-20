load('ADC1.mat');
load('valveOnsets.mat');
load('parameters.mat');




%find inhalation onsets
[inhal_on, movement] = respirationFilter(ADC, 0.1, 100, 20000); 


move = zeros(n_trials, (pre+post)*fs, odors);
for k = 1:odors   %cycles through odors
    for i = 1:n_trials     %cycles through trials
        row_move = movement(floor((app_sec(i,k) - pre)*fs) : floor((app_sec(i,k) + post)*fs));
        row_move1 = row_move(1:(pre+post)*fs);
        move(i,:,k) = row_move1; %- floor(app_sec(i,k)*fs)
    end
end

save('movement.mat', 'app_sec', 'move'); 


