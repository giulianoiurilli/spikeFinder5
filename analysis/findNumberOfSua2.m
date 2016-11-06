function [totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua2(esp, odors)



odorsRearranged = odors;
odors = length(odorsRearranged);
idxCell1 = 0;
idxCell2 = 0;
idxO1 = zeros(1,15);


for idxExp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                app = zeros(1,15);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    if app(idxO) == 1
                        idxO1(idxO) = idxO1(idxO) + 1;
                    end
                end
                if sum(app) > 0
                    idxCell2 = idxCell2 + 1;
                end
            end
        end
    end
end

totalSUA = idxCell1;
totalResponsiveSUA = idxCell2;
totalResponsiveNeuronPerOdor = idxO1;