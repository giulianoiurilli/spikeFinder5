
function [responsivity, auROC, nCellsExp] = findResponsivityAndAurocPerShank(esp)


for idxShank = 1:4
    idxCell = 0;
    for idxExp = 1:length(esp)
        cellsExp = 0;
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    idxCell = idxCell + 1;
                    cellsExp = cellsExp + 1;
                    for odor = 1:3
                        for iOdor = 1:5
                            idxOdor = iOdor + 5*(odor-1);
                            responsivity{idxShank}(idxCell,iOdor,odor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                            auROC{idxShank}(idxCell,iOdor,odor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC1000ms;
                        end
                    end
                end
            end
        end
        nCellsExp(idxExp, idxShank) = cellsExp;
    end
end
