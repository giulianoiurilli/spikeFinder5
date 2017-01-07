function [trough_to_peak_ratio, trough_to_peak_time, half_amplitude_duration] = retrieveSpikeFeatures(esp)


trough_to_peak_ratio = [];
trough_to_peak_time = [];
half_amplitude_duration = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
%                     if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && max(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR) >5
                    trough_to_peak_ratio = [trough_to_peak_ratio esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_ratio];
                    trough_to_peak_time = [trough_to_peak_time esp(idxExp).shank(idxShank).SUA.cell(idxUnit).trough_to_peak_time];
                    half_amplitude_duration = [half_amplitude_duration esp(idxExp).shank(idxShank).SUA.cell(idxUnit).half_amplitude_duration];
                end
            end
        end
    end
end