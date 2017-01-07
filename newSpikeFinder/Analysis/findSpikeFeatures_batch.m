fileToSave = 'plCoA_natMix_2.mat';
folderlist = {esp(:).filename};
startingFolder = pwd;

Fs = 20000;

for idxExp =  1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                wf = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).meanWaveform;
                [trough_to_peak_ratio, trough_to_peak_time, half_amplitude_duration] = findSpikeFeatures(wf, Fs);
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_ratio = trough_to_peak_ratio;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_time = trough_to_peak_time;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).half_amplitude_duration = half_amplitude_duration;
            end
        end
    end
end

cd(startingFolder)
save(fileToSave, 'esp', '-append')
                