function [Emean, Esem, EmeanShuffled, EsemShuffled, EmeanDecorr, EsemDecorr] = findBestNumberOfClusters(esp, odors, nClusters)

odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = [];
                    app = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms; %- ...
                    %esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    baselineCell1All(idxCell1,:,idxO) = app2;
                end
            end
        end
    end
end

%% k-means or agglomerative hiearchical clustering of odor representations and cluster evaluation
X = [];
nRep = 100;
%nClusters = 1:odors;
%nClusters = [nClusters 20 30 40 50 60 70];
%nClusters = 1:8;
Emean = zeros(nRep, length(nClusters));
Esem = zeros(nRep, length(nClusters));

dataAll = [];
trials = size(responseCell1All,2);
stimuli = size(responseCell1All,3);

for idxRep = 1:nRep
    idxCell = randsample(size(responseCell1All,1), 100);
    dataAll = responseCell1All(idxCell,:);
    neurons = size(dataAll,1);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    dataAll= zscore(dataAll);
    app = [];
    %app = evalclusters(dataAll, 'kmeans', 'gap', 'klist', nClusters);
    app = evalclusters(dataAll,'linkage','gap','KList',nClusters, 'Distance', 'correlation');
    Emean(idxRep,:) = app.CriterionValues;
    Esem(idxRep,:) = app.SE;
end


Emean = nanmean(Emean);
Esem = nanmean(Esem);

%figure; errorbar(Emean, Estd);

%% shuffle neurons    
X = [];
EmeanShuffled = zeros(nRep, length(nClusters));
EsemShuffled = zeros(nRep, length(nClusters));


dataAll = [];
trials = size(responseCell1All,2);
stimuli = size(responseCell1All,3);

for idxRep = 1:nRep
    idxCell = randsample(size(responseCell1All,1), 100);
    dataAll = responseCell1All(idxCell,:,:);
    neurons = size(dataAll,1);
    for idxTrial = 1:trials
        for idxStim = 1:stimuli;
            idx = randperm(neurons);
            dataAll(:,idxTrial, idxStim) = dataAll(idx,idxTrial, idxStim);
        end
    end
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    dataAll= zscore(dataAll);
    app = [];
    %app = evalclusters(dataAll, 'kmeans', 'silhouette', 'klist', nClusters);
    app = evalclusters(dataAll,'linkage','gap','KList',nClusters, 'Distance', 'correlation');
    EmeanShuffled(idxRep,:) = app.CriterionValues;
    EsemShuffled(idxRep,:) = app.SE;
end  

%% remove noise and signal correlation   
X = [];
EmeanDecorr = zeros(nRep, length(nClusters));
EsemDecorr = zeros(nRep, length(nClusters));


dataAll = [];
trials = size(responseCell1All,2);
stimuli = size(responseCell1All,3);

for idxRep = 1:nRep
    idxCell = randsample(size(responseCell1All,1), 100);
    dataAll = responseCell1All(idxCell,:,:);
    neurons = size(dataAll,1);
    for idxNeuron = 1:neurons
        idx = randperm(stimuli);
        dataAll(idxNeuron,:, :) = dataAll(idxNeuron,:, idx);
    end
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    dataAll= zscore(dataAll);
    app = [];
    %app = evalclusters(dataAll, 'kmeans', 'silhouette', 'klist', nClusters);
    app = evalclusters(dataAll,'linkage','gap','KList',nClusters, 'Distance', 'correlation');
    EmeanDecorr(idxRep,:) = app.CriterionValues;
    EsemDecorr(idxRep,:) = app.SE;
end 
    
    
    
    
    
    
    
    
    
    