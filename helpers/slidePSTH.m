function slidingPSTH = slidePSTH(spikesVect, binSize, moveBy)

if nargin < 3
    moveBy = 5;
end

if nargin < 2
    binSize = 10;
    moveBy = 5;
end

nTrials = size(spikesVect, 1);
nTimepoints = size(spikesVect, 2);

slidingPSTH = zeros(nTrials, nTimepoints);

for idxTrial = 1:nTrials
    spikeVector = spikesVect(idxTrial,:);
    k = ones(1, binSize);
    slidingPSTH(idxTrial,:) = conv(spikeVector, k, 'same');
end

slidingPSTH = slidingPSTH(:,1:moveBy:end);
slidingPSTH = mean(slidingPSTH,1);




