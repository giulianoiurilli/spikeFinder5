function [conc, totalResponsiveSUA] = findOdorDiscriminative_new2(esp, odors)

[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua2(esp, odors);
C  = [1 6 11; 2 7 12; 3 8 13; 4 9 14; 5 10 15];
conc = zeros(1,5);
for idxExp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxConc = 1:5
                    appOdor = zeros(1,3);
                    appResp = nan(10,3);
                    idxO = 0;
                    for iOdor = C(idxConc,:)
                        idxO = idxO + 1;
                        appOdor(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(iOdor).DigitalResponse1000ms == 1;
                        appResp(:,idxO) = (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(iOdor).AnalogicResponse1000ms -...
                            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(iOdor).AnalogicBsl1000ms)';
                    end
                    if sum(appOdor) > 0
                        [p, ~] = anova1(appResp,[],'off');
                        if p < 0.05
                            conc(idxConc) = conc(idxConc) + 1;
                        end
                    end
                end
            end
        end
    end
end
