function findValveOnsets(thresTTL, samplingFrequency, triggerToOnsetDelay)

load('dig0.mat');

signal = Dig_inputs; 

%find valve onsets
dig_supra_thresh = valve_onset(signal, thresTTL); 
dig_supra_thresh = round(dig_supra_thresh./samplingFrequency, 3) + triggerToOnsetDelay; %convert to seconds and add to 3 seconds 

filename = 'valveOnsets.mat';
save(filename, 'dig_supra_thresh');