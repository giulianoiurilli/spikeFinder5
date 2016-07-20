clc
odors = 1:15;
odorsAA = 1:10;
odorsMix = [1 11 12 6 13 14];
%% Load'em all
load('parameters.mat');
coaAAMix1 = load('coa_AAmix_2_1.mat');
coa151 = load('coa_15_2_1.mat');
coaCs1 = load('coa_CS_2_1.mat');
coaAAMix2 = load('coa_AAmix_2_2.mat');
coa152 = load('coa_15_2_2.mat');
coaCs2 = load('coa_CS_2_2.mat');

pcxAAMix1 = load('pcx_AAmix_2_1.mat');
pcx151 = load('pcx_15_2_1.mat');
pcxCs1 = load('pcx_CS_2_1.mat');
pcxAAMix2 = load('pcx_AAmix_2_2.mat');
pcx152 = load('pcx_15_2_2.mat');
pcxCs2 = load('pcx_CS_2_2.mat');

%% Tuning curves
% [auroc300Coa15, significantAuroc300Coa15, auroc1Coa15, significantAuroc1Coa15] = makeTuningCurves2(coa152.esp, odors);
% [auroc300CoaCs, significantAuroc300CoaCs, auroc1CoaCs, significantAuroc1CoaCs] = makeTuningCurves2(coaCs2.esp, odors);
% [auroc300CoaAA, significantAuroc300CoaAA, auroc1CoaAA, significantAuroc1CoaAA] = makeTuningCurves2(coaAAMix2.esp, odorsAA);
% [auroc300CoaMix, significantAuroc300CoaMix, auroc1CoaMix, significantAuroc1CoaMix] = makeTuningCurves2(coaAAMix2.esp, odorsMix);
% 
% [auroc300Pcx15, significantAuroc300Pcx15, auroc1Pcx15, significantAuroc1Pcx15] = makeTuningCurves2(pcx152.esp, odors);
% [auroc300PcxCs, significantAuroc300PcxCs, auroc1PcxCs, significantAuroc1PcxCs] = makeTuningCurves2(pcxCs2.esp, odors);
% [auroc300PcxAA, significantAuroc300PcxAA, auroc1PcxAA, significantAuroc1PcxAA] = makeTuningCurves2(pcxAAMix2.esp, odorsAA);
% [auroc300PcxMix, significantAuroc300PcxMix, auroc1PcxMix, significantAuroc1PcxMix] = makeTuningCurves2(pcxAAMix2.esp, odorsMix);
% 
% 
%% Find response types
[allSdfCoa15, cellLogAllSdfsCoa15] = collectAllSdfs(coa15.esp,coa151.espe, 1:15);
[allSdfCoaCs, cellLogAllSdfsCoaCs] = collectAllSdfs(coaCS.esp,coaCS1.espe, 1:15);
[allSdfCoaAA, cellLogAllSdfsCoaAA] = collectAllSdfs(coaAA.esp,coaAA1.espe, 1:10);
[allSdfCoaMix, cellLogAllSdfsCoaMix] = collectAllSdfs(coaAA.esp,coaAA1.espe, 11:14);
[allSdfPcx15, cellLogAllSdfsPcx15] = collectAllSdfs(pcx15.esp,pcx151.espe, 1:15);
[allSdfPcxCs, cellLogAllSdfsPcxCs] = collectAllSdfs(pcxCS.esp,pcxCS1.espe, 1:15);
[allSdfPcxAA, cellLogAllSdfsPcxAA] = collectAllSdfs(pcxAA.esp,pcxAA1.espe, 1:10);
[allSdfPcxMix, cellLogAllSdfsPcxMix] = collectAllSdfs(pcxAA.esp,pcxAA1.espe, 11:14);

idxArea = [zeros(size(cellLogAllSdfsCoa15,1) + size(cellLogAllSdfsCoaCs,1) + size(cellLogAllSdfsCoaAA,1) + size(cellLogAllSdfsCoaMix,1),1);...
            ones(size(cellLogAllSdfsPcx15,1) + size(cellLogAllSdfsPcxCs,1) + size(cellLogAllSdfsPcxAA,1) + size(cellLogAllSdfsPcxMix,1),1)];
idxExpType = [ones(size(cellLogAllSdfsCoa15,1),1); 2*ones(size(cellLogAllSdfsCoaCs,1),1); 3*ones(size(cellLogAllSdfsCoaAA,1),1); 4*ones(size(cellLogAllSdfsCoaMix,1),1);...
               ones(size(cellLogAllSdfsPcx15,1),1); 2*ones(size(cellLogAllSdfsPcxCs,1),1); 3*ones(size(cellLogAllSdfsPcxAA,1),1); 4*ones(size(cellLogAllSdfsPcxMix,1),1)]; 
allSdf = [allSdfCoa15; allSdfCoaCs; allSdfCoaAA; allSdfCoaMix; allSdfPcx15; allSdfPcxCs; allSdfPcxAA; allSdfPcxMix];
cellLogAllResponses = [cellLogAllSdfsCoa15; cellLogAllSdfsCoaCs; cellLogAllSdfsCoaAA; cellLogAllSdfsCoaMix; cellLogAllSdfsPcx15; cellLogAllSdfsPcxCs; cellLogAllSdfsPcxAA; cellLogAllSdfsPcxMix];
cellLogAllResponses = [cellLogAllResponses idxArea idxExpType];

%%
X1 = [];
X1 = allSdf(:,14800:19000-1);
X = [];
SL = [];
SD = [];
X = X1 - repmat(mean(X1,2), 1,size(X1,2));
norme = sqrt(sum( X.^2, 2));
X = X ./ repmat(norme, 1,size(X1,2));

K = 10;
delta = inf;
stop = -800*ones(1,K);
stop(1) = -200 ;
stop(4) = -1500 ;
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
d = 500;
n_clusters = 30;
x1 = linspace(min(X(:,1)) - 2,max(X(:,1)) + 2,d);
x2 = linspace(min(X(:,2)) - 2,max(X(:,2)) + 2,d);
[x1grid,x2grid] = meshgrid(x1,x2);
X0 = [x1grid(:) x2grid(:)];
threshold = sqrt(chi2inv(0.99,2));
options = statset('MaxIter',1000); 
clusterX = nan*ones(size(scores,1),n_clusters-1);
aic = [];
bic = [];
nll = [];
gmfit = [];
c = 1;

for k = 1:n_clusters-1
    gmfit{k} = fitgmdist(scores,k+1,'CovarianceType','diagonal',...
        'SharedCovariance',false,'Options',options, 'Start', 'plus', 'Replicates', 10, 'Regularize', 1e-5);
    clusterX(:,k) = cluster(gmfit{k},scores);
    aic(k) = gmfit{k}.AIC;
    bic(k) = gmfit{k}.BIC;
    nll(k) = gmfit{k}.NegativeLogLikelihood;
end
% %%
% I = [];
% 
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
%eva = evalclusters(scores, 'gmdistribution', 'gap', 'Klist', 1:20);
%evaDB = evalclusters(scores, 'gmdistribution', 'DaviesBouldin', 'Klist', 1:20);
%figure;
%plot(eva)
% figure;
% plot(evaDB)
%%
t = -200:3999;
totalPropTitle = 'tot: ';
pcxPropTitle = '; pcx: ';
coaPropTitle = '; coa: ';
perc = '%';
for idxModel = 9
    I = idxModel+1;
    allResponsesInCluster = nan * ones(I,4200);
    proportionTot = nan*ones(1,I);
    proportionPcx = nan*ones(1,I);
    proportionCoa = nan*ones(1,I);
    for idxClust = 1:I
        clusterID = find(clusterX(:,idxModel)==idxClust);
        proportionTot(idxClust) = numel(clusterID)./size(X,1) * 100;
        responsesInCluster = cellLogAllResponses(clusterID,:);
        responsesInPcx = responsesInCluster(responsesInCluster(:,5)==1,:);
        responsesInCoa = responsesInCluster(responsesInCluster(:,5)==0,:);
        proportionPcx(idxClust) = size(responsesInPcx,1)./size(X(cellLogAllResponses(:,5) == 1),1) * 100;
        proportionCoa(idxClust) = size(responsesInCoa,1)./size(X(cellLogAllResponses(:,5) == 0),1) * 100;
        allResponsesInCluster(idxClust,:) = nanmean(X(clusterID,:));
    end
    D = pdist(gmfit{1,idxModel}.mu, 'euclidean');
    tree = linkage(D, 'average');
    leafOrder = optimalleaforder(tree, D);
    figure;
    set(gcf,'Position',[122 62 1572 996]);
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    titolo = sprintf('%i', idxModel);
    suptitle(titolo)
    idxPlot = 0;
    for idxClust = 1:numel(leafOrder)
        idxPlot = idxPlot + 1;
        useClust = leafOrder(idxClust);
        subplot(5,6,idxPlot)
        plot(t, allResponsesInCluster(useClust,:) - mean(allResponsesInCluster(useClust,1:200)));
        ylim([-0.04 0.055]);
        xlim([-200 4000]);
        tit = sprintf('%s%.1f%s%s%.1f%s%s%.1f%s', totalPropTitle, proportionTot(useClust), perc, coaPropTitle, proportionCoa(useClust), perc, coaPropTitle, proportionPcx(useClust), perc);
        title(tit)
    end
end















