function [conc, totalResponsiveSUA] = findOdorDiscriminative_new(esp, odors)

[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors);
C  = [1 6 11; 2 7 12; 3 8 13; 4 9 14; 5 10 15]; 
conc = zeros(1,5);
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    for idxConc = 1:5
                        appOdor = zeros(1,3);
                        appResp = nan(10,3);
                        idxO = 0;
                        for iOdor = C(idxConc,:)
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



                        
                            