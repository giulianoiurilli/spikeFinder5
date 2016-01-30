%odorsRearranged = [1 2 5 10 15 7 8];% pcxL
%odorsRearranged = [14 6 4 12 13 3 11 ];% pcxH
%odorsRearranged = [14 6 4 12 13 3 11 9];% pcxH8
%odorsRearranged = [6 1 3 13 12 7 5];% coaL
%odorsRearranged = [14 2 15 4 10 11 8];% coaH
%odorsRearranged = [14 2 15 4 10 11 8 9];% coaH8
odorsRearranged = 1:15;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(pcx2.esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxesp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = [];
                    app = pcx2.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms; %- ...
                    %esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = pcx2.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
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


%% Odor distances - Means - MDS - hierarchical clustering
X = [];
responseCell1Mean = responseCell1Mean';
responseCell1Mean = zscore(responseCell1Mean);

nRep = 1000;
D = zeros(nRep, odors*(odors-1)/2);
DS = D;
for idxRep = 1:nRep
    idxCell = randsample(size(responseCell1Mean,2), 100);
    X = responseCell1Mean(:,idxCell);
    D(idxRep, :) = pdist(X, 'correlation');
    for idxUnit = 1:100
        idxOdor = randperm(15);
        X(:,idxUnit) = X(idxOdor, idxUnit);
    end
    DS(idxRep, :) = pdist(X, 'correlation');
end
distOdors = mean(D);
distOdorsDecorr = mean(DS);
figure;
maxD = max(distOdors);
minD = min(distOdors);
edges = minD:0.025:maxD;
[N,edges] = histcounts(distOdors, edges,'normalization', 'probability');
[N1,edges] = histcounts(distOdorsDecorr, edges,'normalization', 'probability');
edges(end) = [];
h1 = area(edges, N);
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
alpha(h1, 0.5)
hold on
plot(edges,N1, ':k')
set(gca,'YColor','w','box','off')

% D = squareform(D);
% Z = linkage(D);
% Y = mdscale(D, 3, 'criterion', 'stress');
% 
% distancePcx = D;
% treePcx = Z;
% figure;
% clims = [0 2];
% imagesc(D, clims); 
% colormap(brewermap([],'*RdBu')); axis tight; axis square
% set(gca,'YColor','w')
% set(gca,'XColor','w')
% set(gca,'XTick',[])
% set(gca,'XTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'YTickLabel',[])
% figure;
% dendrogram(Z)
% figure;
% C = [228,26,28;
% 55,126,184;
% 77,175,74;
% 152,78,163;
% 255,127,0]./255;
% idxC = 0;
% for idx = 0:3:12
%     idxC = idxC + 1;
%     scatter3(Y(1 + idx : 3 + idx, 1), Y(1 + idx : 3 + idx, 2), Y(1 + idx : 3 + idx, 3), 150, C(idxC,:), 'filled');
% hold on
% end



%% Odor distances - Single trials (averages of 2 presentations) - PCA
dataAll = [];
trials = size(responseCell1All,2);
stimuli = size(responseCell1All,3);
scores = zeros(trials .* stimuli, 3, nRep);
for idxRep = 1:nRep
    idxCell = randsample(size(responseCell1All,1), 100);
    dataAll = responseCell1All(idxCell,:);
    neurons = size(dataAll,1);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    dataAll= zscore(dataAll);
    [coeff, score, latent, tsuared, explained, mu] = pca(dataAll);
    scores(:,:,idxRep) = score(:,1:3);
end

scores = squeeze(mean(scores,3));
scoresMean = zeros(stimuli,3);
for idxScore = 1:3
app = [];
app = reshape(scores(:, idxScore), trials, stimuli);
app = mean(app);
scoresMean(:, idxScore) = app'; 
end

figure;
colorClass = [228,26,28;...
    55,126,184;...
    77,175,74;...
    152,78,163;...
    255,127,0]./255;
symbolOdor = {'o', 's', 'p'};
k = 0;
for idxCat = 1:5
    C = colorClass(idxCat,:);
    for idxOdor = 1:3
        mT = symbolOdor{idxOdor};
        scatter(scores(1 + k*5:5 + k*5, 1), scores(1 + k*5:5 + k*5, 2), 100, C, mT, 'filled');
        k = k + 1;
        hold on
%         scatter3(scoresMean(k, 1), scoresMean(k, 2), scoresMean(k, 3), 100, C, 'd','filled');
%         hold on
    end
end

%% k-means of odor representations and cluster evaluation
X = [];
nRep = 50;
E = zeros(nRep, odors);
nClusters = 1:odors;


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
    app = evalclusters(dataAll, 'kmeans', 'silhouette', 'klist', nClusters);
    E(idxRep,:) = app.CriterionValues;
end




% for idxRep = 1:nRep
%     idxCell = randsample(size(responseCell1Mean,2), 100);
%     X = responseCell1Mean(:,idxCell);
%     app = [];
%     app = evalclusters(X, 'kmeans', 'silhouette', 'klist', nClusters);
%     E(idxRep,:) = app.CriterionValues;
% end

Emean = nanmean(E);
Estd = nanstd(E);

figure; errorbar(Emean, Estd);



%% SVM classification and confusion matrices

%On responses
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;

%                                                                                     for odor = 1:size(dataAll,3) - 1
%                                                                                         if odor < 5
%                                                                                         labels  = [labels, app_labels];
%                                                                                         else
%                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
%                                                                                         end
%                                                                                     end

for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end
labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 5000;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
accuracyResponses = [mean_acc_svm std_acc_svm];

%%
%On baselines
dataAll = baselineCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;

%                                                                                     for odor = 1:size(dataAll,3) - 1
%                                                                                         if odor < 5
%                                                                                         labels  = [labels, app_labels];
%                                                                                         else
%                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
%                                                                                         end
%                                                                                     end

for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end
labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 5000;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
accuracyBaseline = [mean_acc_svm std_acc_svm];


%%
%Shuffle order neurons across trials
accuracyShuffled = zeros(50,2);
for idxShuffle = 1:50
    dataAll = responseCell1All;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    
    for idxTrial = 1:trials
        for idxStim = 1:stimuli;
            idx = randperm(neurons);
            dataAll(:,idxTrial, idxStim) = dataAll(idx,idxTrial, idxStim);
        end
    end
    
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    dataAll = zscore(dataAll);
    dataAll = dataAll';
    dataAll(isinf(dataAll)) = 0;
    dataAll(isnan(dataAll)) = 0;
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    dataAll = double(dataAll);
    labels      = ones(1,size(dataAll,2));
    app_labels  = labels;
    
    %                                                                                     for odor = 1:size(dataAll,3) - 1
    %                                                                                         if odor < 5
    %                                                                                         labels  = [labels, app_labels];
    %                                                                                         else
    %                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
    %                                                                                         end
    %                                                                                     end
    
    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    labels      = labels';
    
    trainingN = floor(0.9*(trials * stimuli));
    repetitions = 100;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    accuracyShuffled(idxShuffle,:) =  [mean_acc_svm std_acc_svm];
end
accuracyShuffled = mean(accuracyShuffled);

%%
%Remove signal and noise correlation
accuracyDecorrTuning = zeros(50,2);
for idxShuffle = 1:50
    dataAll = responseCell1All;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    
    for idxNeuron = 1:neurons
        idx = randperm(stimuli);
        dataAll(idxNeuron,:, :) = dataAll(idxNeuron,:, idx);
    end
    
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    dataAll = zscore(dataAll);
    dataAll = dataAll';
    dataAll(isinf(dataAll)) = 0;
    dataAll(isnan(dataAll)) = 0;
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    dataAll = double(dataAll);
    labels      = ones(1,size(dataAll,2));
    app_labels  = labels;
    
    %                                                                                     for odor = 1:size(dataAll,3) - 1
    %                                                                                         if odor < 5
    %                                                                                         labels  = [labels, app_labels];
    %                                                                                         else
    %                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
    %                                                                                         end
    %                                                                                     end
    
    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    labels      = labels';
    
    trainingN = floor(0.9*(trials * stimuli));
    repetitions = 100;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    accuracyDecorrTuning(idxShuffle,:) =  [mean_acc_svm std_acc_svm];
end
accuracyDecorrTuning = mean(accuracyDecorrTuning);

%%
%Remove noise correlation
accuracyDecorrNoise = zeros(50,2);
for idxShuffle = 1:50
    dataAll = responseCell1All;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    
    for idxNeuron = 1:neurons
        idx = randperm(trials);
        dataAll(idxNeuron,:, :) = dataAll(idxNeuron,idx, :);
    end
    
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    dataAll = zscore(dataAll);
    dataAll = dataAll';
    dataAll(isinf(dataAll)) = 0;
    dataAll(isnan(dataAll)) = 0;
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    dataAll = double(dataAll);
    labels      = ones(1,size(dataAll,2));
    app_labels  = labels;
    
    %                                                                                     for odor = 1:size(dataAll,3) - 1
    %                                                                                         if odor < 5
    %                                                                                         labels  = [labels, app_labels];
    %                                                                                         else
    %                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
    %                                                                                         end
    %                                                                                     end
    
    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    labels      = labels';
    
    trainingN = floor(0.9*(trials * stimuli));
    repetitions = 100;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    accuracyDecorrNoise(idxShuffle,:) =  [mean_acc_svm std_acc_svm];
end
accuracyDecorrNoise = mean(accuracyDecorrNoise);

















