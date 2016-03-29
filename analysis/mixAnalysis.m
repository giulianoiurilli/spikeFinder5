function [aurocBetweenMix, aurocBetweenMixSig, auRocMix, respMix, cellLogMix] = mixAnalysis(esp)



c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end

aurocBetweenMix = nan(c,1);
aurocBetweenMixSig = nan(c,1);
auRocMix = nan(c,6);
respMix = nan(c,15);
cellLogMix = nan(c,3);
c = 0;

odorMixes = [1 11 12 6 13 14];
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                aurocBetweenMix(c) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).auROC1sBetweenMixIdentity;
                aurocBetweenMixSig(c) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).auROC1sBetweenMixIdentitySig;
                for idxOdor = odorMixes
                    idxO = idxO + 1;
                    auRocMix(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                cellLogMix(c,:) = [idxExp, idxShank, idxUnit];
            end
        end
    end
end

c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                aurocBetweenMix(c) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).auROC1sBetweenMixIdentity;
                for idxOdor = 1:15
                    idxO = idxO + 1;
                    respMix(c,idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                end
            end
        end
    end
end

                     