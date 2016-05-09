function [phasePeakBsl, phasePeakRsp, significance] = findBslRspPeakPhase(esp, esperimento)





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

phasePeakBsl = nan(1, c);
phasePeakRsp = nan(c, 15);
significance = nan(c, 15);
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                bslCycles = [];
                rspCycles = [];
                appBsl = [];
                for idxOdor = 1:15
                    bslCycles = esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(:, 360*7+1:360*8);
                    rspCycles = esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(:, 360*10+1:360*11);
                    [~,maxBsl] = max(bslCycles, [], 2);
                    [~,maxRsp] = max(rspCycles, [], 2);
                    phasePeakRsp(c,idxOdor) = mean(maxRsp);
                    appBsl = [appBsl; maxBsl];
                    significance(c, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms;
                end
                phasePeakBsl(c) = mean(appBsl);
            end
        end
    end
end