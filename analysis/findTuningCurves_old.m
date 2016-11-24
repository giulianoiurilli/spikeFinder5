function [tuningCurves, tuningCurvesAuRoc, tuningCurvesSig, auROCSig] = findTuningCurves_old(esp, odors, onlyexc)

cells = 0;
idxCell = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                idxO = 0;
                app = [];
                for idxOdor = odors
                    idxO = idxO + 1;
                    if onlyexc == 1
                        app(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    else
                        app(idxO) = abs(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                    end
                end
                if sum(app) > 0
                    idxCell = idxCell + 1;
                end
            end
        end
    end
end

%%
tuningCurves = 0.5 * ones(cells, length(odors));
tuningCurvesSig = 0.5 * ones(idxCell, length(odors));
cells = 0;
idxCell = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                idxO = 0;
                app = [];
                for idxOdor = odors
                    idxO = idxO + 1;
                    tuningCurves(cells, idxO) = mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) -...
                        mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    if onlyexc == 1
                        app(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    else
                        app(idxO) = abs(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                    end
                    tuningCurvesAuRoc(cells, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                if sum(app) > 0
                    idxCell = idxCell + 1;
                    tuningCurvesSig(idxCell,:) = tuningCurves(cells, :);
                    auROCSig(idxCell,:) = tuningCurvesAuRoc(cells, :);
                end
            end
        end
    end
end
end