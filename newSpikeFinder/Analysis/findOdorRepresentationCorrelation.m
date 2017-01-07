function [rhoOdorRepresentationsSig, rhoMeanOdorRepresentationsSig, eva] = findOdorRepresentationCorrelation(esp, odors, lratio, onlyexc,shuffle)

[responseCell1AllResp, responseCell1MeanResp, responseCell1All, responseCell1Mean] = makeDataAll(esp, odors, lratio, onlyexc);

if shuffle == 0
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
    
    dataAll2 = [];
    dataAll = responseCell1AllResp;
    for idxCell = 1:neurons
        dataAll2 = [dataAll2; squeeze(dataAll(idxCell,:,:))];
    end
    eva = evalclusters(dataAll2, 'linkage', 'gap', 'KList', [1:numel(odors)], 'distance', 'sqEuclidean'); 

end


if shuffle == 1
    dataAll = responseCell1AllResp;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    rhoOdorRepresentationsSigAll = nan(trials*stimuli, trials*stimuli, 100);
    rhoMeanOdorRepresentationsSigAll = nan(length(odors),length(odors),100);
    responseCell1MeanRespShuffled = responseCell1MeanResp;
    responseCell1MeanRespShuffled = responseCell1MeanRespShuffled';
    responseCell1MeanRespShuffled = zscore(responseCell1MeanRespShuffled);
    responseCell1MeanRespShuffled = responseCell1MeanRespShuffled';
    
    
    for idxRep = 1:100
        dataAll = responseCell1AllResp;
        for idxCell = 1:size(dataAll,1)
            newOrder = randperm(length(odors));
            dataAll(idxCell,:,:) = dataAll(idxCell,:,newOrder);
        end
        neurons = size(dataAll,1);
        trials = size(dataAll,2);
        stimuli = size(dataAll,3);
        dataAll = reshape(dataAll, neurons, trials .* stimuli);
        dataAll = dataAll';
        dataAll = zscore(dataAll);
        dataAll = dataAll';
        rhoOdorRepresentationsSigAll(:,:,idxRep) = corr(dataAll);
        for idxCell = 1:neurons
            newOrder = randperm(length(odors));
            responseCell1MeanRespShuffled(idxCell,:) = responseCell1MeanRespShuffled(idxCell,newOrder);
        end
        rhoMeanOdorRepresentationsSigAll(:,:,idxRep) = corr(responseCell1MeanRespShuffled);
    end
    rhoOdorRepresentationsSig = mean(rhoOdorRepresentationsSigAll,3);
    rhoMeanOdorRepresentationsSig = mean(rhoMeanOdorRepresentationsSigAll,3);
end
