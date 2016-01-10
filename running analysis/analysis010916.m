figure; plot(mean(pcx.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'k')
hold on; plot(mean(coa.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'r')
axis off
box off
title('15 odors', 'FontName', 'DINcondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');

figure; plot(mean(pcxH.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'k')
hold on; plot(mean(coaH.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'r')
axis off
box off
title('odor dilution: 1/1000', 'FontName', 'DINcondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');

figure; plot(mean(pcxL.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'k')
hold on; plot(mean(coaL.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'r')
axis off
box off
title('odor dilution: 1/10', 'FontName', 'DINcondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');



figure; plot(pcx.distSniffNorm, 'LineWidth', 2, 'Color', 'k')
hold on; plot(coa.distSniffNorm, 'LineWidth', 2, 'Color', 'r')
grid on
ylabel('Change of correlation distance between odor representations relative to rest', 'FontName', 'DINcondensed', 'FontSize', 14)
xlabel('respiration cycle', 'FontName', 'DINcondensed', 'FontSize', 14)
title('15 odors - odor dilution: 1/100', 'FontName', 'DINcondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
figure; plot(pcxH.distSniffNorm, 'LineWidth', 2, 'Color', 'k')
hold on; plot(coaH.distSniffNorm, 'LineWidth', 2, 'Color', 'r')
grid on
xlabel('respiration cycle', 'FontName', 'DINcondensed', 'FontSize', 14)
title('7 odors - odor dilution: 1/1000', 'FontName', 'DINcondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
figure; plot(pcxL.distSniffNorm, 'LineWidth', 2, 'Color', 'k')
hold on; plot(coaL.distSniffNorm, 'LineWidth', 2, 'Color', 'r')
grid on
xlabel('respiration cycle', 'FontName', 'DINcondensed', 'FontSize', 14)
title('7 odors - odor dilution: 1/10', 'FontName', 'DINcondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%

edges300 = -0.05:0.1:1.05;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcx.ls300msTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(pcx.ls300msTot));
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
hold on
[N,edges] = histcounts(coa.ls300msTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(coa.ls300msTot));
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 300 ms')


edges300 = -0.05:0.1:1.05;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcx.ls1sTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(pcx.ls1sTot));
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
hold on
[N,edges] = histcounts(coa.ls1sTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(coa.ls1sTot));
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 1000 ms')

edges300 = -0.05:0.1:1.05;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxH.ls300msTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(pcxH.ls300msTot));
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
hold on
[N,edges] = histcounts(coaH.ls300msTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(coaH.ls300msTot));
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 300 ms - H')

edges300 = -0.05:0.1:1.05;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxH.ls1sTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(pcxH.ls1sTot));
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
hold on
[N,edges] = histcounts(coaH.ls1sTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(coaH.ls1sTot));
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 1000 s - H')

edges300 = -0.05:0.1:1.05;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxL.ls300msTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(pcxL.ls300msTot));
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
hold on
[N,edges] = histcounts(coaL.ls300msTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(coaL.ls300msTot));
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 300 ms - L')

edges300 = -0.05:0.1:1.05;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxL.ls1sTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(pcxL.ls1sTot));
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
hold on
[N,edges] = histcounts(coaL.ls1sTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(coaL.ls1sTot));
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 1000 s - L')

edges300 = -0.05:0.1:1.05;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxAA.ls300msTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(pcxAA.ls300msTot));
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
hold on
[N,edges] = histcounts(coaAA.ls300msTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(coaAA.ls300msTot));
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 300 ms')


edges300 = -0.05:0.1:1.05;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxAA.ls1sTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(pcxAA.ls1sTot));
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
hold on
[N,edges] = histcounts(coaAA.ls1sTot, edges300);
edges(1) = [];
h1 = area(edges, N./length(coaAA.ls1sTot));
h1.FaceColor = 'r';
h1.EdgeColor = 'r';
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 1000 ms')
%%
edges300 = 0:0.1:1;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcx.auROCTot300ms, edges300);
edges(1) = [];
plot(edges, N./length(pcx.auROCTot300ms), 'k');
hold on
[N,edges] = histcounts(coa.auROCTot300ms, edges300);
edges(1) = [];
plot(edges, N./length(coa.auROCTot300ms), 'r');
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('auROC  - first 300 ms')

edges300 = 0:0.1:1;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcx.auROCTot1s, edges300);
edges(1) = [];
plot(edges, N./length(pcx.auROCTot1s), 'k');
hold on
[N,edges] = histcounts(coa.auROCTot1s, edges300);
edges(1) = [];
plot(edges, N./length(coa.auROCTot1s), 'r');
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('auROC  - first 1000 ms')

edges300 = 0:0.1:1;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxH.auROCTot300ms, edges300);
edges(1) = [];
plot(edges, N./length(pcxH.auROCTot300ms), 'k');
hold on
[N,edges] = histcounts(coaH.auROCTot300ms, edges300);
edges(1) = [];
plot(edges, N./length(coaH.auROCTot300ms), 'r');
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('auROC - L   - first 300 ms')

edges300 = 0:0.1:1;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxH.auROCTot1s, edges300);
edges(1) = [];
plot(edges, N./length(pcxH.auROCTot1s), 'k');
hold on
[N,edges] = histcounts(coaH.auROCTot1s, edges300);
edges(1) = [];
plot(edges, N./length(coaH.auROCTot1s), 'r');
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('auROC - L  - first 1000 ms')

edges300 = 0:0.1:1;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxL.auROCTot300ms, edges300);
edges(1) = [];
plot(edges, N./length(pcxL.auROCTot300ms), 'k');
hold on
[N,edges] = histcounts(coaL.auROCTot300ms, edges300);
edges(1) = [];
plot(edges, N./length(coaL.auROCTot300ms), 'r');
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('auROC - H   - first 300 ms')

edges300 = 0:0.1:1;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxL.auROCTot1s, edges300);
edges(1) = [];
plot(edges, N./length(pcxL.auROCTot1s), 'k');
hold on
[N,edges] = histcounts(coaL.auROCTot1s, edges300);
edges(1) = [];
plot(edges, N./length(coaL.auROCTot1s), 'r');
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('auROC - H  - first 1000 ms')

edges300 = 0:0.1:1;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxAA.auROCTot300ms, edges300);
edges(1) = [];
plot(edges, N./length(pcxAA.auROCTot300ms), 'k');
hold on
[N,edges] = histcounts(coaAA.auROCTot300ms, edges300);
edges(1) = [];
plot(edges, N./length(coaAA.auROCTot300ms), 'r');
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('auROC -AA - first 300 ms')

edges300 = 0:0.1:1;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(pcxAA.auROCTot1s, edges300);
edges(1) = [];
plot(edges, N./length(pcxAA.auROCTot1s), 'k');
hold on
[N,edges] = histcounts(coaAA.auROCTot1s, edges300);
edges(1) = [];
plot(edges, N./length(coaAA.auROCTot1s), 'r');
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('auROC -AA - first 1000 ms')

%%

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = cdfplot(pcx.auROCTot1s);
set(h1, 'linewidth', 2, 'color', 'k')
hold on
h2 = cdfplot(coa.auROCTot1s);
set(h2, 'linewidth', 2, 'color', 'r')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = cdfplot(pcxAA.auROCTot1s);
set(h1, 'linewidth', 2, 'color', 'k')
hold on
h2 = cdfplot(coaAA.auROCTot1s);
set(h2, 'linewidth', 2, 'color', 'r')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = cdfplot(pcxH.auROCTot1s);
set(h1, 'linewidth', 2, 'color', 'k')
hold on
h2 = cdfplot(coaH.auROCTot1s);
set(h2, 'linewidth', 2, 'color', 'r')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = cdfplot(pcxL.auROCTot1s);
set(h1, 'linewidth', 2, 'color', 'k')
hold on
h2 = cdfplot(coaL.auROCTot1s);
set(h2, 'linewidth', 2, 'color', 'r')

%%
pcx.noiseCorrW1000ms(isnan(pcx.noiseCorrW1000ms)) = [];
pcx.noiseCorrB1000ms(isnan(pcx.noiseCorrB1000ms)) = [];
pcxAA.noiseCorrW1000ms(isnan(pcxAA.noiseCorrW1000ms)) = [];
pcxAA.noiseCorrB1000ms(isnan(pcxAA.noiseCorrB1000ms)) = [];
pcxL.noiseCorrW1000ms(isnan(pcxL.noiseCorrW1000ms)) = [];
pcxL.noiseCorrB1000ms(isnan(pcxL.noiseCorrB1000ms)) = [];
pcxH.noiseCorrW1000ms(isnan(pcxH.noiseCorrW1000ms)) = [];
pcxH.noiseCorrB1000ms(isnan(pcxH.noiseCorrB1000ms)) = [];

coa.noiseCorrW1000ms(isnan(coa.noiseCorrW1000ms)) = [];
coa.noiseCorrB1000ms(isnan(coa.noiseCorrB1000ms)) = [];
coaAA.noiseCorrW1000ms(isnan(coaAA.noiseCorrW1000ms)) = [];
coaAA.noiseCorrB1000ms(isnan(coaAA.noiseCorrB1000ms)) = [];
coaL.noiseCorrW1000ms(isnan(coaL.noiseCorrW1000ms)) = [];
coaL.noiseCorrB1000ms(isnan(coaL.noiseCorrB1000ms)) = [];
coaH.noiseCorrW1000ms(isnan(coaH.noiseCorrW1000ms)) = [];
coaH.noiseCorrB1000ms(isnan(coaH.noiseCorrB1000ms)) = [];


ncPcxMW = nanmean(pcx.noiseCorrW1000ms);
ncPcxMB = nanmean(pcx.noiseCorrB1000ms);
ncPcxSEW = nanstd(pcx.noiseCorrW1000ms) ./ sqrt(size(pcx.noiseCorrW1000ms,2));
ncPcxSEB = nanstd(pcx.noiseCorrB1000ms) ./ sqrt(size(pcx.noiseCorrB1000ms,2));
ncPcxM = [ncPcxMW ncPcxMB];
ncPcxSE = [ncPcxSEW ncPcxSEB];

ncPcxAAMW = nanmean(pcxAA.noiseCorrW1000ms);
ncPcxAAMB = nanmean(pcxAA.noiseCorrB1000ms);
ncPcxAASEW = nanstd(pcxAA.noiseCorrW1000ms) ./ sqrt(size(pcxAA.noiseCorrW1000ms,2));
ncPcxAASEB = nanstd(pcxAA.noiseCorrB1000ms) ./ sqrt(size(pcxAA.noiseCorrB1000ms,2));
ncPcxAAM = [ncPcxAAMW ncPcxAAMB];
ncPcxAASE = [ncPcxAASEW ncPcxAASEB];

ncPcxHMW = nanmean(pcxH.noiseCorrW1000ms);
ncPcxHMB = nanmean(pcxH.noiseCorrB1000ms);
ncPcxHSEW = nanstd(pcxH.noiseCorrW1000ms) ./ sqrt(size(pcxH.noiseCorrW1000ms,2));
ncPcxHSEB = nanstd(pcxH.noiseCorrB1000ms) ./ sqrt(size(pcxH.noiseCorrB1000ms,2));
ncPcxHM = [ncPcxHMW ncPcxHMB];
ncPcxHSE = [ncPcxHSEW ncPcxHSEB];

ncPcxLMW = nanmean(pcxL.noiseCorrW1000ms);
ncPcxLMB = nanmean(pcxL.noiseCorrB1000ms);
ncPcxLSEW = nanstd(pcxL.noiseCorrW1000ms) ./ sqrt(size(pcxL.noiseCorrW1000ms,2));
ncPcxLSEB = nanstd(pcxL.noiseCorrB1000ms) ./ sqrt(size(pcxL.noiseCorrB1000ms,2));
ncPcxLM = [ncPcxLMW ncPcxLMB];
ncPcxLSE = [ncPcxLSEW ncPcxLSEB];

nccoaMW = nanmean(coa.noiseCorrW1000ms);
nccoaMB = nanmean(coa.noiseCorrB1000ms);
nccoaSEW = nanstd(coa.noiseCorrW1000ms) ./ sqrt(size(coa.noiseCorrW1000ms,2));
nccoaSEB = nanstd(coa.noiseCorrB1000ms) ./ sqrt(size(coa.noiseCorrB1000ms,2));
nccoaM = [nccoaMW nccoaMB];
nccoaSE = [nccoaSEW nccoaSEB];

nccoaAAMW = nanmean(coaAA.noiseCorrW1000ms);
nccoaAAMB = nanmean(coaAA.noiseCorrB1000ms);
nccoaAASEW = nanstd(coaAA.noiseCorrW1000ms) ./ sqrt(size(coaAA.noiseCorrW1000ms,2));
nccoaAASEB = nanstd(coaAA.noiseCorrB1000ms) ./ sqrt(size(coaAA.noiseCorrB1000ms,2));
nccoaAAM = [nccoaAAMW nccoaAAMB];
nccoaAASE = [nccoaAASEW nccoaAASEB];

nccoaHMW = nanmean(coaH.noiseCorrW1000ms);
nccoaHMB = nanmean(coaH.noiseCorrB1000ms);
nccoaHSEW = nanstd(coaH.noiseCorrW1000ms) ./ size(coaH.noiseCorrW1000ms,2);
nccoaHSEB = nanstd(coaH.noiseCorrB1000ms) ./ size(coaH.noiseCorrB1000ms,2);
nccoaHM = [nccoaHMW nccoaHMB];
nccoaHSE = [nccoaHSEW nccoaHSEB];

nccoaLMW = nanmean(coaL.noiseCorrW1000ms);
nccoaLMB = nanmean(coaL.noiseCorrB1000ms);
nccoaLSEW = nanstd(coaL.noiseCorrW1000ms) ./ sqrt(size(coaL.noiseCorrW1000ms,2));
nccoaLSEB = nanstd(coaL.noiseCorrB1000ms) ./ sqrt(size(coaL.noiseCorrB1000ms,2));
nccoaLM = [nccoaLMW nccoaLMB];
nccoaLSE = [nccoaLSEW nccoaLSEB];

figure;
errorbar(ncPcxM, ncPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(nccoaM, nccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)

figure;
errorbar(ncPcxAAM, ncPcxAASE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(nccoaAAM, nccoaAASE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)

figure;
errorbar(ncPcxHM, ncPcxHSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(nccoaHM, nccoaHSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)

figure;
errorbar(ncPcxLM, ncPcxLSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(nccoaLM, nccoaLSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
