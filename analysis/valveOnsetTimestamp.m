

load('dig1.mat');
load('parameters.mat');
signal = Dig_inputs; 

%find valve onsets
dig_supra_thresh = valve_onset(signal, thres); 
dig_supra_thresh = dig_supra_thresh./fs; %convert to seconds

filename = 'valveOnsets.mat';
save(filename, 'dig_supra_thresh');