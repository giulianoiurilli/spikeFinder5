function [i300, i1000] = retrievePoissonInformation(esp)


i300 = [];
i1000 = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
%                     if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && max(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR) >5
                    i300 = [i300 esp(idxExp).shank(idxShank).SUA.cell(idxUnit).I300ms];
                    i1000 = [i1000 esp(idxExp).shank(idxShank).SUA.cell(idxUnit).I1s];
                end
            end
        end
    end
end