odors = 1:15;

[allSdfCoa15, allGvarCoa15, cellLogAllSdfsCoa15] = collectAllExcitatorySdfs(coa15.esp, coa151.espe, odors);
[allSdfPcx15, allGvarPcx15, cellLogAllSdfsPcx15] = collectAllExcitatorySdfs(pcx15.esp, pcx151.espe, odors);
[allSdfCoaAA, allGvarCoaAA, cellLogAllSdfsCoaAA] = collectAllExcitatorySdfs(coaAA.esp, coaAA1.espe, odors);
[allSdfPcxAA, allGvarPcxAA, cellLogAllSdfsPcxAA] = collectAllExcitatorySdfs(pcxAA.esp, pcxAA1.espe, odors);

oneS  = size(allGvarCoa15,2) * 1000 / 30000;
start1 = floor(size(allGvarCoa15,2) / 2 - 0.1*oneS);
end1 = floor(size(allGvarCoa15,2) / 2 + 2*oneS);
start2 = floor(size(allGvarCoa15,2) / 2 - 2*oneS);
end2 = floor(size(allGvarCoa15,2) / 2 + 4*oneS);

X1 = [allSdfCoa15(:,start1:end1-1); allSdfCoaAA(:,start1:end1-1); allSdfPcx15(:,start1:end1-1); allSdfPcxAA(:,start1:end1-1)];
X2 = [allSdfCoa15(:,start2:end2-1); allSdfCoaAA(:,start2:end2-1); allSdfPcx15(:,start2:end2-1); allSdfPcxAA(:,start2:end2-1)];
X2 = X2 - repmat(mean(X2,2), 1,size(X2,2));
norme = sqrt(sum( X2.^2, 2));
X2 = X2 ./ repmat(norme, 1,size(X2,2));

Y1 = [allGvarCoa15(:,start1:end1-1); allGvarCoaAA(:,start1:end1-1); allGvarPcx15(:,start1:end1-1); allGvarPcxAA(:,start1:end1-1)];
Y2 = [allGvarCoa15(:,start2:end2-1); allGvarCoaAA(:,start2:end2-1); allGvarPcx15(:,start2:end2-1); allGvarPcxAA(:,start2:end2-1)];
Y2 = Y2 - repmat(mean(Y2,2), 1,size(Y2,2));
norme = sqrt(sum( Y2.^2, 2));
Y2 = Y2 ./ repmat(norme, 1,size(Y2,2));

s1 = size(cellLogAllSdfsCoa15,1);
s2 = size(cellLogAllSdfsCoaAA,1);
s3 = size(cellLogAllSdfsPcx15,1);
s4 = size(cellLogAllSdfsPcxAA,1);
idArea = [zeros(s1,1); zeros(s2,1); ones(s3,1); ones(s4,1)];
idExpType = [zeros(s1,1); ones(s2,1); zeros(s3,1); ones(s4,1)];
L = [cellLogAllSdfsCoa15; cellLogAllSdfsCoaAA; cellLogAllSdfsPcx15; cellLogAllSdfsPcxAA];
L = [L idArea idExpType];

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

%% spca for gVar
XG = [];
SLG = [];
SDG = [];
XG = Y1 - repmat(mean(Y1,2), 1,size(Y1,2));
norme = sqrt(sum( XG.^2, 2));
XG = XG ./ repmat(norme, 1,size(Y1,2));

K = 10;
delta = inf;
stop = -100*ones(1,K);
stop(1) = -50 ;
%stop(4) = -1500 ;
maxiter = 3000;
convergenceCriterion = 1e-9;
verbose = true;
[SLG SDG] = spca(XG, [], K, delta, stop, maxiter, convergenceCriterion, verbose);

t = 1:size(XG,2);
figure; imagesc(SLG')
figure
plot(t, sqrt(SDG(1:4))*ones(1,size(X,2)).*SLG(:,1:4)');  
scoresG = XG * SLG;
figure; plot(scoresG(:,1), scoresG(:,2), 'ok')

%%
scoresAll = [];
%scoresAll = [scores scoresG];
scoresAll = [scoresG];
%scoresAll = [scores];
d = 500;
n_clusters = 30;
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
oneS  = size(scores,1) * 1000 / 30000;
start1 = floor(size(scores,1) / 2 - 0.1*oneS);
end1 = floor(size(scores,1) / 2 + 2*oneS);
start2 = floor(size(scores,1) / 2 - 2*oneS);
end2 = floor(size(scores,1) / 2 + 4*oneS);
for idxModel = 1:11
    figure
    I = idxModel + 1;
    idxPlot = 0;
    for idxClust = 1:I
        idxPlot = idxPlot + 1;
        clusterID = find(clusterX(:,idxModel)==idxClust);
        response(idxClust, :) = mean(X2(clusterID,:));
        varG(idxClust, :) = mean(Y2(clusterID,:));
        subplot(6,2,idxPlot)
        hold on
        plot(response(idxClust, :) - mean(response(idxClust, 1:2*oneS)));
        plot(varG(idxClust, :) - mean(varG(idxClust, 1:2*oneS)));
        hold off
    end
end

%%
p = posterior(gmfit{9},scoresAll);