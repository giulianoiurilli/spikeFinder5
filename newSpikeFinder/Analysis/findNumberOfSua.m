function [totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor, totalSUAExp] = findNumberOfSua(esp, odors, lratio, onlyexc)



odorsRearranged = odors;
odors = length(odorsRearranged);
idxCell1 = 0;
idxCell2 = 0;
idx.idxExc.idxO1 = zeros(length(esp),odors);
idx.idxInh.idxO1 = zeros(length(esp),odors);
totalSUAExp = zeros(1,length(esp));

idxE = 0;
for idxExp = 1:length(esp)
    idxE = idxE + 1;
    idxCellExp = 0;
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    idxCell1 = idxCell1 + 1;
                    idxCellExp = idxCellExp + 1;
                    idxO = 0;
                    app = zeros(1,odors);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        if onlyexc == 1
                            app(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        else
                            app(idxO) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        end
                        app1(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                        if app1(idxO) > 0
                            idx.idxExc.idxO1(idxExp,idxO) = idx.idxExc.idxO1(idxExp,idxO) + 1;
                        end
                        if app1(idxO) < 0
                            idx.idxInh.idxO1(idxExp,idxO) = idx.idxInh.idxO1(idxExp,idxO) + 1;
                        end
                    end
                    if sum(app) > 0
                        idxCell2 = idxCell2 + 1;
                    end
                end
            end
        end
    end
    totalSUAExp(idxE) = idxCellExp;
end
totalSUA = idxCell1;
totalResponsiveSUA = idxCell2;
totalResponsiveNeuronPerOdor = idx;