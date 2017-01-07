
%% Good
% %%
% [tuningCurvesCoa, tuningCurvesSigCoa, tuningCurvesCoaAuRoc, tuningCurvesCoaAuRocSig] = findTuningCurves(coaNM.esp, 1:13, 1, 0);
% [tuningCurvesPcx, tuningCurvesSigPcx, tuningCurvesPcxAuRoc, tuningCurvesPcxAuRocSig] = findTuningCurves(pcxNM.esp, 1:13, 1, 0);
% 
% X = tuningCurvesSigCoa;
% [coeff,score,latent,tsquared,explained,mu] = pca(X');
% figure;
% scatter(score(:,1), score(:,2))
% figure;
% scatter3(score(:,1), score(:,2), score(:,3))
% 
% Y = tuningCurvesSigPcx;
% [coeff,score,latent,tsquared,explained,mu] = pca(Y');
% figure;
% scatter(score(:,1), score(:,2))
% figure;
% scatter3(score(:,1), score(:,2), score(:,3))
% %%
% [tuningCurvesCoa, tuningCurvesSigCoa, tuningCurvesCoaAuRoc, tuningCurvesCoaAuRocSig] = findTuningCurves(coaNM.esp, 1:13, 1, 1);
% [tuningCurvesPcx, tuningCurvesSigPcx, tuningCurvesPcxAuRoc, tuningCurvesPcxAuRocSig] = findTuningCurves(pcxNM.esp, 1:13, 1, 1);
% %%
% mappedCoa = tsne(tuningCurvesSigCoa(:,1:6),[],3);
% mappedPcx = tsne(tuningCurvesSigPcx(:,1:6), [], 3);
% %%
% n_clusters = 10;
% options = statset('MaxIter',1000); 
% clusterCoa = nan*ones(size(mappedCoa,1),n_clusters-1);
% aic = [];
% bic = [];
% nll = [];
% gmfit = [];
% c = 1;
% 
% for k = 1:n_clusters-1
%     gmfit{k} = fitgmdist(mappedCoa,k+1,'CovarianceType','diagonal',...
%         'SharedCovariance',false,'Options',options, 'Regularize', 1e-5);
%     clusterCoa(:,k) = cluster(gmfit{k},mappedCoa);
%     aic(k) = gmfit{k}.AIC;
%     bic(k) = gmfit{k}.BIC;
%     nll(k) = gmfit{k}.NegativeLogLikelihood;
% end
% %%
% n_clusters = 10;
% options = statset('MaxIter',1000); 
% clusterPcx = nan*ones(size(mappedPcx,1),n_clusters-1);
% aic = [];
% bic = [];
% nll = [];
% gmfit = [];
% c = 1;
% 
% for k = 1:n_clusters-1
%     gmfit{k} = fitgmdist(mappedPcx,k+1,'CovarianceType','diagonal',...
%         'SharedCovariance',false,'Options',options, 'Regularize', 1e-5);
%     clusterPcx(:,k) = cluster(gmfit{k},mappedPcx);
%     aic(k) = gmfit{k}.AIC;
%     bic(k) = gmfit{k}.BIC;
%     nll(k) = gmfit{k}.NegativeLogLikelihood;
% end
% 
% %%
% X = tuningCurvesSigCoa;
% % X = tuningCurvesSigNormPcx;
% X = [X clusterCoa(:,5)];
% X = sortrows(X, size(X,2));
% X(:,size(X,2)) = [];
% clims = [-2 2];
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% imagesc(X);
% colormap(brewermap([],'*PuBuGn')); axis tight
% set(gca,'YColor','w')
% set(gca,'XColor','w')
% set(gca,'XTick',[])
% set(gca,'XTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'YTickLabel',[])
% 
% C = corr(X');
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% imagesc(C)
% colormap(brewermap([],'*PuBuGn')); axis square
% 
% 
% %%
% Y = tuningCurvesSigPcx;
% % X = tuningCurvesSigNormPcx;
% Y = [Y clusterPcx(:,5)];
% Y = sortrows(Y, size(Y,2));
% Y(:,size(Y,2)) = [];
% clims = [-2 2];
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% imagesc(Y);
% colormap(brewermap([],'*PuBuGn')); axis tight
% set(gca,'YColor','w')
% set(gca,'XColor','w')
% set(gca,'XTick',[])
% set(gca,'XTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'YTickLabel',[])
% 
% C = corr(Y');
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% imagesc(C)
% colormap(brewermap([],'*PuBuGn')); axis square
% 
%% Correlation Matrix Odor Representations
[rhoOdorRepresentationsSigCoa, rhoMeanOdorRepresentationsSigCoa, evaCoa] = findOdorRepresentationCorrelation(coaAA.esp, 1:10, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 1];
imagesc(rhoOdorRepresentationsSigCoa, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlGnBu'))
colorbar
title('Corrleation between odor representations - plCoA')

[rhoOdorRepresentationsSigPcx, rhoMeanOdorRepresentationsSigPcx, evaPcx] = findOdorRepresentationCorrelation(pcxAA.esp, 1:10, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 1];
imagesc(rhoOdorRepresentationsSigPcx, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlGnBu'))
colorbar
title('Corrleation between odor representations - aPCx')
%% Distributions per Shank
clims = [0 0.05];
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coaNM.esp, 1:13, 1, 0);
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcxNM.esp, 1:13, 1, 0);
edges = 0.5:13.5;
%
fractionPerOdorCoa = [];


%
 for idxShank = 1:4
        app1 = responsivityCoa{1,idxShank};
        app2 = auROCCoa{1,idxShank};
        for idxExp = 1:size(nCellsExpCoa,1)
            app11 = app1(1:nCellsExpCoa(idxExp,idxShank),:);
            app1(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpCoa(idxExp,idxShank),:);
            app2(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            fractionPerOdorCoa(idxShank,:, idxExp) = freq./sum(nCellsExpCoa(idxExp,:),2);
        end
 end
figure
imagesc(nanmean(fractionPerOdorCoa,3)', clims)
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlGnBu'))
colorbar
ylabel('Odor I.D.')
xlabel('Shank')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)

fractionPerOdorPcx = [];
 for idxShank = 1:4
        app1 = responsivityPcx{1,idxShank};
        app2 = auROCPcx{1,idxShank};
        for idxExp = 1:size(nCellsExpPcx,1)
            app11 = app1(1:nCellsExpPcx(idxExp,idxShank),:);
            app1(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpPcx(idxExp,idxShank),:);
            app2(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            fractionPerOdorPcx(idxShank,:, idxExp) = freq./sum(nCellsExpPcx(idxExp,:),2);
        end
 end
figure
imagesc(nanmean(fractionPerOdorPcx,3)', clims)    
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlGnBu'))
colorbar
ylabel('Odor I.D.')
xlabel('Shank')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
%% Distributions per Shank
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coa15.esp, 1:15, 1, 0);
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcx15.esp, 1:15, 1, 0);
edges = 0.5:15.5;

fractionPerOdorCoa = [];
 for idxShank = 1:4
        app1 = responsivityCoa{1,idxShank};
        app2 = auROCCoa{1,idxShank};
        for idxExp = 1:size(nCellsExpCoa,1)
            app11 = app1(1:nCellsExpCoa(idxExp,idxShank),:);
            app1(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpCoa(idxExp,idxShank),:);
            app2(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            fractionPerOdorCoa(idxShank,:, idxExp) = freq./sum(nCellsExpCoa(idxExp,:),2);
        end
 end
figure
imagesc(nanmean(fractionPerOdorCoa,3)', clims)
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlGnBu'))
colorbar
ylabel('Odor I.D.')
xlabel('Shank')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
fractionPerOdorPcx = [];
 for idxShank = 1:4
        app1 = responsivityPcx{1,idxShank};
        app2 = auROCPcx{1,idxShank};
        for idxExp = 1:size(nCellsExpPcx,1)
            app11 = app1(1:nCellsExpPcx(idxExp,idxShank),:);
            app1(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpPcx(idxExp,idxShank),:);
            app2(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            fractionPerOdorPcx(idxShank,:, idxExp) = freq./sum(nCellsExpPcx(idxExp,:),2);
        end
 end
figure
imagesc(nanmean(fractionPerOdorPcx,3)', clims)   
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlGnBu'))
colorbar
ylabel('Odor I.D.')
xlabel('Shank')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
%% Distributions per Shank
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coaAA.esp, 1:10, 1, 0);
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcxAA.esp, 1:10, 1, 0);
edges = 0.5:10.5;

fractionPerOdorCoa = [];
 for idxShank = 1:4
        app1 = responsivityCoa{1,idxShank};
        app2 = auROCCoa{1,idxShank};
        for idxExp = 1:size(nCellsExpCoa,1)
            app11 = app1(1:nCellsExpCoa(idxExp,idxShank),:);
            app1(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpCoa(idxExp,idxShank),:);
            app2(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            fractionPerOdorCoa(idxShank,:, idxExp) = freq./sum(nCellsExpCoa(idxExp,:),2);
        end
 end
figure
imagesc(nanmean(fractionPerOdorCoa,3)', clims)
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlGnBu'))
colorbar
ylabel('Odor I.D.')
xlabel('Shank')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
fractionPerOdorPcx = [];
 for idxShank = 1:4
        app1 = responsivityPcx{1,idxShank};
        app2 = auROCPcx{1,idxShank};
        for idxExp = 1:size(nCellsExpPcx,1)
            app11 = app1(1:nCellsExpPcx(idxExp,idxShank),:);
            app1(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpPcx(idxExp,idxShank),:);
            app2(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            fractionPerOdorPcx(idxShank,:, idxExp) = freq./sum(nCellsExpPcx(idxExp,:),2);
        end
 end
figure
imagesc(nanmean(fractionPerOdorPcx,3)', clims) 
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlGnBu'))
colorbar
ylabel('Odor I.D.')
xlabel('Shank')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)