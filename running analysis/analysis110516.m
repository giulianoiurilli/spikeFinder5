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
%% Distribution Odor Representations Correlations
[tuningCurvesCoa, tuningCurvesSigCoa] = findTuningCurves(coa.esp, 1:6);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
tuningCurvesSigNormCoa = zscore(tuningCurvesSigCoa');
tuningCurvesSigNormCoa = tuningCurvesSigNormCoa';
rhoSigCoa = 1-pdist(tuningCurvesSigNormCoa, 'correlation');
[fCoa,xiCoa] = ksdensity(rhoSigCoa);
plot(xiCoa,fCoa, 'color', coaC, 'linewidth', 1)
xlabel('signal correlation')
ylabel('p.d.f.')

hold on

[tuningCurvesPcx, tuningCurvesSigPcx] = findTuningCurves(pcx.esp, 1:6);

tuningCurvesSigNormPcx = zscore(tuningCurvesSigPcx');
tuningCurvesSigNormPcx = tuningCurvesSigNormPcx';
rhoSigPcx = 1-pdist(tuningCurvesSigNormPcx, 'correlation');
[fPcx,xiPcx] = ksdensity(rhoSigPcx);
plot(xiPcx,fPcx, 'color', pcxC, 'linewidth', 1)
xlabel('signal correlation')
ylabel('p.d.f.')




%%
tuningCurvesSigNorm = [tuningCurvesSigNormCoa; tuningCurvesSigNormPcx];
mappedX = tsne(tuningCurvesSigNorm);
c1 = repmat(coaC,size(tuningCurvesSigNormCoa,1),1);
c2 = repmat(pcxC,size(tuningCurvesSigNormPcx,1),1);
c = [c1; c2];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
scatter(mappedX(:,1), mappedX(:,2), [], c)
xlabel('tsne 1')
ylabel('tsne 2')
title('odor tuning profiles of responsive neurons')


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

