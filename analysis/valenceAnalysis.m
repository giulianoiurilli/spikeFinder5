function [aurocBetweenValence, aurocBetweenValenceSig, auRocValence, cellLogValence] = valenceAnalysis(esp)



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

aurocBetweenValence = nan(c,1);
aurocBetweenValenceSig = nan(c,1);
auRocValence = nan(c,10);
cellLogValence = nan(c,3);
c = 0;

odorValence = 1:10;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                aurocBetweenValence(c) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).auROC1sBetweenValenceClassIdentity;
                aurocBetweenValenceSig(c) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).auROC1sBetweenValenceClassIdentitySig;
                for idxOdor = odorValence
                    idxO = idxO + 1;
                    auRocValence(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                cellLogValence(c,:) = [idxExp, idxShank, idxUnit];
            end
        end
    end
end