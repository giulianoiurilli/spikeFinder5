pcx = load('aPCx_natMix_2.mat');
%%
coa = load('plCoA_natMix_2.mat');
%%
odors = 1:15;
coaC = [228,26,28]./255;
pcxC = [55,126,184]./255;
%%
folder = fullfile(pwd, 'binnedSUA13odors');
mkdir(folder)
prepareDataForClassification(esp, 13, folder);
%%
folder = fullfile(pwd, 'binnedSUA13odors');
options.classifierType = 1;
[meanAccuracyPcxRadBasis, stdevAccuracyPcxRadBasis, confMatPcxRadBasis] = findClassificationAccuracy(pcx.esp, 13, folder, options);
options.classifierType = 3;
[meanAccuracyPcxLinear, stdevAccuracyPcxLinear, confMatPcxLinear] = findClassificationAccuracy(pcx.esp, 13, folder, options);
%%
folder = fullfile(pwd, 'binnedSUA13odors');
options.classifierType = 1;
[meanAccuracyCoaRadBasis, stdevAccuracyCoaRadBasis, confMatCoaRadBasis] = findClassificationAccuracy(coa.esp, 13, folder, options);
options.classifierType = 3;
[meanAccuracyCoaLinear, stdevAccuracyCoaLinear, confMatCoaLinear] = findClassificationAccuracy(coa.esp, 13, folder, options);
%% plot classification results
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(meanAccuracyCoaLinear, 'color', coaC, 'linewidth', 1)
hold on
plot(meanAccuracyCoaRadBasis, ':','color', coaC, 'linewidth', 1)
hold on
plot(meanAccuracyPcxLinear, 'color', pcxC, 'linewidth', 1)
hold on
plot(meanAccuracyPcxRadBasis, ':','color', pcxC, 'linewidth', 1)
xlabel('Number of Neurons')
ylabel('Accuracy')
title('Linear and non linear odor discrimination')

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 1];
subplot(1,2,1)
imagesc(confMatCoaLinear, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
title('plCoA')
subplot(1,2,2)
imagesc(confMatPcxLinear, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
title('aPCx')
suptitle('Confusion Matrix')

%% Correlation Matrix Odor Representations
[rhoOdorRepresentationsSigCoa, rhoMeanOdorRepresentationsSigCoa] = findOdorRepresentationCorrelation(coa.esp, 1:6);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 1];
imagesc(rhoOdorRepresentationsSigCoa, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
colorbar
title('Corrleation between odor representations - plCoA')

[rhoOdorRepresentationsSigPcx, rhoMeanOdorRepresentationsSigPcx] = findOdorRepresentationCorrelation(pcx.esp, 1:6);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 1];
imagesc(rhoOdorRepresentationsSigPcx, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
colorbar
title('Corrleation between odor representations - aPCx')

%%
idx = triu(true(6,6),1);
odorCorrCoa = rhoMeanOdorRepresentationsSigCoa(idx);
odorCorrPcx = rhoMeanOdorRepresentationsSigPcx(idx);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(odorCorrCoa);
plot(xiCoa,fCoa, 'color', coaC, 'linewidth', 1)
xlabel('correlation')
ylabel('p.d.f.')
hold on
[fPcx,xiPcx] = ksdensity(odorCorrPcx);
plot(xiPcx,fPcx, 'color', pcxC, 'linewidth', 1)
xlabel('correlation')
ylabel('p.d.f.')
title('Distribution of correlations between odor representations')
xlim([-1.2 1.2])
%% Distribution Odor Representations Correlations
bw = 0.1;
[tuningCurvesCoa, tuningCurvesSigCoa, tuningCurvesCoaAuRocSig] = findTuningCurves(coa.esp, 1:6);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
tuningCurvesSigNormCoa = zscore(tuningCurvesSigCoa');
tuningCurvesSigNormCoa = tuningCurvesSigNormCoa';
rhoSigCoa = 1-pdist(tuningCurvesSigNormCoa, 'correlation');
[fCoa,xiCoa] = ksdensity(rhoSigCoa, 'bandwidth', bw);
plot(xiCoa,fCoa, 'color', coaC, 'linewidth', 1)
xlabel('signal correlation')
ylabel('p.d.f.')

hold on

[tuningCurvesPcx, tuningCurvesSigPcx, tuningCurvesPcxAuRocSig] = findTuningCurves(pcx.esp, 1:6);

tuningCurvesSigNormPcx = zscore(tuningCurvesSigPcx');
tuningCurvesSigNormPcx = tuningCurvesSigNormPcx';
rhoSigPcx = 1-pdist(tuningCurvesSigNormPcx, 'correlation');
[fPcx,xiPcx] = ksdensity(rhoSigPcx, 'bandwidth', bw);
plot(xiPcx,fPcx, 'color', pcxC, 'linewidth', 1)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
%%
Y = [];
Z = [];
Y = pdist(tuningCurvesSigCoa);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesSigCoa,1));

%T = [];
%T = cluster(Z, 'maxclust', 2);
app = [];
app = [tuningCurvesCoaAuRocSig outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurves = app;
clims = [0 1];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(tuningCurves,clims);
colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

%%
% tuningCurvesSigNorm = [tuningCurvesSigNormCoa; tuningCurvesSigNormPcx];
% tuningCurvesSigNorm = [tuningCurvesSigNormCoa];
tuningCurvesSigNorm = [tuningCurvesSigNormPcx];
mappedX = tsne(tuningCurvesSigNorm, [], 3);
c1 = repmat(coaC,size(tuningCurvesSigNormCoa,1),1);
c2 = repmat(pcxC,size(tuningCurvesSigNormPcx,1),1);
c = [c1; c2];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
%scatter(mappedX(:,1), mappedX(:,2), [], c)
scatter(mappedX(:,1), mappedX(:,2))
xlabel('tsne 1')
ylabel('tsne 2')
title('odor tuning profiles of responsive neurons')



%%
%%

n_clusters = 6;
options = statset('MaxIter',1000); 
clusterX = nan*ones(size(mappedX,1),n_clusters-1);
aic = [];
bic = [];
nll = [];
gmfit = [];
c = 1;

for k = 1:n_clusters-1
    gmfit{k} = fitgmdist(mappedX,k+1,'CovarianceType','diagonal',...
        'SharedCovariance',false,'Options',options, 'Regularize', 1e-5);
    clusterX(:,k) = cluster(gmfit{k},mappedX);
    aic(k) = gmfit{k}.AIC;
    bic(k) = gmfit{k}.BIC;
    nll(k) = gmfit{k}.NegativeLogLikelihood;
end


%%

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
figure





colorClass = [];
for idx = 1: size(mappedX,1)
    clu = clusterX(idx,2);
    switch clu
        case 1
            colorClass(idx,:) = [228,26,28]./255;
        case 2
            colorClass(idx,:) = [55,126,184]./255;
        case 3
            colorClass(idx,:) = [77,175,74]./255;
    end
end

        scatter3(mappedX(:,1), mappedX(:, 2), mappedX(:, 3), 100, colorClass, 'o', 'filled');

xlabel('tsne1');
ylabel('tsne2');
zlabel('tsne3');
title('aPCx');
%%
X = tuningCurvesSigNormCoa;
% X = tuningCurvesSigNormPcx;
X = [X clusterX(:,2)];
X = sortrows(X, size(X,2));
X(:,size(X,2)) = [];
clims = [-2 2];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(X);
colormap(brewermap([],'*PuBuGn')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
%% Fraction of excited neurons per odor
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa] = findNumberOfSua(coa.esp, 1:6);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
x = totalResponsiveNeuronPerOdorCoa./ totalSUACoa;
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx] = findNumberOfSua(pcx.esp, 1:6);
y = totalResponsiveNeuronPerOdorPcx./ totalSUAPcx;
set(gcf,'color','white', 'PaperPositionMode', 'auto');

all = [x', y'];

b = bar(all);
b(1).FaceColor = coaC;
b(1).EdgeColor = coaC;
b(2).FaceColor = pcxC;
b(2).EdgeColor = pcxC;

xlabel('odor I.D.')
ylabel('fraction of excited neurons')



%% Distribution of lifetime sparseness
[lsCoa, cellLogCoa, lsSigCoa, cellLogSigCoa] = findLifetimeSparseness(coa.esp, 1:6);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(lsCoa(~isnan(lsCoa)));
plot(xiCoa,fCoa,'color', coaC, 'linewidth', 1)
hold on
% [fCoa,xiCoa] = ksdensity(lsSigCoa(~isnan(lsSigCoa)));
% plot(xiCoa,fCoa, ':', 'color', coaC, 'linewidth', 1)

[lsPcx, cellLogPcx, lsSigPcx, cellLogSigPcx] = findLifetimeSparseness(pcx.esp, 1:6);
[fPcx,xiPcx] = ksdensity(lsPcx(~isnan(lsPcx)));
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
% hold on
% [fPcx,xiPcx] = ksdensity(lsSigPcx(~isnan(lsSigPcx)));
% plot(xiPcx,fPcx, ':', 'color', coaC, 'linewidth', 1)

xlabel('lifetime sparseness')
ylabel('fraction of neurons')


%% Plot grand-average PSTH per odor
meanPSTHCoa = plotMeanPSTHPerOdor(coa.esp, 1:6, coaC);
meanPSTHPcx = plotMeanPSTHPerOdor(pcx.esp, 1:6, pcxC);

%% Distributions per Shank
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coa.esp, 1:6, 0);
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcx.esp, 1:6, 0);

%
%% class l-svm - 6 odors
n_comb = nchoosek(6,2)/2;


combinations = combnk(1:6, 3);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = 1:6;
odorsRearrangedPcx = 1:6;
odorsRearranged2Coa = nan*ones(size(combinations,1),6);
odorsRearranged2Pcx = nan*ones(size(combinations,1),6);
accuracyResponses2CoaAAaaTrueNoDecorr = l_svmClassify_new(coa.esp, odorsRearrangedCoa,7);
accuracyResponses2PcxAAaaTrueNoDecorr = l_svmClassify_new(pcx.esp, odorsRearrangedPcx,7);
aa2CoaNoDecorr = nan(size(combinations,1), size(accuracyResponses2CoaAAaaTrueNoDecorr,2));
aa2PcxNoDecorr = nan(size(combinations,1), size(accuracyResponses2PcxAAaaTrueNoDecorr,2));
for idxRep = 1:size(combinations,1)
    odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
    accuracyResponses2CoaAAaa = l_svmClassify_new(coa.esp, odorsRearranged2Coa(idxRep,:),7);
    aa2CoaNoDecorr(idxRep,:) = mean(accuracyResponses2CoaAAaa);
    odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
    accuracyResponses2PcxAAaa = l_svmClassify_new(pcx.esp, odorsRearranged2Pcx(idxRep,:),7);
    aa2PcxNoDecorr(idxRep,:) = mean(accuracyResponses2PcxAAaa);
end

figure;
dataToPlot = {accuracyResponses2CoaAAaaTrueNoDecorr, accuracyResponses2PcxAAaaTrueNoDecorr, aa2CoaNoDecorr, aa2PcxNoDecorr};
catIdx = [zeros(1000,1); ones(1000,1); 2*ones(n_comb,1); 3*ones(n_comb, 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)