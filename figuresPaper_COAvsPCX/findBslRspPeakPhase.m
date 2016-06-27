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

sdf = nan(c,7200,15);
phasePeakBsl = nan(c, 15);
phasePeakRsp = nan(c, 15);
ampPeakBsl = nan(c, 15);
ampPeakRsp = nan(c, 15);
significance300 = nan(c, 15);
significance1000 = nan(c, 15);
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                bslCycles = [];
                rspCycles = [];
                appPhaseBsl = [];
                for idxOdor = 1:15
                    sdf(c,:,idxOdor) = mean(esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad);
                    bslCycles = mean(esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad(:, 360*9+1+10:360*10+10));
                    rspCycles = mean(esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad(:, 360*10+1+10:360*11+10));
                    [maxBsl,maxBslPhase] = max(bslCycles);
                    [maxRsp,maxRspPhase] = max(rspCycles);
                    phasePeakRsp(c,idxOdor) = maxRspPhase;
                    ampPeakRsp(c,idxOdor) = maxRsp;
                    appPhaseBsl = [appPhaseBsl; maxBslPhase];
                    significance300(c, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms;
                    significance1000(c, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                    phasePeakBsl(c,idxOdor) = maxBslPhase;
                    ampPeakBsl(c,idxOdor) = maxBsl;
                end
            end
        end
    end
end