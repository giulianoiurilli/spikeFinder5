function [acg, sniffIndex] = retrieveACGs(esp, odors, onlyexc)

[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor, totalSUAExp] = findNumberOfSua(esp, odors, onlyexc);
acg = nan(totalSUA,2201);
sniffIndex = nan(totalSUA,1);

idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    idxCell = idxCell + 1;
                    acg(idxCell, :) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ACG;
                    sniffIndex(idxCell) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sniffModulation;
                end
            end
        end
    end
end