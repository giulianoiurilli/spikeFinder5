X1 = [coaR.allSdf(:,14800:19000-1); coaRAA.allSdf(:,14800:19000-1); pcxR.allSdf(:,14800:19000-1); pcxRAA.allSdf(:,14800:19000-1)];
X2 = [coaR.cellLogAllSdfs; coaRAA.cellLogAllSdfs; pcxR.cellLogAllSdfs; pcxRAA.cellLogAllSdfs];
X3 = [coaR.allSdf(:,13000:19000-1); coaRAA.allSdf(:,13000:19000-1); pcxR.allSdf(:,13000:19000-1); pcxRAA.allSdf(:,13000:19000-1)];
X3 = X3 - repmat(mean(X3,2), 1,size(X3,2));
norme = sqrt(sum( X3.^2, 2));
X3 = X3 ./ repmat(norme, 1,size(X3,2));
s1 = size(coaR.cellLogAllSdfs,1);
s2 = size(coaRAA.cellLogAllSdfs,1);
s3 = size(pcxR.cellLogAllSdfs,1);
s4 = size(pcxRAA.cellLogAllSdfs,1);
idArea = [zeros(s1,1); zeros(s2,1); ones(s3,1); ones(s4,1)];
idExpType = [zeros(s1,1); ones(s2,1); zeros(s3,1); ones(s4,1)];
X2 = [X2 idArea];

%%
X = [];
SL = [];
SD = [];
X = X1 - repmat(mean(X1,2), 1,size(X1,2));
norme = sqrt(sum( X.^2, 2));
X = X ./ repmat(norme, 1,size(X1,2));

K = 20;
delta = inf;
stop = -800*ones(1,K);
stop(1) = -200 ;
stop(4) = -1500 ;
maxiter = 3000;
convergenceCriterion = 1e-9;
verbose = true;
[SL SD] = spca(X, [], K, delta, stop, maxiter, convergenceCriterion, verbose);




%%
t = 1:size(X,2);
figure; imagesc(SL')
figure
plot(t, sqrt(SD(1:4))*ones(1,size(X,2)).*SL(:,1:4)');  
scores = X * SL;
figure; plot(scores(:,1), scores(:,2), 'ok')

% figure;
% for j = 1:length(cluster3)
%  plot(X(cluster3(j).DataIndex, :)); 
%  hold on; 
% end

%%
d = 500;
n_clusters = 10;
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
        'SharedCovariance',false,'Options',options, 'Regularize', 1e-5);
    clusterX(:,k) = cluster(gmfit{k},scores);
    aic(k) = gmfit{k}.AIC;
    bic(k) = gmfit{k}.BIC;
    nll(k) = gmfit{k}.NegativeLogLikelihood;
%     mahalDist = mahal(gmfit{k},X0);
%     subplot(2,2,c);
%     h1 = gscatter(scores(:,1),scores(:,2),clusterX);
%     hold on;
%     for m = 1:k;
%         idx = mahalDist(:,m)<=threshold;
%         Color = h1(m).Color*0.75 + -0.5*(h1(m).Color - 1);
%         h2 = plot(X0(idx,1),X0(idx,2),'.','Color',Color,'MarkerSize',1);
%         uistack(h2,'bottom');
%     end
%     plot(gmfit{k}.mu(:,1),gmfit{k}.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
%     hold off
%     c = c + 1;
end
%%
I = [];

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
eva = evalclusters(scores, 'gmdistribution', 'gap', 'Klist', 1:n_clusters);
figure;
plot(eva)





%%
figure;
set(gcf,'Position',[744 5 1048 1045]);
trialsN = 10;
pcxResponses = [];
coaResponses = [];
patchY = [0 trialsN trialsN 0];
patchX = [0 0 2 2];
patchX1 = [2000 2000 4000 4000];
patchY1 = [-0.3 0.05 0.05 -0.3];

I = 6;
n = 1;
allCellOdorPairInCluster_Coa = cell(I,1);
allCellOdorPairInCluster_Pcx = cell(I,1);
for idxClust = 1:I
    clusterID = find(clusterX(:,I-1)==idxClust);
    allResponsesInCluster = [];
    allResponsesInClusterLong = [];
    allCellOdorPairInCluster = [];
    allResponsesInCluster = X(clusterID,:);
    allResponsesInClusterLong = X3(clusterID,:);
    allCellOdorPairInCluster = X2(clusterID,:);
    allResponsesInCluster_Coa = [];
    allResponsesInCluster_Pcx = [];
    allResponsesInClusterLong_Coa = [];
    allResponsesInClusterLong_Pcx = [];

    idxCoa1 = []; idxCoa1 = find(allCellOdorPairInCluster(:,5) == 1);
    idxCoa2 = []; idxCoa2 = find(allCellOdorPairInCluster(:,5) == 2);
    idxCoa = []; idxCoa = [idxCoa1; idxCoa2];
    idxPcx1 = []; idxPcx1 = find(allCellOdorPairInCluster(:,5) == 3);
    idxPcx2 = []; idxPcx2 = find(allCellOdorPairInCluster(:,5) == 4);
    idxPcx = []; idxPcx = [idxPcx1; idxPcx2];
    allCellOdorPairInCluster_Coa{idxClust} = allCellOdorPairInCluster(idxCoa,:);
    allResponsesInCluster_Coa = allResponsesInCluster(idxCoa,:);
    allResponsesInClusterLong_Coa = allResponsesInClusterLong(idxCoa,:);
    allCellOdorPairInCluster_Pcx{idxClust} = allCellOdorPairInCluster(idxPcx,:);
    allResponsesInCluster_Pcx = allResponsesInCluster(idxPcx,:);
    allResponsesInClusterLong_Pcx = allResponsesInClusterLong(idxPcx,:);
    sserrCoa = []; sserrCoa = nan * ones(size(allResponsesInCluster_Coa,1));
    sserrPcx = []; sserrPcx = nan * ones(size(allResponsesInCluster_Pcx,1));
    meanTypeCoa = nan * ones(1, size(X,2)); 
    exampleTypeCoa = nan * ones(5, size(X,2)); 
    app = []; app = mean(allResponsesInCluster_Coa);
    app1 = []; app1 = mean(allResponsesInClusterLong_Coa);
    if ~isempty(app)
        meanTypeCoa = app;
        meanTypeLongCoa = app1;
        M = []; M = repmat(meanTypeCoa, size(allResponsesInCluster_Coa,1),1);
        sserrCoa = sum((allResponsesInCluster_Coa - M).^2, 2);
        allResponsesInCluster_Coa = [allResponsesInCluster_Coa, sserrCoa];
        allResponsesInCluster_Coa = sortrows(allResponsesInCluster_Coa, size(allResponsesInCluster_Coa,2));
        allResponsesInCluster_Coa(:,size(allResponsesInCluster_Coa,2)) = [];
        allCellOdorPairInCluster_Coa{idxClust} = [allCellOdorPairInCluster_Coa{idxClust}, sserrCoa];
        allCellOdorPairInCluster_Coa{idxClust} = sortrows(allCellOdorPairInCluster_Coa{idxClust}, size(allCellOdorPairInCluster_Coa{idxClust},2));
        allCellOdorPairInCluster_Coa{idxClust}(:,size(allCellOdorPairInCluster_Coa{idxClust},2)) = [];
        stdTypeCoa = std(allResponsesInClusterLong_Coa);
        idxExp = allCellOdorPairInCluster_Coa{idxClust}(1,1);
        idxShank = allCellOdorPairInCluster_Coa{idxClust}(1,2);
        idxUnit = allCellOdorPairInCluster_Coa{idxClust}(1,3);
        idxOdor = allCellOdorPairInCluster_Coa{idxClust}(1,4);
        idxEntry = allCellOdorPairInCluster_Coa{idxClust}(1,5);
        for idxTrial = 1:trialsN
            app = [];
            switch idxEntry
                case 1
                    app = coa1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
                case 2
                    app = coa1AA.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
            end
            app1=[];
            app1 = find(app==1);
            app1 = (app1./1000) - 15;
            coaResponses(idxClust).spikes{idxTrial} = app1;
        end
        subplot(I, 4, n)
        n = n+1;
        p1 = patch(patchX, patchY, [191,211,230]/255);
        set(p1, 'EdgeColor', 'none');
        hold on
        LineFormat.Color =  'r';
        plotSpikeRaster(coaResponses(idxClust).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 7], 'LineFormat', LineFormat);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'XColor','w')
        
        subplot(I, 4, n)
        n = n+1;
        t = 1:length(meanTypeLongCoa);
        p1 = patch(patchX1, patchY1, [191,211,230]/255);
        set(p1, 'EdgeColor', 'none');
        hold on
        PlotMeanWithFilledSemBand(t, meanTypeLongCoa, stdTypeCoa, stdTypeCoa, 'r', 2, 'r', 0.2);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'XColor','w')
        xlim([0 6999]);
        ylim([-0.03 0.05]);
    else
        subplot(I, 4, n)
            n = n+1;
        plot(exampleTypeCoa, '-','Color', [191,211,230]/255);
        subplot(I, 4, n)
            n = n+1;
        plot(exampleTypeCoa', '-','Color', [191,211,230]/255);
        hold on
        plot(meanTypeCoa, '-','Color', 'r');
        hold off
        axis tight;
    end
    

    meanTypePcx = nan * ones(1, size(X,2));
    exampleTypePcx = nan * ones(5, size(X,2)); 
    app = []; app = mean(allResponsesInCluster_Pcx); 
    app1 = []; app1 = mean(allResponsesInClusterLong_Pcx); 
    if ~isempty(app)
        meanTypePcx = app;
        meanTypeLongPcx = app1;
        M = []; M = repmat(meanTypePcx, size(allResponsesInCluster_Pcx,1),1);
        sserrPcx = sum((allResponsesInCluster_Pcx - M).^2, 2); 
        allResponsesInCluster_Pcx = [allResponsesInCluster_Pcx, sserrPcx];
        allResponsesInCluster_Pcx = sortrows(allResponsesInCluster_Pcx, size(allResponsesInCluster_Pcx,2));
        allResponsesInCluster_Pcx(:,size(allResponsesInCluster_Pcx,2)) = [];
        allCellOdorPairInCluster_Pcx{idxClust} = [allCellOdorPairInCluster_Pcx{idxClust}, sserrPcx];
        allCellOdorPairInCluster_Pcx{idxClust} = sortrows(allCellOdorPairInCluster_Pcx{idxClust}, size(allCellOdorPairInCluster_Pcx{idxClust},2));
        allCellOdorPairInCluster_Pcx{idxClust}(:,size(allCellOdorPairInCluster_Pcx{idxClust},2)) = [];
        stdTypePcx = std(allResponsesInClusterLong_Pcx);
        idxExp = allCellOdorPairInCluster_Pcx{idxClust}(1,1);
        idxShank = allCellOdorPairInCluster_Pcx{idxClust}(1,2);
        idxUnit = allCellOdorPairInCluster_Pcx{idxClust}(1,3);
        idxOdor = allCellOdorPairInCluster_Pcx{idxClust}(1,4);
        idxEntry = allCellOdorPairInCluster_Pcx{idxClust}(1,5);
        if idxClust == 3
            idxExp = allCellOdorPairInCluster_Pcx{idxClust}(1,1);
            idxShank = allCellOdorPairInCluster_Pcx{idxClust}(1,2);
            idxUnit = allCellOdorPairInCluster_Pcx{idxClust}(1,3);
            idxOdor = allCellOdorPairInCluster_Pcx{idxClust}(1,4);
            idxEntry = allCellOdorPairInCluster_Pcx{idxClust}(1,5);
        end
            
        for idxTrial = 1:trialsN
            app = [];
            switch idxEntry
                case 3
                    app = pcx1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
                case 4
                    app = pcx1AA.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
            end
            app1=[];
            app1 = find(app==1);
            app1 = (app1./1000) - 15;
            pcxResponses(idxClust).spikes{idxTrial} = app1;
        end
        
        subplot(I, 4, n)
        n = n+1;
        t = 1:length(meanTypeLongPcx);
        p1 = patch(patchX1, patchY1, [191,211,230]/255);
        set(p1, 'EdgeColor', 'none');
        hold on
        PlotMeanWithFilledSemBand(t, meanTypeLongPcx, stdTypePcx, stdTypePcx, 'k', 2, 'k', 0.2);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'XColor','w')
        xlim([0 6999]);
        ylim([-0.03 0.05]);
        
        
        subplot(I, 4, n)
        n = n+1;
        p1 = patch(patchX, patchY, [191,211,230]/255);
        set(p1, 'EdgeColor', 'none');
        hold on
        LineFormat.Color =  'k';
        plotSpikeRaster(pcxResponses(idxClust).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 7], 'LineFormat', LineFormat);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'XColor','w')
        

    else
        subplot(I, 4, n)
        n = n + 1;
        plot(exampleTypePcx', '-','Color', [191,211,230]/255);
        hold on
        plot(meanTypePcx, '-','Color', 'r');
        hold off
        axis tight;
        subplot(I, 4, n)
        n = n + 1;
        plot(exampleTypePcx, '-','Color', [191,211,230]/255);
    end
end

%%
save('responseTypes.mat', 'SL', 'SD', 'scores', 'gmfit', 'clusterX', 'allCellOdorPairInCluster_Pcx', 'allCellOdorPairInCluster_Coa')
