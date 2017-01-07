%%
auRocCOA15 = M15c.auRoc;
auRocPCX15 = M15p.auRoc;
sigCOA15 = M15c.significance;
sigPCX15 = M15p.significance;

auRocCOA15 = auRocCOA15(:);
auRocPCX15 = auRocPCX15(:);
sigCOA15 = logical(sigCOA15(:));
sigPCX15 = logical(sigPCX15(:));





allauRocCoa = [auRocCOA15];
allauRocPcx = [auRocPCX15];
allSigCoa = [sigCOA15];
allSigPcx = [sigPCX15];
%%

edges = 0:0.05:1.05;
[Ncoa,edges1] = histcounts(allauRocCoa,edges);
[Npcx,edges2] = histcounts(allauRocPcx,edges);
[NcoaS,edges1] = histcounts(allauRocCoa(allSigCoa),edges);
[NpcxS,edges2] = histcounts(allauRocPcx(allSigPcx),edges);
Ncoa = Ncoa./numel(allauRocCoa);
Npcx = Npcx./numel(allauRocPcx);
NcoaS = NcoaS./numel(allauRocCoa);
NpcxS = NpcxS./numel(allauRocPcx);
edges(end) = [];

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = bar(edges,Ncoa);
h1.FaceColor = 'none';
h1.EdgeColor = coaC;
hold on
h2 = bar(edges,NcoaS);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = bar(edges,Npcx);
h1.FaceColor = 'none';
h1.EdgeColor = pcxC;
hold on
h2 = bar(edges,NpcxS);
h2.FaceColor = pcxC;
h2.EdgeColor = pcxC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.2])
%%


Ncoa = Ncoa./numel(allauRocCoa);
Npcx = Npcx./numel(allauRocPcx);


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h = bar(edges,Ncoa);
h.FaceColor = 'none';
h.EdgeColor = coaC;
%%
figure
histfit(allauRocCoa, 10, 'kernel')
figure
histfit(allauRocPcx, 10, 'kernel')
%%

edges = 0:0.05:1.05;
[NcoaS,edges1] = histcounts(allauRocCoa(allSigCoa),edges);

[NpcxS,edges2] = histcounts(allauRocPcx(allSigPcx),edges);

NcoaS = NcoaS./numel(allauRocCoa);
NpcxS = NpcxS./numel(allauRocPcx);
edges(end) = [];
%%
sNcoa = smooth(Ncoa, 10, 'loess');
sNpcx = smooth(Npcx, 10, 'loess');
sNcoaS = smooth(NcoaS, 10, 'loess');
sNpcxS = smooth(NpcxS, 10, 'loess');



sNcoaS([1,8:13]) = 0;
sNpcxS(9:13) = 0;


%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges, Ncoa, 'color', coaC, 'linewidth', 1) 
hold on
plot(edges, Npcx, 'color', pcxC, 'linewidth', 1) 
ylabel('Fraction of Responses')
xlabel('Number of Spikes')
axis tight
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
hold on
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges, NcoaS, 'color', coaC, 'linewidth', 2) 
hold on
plot(edges, NpcxS, 'color', pcxC, 'linewidth', 2)
ylabel('Fraction of Responses')
xlabel('Number of Spikes')
axis tight
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
%% bar plot auROCExc/odor
X1 = M15c.auRoc;
X1(M15c.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X1(:,j);
    app(isnan(app)) = [];
    notnanX1(j) = numel(app);
end
X1app = X1;
X1appNotnan = notnanX1;
X1mean = nanmean(X1app);
X1sem = nanstd(X1app) ./ sqrt(X1appNotnan - ones(1,15));

Y1 = M15p.auRoc;
Y1(M15p.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y1(:,j);
    app(isnan(app)) = [];
    notnanY1(j) = numel(app);
end
Y1app = Y1;
Y1appNotnan = notnanY1;
Y1mean = nanmean(Y1app);
Y1sem = nanstd(Y1app) ./ sqrt(Y1appNotnan - ones(1,15));

%%
meanX = reshape(X1mean,5,3);
semX = reshape(X1sem,5,3);
errorbar_groups(meanX,semX,'bar_colors', repmat(coaC,5,1), 'errorbar_colors', repmat(coaC,5,1))
ylim([0.5 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'helvetica', 'fontsize', 14)


meanY = reshape(Y1mean,5,3);
semY = reshape(Y1sem,5,3);
errorbar_groups(meanY,semY,'bar_colors', repmat(pcxC,5,1), 'errorbar_colors', repmat(pcxC,5,1))
ylim([0.5 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'helvetica', 'fontsize', 14)

%%
%%
longList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'};
shortList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13'};
longTicks = 0.15:15.15;
shortTicks = 0.15:13.15;
[actOdorPcx, supOdorPcx, a, b, c, respOdorPcx] = proportionActivatingOdors_new(pcx15.esp, 1:15, 0);
[actOdorCoa, supOdorCoa, a, b, c, respOdorCoa] = proportionActivatingOdors_new(coa15.esp, 1:15, 0);

N = histcounts(actOdorPcx,0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(actOdorCoa,0:16); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:15, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8)
xlim([-1 16.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , longTicks);
set(gca, 'XTickLabel', longList);
xlabel({'Excitatory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)


N = histcounts(supOdorPcx,0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(supOdorCoa,0:16); 
PCoa = N./ sum(N);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:15, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8)
xlim([-1 14.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , longTicks);
set(gca, 'XTickLabel', longList);
xlabel({'Inhibitory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

N = histcounts(respOdorPcx,0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(respOdorCoa,0:16); 
PCoa = N./ sum(N);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:15, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8)
xlim([-1 14.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , longTicks);
set(gca, 'XTickLabel', longList);
xlabel({'Inhibitory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%% 
[lsCoa, cellLogCoa, lsSigCoa, cellLogSigCoa] = findLifetimeSparseness(coa15.esp, 1:15, 0);
[lsPcx, cellLogPcx, lsSigPcx, cellLogSigPcx] = findLifetimeSparseness(pcx15.esp, 1:15, 0);
edges = 0:0.1:1.1;
[Ncoa,edges1] = histcounts(lsCoa(~isnan(lsCoa)),edges);
[Npcx,edges2] = histcounts(lsPcx(~isnan(lsPcx)),edges);
edges(end) = [];
Ncoa = Ncoa./numel(lsCoa(~isnan(lsCoa)));
Npcx = Npcx./numel(lsPcx(~isnan(lsPcx)));
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = bar(edges,Ncoa);
h1.FaceColor = coaC;
h1.EdgeColor = coaC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = bar(edges,Npcx);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
%%
p = ranksum(lsCoa, lsPcx)
%%
[tuningCurvesCoa, tuningCurvesSigCoa, tuningCurvesCoaAuRoc, tuningCurvesCoaAuRocSig] = findTuningCurves(coa15.esp, 1:15, 0);
[tuningCurvesPcx, tuningCurvesSigPcx, tuningCurvesPcxAuRoc, tuningCurvesPcxAuRocSig] = findTuningCurves(pcx15.esp, 1:15, 0);

%%
Y = [];
Z = [];
Y = pdist(tuningCurvesSigCoa);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesSigCoa,1));
app = [];
app = [tuningCurvesSigCoa outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesSigCoa = app;

clims = [-1 1];
Ccoa = corr(tuningCurvesSigCoa');
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(Ccoa,clims);
colormap(brewermap([],'*PuBuGn')); axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])


Y = [];
Z = [];
Y = pdist(tuningCurvesCoa);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesCoa,1));
app = [];
app = [tuningCurvesCoa outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesCoa = app;

clims = [-1 1];
Ccoa = corr(tuningCurvesCoa');
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(Ccoa,clims);
colormap(brewermap([],'*PuBuGn')); axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

%%
Y = [];
Z = [];
Y = pdist(tuningCurvesSigPcx);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesSigPcx,1));
app = [];
app = [tuningCurvesSigPcx outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesSigPcx = app;

clims = [-1 1];
Ccoa = corr(tuningCurvesSigPcx');
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(Ccoa,clims);
colormap(brewermap([],'*PuBuGn')); axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])


Y = [];
Z = [];
Y = pdist(tuningCurvesPcx);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesPcx,1));
app = [];
app = [tuningCurvesPcx outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesPcx = app;

clims = [-1 1];
Ccoa = corr(tuningCurvesPcx');
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(Ccoa,clims);
colormap(brewermap([],'*PuBuGn')); axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
%%
clims = [-1 1];
odorsRearranged = 1:15;
[sigCorrCoa15, corrMatCoa15, sigCorrCoa15Sig, corrMatCoa15Sig, sigCorr1000msSigSimCoa15] = findSignalCorrelation_new(coa15.esp, odorsRearranged, 0.5);
[sigCorrPcx15, corrMatPcx15, sigCorrPcx15Sig, corrMatPcx15Sig, sigCorr1000msSigSimPcx15] = findSignalCorrelation_new(pcx15.esp, odorsRearranged, 0.5);

%%
sigCorrCoa15 = sigCorrCoa15(:);
sigCorrPcx15 = sigCorrPcx15(:);
sigCorrCoa15Sig = sigCorrCoa15Sig(:);
sigCorrPcx15Sig = sigCorrPcx15Sig(:);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(sigCorrCoa15(~isnan(sigCorrCoa15)));
plot(xiCoa,fCoa,':', 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(sigCorrPcx15(~isnan(sigCorrPcx15)));
plot(xiPcx,fPcx, ':','linewidth', 1,'color', pcxC)
hold on
[fCoa,xiCoa] = ksdensity(sigCorrCoa15Sig(~isnan(sigCorrCoa15Sig)));
plot(xiCoa,fCoa,  'linewidth', 1,'color', coaC)
hold on
line([mean(sigCorrCoa15Sig(~isnan(sigCorrCoa15Sig))) mean(sigCorrCoa15Sig(~isnan(sigCorrCoa15Sig)))], [0 max(fCoa)], 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(sigCorrPcx15Sig(~isnan(sigCorrPcx15Sig)));
hold on
line([mean(sigCorrPcx15Sig(~isnan(sigCorrPcx15Sig))) mean(sigCorrPcx15Sig(~isnan(sigCorrPcx15Sig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
hold on
plot(xiCoa,sigCorr1000msSigSimCoa15,  '--', 'linewidth', 1,'color', coaC)
hold on
plot(xiPcx,fPcx, 'linewidth', 1,'color', pcxC)
hold on
plot(xiPcx,sigCorr1000msSigSimPcx15,  '--', 'linewidth', 1,'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylabel('p.d.f.')
xlabel('Signal Correlation')
%%
odorsRearranged = 1:15;
[noiseCorrW1000msCoa15, noiseCorrB1000msCoa15, noiseCorrW1000msCoa15Sig, noiseCorrB1000msCoa15Sig] = findNoiseCorrelation_new(coa15.esp, odorsRearranged, 0.5);
[noiseCorrW1000msPcx15, noiseCorrB1000msPcx15, noiseCorrW1000msPcx15Sig, noiseCorrB1000msPcx15Sig] = findNoiseCorrelation_new(pcx15.esp, odorsRearranged, 0.5);


B = [noiseCorrW1000msCoa15, noiseCorrB1000msCoa15]; 
A = [noiseCorrW1000msPcx15, noiseCorrB1000msPcx15];
BSig = [noiseCorrW1000msCoa15Sig, noiseCorrB1000msCoa15Sig]; 
ASig = [noiseCorrW1000msPcx15Sig, noiseCorrB1000msPcx15Sig];

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