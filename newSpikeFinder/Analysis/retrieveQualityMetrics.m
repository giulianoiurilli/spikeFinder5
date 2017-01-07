function [l_ratio, isolation_distance, snr] = retrieveQualityMetrics(esp)


l_ratio = [];
isolation_distance = [];
snr = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
%                 if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    l_ratio = [l_ratio esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio];
                    isolation_distance = [isolation_distance esp(idxExp).shank(idxShank).SUA.cell(idxUnit).isolationDistance];
                    snr = [snr max(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR)];
%                 end
            end
        end
    end
end