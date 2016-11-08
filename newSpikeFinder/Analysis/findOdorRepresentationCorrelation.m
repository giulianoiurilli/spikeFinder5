function [rhoOdorRepresentationsSig, rhoMeanOdorRepresentationsSig] = findOdorRepresentationCorrelation(esp, odors)

[responseCell1AllResp, responseCell1MeanResp, responseCell1All, responseCell1Mean] = makeDataAll(esp, odors);
dataAll = responseCell1AllResp;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
rhoOdorRepresentationsSig = corr(dataAll);

responseCell1MeanResp = responseCell1MeanResp';
responseCell1MeanResp = zscore(responseCell1MeanResp);
responseCell1MeanResp = responseCell1MeanResp';
rhoMeanOdorRepresentationsSig = corr(responseCell1MeanResp);

