function psth = retrieveCycleBinnedPsth(esp, esperimento, odors, lratio, onlyexc)

n_trials = 10;




%%
[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors, lratio, onlyexc);


psth = nan(totalResponsiveSUA, 16);
n_odors = numel(odors);
idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                %                 if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    app = zeros(1,n_odors);
                    for idxOdor = odors
                        if onlyexc == 1
                            app(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        else
                            app(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        end
                        if sum(app) > 0
                            idxCell = idxCell + 1;
                            psth(idxCell,:) = mean(esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).sniffBinnedPsth./...
                                esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).inh_exa_cycleLength);  
                        end
                    end
                end
            end
        end
    end
end