function [conc, totalResponsiveSUA] = findOdorDiscriminative_new_2(esp, odors, onlyexc)

[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors, onlyexc);

C  = [1,6; 2,7; 3,8; 4,9; 5,10]; 

conc = zeros(1,5);

for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    for idxConc = 1:5
                        appOdor = zeros(1,2);
                        appResp = nan(10,2);
                        idxO = 0;
                        for iOdor = odors(C(idxConc,:))
                            idxO = idxO + 1;
                            appOdor(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(iOdor).DigitalResponse1000ms == 1;
                            appResp(:,idxO) = (esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(iOdor).AnalogicResponse1000ms -...
                                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(iOdor).AnalogicBsl1000ms)';
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
end