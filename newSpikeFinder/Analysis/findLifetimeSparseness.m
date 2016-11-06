function [ls, cellLog, lsSig, cellLogSig] = findLifetimeSparseness(esp, odors)

[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors);
%%
ls = nan(totalSUA,1);
cellLog = nan(totalSUA,3);

lsSig = nan(totalResponsiveSUA,1);
cellLogSig = nan(totalResponsiveSUA,3);

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
                    response = nan(10,15);
                    for idxOdor = odors
                        idxO = idxO + 1;
                        app(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        response(:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    end
                    ls(cells) = lifetime_sparseness(response);
                    cellLogSig(cells,:) = [idxExp, idxShank, idxUnit];
                    if sum(app) > 0
                        idxCell = idxCell + 1;
                        idxO = 0;
                        response = nan(10,15);
                        for idxOdor = odors
                            idxO = idxO + 1;
                            response(:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                        end
                        lsSig(idxCell) = lifetime_sparseness(response);
                        cellLogSig(idxCell,:) = [idxExp, idxShank, idxUnit];
                    end
                end
            end
        end
    end
end