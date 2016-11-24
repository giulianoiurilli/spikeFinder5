function [totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor, totalSUAExp] = findNumberOfSua_old(esp, odors)



odorsRearranged = odors;
odors = length(odorsRearranged);
idxCell1 = 0;
idxCell2 = 0;
idx.idxExc.idxO1 = zeros(length(esp),odors);
idx.idxInh.idxO1 = zeros(length(esp),odors);
totalSUAExp = zeros(1,length(esp));

idxE = 0;
for idxExp = 1:length(esp)
    idxCellExp = 0;
    idxE = idxE + 1;
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxCellExp = idxCellExp + 1;
                idxO = 0;
                app = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app(idxO) = abs(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                    app1(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                    if app1(idxO) > 0
                        idx.idxExc.idxO1(idxE,idxO) = idx.idxExc.idxO1(idxE,idxO) + 1;
                    end
                    if app1(idxO) < 0
                        idx.idxInh.idxO1(idxE,idxO) = idx.idxInh.idxO1(idxE,idxO) + 1;
                    end
                end
                if sum(app) > 0
                    idxCell2 = idxCell2 + 1;
                end
            end
        end
    end
    totalSUAExp(idxE) = idxCellExp;
end


totalSUA = idxCell1;
totalResponsiveSUA = idxCell2;
totalResponsiveNeuronPerOdor = idx;