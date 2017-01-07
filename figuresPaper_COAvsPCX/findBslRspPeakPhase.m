function [sdf, phasePeakBsl, phasePeakRsp, ampPeakBsl, ampPeakRsp, significance300, significance1000] = findBslRspPeakPhase(esp, esperimento)





%%
c = 0;
t = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            t = t + 1;
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end

sdf = nan(c,3240,15);
phasePeakBsl = nan(c, 15);
phasePeakRsp = nan(c, 15);
ampPeakBsl = nan(c, 15);
ampPeakRsp = nan(c, 15);
significance300 = nan(c, 15);
significance1000 = nan(c, 15);
c = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
              if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5

                c = c + 1;
                bslCycles = [];
                rspCycles = [];
                appPhaseBsl = [];
                for idxOdor = 1:15
                    spikeMatrixRad = double(full(esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrixRad));
                    app = zeros(10,3240);
                    for idxTrial = 1:10
                        app(idxTrial,:) = spikeDensityRad(spikeMatrixRad(1,:), 10);
                    end
                    app = nanmean(app);
                    sdf(c,:,idxOdor) = app;
                    bslCycles = app(1+10:360*3+10);
                    rspCycles = app(360*3+1+10:360*4+10);
                    [maxBsl,maxBslPhase] = max(bslCycles);
                    [maxRsp,maxRspPhase] = max(rspCycles);
                    phasePeakRsp(c,idxOdor) = maxRspPhase;
                    ampPeakRsp(c,idxOdor) = maxRsp;
                    appPhaseBsl = [appPhaseBsl; maxBslPhase];
                    significance300(c, idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms;
                    significance1000(c, idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                    phasePeakBsl(c,idxOdor) = maxBslPhase;
                    ampPeakBsl(c,idxOdor) = maxBsl;
                end
            end
        end
    end
    end
end

