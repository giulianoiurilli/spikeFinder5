function [tuningCurves, tuningCurvesSig] = findTuningCurves(esp, odors)

[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors);

%%
tuningCurves = 0.5 * ones(totalSUA, length(odors));
tuningCurvesSig = 0.5 * ones(totalResponsiveSUA, length(odors));
cells = 0;
idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    cells = cells + 1;
                    idxO = 0;
                    app = [];
                    for idxOdor = odors
                        idxO = idxO + 1;
                        tuningCurves(cells, idxO) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) -...
                            mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                        app(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(app) > 0
                        idxCell = idxCell + 1;
                        tuningCurvesSig(idxCell,:) = tuningCurves(cells, :);
                    end
                end
            end
        end
    end
end