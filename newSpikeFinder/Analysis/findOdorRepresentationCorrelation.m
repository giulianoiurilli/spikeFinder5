function [rhoOdorRepresentationsSig, rhoMeanOdorRepresentationsSig] = findOdorRepresentationCorrelation(esp, odors)


[responseCell1All, responseCell1Mean] = makeDataAll(esp, odors);

%%
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
clims = [0 1];
rhoOdorRepresentationsSig = corr(dataAll);

responseCell1Mean = responseCell1Mean';
responseCell1Mean = zscore(responseCell1Mean);
responseCell1Mean = responseCell1Mean';
rhoMeanOdorRepresentationsSig = corr(responseCell1Mean);

