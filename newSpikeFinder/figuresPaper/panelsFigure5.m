Mnmc = find_Baseline_DeltaRsp_FanoFactor_new(coaNM.esp, 1:13, 1000, 0);
Mnmp = find_Baseline_DeltaRsp_FanoFactor_new(pcxNM.esp, 1:13, 1000, 0);
%
auRocCOAnm = Mnmc.auRoc;
auRocPCXnm = Mnmp.auRoc;
sigCOAnm = Mnmc.significance;
sigPCXnm = Mnmp.significance;
 
auRocCOAnm = auRocCOAnm(:);
auRocPCXnm = auRocPCXnm(:);
sigCOAnm = logical(sigCOAnm(:));
sigPCXnm = logical(sigPCXnm(:));
 
 
allauRocCoa = [auRocCOAnm];
allauRocPcx = [auRocPCXnm];
allSigCoa = [sigCOAnm];
allSigPcx = [sigPCXnm];
 
% bar plot auROCExc/odor
X1 = Mnmc.auRoc;
X1(Mnmc.significance<1) = NaN;
for j = 1:13
    app = [];
    app = X1(:,j);
    app(isnan(app)) = [];
    notnanX1(j) = numel(app);
end
X1app = X1;
X1appNotnan = notnanX1;
X1mean = nanmean(X1app);
X1sem = nanstd(X1app) ./ sqrt(X1appNotnan - ones(1,13));
 
Y1 = Mnmp.auRoc;
Y1(Mnmp.significance<1) = NaN;
for j = 1:13
    app = [];
    app = Y1(:,j);
    app(isnan(app)) = [];
    notnanY1(j) = numel(app);
end
Y1app = Y1;
Y1appNotnan = notnanY1;
Y1mean = nanmean(Y1app);
Y1sem = nanstd(Y1app) ./ sqrt(Y1appNotnan - ones(1,13));
 
%
errorbar_groups(X1mean(1:13),X1sem(1:13),'bar_colors', coaC, 'errorbar_colors', coaC)
ylim([0.5 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'helvetica', 'fontsize', 14)
 
errorbar_groups(Y1mean(1:13),Y1sem(1:13),'bar_colors', pcxC, 'errorbar_colors', pcxC)
ylim([0.5 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'helvetica', 'fontsize', 14)
 
%%
longList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'};
shortList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13'};
longTicks = 0.15:15.15;
shortTicks = 0.15:13.15;
[actOdorPcx, supOdorPcx] = proportionActivatingOdors_new(pcxNM.esp, 1:13, 0);
[actOdorCoa, supOdorCoa] = proportionActivatingOdors_new(coaNM.esp, 1:13, 0);
 
N = histcounts(actOdorPcx,0:14); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(actOdorCoa,0:14); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));
 
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:13, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8)
hold on
errorbar(0.3:13.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8)
xlim([-1 14.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , shortTicks);
set(gca, 'XTickLabel', shortList);
xlabel({'Excitatory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
 
 
N = histcounts(supOdorPcx,0:14); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(supOdorCoa,0:14); 
PCoa = N./ sum(N);
 
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:13, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8)
hold on
errorbar(0.3:13.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8)
xlim([-1 14.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , shortTicks);
set(gca, 'XTickLabel', shortList);
xlabel({'Inhibitory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
[tuningCurvesCoa, tuningCurvesSigCoa, tuningCurvesCoaAuRoc, tuningCurvesCoaAuRocSig] = findTuningCurves(coaNM.esp, 1:13, 0);
[tuningCurvesPcx, tuningCurvesSigPcx, tuningCurvesPcxAuRoc, tuningCurvesPcxAuRocSig] = findTuningCurves(pcxNM.esp, 1:13, 0);
 
% %%
% Y = [];
% Z = [];
% Y = pdist(tuningCurvesSigCoa);
% Z = linkage(Y);
% figure
% [H, T, outperm] = dendrogram(Z, size(tuningCurvesSigCoa,1));
% app = [];
% app = [tuningCurvesSigCoa outperm'];
% app = sortrows(app, size(app,2));
% app(:,size(app,2)) = [];
% tuningCurvesSigCoa = app;
%  
% clims = [-1 1];
% Ccoa = corr(tuningCurvesSigCoa');
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% imagesc(Ccoa,clims);
% colormap(brewermap([],'*PuBuGn')); axis square
% set(gca,'YColor','w')
% set(gca,'XColor','w')
% set(gca,'XTick',[])
% set(gca,'XTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'YTickLabel',[])
%  
%  
% Y = [];
% Z = [];
% Y = pdist(tuningCurvesCoa);
% Z = linkage(Y);
% figure
% [H, T, outperm] = dendrogram(Z, size(tuningCurvesCoa,1));
% app = [];
% app = [tuningCurvesCoa outperm'];
% app = sortrows(app, size(app,2));
% app(:,size(app,2)) = [];
% tuningCurvesCoa = app;
%  
% clims = [-1 1];
% Ccoa = corr(tuningCurvesCoa');
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% imagesc(Ccoa,clims);
% colormap(brewermap([],'*PuBuGn')); axis square
% set(gca,'YColor','w')
% set(gca,'XColor','w')
% set(gca,'XTick',[])
% set(gca,'XTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'YTickLabel',[])
%  
% %%
% Y = [];
% Z = [];
% Y = pdist(tuningCurvesSigPcx);
% Z = linkage(Y);
% figure
% [H, T, outperm] = dendrogram(Z, size(tuningCurvesSigPcx,1));
% app = [];
% app = [tuningCurvesSigPcx outperm'];
% app = sortrows(app, size(app,2));
% app(:,size(app,2)) = [];
% tuningCurvesSigPcx = app;
%  
% clims = [-1 1];
% Ccoa = corr(tuningCurvesSigPcx');
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% imagesc(Ccoa,clims);
% colormap(brewermap([],'*PuBuGn')); axis square
% set(gca,'YColor','w')
% set(gca,'XColor','w')
% set(gca,'XTick',[])
% set(gca,'XTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'YTickLabel',[])
%  
%  
% Y = [];
% Z = [];
% Y = pdist(tuningCurvesPcx);
% Z = linkage(Y);
% figure
% [H, T, outperm] = dendrogram(Z, size(tuningCurvesPcx,1));
% app = [];
% app = [tuningCurvesPcx outperm'];
% app = sortrows(app, size(app,2));
% app(:,size(app,2)) = [];
% tuningCurvesPcx = app;
%  
% clims = [-1 1];
% Ccoa = corr(tuningCurvesPcx');
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% imagesc(Ccoa,clims);
% colormap(brewermap([],'*PuBuGn')); axis square
% set(gca,'YColor','w')
% set(gca,'XColor','w')
% set(gca,'XTick',[])
% set(gca,'XTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'YTickLabel',[])
%  
%%
clims = [-1 1];
odorsRearranged = 1:13;
[sigCorrCoaNM, corrMatCoaNM, sigCorrCoaNMSig, corrMatCoaNMSig, sigCorr1000msSigSimCoaNM] = findSignalCorrelation_new(coaNM.esp, odorsRearranged, 0.5);
[sigCorrPcxNM, corrMatPcxNM, sigCorrPcxNMSig, corrMatPcxNMSig, sigCorr1000msSigSimPcxNM] = findSignalCorrelation_new(pcxNM.esp, odorsRearranged, 0.5);
 
%%
sigCorrCoaNM = sigCorrCoaNM(:);
sigCorrPcxNM = sigCorrPcxNM(:);
sigCorrCoaNMSig = sigCorrCoaNMSig(:);
sigCorrPcxNMSig = sigCorrPcxNMSig(:);
sigCorr1000msSigSimCoaNM = sigCorr1000msSigSimCoaNM(:);
sigCorr1000msSigSimPcxNM = sigCorr1000msSigSimPcxNM(:);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(sigCorrCoaNM(~isnan(sigCorrCoaNM)));
plot(xiCoa,fCoa,':', 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(sigCorrPcxNM(~isnan(sigCorrPcxNM)));
plot(xiPcx,fPcx, ':','linewidth', 1,'color', pcxC)
hold on
[fCoa,xiCoa] = ksdensity(sigCorrCoaNMSig(~isnan(sigCorrCoaNMSig)));
plot(xiCoa,fCoa,  'linewidth', 1,'color', coaC)
hold on
line([mean(sigCorrCoaNMSig(~isnan(sigCorrCoaNMSig))) mean(sigCorrCoaNMSig(~isnan(sigCorrCoaNMSig)))], [0 max(fCoa)], 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(sigCorrPcxNMSig(~isnan(sigCorrPcxNMSig)));
hold on
line([mean(sigCorrPcxNMSig(~isnan(sigCorrPcxNMSig))) mean(sigCorrPcxNMSig(~isnan(sigCorrPcxNMSig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
hold on
plot(xiPcx,fPcx, 'linewidth', 1,'color', pcxC)
hold on
plot(xiCoa,sigCorr1000msSigSimCoaNM,'--', 'linewidth', 1,'color', coaC)
hold on
plot(xiPcx,sigCorr1000msSigSimPcxNM,'--', 'linewidth', 1,'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylabel('p.d.f.')
xlabel('Signal Correlation')
%%
odorsRearranged = 1:13;
[noiseCorrW1000msCoaNM, noiseCorrB1000msCoaNM, noiseCorrW1000msCoaNMSig, noiseCorrB1000msCoaNMSig] = findNoiseCorrelation_new(coaNM.esp, odorsRearranged, 0.5);
[noiseCorrW1000msPcxNM, noiseCorrB1000msPcxNM, noiseCorrW1000msPcxNMSig, noiseCorrB1000msPcxNMSig] = findNoiseCorrelation_new(pcxNM.esp, odorsRearranged, 0.5);
 
 
B = [noiseCorrW1000msCoaNM, noiseCorrB1000msCoaNM]; 
A = [noiseCorrW1000msPcxNM, noiseCorrB1000msPcxNM];
BSig = [noiseCorrW1000msCoaNMSig, noiseCorrB1000msCoaNMSig]; 
ASig = [noiseCorrW1000msPcxNMSig, noiseCorrB1000msPcxNMSig];
 
%%
B = B(:);
A = A(:);
BSig = BSig(:);
ASig = ASig(:);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(B(~isnan(B)));
plot(xiCoa,fCoa,':', 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(A(~isnan(A)));
plot(xiPcx,fPcx, ':','linewidth', 1,'color', pcxC)
hold on
[fCoa,xiCoa] = ksdensity(BSig(~isnan(BSig)));
plot(xiCoa,fCoa,  'linewidth', 1,'color', coaC)
hold on
line([mean(BSig(~isnan(BSig))) mean(BSig(~isnan(BSig)))], [0 max(fCoa)], 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(ASig(~isnan(ASig)));
plot(xiPcx,fPcx, 'linewidth', 1,'color', pcxC)
hold on
line([mean(ASig(~isnan(ASig))) mean(ASig(~isnan(ASig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
xlim([-1 1])
ylabel('p.d.f.')
xlabel('Noise Correlation')




%%
option = [];
option.units = 'incrementing_by_one';
option.repetitions = 500;
[performanceCoaNM, confusionMatrixCoaNM] = perform_linear_svm_decoding(coaNM.esp, 1:13, option);
[performancePcxNM, confusionMatrixPcxNM] = perform_linear_svm_decoding(pcxNM.esp, 1:13, option);
[performanceTogetherNM, confusionTogetherPcxNM] = perform_linear_svm_decoding([pcxNM.esp coaNM.esp], 1:13, option);

%%
option = [];
option.units = 'incrementing_by_one';
option.repetitions = 50;
option.shuffle  = 1;
option.number_of_shuffles = 10;
[performanceCoaNMshuffled, confusionMatrixCoaNMshuffled] = perform_linear_svm_decoding(coaNM.esp, 1:13, option);
[performancePcxNMshuffled, confusionMatrixPcxNMshuffled] = perform_linear_svm_decoding(pcxNM.esp, 1:13, option);

%% figure
figure
plot(mean(performancePcxNM,1), 'color', pcxC, 'linewidth', 2);
hold on
plot(mean(performanceCoaNM,1), 'color', coaC, 'linewidth', 2);
plot(mean(performanceTogetherNM,1), 'color', [77,175,74]./255, 'linewidth', 2);
plot(mean(performancePcxNMshuffled,1), ':', 'color', pcxC, 'linewidth', 2);
plot(mean(performanceCoaNMshuffled,1),':', 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')

clim = [0 1];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(confusionMatrixCoaNM, clim)
colormap(brewermap([],'*YlGnBu'))
axis square
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

clim = [0 1];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(confusionMatrixPcxNM, clim)
colormap(brewermap([],'*YlGnBu'))
axis square
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
option = [];
option.units = 'incrementing_by_10';
option.repetitions = 500;
option.grouping = [1 1 1 3 2 2 3 1 3 1 3 3 3];
lista = [];
odors = 1:13;
for k = 1:150
    lista(k,:) = randperm(numel(odors));
end

for idxRep = 1:150
    if idxRep == 1
        app1 = perform_linear_svm_decoding(coaNM.esp, lista(idxRep,:),option);
        app2 = perform_linear_svm_decoding(pcxNM.esp, lista(idxRep,:),option);
        performanceGroups1ShuffledCoa = nan(150, size(app1,2));
        performanceGroups1ShuffledPcx = nan(150, size(app2,2));
        performanceGroups1ShuffledCoa(idxRep,:) = mean(app1);
        performanceGroups1ShuffledPcx(idxRep,:) = mean(app2);
    else
        app1 = perform_linear_svm_decoding(coaNM.esp, lista(idxRep,:),option);
        app2 = perform_linear_svm_decoding(pcxNM.esp, lista(idxRep,:),option);
        performanceGroups1ShuffledCoa(idxRep,:) = mean(app1);
        performanceGroups1ShuffledPcx(idxRep,:) = mean(app2);
    end
end

performanceGroups1Coa = perform_linear_svm_decoding(coaNM.esp, odors, option);
performanceGroups1Pcx = perform_linear_svm_decoding(pcxNM.esp, odors, option);
%%
figure
plot(2:10:142,performanceGroups1ShuffledPcx(:,1:15)', 'o', 'color', [166,206,227]./255, 'MarkerSize', 2, 'MarkerFaceColor', pcxC);
hold on
plot(1:10:150, performanceGroups1ShuffledCoa(:,1:15)', 'o', 'color', [251,154,153]./255, 'MarkerSize', 2, 'MarkerFaceColor', coaC);
hold on
plot(2:10:142,mean(performanceGroups1Pcx(:,1:15),1), '-o', 'color', pcxC, 'linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', pcxC);
hold on
plot(1:10:150,mean(performanceGroups1Coa(:,1:15),1),'-o', 'color', coaC, 'linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', coaC);

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
%%
option = [];
option.units = 'incrementing_by_10';
option.repetitions = 500;
option.grouping = [1 1 2 2 3 3 4 4 4 4 4 4 4];
lista = [];
odors = 1:13;
for k = 1:150
    lista(k,:) = randperm(numel(odors));
end

for idxRep = 1:150
    if idxRep == 1
        app1 = perform_linear_svm_decoding(coaNM.esp, lista(idxRep,:),option);
        app2 = perform_linear_svm_decoding(pcxNM.esp, lista(idxRep,:),option);
        performanceGroups2ShuffledCoa = nan(150, size(app1,2));
        performanceGroups2ShuffledPcx = nan(150, size(app2,2));
        performanceGroups2ShuffledCoa(idxRep,:) = mean(app1);
        performanceGroups2ShuffledPcx(idxRep,:) = mean(app2);
    else
        app1 = perform_linear_svm_decoding(coaNM.esp, lista(idxRep,:),option);
        app2 = perform_linear_svm_decoding(pcxNM.esp, lista(idxRep,:),option);
        performanceGroups2ShuffledCoa(idxRep,:) = mean(app1);
        performanceGroups2ShuffledPcx(idxRep,:) = mean(app2);
    end
end

performanceGroups2Coa = perform_linear_svm_decoding(coaNM.esp, odors, option);
performanceGroups2Pcx = perform_linear_svm_decoding(pcxNM.esp, odors, option);

%%
figure
plot(2:10:142,performanceGroups2ShuffledPcx(:,1:15)', 'o', 'color', [166,206,227]./255, 'MarkerSize', 2, 'MarkerFaceColor', pcxC);
hold on
plot(1:10:150,performanceGroups2ShuffledCoa(:,1:15)', 'o', 'color', [251,154,153]./255, 'MarkerSize', 2, 'MarkerFaceColor', coaC);
hold on
plot(2:10:142,mean(performanceGroups2Pcx(:,1:15),1), '-o', 'color', pcxC, 'linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', pcxC);
hold on
plot(1:10:150,mean(performanceGroups2Coa(:,1:15),1),'-o', 'color', coaC, 'linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', coaC);

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
%%
n_odors = 13;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaNM.esp, 1:n_odors, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxNM.esp, 1:n_odors, 1, 0);

option = [];
option.repetitions = 500;
option.grouping = [1 1 2 2 3 3 4 4 4 4 4 4 4];
sua_performance_coa = nan(1,totalResponsiveSUACoa);
sua_MI_coa = nan(1,totalResponsiveSUACoa);
sua_CM_coa =  nan(totalResponsiveSUACoa,16);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(coaNM.esp, 1:n_odors, option);
    sua_performance_coa(idxUnit) = mean(app);
    sua_MI_coa(idxUnit) = miApp;
    sua_CM_coa(idxUnit,:) = app2(:);
end

sua_performance_pcx = nan(1,totalResponsiveSUAPcx);
sua_MI_pcx =  nan(1,totalResponsiveSUAPcx);
sua_CM_pcx =  nan(totalResponsiveSUAPcx, 16);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(pcxNM.esp, 1:n_odors, option);
    sua_performance_pcx(idxUnit) = mean(app);
    sua_MI_pcx(idxUnit) = miApp;
    sua_CM_pcx(idxUnit,:) = app2(:);
end
%%
figure; imagesc(sua_CM_coa)
n_clusters = 10;
options = statset('MaxIter',1000); 
clusterX = nan*ones(size(sua_CM_coa,1),n_clusters-1);
aic = [];
bic = [];
nll = [];
gmfit = [];
c = 1;

for k = 1:n_clusters-1
    gmfit{k} = fitgmdist(sua_CM_coa,k+1,'CovarianceType','diagonal',...
        'SharedCovariance',false,'Options',options, 'Regularize', 1e-5);
    clusterX(:,k) = cluster(gmfit{k},sua_CM_coa);
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
figure

[tuningCurvesCoa, tuningCurvesSigCoa, tuningCurvesCoaAuRoc, tuningCurvesCoaAuRocSig] = findTuningCurves(coaNM.esp, 1:13, 1, 0);
[tuningCurvesPcx, tuningCurvesSigPcx, tuningCurvesPcxAuRoc, tuningCurvesPcxAuRocSig] = findTuningCurves(pcxNM.esp, 1:13, 1, 0);

app = tuningCurvesSigCoa;
app = [app clusterX(:,3)];
app = sortrows(app,size(app,2));
app(:,size(app,2)) = [];
C = corr(app(:,1:6)');
imagesc(C)
axis square
%%
app = zscore(app');
app = app';
figure
imagesc(app)
%%
% %%
% Rcoa = tuningCurvesSigCoa;
% Rcoa = zscore(Rcoa');
% Rcoa = Rcoa';
% odorCorrCoa = corr(Rcoa);
% index = find(triu(ones(size(odorCorrCoa)),1));
% odorCorrCoa = odorCorrCoa(index);
% 
% 
% Rpcx = tuningCurvesSigPcx;
% Rpcx = zscore(Rpcx');
% Rpcx = Rpcx';
% odorCorrPcx = corr(Rpcx);
% index = find(triu(ones(size(odorCorrPcx)),1));
% odorCorrPcx = odorCorrPcx(index);
% 
% odorCorrCoaSim = nan(1000,100);
% odorCorrPcxSim = nan(1000,100);
% for idx = 1:1000
%     
%     appCoa = Rcoa;
%     for idxCell = 1:size(Rcoa,1)
%         orderOdors = randperm(13);
%         appCoa(idxCell,:) = appCoa(idxCell,orderOdors);
%     end
%     
%     appPcx = Rpcx;
%     for idxCell = 1:size(Rpcx,1)
%         orderOdors = randperm(13);
%         appPcx(idxCell,:) = appPcx(idxCell,orderOdors);
%     end
%         
%     
%     odorCorrCoaApp = corr(appCoa);
%     index = find(triu(ones(size(odorCorrCoaApp)),1));
%     odorCorrCoaApp = odorCorrCoaApp(index);
%     [fCoa, xiCoa] = ksdensity(odorCorrCoaApp);
%     
%     odorCorrPcxApp = corr(appPcx);
%     index = find(triu(ones(size(odorCorrPcxApp)),1));
%     odorCorrPcxApp = odorCorrPcxApp(index);
%     [fPcx, xiPcx] = ksdensity(odorCorrPcxApp);
%     
%     odorCorrCoaSim(idx,:) = fCoa;
%     odorCorrPcxSim(idx,:) = fPcx;
% end
% 
% figure
% [fCoa, xiCoa] = ksdensity(odorCorrCoa);
% plot(xiCoa, fCoa, 'linewidth', 1, 'color', coaC)
% hold on
% [fPcx, xiPcx] = ksdensity(odorCorrPcx);
% plot(xiPcx, fPcx, 'linewidth', 1, 'color', pcxC)
% hold on
% plot(xiCoa,mean(odorCorrCoaSim), '--', 'linewidth', 1, 'color', coaC)
% hold on
% plot(xiPcx,mean(odorCorrPcxSim), '--', 'linewidth', 1, 'color', pcxC)