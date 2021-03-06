


%% signal correlation across mice
[D300Coa, D1000Coa] = signalCorrelationAcrossMice(coaAA.esp, odors);
[D300Pcx, D1000Pcx] = signalCorrelationAcrossMice(pcxAA.esp, odors);

coa1000SC = [];
pcx1000SC = [];
coa300SC = [];
pcx300SC = [];
for idxShank = 1:4
    coa1000C(idxShank) = nanmean(D1000Coa{1,idxShank});
    pcx1000C(idxShank) = nanmean(D1000Pcx{1,idxShank});
    coa1000SC = [coa1000SC; D1000Coa{1,idxShank}];
    pcx1000SC = [pcx1000SC; D1000Pcx{1,idxShank}];
    coa300C(idxShank) = nanmean(D300Coa{1,idxShank});
    pcx300C(idxShank) = nanmean(D300Pcx{1,idxShank});
    coa300SC = [coa300SC; D300Coa{1,idxShank}];
    pcx300SC = [pcx300SC; D300Pcx{1,idxShank}];
    coaN(idxShank) = numel(D300Coa{1,idxShank});
    pcxN(idxShank) = numel(D300Pcx{1,idxShank});
end

y = [coa300SC; pcx300SC]; 
g1 = [zeros(sum(coaN),1); ones(sum(pcxN),1)];
g2 = [zeros(coaN(1),1); ones(coaN(2),1); 2*ones(coaN(3),1); 3*ones(coaN(4),1); zeros(pcxN(1),1); ones(pcxN(2),1); 2*ones(pcxN(3),1); 3*ones(pcxN(4),1)];
[p, tbl, stats, terms] = anovan( y, {g1, g2})
multcompare(stats, 'Dimension', [1 2])
[h, p] = ttest2(coa300SC, pcx300SC)

y = [coa1000SC; pcx1000SC]; 
g1 = [zeros(sum(coaN),1); ones(sum(pcxN),1)];
g2 = [zeros(coaN(1),1); ones(coaN(2),1); 2*ones(coaN(3),1); 3*ones(coaN(4),1); zeros(pcxN(1),1); ones(pcxN(2),1); 2*ones(pcxN(3),1); 3*ones(pcxN(4),1)];
[p, tbl, stats, terms] = anovan( y, {g1, g2})
multcompare(stats, 'Dimension', [1 2])
[h, p] = ttest2(coa1000SC, pcx1000SC)

figure; 
plot(coa1000C)
hold on
plot(pcx1000C)
figure; 
plot(coa300C)
hold on
plot(pcx300C)

[p, tbl, stats, terms] = anovan( y, {g1, g2})

%% response types

[allSdfCoa15, cellLogAllSdfsCoa15] = collectAllSdfs(coa15.esp, coa151.espe, odors);
[allSdfPcx15, cellLogAllSdfsPcx15] = collectAllSdfs(pcx15.esp, pcx151.espe, odors);
[allSdfCoaAA, cellLogAllSdfsCoaAA] = collectAllSdfs(coaAA.esp, coaAA1.espe, odors);
[allSdfPcxAA, cellLogAllSdfsPcxAA] = collectAllSdfs(pcxAA.esp, pcxAA1.espe, odors);

X1 = [allSdfCoa15(:,14800:19000-1); allSdfCoaAA(:,14800:19000-1); allSdfPcx15(:,14800:19000-1); allSdfPcxAA(:,14800:19000-1)];
X2 = [cellLogAllSdfsCoa15; cellLogAllSdfsCoaAA; cellLogAllSdfsPcx15; cellLogAllSdfsPcxAA];
X3 = [allSdfCoa15(:,13000:19000-1); allSdfCoaAA(:,13000:19000-1); allSdfPcx15(:,13000:19000-1); allSdfPcxAA(:,13000:19000-1)];
X3 = X3 - repmat(mean(X3,2), 1,size(X3,2));
norme = sqrt(sum( X3.^2, 2));
X3 = X3 ./ repmat(norme, 1,size(X3,2));
s1 = size(cellLogAllSdfsCoa15,1);
s2 = size(cellLogAllSdfsCoaAA,1);
s3 = size(cellLogAllSdfsPcx15,1);
s4 = size(cellLogAllSdfsPcxAA,1);
idArea = [zeros(s1,1); zeros(s2,1); ones(s3,1); ones(s4,1)];
idExpType = [zeros(s1,1); ones(s2,1); zeros(s3,1); ones(s4,1)];
X2 = [X2 idArea idExpType];


%%
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

%%
t = 1:size(X,2);
figure; imagesc(SL')
figure
plot(t, sqrt(SD(1:4))*ones(1,size(X,2)).*SL(:,1:4)');  
scores = X * SL;
figure; plot(scores(:,1), scores(:,2), 'ok')

%%
%%
d = 500;
n_clusters = 30;
options = statset('MaxIter',1000); 
clusterX = nan*ones(size(scores,1),n_clusters-1);
aic = [];
bic = [];
nll = [];
gmfit = [];
c = 1;

for k = 1:n_clusters-1
    gmfit{k} = fitgmdist(scores,k+1,'CovarianceType','diagonal',...
        'SharedCovariance',false,'Options',options, 'Regularize', 1e-5, 'Replicates', 10);
    clusterX(:,k) = cluster(gmfit{k},scores);
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
%eva = evalclusters(scores, 'gmdistribution', 'gap', 'Klist', 1:n_clusters);
figure;
plot(eva)

%%
t = -2000:4000-1;
for idxModel = 1:12
    figure
    I = idxModel + 1;
    for idxClust = 1:I
    clusterID = find(clusterX(:,idxModel)==idxClust);
    response(idxClust, :) = mean(X3(clusterID,:));
    subplot(5,3,idxClust)
    plot(t,response(idxClust, :) - mean(response(idxClust, 1:2000)));
    end
end
%%

figure;
set(gcf,'Position',[740 300 585 750]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
trialsN = 10;
patchY = [0 trialsN trialsN 0];
patchX = [0 0 2 2];
patchX1 = [0 0 2 2];
patchY1 = [-0.3 0.05 0.05 -0.3];
idxModel = 9;
I = idxModel + 1;
totCoa = s1 + s2;
totPcx = s3 + s4;
n = 1;

D = pdist(gmfit{idxModel}.mu);
tree = linkage(D, 'average');
leaforder = optimalleaforder(tree,D);
for idxClust = [8 2 4 6 5 10 3 9 1 7]
    clusterID = find(clusterX(:,idxModel)==idxClust);
    appX1 = X1(clusterID,:);
    appX2 = X2(clusterID,:);
    appX3 = X3(clusterID,:);
    appScores = scores(clusterID,:);
    
    coaResponsesX1 = appX1(appX2(:,5)==0,:);
    coaLog = appX2(appX2(:,5)==0,:);
    coaResponsesX3 = appX3(appX2(:,5)==0,:);
    coaScores = appScores(appX2(:,5)==0,:);
    posteriorsCoa = posterior(gmfit{idxModel}, coaScores);
%     coaResponsesX1 = coaResponsesX1(posteriorsCoa(:,idxClust)>0.75,:);
%     coaLog = coaLog(posteriorsCoa(:,idxClust)>0.75,:);
%     coaResponsesX3 = coaResponsesX3(posteriorsCoa(:,idxClust)>0.75,:);
%     coaScores = coaScores(posteriorsCoa(:,idxClust)>0.75,:);
    [~, idxMaxCoa] = max(posteriorsCoa(:,idxClust));
    meanCoaShort = mean(coaResponsesX1);
    meanCoaLong = mean(coaResponsesX3);
    stdCoaLong = std(coaResponsesX3);
    puCoaLong = prctile(coaResponsesX3,95);
    plCoaLong = prctile(coaResponsesX3,5);
    pCoa = size(coaResponsesX1,1) ./ totCoa * 100;
    
%     M = []; M = repmat(meanCoaShort, size(coaResponsesX1,1),1);
%     sserrCoa = sum((coaResponsesX1 - M).^2, 2);
%     coaLog = [coaLog, sserrCoa];
%     coaLog = sortrows(coaLog, size(coaLog,2));
%     coaLog(:,size(coaLog,2)) = [];
    idxExp = coaLog(idxMaxCoa,1);
    idxShank = coaLog(idxMaxCoa,2);
    idxUnit = coaLog(idxMaxCoa,3);
    idxOdor = coaLog(idxMaxCoa,4);
    idxExpType = coaLog(idxMaxCoa,6);
    for idxTrial = 1:trialsN
        app = [];
        switch idxExpType
            case 0
                app = coa151.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
            case 1
                app = coaAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
        end
        app1=[];
        app1 = find(app==1);
        app1 = (app1./1000) - 15;
        coaResponses.spikes{idxTrial} = app1;
    end
    subplot(I, 4, n)
    n = n+1;
    p1 = patch(patchX, patchY, [191,211,230]/255);
    set(p1, 'EdgeColor', 'none');
    hold on
    LineFormat.Color =  'r';
    plotSpikeRaster(coaResponses.spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 7], 'LineFormat', LineFormat);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
    
    subplot(I, 4, n)
    n = n+1;
    t = -2:1/1000:4;
    t(end) = [];
    p1 = patch(patchX1, patchY1, [191,211,230]/255);
    set(p1, 'EdgeColor', 'none');
    hold on
    PlotMeanWithFilledCiBand(t, meanCoaLong, plCoaLong, puCoaLong, 'r', 2, 'r', 0.2);
    %PlotMeanWithFilledSemBand(t, meanCoaLong, stdCoaLong, stdCoaLong, 'r', 2, 'r', 0.2);
    %plot(t, meanCoaLong, '-r', 'linewidth',2);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
    xlim([-2 4]);
    ylim([-0.03 0.05]);
    titolo = sprintf('%0.1f', pCoa); 
    title(titolo)
    
    pcxResponsesX1 = appX1(appX2(:,5)==1,:);
    pcxLog = appX2(appX2(:,5)==1,:);
    pcxResponsesX3 = appX3(appX2(:,5)==1,:);
    pcxScores = appScores(appX2(:,5)==1,:);
    posteriorsPcx = posterior(gmfit{idxModel}, pcxScores);
    [~, idxMaxPcx] = max(posteriorsPcx(:,idxClust));
%     pcxResponsesX1 = pcxResponsesX1(posteriorsPcx(:,idxClust)>0.75,:);
%     pcxLog = pcxLog(posteriorsPcx(:,idxClust)>0.75,:);
%     pcxResponsesX3 = pcxResponsesX3(posteriorsPcx(:,idxClust)>0.75,:);
%     pcxScores = pcxScores(posteriorsPcx(:,idxClust)>0.75,:);
    meanPcxShort = mean(pcxResponsesX1);
    meanPcxLong = mean(pcxResponsesX3);
    stdPcxLong = std(pcxResponsesX3);
    puPcxLong = prctile(pcxResponsesX3,95);
    plPcxLong = prctile(pcxResponsesX3,5);
    pPcx = size(pcxResponsesX1,1) ./ totPcx * 100;

%     M = []; M = repmat(meanPcxShort, size(pcxResponsesX1,1),1);
%     sserrPcx = sum((pcxResponsesX1 - M).^2, 2);
%     pcxLog = [pcxLog, sserrPcx];
%     pcxLog = sortrows(pcxLog, size(pcxLog,2));
%     pcxLog(:,size(pcxLog,2)) = [];
    idxExp = pcxLog(idxMaxPcx,1);
    idxShank = pcxLog(idxMaxPcx,2);
    idxUnit = pcxLog(idxMaxPcx,3);
    idxOdor = pcxLog(idxMaxPcx,4);
    idxExpType = pcxLog(idxMaxPcx,6);
    for idxTrial = 1:trialsN
        app = [];
        switch idxExpType
            case 0
                app = pcx151.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
            case 1
                app = pcxAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
        end
        app1=[];
        app1 = find(app==1);
        app1 = (app1./1000) - 15;
        pcxResponses.spikes{idxTrial} = app1;
    end
        subplot(I, 4, n)
    n = n+1;
    t = -2:1/1000:4;
    t(end) = [];
    p1 = patch(patchX1, patchY1, [191,211,230]/255);
    set(p1, 'EdgeColor', 'none');
    hold on
    PlotMeanWithFilledCiBand(t, meanPcxLong, plPcxLong, puPcxLong, 'k', 2, 'k', 0.2);
    %PlotMeanWithFilledSemBand(t, meanPcxLong, stdPcxLong, stdPcxLong, 'k', 2, 'k', 0.2);
    %plot(t, meanPcxLong, '-k', 'linewidth', 2);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
    xlim([-2 4]);
    ylim([-0.03 0.05]);
    titolo = sprintf('%0.1f', pPcx);
    title(titolo)
    subplot(I, 4, n)
    n = n+1;
    p1 = patch(patchX, patchY, [191,211,230]/255);
    set(p1, 'EdgeColor', 'none');
    hold on
    LineFormat.Color =  'k';
    plotSpikeRaster(pcxResponses.spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 7], 'LineFormat', LineFormat);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
end
    
    
    
    

    
