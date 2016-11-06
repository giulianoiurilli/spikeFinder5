



%% fraction of excited neurons per odor
figure
bar(totalResponseOdor./ totalSUA)
figure
bar(totalResponseOdor./ totalResponsiveSUA)


%% tuning curves and overall signal correlation





figure

tuningCurvesSigNorm = zscore(tuningCurvesSig');
tuningCurvesSigNorm = tuningCurvesSigNorm';


rhoSig = 1-pdist(tuningCurvesSigNorm, 'correlation');
[f,xi] = ksdensity(rhoSig);
plot(xi,f)

%%


mappedX = tsne(tuningCurvesSigNorm);

figure
scatter(mappedX(:,1), mappedX(:,2))



%% lifetimeSparseness




% figure
hold on
[f,xi] = ksdensity(ls);
plot(xi,f)













