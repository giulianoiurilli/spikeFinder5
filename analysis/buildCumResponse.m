function [firingRestSumMean, firingOdorSumMean] = buildCumResponse(A, sniffs, windowLength, n_sniffs, idxOdor)


n_trials = 10;


%A = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;


firingRestSum = zeros(n_trials, windowLength, n_sniffs);
firingOdorSum = zeros(n_trials, windowLength, n_sniffs);
for idxTrial = 1:n_trials
    snif = [];
    idxSniffsRest = [];
    idxSniffsOdor = [];
    snif = sniffs(idxOdor).trial(idxTrial).sniffPower(:,1)';
    onset = find(snif>0,1);
    idxSniffsRest = floor(15000 + floor(snif(onset-n_sniffs:onset-1)*1000));
    idxSniffsOdor = floor(floor(snif(onset:onset+n_sniffs-1)*1000) + 15000);
    for idxSnif = 1:n_sniffs
        firingRestSum(idxTrial,:,idxSnif) = cumsum(A(idxTrial, idxSniffsRest(idxSnif) + 1 : idxSniffsRest(idxSnif) + windowLength),2);
        firingOdorSum(idxTrial,:,idxSnif) = cumsum(A(idxTrial, idxSniffsOdor(idxSnif) + 1 : idxSniffsOdor(idxSnif) + windowLength),2);
    end
end

app1 = [];
app1 = reshape(firingRestSum,size(firingRestSum,1), size(firingRestSum,2)*size(firingRestSum,3));
firingRestSumMean = mean(app1);
app2 = [];
app2 = reshape(firingOdorSum,size(firingOdorSum,1), size(firingOdorSum,2)*size(firingOdorSum,3));
firingOdorSumMean = mean(app2);

