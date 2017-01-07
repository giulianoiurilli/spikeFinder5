function [ls300, ls1000] = retrieveLifetimeSparseness(esp)


ls300 = [];
ls1000 = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
%                     if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && max(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR) >5
                    ls300 = [ls300 esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls300ms];
                    ls1000 = [ls1000 esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls1s];
                end
            end
        end
    end
end