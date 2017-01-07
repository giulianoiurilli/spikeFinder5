%%
[allPsthP15,  cellOdorLogP15] = collectAllPsth(pcx15.esp, pcx15_1.espe, 1:15);
[allPsthPA,  cellOdorLogPA] = collectAllPsth(pcxAA.esp, pcxAA_1.espe, 1:10);
[allPsthPN,  cellOdorLogPN] = collectAllPsth(pcxNM.esp, pcxNM_1.espe, 1:15);
%[allPsthPC1,  cellOdorLogPC1] = collectAllPsth(pcxCS1.esp, pcxCS1_1.espe, 1:15);
[allPsthPC2,  cellOdorLogPC2] = collectAllPsth(pcxCS2.esp, pcxCS2_1.espe, 1:15);

[allPsthC15,  cellOdorLogC15] = collectAllPsth(coa15.esp, coa15_1.espe, 1:15);
[allPsthCA,  cellOdorLogCA] = collectAllPsth(coaAA.esp, coaAA_1.espe, 1:10);
[allPsthCN,  cellOdorLogCN] = collectAllPsth(coaNM.esp, coaNM_1.espe, 1:15);
% [allPsthCC1,  cellOdorLogCC1] = collectAllPsth(coaCS1.esp, coaCS1_1.espe, 1:15);
[allPsthCC2,  cellOdorLogCC2] = collectAllPsth(coaCS2.esp, coaCS2_1.espe, 1:15);
%%
X1 = [allPsthP15(:,11:1991); allPsthPA(:,11:1991); allPsthPN(:,11:1991); allPsthPC2(:,11:1991);...
    allPsthC15(:,11:1991); allPsthCA(:,11:1991); allPsthCN(:,11:1991); allPsthCC2(:,11:1991)];
%% spca for psth
X = [];
SL = [];
SD = [];
X = X1 - repmat(mean(X1,2), 1,size(X1,2));
norme = sqrt(sum( X.^2, 2));
X = X ./ repmat(norme, 1,size(X1,2));

K = 10;
delta = inf;
stop = -100*ones(1,K);
stop(1) = -50 ;
%stop(4) = -1500 ;
maxiter = 3000;
convergenceCriterion = 1e-9;
verbose = true;
[SL SD] = spca(X, [], K, delta, stop, maxiter, convergenceCriterion, verbose);

t = 1:size(X,2);
figure; imagesc(SL')
figure
plot(t, sqrt(SD(1:4))*ones(1,size(X,2)).*SL(:,1:4)');  
scores = X * SL;
figure; plot(scores(:,1), scores(:,2), 'ok')
%%
%%
scoresAll = [];
scoresAll = scores;
d = 500;
n_clusters = 10;
options = statset('MaxIter',1000); 
clusterX = nan*ones(size(scoresAll,1),n_clusters-1);
aic = [];
bic = [];
nll = [];
gmfit = [];
c = 1;

for k = 1:n_clusters-1
    gmfit{k} = fitgmdist(scoresAll,k+1,'CovarianceType','diagonal',...
        'SharedCovariance',false,'Options',options, 'Regularize', 1e-5);
    clusterX(:,k) = cluster(gmfit{k},scoresAll);
    aic(k) = gmfit{k}.AIC;
    bic(k) = gmfit{k}.BIC;
    nll(k) = gmfit{k}.NegativeLogLikelihood;
end

%%
figure;
clust_axis = 2:n_clusters;
hold on
plot(clust_axis, bic);
plot(clust_axis, aic);
plot(clust_axis, nll);
hold off
legend('BIC', 'AIC', 'neg log-likelihood')
figure;
hold on
plot(clust_axis, [0 diff(bic)]);
plot(clust_axis, [0 diff(aic)]);
plot(clust_axis, [0 diff(nll)]);
hold off
legend('BIC', 'AIC', 'neg log-likelihood')
%%
for idxModel = 1:6
    figure
    I = idxModel;
    idxPlot = 0;
    for idxClust = 1:I+1
        idxPlot = idxPlot + 1;
        clusterID = find(clusterX(:,idxModel)==idxClust);
        response(idxClust, :) = mean(X1(clusterID,:));
        subplot(3,3,idxPlot)
        hold on
        plot(response(idxClust, :) - mean(response(idxClust, 1:400)), 'linewidth', 1, 'color', 'k');
        hold off
    end
end
%%
p = posterior(gmfit{5},scoresAll);
%%
pcxPsth = [allPsthP15(:,11:1991); allPsthPA(:,11:1991); allPsthPN(:,11:1991); allPsthPC2(:,11:1991)];
pcxLog  = [cellOdorLogP15; cellOdorLogPA; cellOdorLogPN; cellOdorLogPC2];
sizePcx = size(pcxPsth,1);
sizePcx15 = size(allPsthP15,1);
sizePcxA = size(allPsthPA,1);
sizePcxN = size(allPsthPN,1);
sizePcxC = size(allPsthPC2,1);
pcxLog = [[ones(sizePcx15,1); 2*ones(sizePcxA,1); 3*ones(sizePcxN,1); 4*ones(sizePcxC,1)] pcxLog];
coaPsth = [allPsthC15(:,11:1991); allPsthCA(:,11:1991); allPsthCN(:,11:1991); allPsthCC2(:,11:1991)];
coaLog  = [cellOdorLogC15; cellOdorLogCA; cellOdorLogCN; cellOdorLogCC2];
sizeCoa = size(coaPsth,1);
sizeCoa15 = size(allPsthC15,1); %1
sizeCoaA = size(allPsthCA,1); %2
sizeCoaN = size(allPsthCN,1); %3
sizeCoaC = size(allPsthCC2,1); %4
coaLog = [[ones(sizeCoa15,1); 2*ones(sizeCoaA,1); 3*ones(sizeCoaN,1); 4*ones(sizeCoaC,1)] coaLog];

% pcxPsth = [allPsthP15; allPsthPA; allPsthPN; allPsthPC2];
% pcxLog  = [cellOdorLogP15; cellOdorLogPA; cellOdorLogPN; cellOdorLogPC2];
% sizePcx = size(pcxPsth,1);
% coaPsth = [allPsthC15; allPsthCA; allPsthCN; allPsthCC2];
% coaLog  = [cellOdorLogC15; cellOdorLogCA; cellOdorLogCN; cellOdorLogCC2];
% sizeCoa = size(coaPsth,1);


goodClustersPcx = clusterX(1:sizePcx,5);
goodClustersCoa = clusterX(sizePcx+1:end,5);
goodPosteriorsPcx = p(1:sizePcx,:);
goodPosteriorsCoa = p(sizePcx+1:end,:);
%%
for idxCluster = [1 3 4 5 6]
    cellpcx = nan(3,5);
    cellcoa = nan(3,5);
    
    [x,sortedI] = sort(goodPosteriorsPcx(:,idxCluster), 'descend');   
    cellpcx(1,:) = pcxLog(sortedI(1),:);
    cellpcx(2,:) = pcxLog(sortedI(2),:);
    cellpcx(3,:) = pcxLog(sortedI(3),:);
    
    for idx = 1:3
        switch cellpcx(idx,1)
            case 1
                plotRasterCellOdorPair(pcx15_1.espe,cellpcx(idx,2:end))
            case 2
                plotRasterCellOdorPair(pcxAA_1.espe,cellpcx(idx,2:end))
            case 3
                plotRasterCellOdorPair(pcxNM_1.espe,cellpcx(idx,2:end))
            case 4
                plotRasterCellOdorPair(pcxCS2_1.espe,cellpcx(idx,2:end))
        end
    end
    
    [~,sortedI] = sort(goodPosteriorsCoa(:,idxCluster), 'descend');
    cellcoa(1,:) = coaLog(sortedI(1),:);
    cellcoa(2,:) = coaLog(sortedI(2),:);
    cellcoa(3,:) = coaLog(sortedI(3),:);
    for idx = 1:3
        switch cellcoa(idx,1)
            case 1
                plotRasterCellOdorPair(coa15_1.espe,cellcoa(idx,2:end))
            case 2
                plotRasterCellOdorPair(coaAA_1.espe,cellcoa(idx,2:end))
            case 3
                plotRasterCellOdorPair(coaNM_1.espe,cellcoa(idx,2:end))
            case 4
                plotRasterCellOdorPair(coaCS2_1.espe,cellcoa(idx,2:end))
        end
    end
    
end
    
%%
%saveOpenFigures(30)
    
    





