figure; plot(mean(pcx.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'k')
hold on; plot(mean(coa.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'r')
%axis off
box off
title('15 odors', 'FontName', 'DIscondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');

figure; plot(mean(pcxAA.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'k')
hold on; plot(mean(coaAA.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'r')
%axis off
box off
title('Innately Relevant Odors', 'FontName', 'DIscondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');


% figure; plot(mean(pcxH.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'k')
% hold on; plot(mean(coaH.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'r')
% axis off
% box off
% title('odor dilution: 1/1000', 'FontName', 'DIscondensed', 'FontSize', 14)
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% 
% figure; plot(mean(pcxL.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'k')
% hold on; plot(mean(coaL.respCellOdorPairPSTHExcMn), 'LineWidth', 2, 'Color', 'r')
% axis off
% box off
% title('odor dilution: 1/10', 'FontName', 'DIscondensed', 'FontSize', 14)
% set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%

figure; plot(pcx.distSniffNorm, 'LineWidth', 2, 'Color', 'k')
hold on; plot(coa.distSniffNorm, 'LineWidth', 2, 'Color', 'r')
grid on
ylabel('Change of correlation distance between odor representations relative to rest', 'FontName', 'DIscondensed', 'FontSize', 14)
xlabel('respiration cycle', 'FontName', 'DIscondensed', 'FontSize', 14)
title('15 odors', 'FontName', 'DIscondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');

figure; plot(pcxAA.distSniffNorm, 'LineWidth', 2, 'Color', 'k')
hold on; plot(coaAA.distSniffNorm, 'LineWidth', 2, 'Color', 'r')
grid on
ylabel('Change of correlation distance between odor representations relative to rest', 'FontName', 'DIscondensed', 'FontSize', 14)
xlabel('respiration cycle', 'FontName', 'DIscondensed', 'FontSize', 14)
title('Innately Relevant Odors', 'FontName', 'DIscondensed', 'FontSize', 14)
set(gcf,'color','white', 'PaperPositionMode', 'auto');

% figure; plot(pcxH.distSniffNorm, 'LineWidth', 2, 'Color', 'k')
% hold on; plot(coaH.distSniffNorm, 'LineWidth', 2, 'Color', 'r')
% grid on
% xlabel('respiration cycle', 'FontName', 'DIscondensed', 'FontSize', 14)
% title('7 odors - odor dilution: 1/1000', 'FontName', 'DIscondensed', 'FontSize', 14)
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% figure; plot(pcxL.distSniffNorm, 'LineWidth', 2, 'Color', 'k')
% hold on; plot(coaL.distSniffNorm, 'LineWidth', 2, 'Color', 'r')
% grid on
% xlabel('respiration cycle', 'FontName', 'DIscondensed', 'FontSize', 14)
% title('7 odors - odor dilution: 1/10', 'FontName', 'DIscondensed', 'FontSize', 14)
% set(gcf,'color','white', 'PaperPositionMode', 'auto');

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
title('lifetime sparseness - 15 - first 300 ms')


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
title('lifetime sparseness - 15 - first 1000 ms')

% edges300 = -0.05:0.1:1.05;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxH.ls300msTot, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(pcxH.ls300msTot));
% h1.FaceColor = 'k';
% h1.EdgeColor = 'k';
% hold on
% [N,edges] = histcounts(coaH.ls300msTot, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(coaH.ls300msTot));
% h1.FaceColor = 'r';
% h1.EdgeColor = 'r';
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('lifetime sparseness  - first 300 ms - Low')
% 
% edges300 = -0.05:0.1:1.05;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxH.ls1sTot, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(pcxH.ls1sTot));
% h1.FaceColor = 'k';
% h1.EdgeColor = 'k';
% hold on
% [N,edges] = histcounts(coaH.ls1sTot, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(coaH.ls1sTot));
% h1.FaceColor = 'r';
% h1.EdgeColor = 'r';
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('lifetime sparseness  - first 1000 s - Low')
% 
% edges300 = -0.05:0.1:1.05;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxL.ls300msTot, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(pcxL.ls300msTot));
% h1.FaceColor = 'k';
% h1.EdgeColor = 'k';
% hold on
% [N,edges] = histcounts(coaL.ls300msTot, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(coaL.ls300msTot));
% h1.FaceColor = 'r';
% h1.EdgeColor = 'r';
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('lifetime sparseness  - first 300 ms - High')
% 
% edges300 = -0.05:0.1:1.05;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxL.ls1sTot, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(pcxL.ls1sTot));
% h1.FaceColor = 'k';
% h1.EdgeColor = 'k';
% hold on
% [N,edges] = histcounts(coaL.ls1sTot, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(coaL.ls1sTot));
% h1.FaceColor = 'r';
% h1.EdgeColor = 'r';
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('lifetime sparseness  - first 1000 s - High')
% 
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
title('lifetime sparseness - AA - first 300 ms')


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
title('lifetime sparseness - AA - first 1000 ms')
%%
% edges300 = 0:0.1:1;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcx.auROCTot300ms, edges300);
% edges(1) = [];
% plot(edges, N./length(pcx.auROCTot300ms), 'k');
% hold on
% [N,edges] = histcounts(coa.auROCTot300ms, edges300);
% edges(1) = [];
% plot(edges, N./length(coa.auROCTot300ms), 'r');
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('auROC  - first 300 ms')
% 
% edges300 = 0:0.1:1;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcx.auROCTot1s, edges300);
% edges(1) = [];
% plot(edges, N./length(pcx.auROCTot1s), 'k');
% hold on
% [N,edges] = histcounts(coa.auROCTot1s, edges300);
% edges(1) = [];
% plot(edges, N./length(coa.auROCTot1s), 'r');
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('auROC  - first 1000 ms')

% edges300 = 0:0.1:1;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxH.auROCTot300ms, edges300);
% edges(1) = [];
% plot(edges, N./length(pcxH.auROCTot300ms), 'k');
% hold on
% [N,edges] = histcounts(coaH.auROCTot300ms, edges300);
% edges(1) = [];
% plot(edges, N./length(coaH.auROCTot300ms), 'r');
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('auROC - L   - first 300 ms')
% 
% edges300 = 0:0.1:1;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxH.auROCTot1s, edges300);
% edges(1) = [];
% plot(edges, N./length(pcxH.auROCTot1s), 'k');
% hold on
% [N,edges] = histcounts(coaH.auROCTot1s, edges300);
% edges(1) = [];
% plot(edges, N./length(coaH.auROCTot1s), 'r');
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('auROC - L  - first 1000 ms')
% 
% edges300 = 0:0.1:1;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxL.auROCTot300ms, edges300);
% edges(1) = [];
% plot(edges, N./length(pcxL.auROCTot300ms), 'k');
% hold on
% [N,edges] = histcounts(coaL.auROCTot300ms, edges300);
% edges(1) = [];
% plot(edges, N./length(coaL.auROCTot300ms), 'r');
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('auROC - H   - first 300 ms')
% 
% edges300 = 0:0.1:1;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxL.auROCTot1s, edges300);
% edges(1) = [];
% plot(edges, N./length(pcxL.auROCTot1s), 'k');
% hold on
% [N,edges] = histcounts(coaL.auROCTot1s, edges300);
% edges(1) = [];
% plot(edges, N./length(coaL.auROCTot1s), 'r');
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('auROC - H  - first 1000 ms')

% edges300 = 0:0.1:1;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxAA.auROCTot300ms, edges300);
% edges(1) = [];
% plot(edges, N./length(pcxAA.auROCTot300ms), 'k');
% hold on
% [N,edges] = histcounts(coaAA.auROCTot300ms, edges300);
% edges(1) = [];
% plot(edges, N./length(coaAA.auROCTot300ms), 'r');
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('auROC -AA - first 300 ms')
% 
% edges300 = 0:0.1:1;
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(pcxAA.auROCTot1s, edges300);
% edges(1) = [];
% plot(edges, N./length(pcxAA.auROCTot1s), 'k');
% hold on
% [N,edges] = histcounts(coaAA.auROCTot1s, edges300);
% edges(1) = [];
% plot(edges, N./length(coaAA.auROCTot1s), 'r');
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% title('auROC -AA - first 1000 ms')

%%
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = cdfplot(pcx.auROCTot300ms);
set(h1, 'linewidth', 2, 'color', 'k')
hold on
h2 = cdfplot(coa.auROCTot300ms);
set(h2, 'linewidth', 2, 'color', 'r')
title('auROC - 15 - first 300 ms')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = cdfplot(pcxAA.auROCTot300ms);
set(h1, 'linewidth', 2, 'color', 'k')
hold on
h2 = cdfplot(coaAA.auROCTot300ms);
set(h2, 'linewidth', 2, 'color', 'r')
title('auROC - AA - first 300 ms')
% 
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% h1 = cdfplot(pcxH.auROCTot300ms);
% set(h1, 'linewidth', 2, 'color', 'k')
% hold on
% h2 = cdfplot(coaH.auROCTot300ms);
% set(h2, 'linewidth', 2, 'color', 'r')
% title('auROC - Low - first 1000 ms')
% % 
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% h1 = cdfplot(pcxL.auROCTot300ms);
% set(h1, 'linewidth', 2, 'color', 'k')
% hold on
% h2 = cdfplot(coaL.auROCTot300ms);
% set(h2, 'linewidth', 2, 'color', 'r')
% title('auROC - High - first 1000 ms')
% 
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = cdfplot(pcx.auROCTot1s);
set(h1, 'linewidth', 2, 'color', 'k')
hold on
h2 = cdfplot(coa.auROCTot1s);
set(h2, 'linewidth', 2, 'color', 'r')
title('auROC - 15 - first 1000 ms')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = cdfplot(pcxAA.auROCTot1s);
set(h1, 'linewidth', 2, 'color', 'k')
hold on
h2 = cdfplot(coaAA.auROCTot1s);
set(h2, 'linewidth', 2, 'color', 'r')
title('auROC - AA - first 1000 ms')
% 
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% h1 = cdfplot(pcxH.auROCTot1s);
% set(h1, 'linewidth', 2, 'color', 'k')
% hold on
% h2 = cdfplot(coaH.auROCTot1s);
% set(h2, 'linewidth', 2, 'color', 'r')
% title('auROC - Low - first 1000 ms')
% % 
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% h1 = cdfplot(pcxL.auROCTot1s);
% set(h1, 'linewidth', 2, 'color', 'k')
% hold on
% h2 = cdfplot(coaL.auROCTot1s);
% set(h2, 'linewidth', 2, 'color', 'r')
% title('auROC - High - first 1000 ms')
%%
pcx.sigCorrW1000ms(isnan(pcx.sigCorrW1000ms)) = [];
pcx.sigCorrB1000ms(isnan(pcx.sigCorrB1000ms)) = [];
pcxAA.sigCorrW1000ms(isnan(pcxAA.sigCorrW1000ms)) = [];
pcxAA.sigCorrB1000ms(isnan(pcxAA.sigCorrB1000ms)) = [];
% pcxH.sigCorrW1000ms(isnan(pcxH.sigCorrW1000ms)) = [];
% pcxH.sigCorrB1000ms(isnan(pcxH.sigCorrB1000ms)) = [];
% pcxL.sigCorrW1000ms(isnan(pcxL.sigCorrW1000ms)) = [];
% pcxL.sigCorrB1000ms(isnan(pcxL.sigCorrB1000ms)) = [];

coa.sigCorrW1000ms(isnan(coa.sigCorrW1000ms)) = [];
coa.sigCorrB1000ms(isnan(coa.sigCorrB1000ms)) = [];
coaAA.sigCorrW1000ms(isnan(coaAA.sigCorrW1000ms)) = [];
coaAA.sigCorrB1000ms(isnan(coaAA.sigCorrB1000ms)) = [];
% coaH.sigCorrW1000ms(isnan(coaH.sigCorrW1000ms)) = [];
% coaH.sigCorrB1000ms(isnan(coaH.sigCorrB1000ms)) = [];
% coaL.sigCorrW1000ms(isnan(coaL.sigCorrW1000ms)) = [];
% coaL.sigCorrB1000ms(isnan(coaL.sigCorrB1000ms)) = [];


scPcxMW = [pcx.sigCorrW1000ms ];%pcxAA.sigCorrW1000ms pcxH.sigCorrW1000ms];
scPcxMB = [pcx.sigCorrB1000ms ];%pcxAA.sigCorrB1000ms pcxH.sigCorrB1000ms];
sccoaMW = [coa.sigCorrW1000ms ];%coaAA.sigCorrW1000ms coaH.sigCorrW1000ms];
sccoaMB = [coa.sigCorrB1000ms ];%coaAA.sigCorrB1000ms coaH.sigCorrB1000ms];



scPcxMW1 = nanmean(scPcxMW);
scPcxMB1 = nanmean(scPcxMB);
scPcxSEW = nanstd(scPcxMW) ./ sqrt(size(scPcxMW,2));
scPcxSEB = nanstd(scPcxMB) ./ sqrt(size(scPcxMB,2));
scPcxM = [scPcxMW1 scPcxMB1];
scPcxSE = [scPcxSEW scPcxSEB];

scPcxAAMW = nanmean(pcxAA.sigCorrW1000ms);
scPcxAAMB = nanmean(pcxAA.sigCorrB1000ms);
scPcxAASEW = nanstd(pcxAA.sigCorrW1000ms) ./ sqrt(size(pcxAA.sigCorrW1000ms,2));
scPcxAASEB = nanstd(pcxAA.sigCorrB1000ms) ./ sqrt(size(pcxAA.sigCorrB1000ms,2));
scPcxAAM = [scPcxAAMW scPcxAAMB];
scPcxAASE = [scPcxAASEW scPcxAASEB];
% 
% scPcxHMW = nanmean(pcxH.sigCorrW1000ms);
% scPcxHMB = nanmean(pcxH.sigCorrB1000ms);
% scPcxHSEW = nanstd(pcxH.sigCorrW1000ms) ./ sqrt(size(pcxH.sigCorrW1000ms,2));
% scPcxHSEB = nanstd(pcxH.sigCorrB1000ms) ./ sqrt(size(pcxH.sigCorrB1000ms,2));
% scPcxHM = [scPcxHMW scPcxHMB];
% scPcxHSE = [scPcxHSEW scPcxHSEB];
% 
% scPcxLMW = nanmean(pcxL.sigCorrW1000ms);
% scPcxLMB = nanmean(pcxL.sigCorrB1000ms);
% scPcxLSEW = nanstd(pcxL.sigCorrW1000ms) ./ sqrt(size(pcxL.sigCorrW1000ms,2));
% scPcxLSEB = nanstd(pcxL.sigCorrB1000ms) ./ sqrt(size(pcxL.sigCorrB1000ms,2));
% scPcxLM = [scPcxLMW scPcxLMB];
% scPcxLSE = [scPcxLSEW scPcxLSEB];

sccoaMW1 = nanmean(sccoaMW);
sccoaMB1 = nanmean(sccoaMB);
sccoaSEW = nanstd(sccoaMW) ./ sqrt(size(sccoaMW,2));
sccoaSEB = nanstd(sccoaMB) ./ sqrt(size(sccoaMB,2));
sccoaM = [sccoaMW1 sccoaMB1];
sccoaSE = [sccoaSEW sccoaSEB];

sccoaAAMW = nanmean(coaAA.sigCorrW1000ms);
sccoaAAMB = nanmean(coaAA.sigCorrB1000ms);
sccoaAASEW = nanstd(coaAA.sigCorrW1000ms) ./ sqrt(size(coaAA.sigCorrW1000ms,2));
sccoaAASEB = nanstd(coaAA.sigCorrB1000ms) ./ sqrt(size(coaAA.sigCorrB1000ms,2));
sccoaAAM = [sccoaAAMW sccoaAAMB];
sccoaAASE = [sccoaAASEW sccoaAASEB];
% 
% sccoaHMW = nanmean(coaH.sigCorrW1000ms);
% sccoaHMB = nanmean(coaH.sigCorrB1000ms);
% sccoaHSEW = nanstd(coaH.sigCorrW1000ms) ./ size(coaH.sigCorrW1000ms,2);
% sccoaHSEB = nanstd(coaH.sigCorrB1000ms) ./ size(coaH.sigCorrB1000ms,2);
% sccoaHM = [sccoaHMW sccoaHMB];
% sccoaHSE = [sccoaHSEW sccoaHSEB];
% 
% sccoaLMW = nanmean(coaL.sigCorrW1000ms);
% sccoaLMB = nanmean(coaL.sigCorrB1000ms);
% sccoaLSEW = nanstd(coaL.sigCorrW1000ms) ./ sqrt(size(coaL.sigCorrW1000ms,2));
% sccoaLSEB = nanstd(coaL.sigCorrB1000ms) ./ sqrt(size(coaL.sigCorrB1000ms,2));
% sccoaLM = [sccoaLMW sccoaLMB];
% sccoaLSE = [sccoaLSEW sccoaLSEB];

figure;
errorbar(scPcxM, scPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaM, sccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('sig corr - 15 - first 1000 ms')
set(gcf,'Position',[100 615 198 420]);

figure;
errorbar(scPcxAAM, scPcxAASE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaAAM, sccoaAASE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('sig corr - AA - first 1000 ms')
set(gcf,'Position',[100 615 198 420]);
% 
% figure;
% errorbar(scPcxHM, scPcxHSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
% hold on
% errorbar(sccoaHM, sccoaHSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
% title('sig corr - Low - first 1000 ms')
% % 
% figure;
% errorbar(scPcxLM, scPcxLSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
% hold on
% errorbar(sccoaLM, sccoaLSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
% title('sig corr - High - first 1000 ms')

%%
%%
pcx.sigCorrW300ms(isnan(pcx.sigCorrW300ms)) = [];
pcx.sigCorrB300ms(isnan(pcx.sigCorrB300ms)) = [];
pcxAA.sigCorrW300ms(isnan(pcxAA.sigCorrW300ms)) = [];
pcxAA.sigCorrB300ms(isnan(pcxAA.sigCorrB300ms)) = [];
% pcxH.sigCorrW300ms(isnan(pcxH.sigCorrW300ms)) = [];
% pcxH.sigCorrB300ms(isnan(pcxH.sigCorrB300ms)) = [];
% pcxL.sigCorrW300ms(isnan(pcxL.sigCorrW300ms)) = [];
% pcxL.sigCorrB300ms(isnan(pcxL.sigCorrB300ms)) = [];

coa.sigCorrW300ms(isnan(coa.sigCorrW300ms)) = [];
coa.sigCorrB300ms(isnan(coa.sigCorrB300ms)) = [];
coaAA.sigCorrW300ms(isnan(coaAA.sigCorrW300ms)) = [];
coaAA.sigCorrB300ms(isnan(coaAA.sigCorrB300ms)) = [];
% coaH.sigCorrW300ms(isnan(coaH.sigCorrW300ms)) = [];
% coaH.sigCorrB300ms(isnan(coaH.sigCorrB300ms)) = [];
% coaL.sigCorrW300ms(isnan(coaL.sigCorrW300ms)) = [];
% coaL.sigCorrB300ms(isnan(coaL.sigCorrB300ms)) = [];


scPcxMW = [pcx.sigCorrW300ms ];%pcxAA.sigCorrW300ms pcxH.sigCorrW300ms];
scPcxMB = [pcx.sigCorrB300ms ];%pcxAA.sigCorrB300ms pcxH.sigCorrB300ms];
sccoaMW = [coa.sigCorrW300ms ];%coaAA.sigCorrW300ms coaH.sigCorrW300ms];
sccoaMB = [coa.sigCorrB300ms ];%coaAA.sigCorrB300ms coaH.sigCorrB300ms];



scPcxMW1 = nanmean(scPcxMW);
scPcxMB1 = nanmean(scPcxMB);
scPcxSEW = nanstd(scPcxMW) ./ sqrt(size(scPcxMW,2));
scPcxSEB = nanstd(scPcxMB) ./ sqrt(size(scPcxMB,2));
scPcxM = [scPcxMW1 scPcxMB1];
scPcxSE = [scPcxSEW scPcxSEB];

scPcxAAMW = nanmean(pcxAA.sigCorrW300ms);
scPcxAAMB = nanmean(pcxAA.sigCorrB300ms);
scPcxAASEW = nanstd(pcxAA.sigCorrW300ms) ./ sqrt(size(pcxAA.sigCorrW300ms,2));
scPcxAASEB = nanstd(pcxAA.sigCorrB300ms) ./ sqrt(size(pcxAA.sigCorrB300ms,2));
scPcxAAM = [scPcxAAMW scPcxAAMB];
scPcxAASE = [scPcxAASEW scPcxAASEB];
% 
% scPcxHMW = nanmean(pcxH.sigCorrW300ms);
% scPcxHMB = nanmean(pcxH.sigCorrB300ms);
% scPcxHSEW = nanstd(pcxH.sigCorrW300ms) ./ sqrt(size(pcxH.sigCorrW300ms,2));
% scPcxHSEB = nanstd(pcxH.sigCorrB300ms) ./ sqrt(size(pcxH.sigCorrB300ms,2));
% scPcxHM = [scPcxHMW scPcxHMB];
% scPcxHSE = [scPcxHSEW scPcxHSEB];
% 
% scPcxLMW = nanmean(pcxL.sigCorrW300ms);
% scPcxLMB = nanmean(pcxL.sigCorrB300ms);
% scPcxLSEW = nanstd(pcxL.sigCorrW300ms) ./ sqrt(size(pcxL.sigCorrW300ms,2));
% scPcxLSEB = nanstd(pcxL.sigCorrB300ms) ./ sqrt(size(pcxL.sigCorrB300ms,2));
% scPcxLM = [scPcxLMW scPcxLMB];
% scPcxLSE = [scPcxLSEW scPcxLSEB];

sccoaMW1 = nanmean(sccoaMW);
sccoaMB1 = nanmean(sccoaMB);
sccoaSEW = nanstd(sccoaMW) ./ sqrt(size(sccoaMW,2));
sccoaSEB = nanstd(sccoaMB) ./ sqrt(size(sccoaMB,2));
sccoaM = [sccoaMW1 sccoaMB1];
sccoaSE = [sccoaSEW sccoaSEB];

sccoaAAMW = nanmean(coaAA.sigCorrW300ms);
sccoaAAMB = nanmean(coaAA.sigCorrB300ms);
sccoaAASEW = nanstd(coaAA.sigCorrW300ms) ./ sqrt(size(coaAA.sigCorrW300ms,2));
sccoaAASEB = nanstd(coaAA.sigCorrB300ms) ./ sqrt(size(coaAA.sigCorrB300ms,2));
sccoaAAM = [sccoaAAMW sccoaAAMB];
sccoaAASE = [sccoaAASEW sccoaAASEB];
% 
% sccoaHMW = nanmean(coaH.sigCorrW300ms);
% sccoaHMB = nanmean(coaH.sigCorrB300ms);
% sccoaHSEW = nanstd(coaH.sigCorrW300ms) ./ size(coaH.sigCorrW300ms,2);
% sccoaHSEB = nanstd(coaH.sigCorrB300ms) ./ size(coaH.sigCorrB300ms,2);
% sccoaHM = [sccoaHMW sccoaHMB];
% sccoaHSE = [sccoaHSEW sccoaHSEB];
% 
% sccoaLMW = nanmean(coaL.sigCorrW300ms);
% sccoaLMB = nanmean(coaL.sigCorrB300ms);
% sccoaLSEW = nanstd(coaL.sigCorrW300ms) ./ sqrt(size(coaL.sigCorrW300ms,2));
% sccoaLSEB = nanstd(coaL.sigCorrB300ms) ./ sqrt(size(coaL.sigCorrB300ms,2));
% sccoaLM = [sccoaLMW sccoaLMB];
% sccoaLSE = [sccoaLSEW sccoaLSEB];

figure;
errorbar(scPcxM, scPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaM, sccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('sig corr - 15 - first 300 ms')
set(gcf,'Position',[100 615 198 420]);

figure;
errorbar(scPcxAAM, scPcxAASE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaAAM, sccoaAASE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('sig corr - AA - first 300 ms')
set(gcf,'Position',[100 615 198 420]);
% 
% figure;
% errorbar(scPcxHM, scPcxHSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
% hold on
% errorbar(sccoaHM, sccoaHSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
% title('sig corr - Low - first 300 ms')
% % 
% figure;
% errorbar(scPcxLM, scPcxLSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
% hold on
% errorbar(sccoaLM, sccoaLSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
% title('sig corr - High - first 300 ms')
%%
%%
pcx.noiseCorrW1000ms(isnan(pcx.noiseCorrW1000ms)) = [];
pcx.noiseCorrB1000ms(isnan(pcx.noiseCorrB1000ms)) = [];
pcxAA.noiseCorrW1000ms(isnan(pcxAA.noiseCorrW1000ms)) = [];
pcxAA.noiseCorrB1000ms(isnan(pcxAA.noiseCorrB1000ms)) = [];
% pcxH.noiseCorrW1000ms(isnan(pcxH.noiseCorrW1000ms)) = [];
% pcxH.noiseCorrB1000ms(isnan(pcxH.noiseCorrB1000ms)) = [];
% pcxL.noiseCorrW1000ms(isnan(pcxL.noiseCorrW1000ms)) = [];
% pcxL.noiseCorrB1000ms(isnan(pcxL.noiseCorrB1000ms)) = [];

coa.noiseCorrW1000ms(isnan(coa.noiseCorrW1000ms)) = [];
coa.noiseCorrB1000ms(isnan(coa.noiseCorrB1000ms)) = [];
coaAA.noiseCorrW1000ms(isnan(coaAA.noiseCorrW1000ms)) = [];
coaAA.noiseCorrB1000ms(isnan(coaAA.noiseCorrB1000ms)) = [];
% coaH.noiseCorrW1000ms(isnan(coaH.noiseCorrW1000ms)) = [];
% coaH.noiseCorrB1000ms(isnan(coaH.noiseCorrB1000ms)) = [];
% coaL.noiseCorrW1000ms(isnan(coaL.noiseCorrW1000ms)) = [];
% coaL.noiseCorrB1000ms(isnan(coaL.noiseCorrB1000ms)) = [];


scPcxMW = [pcx.noiseCorrW1000ms ];%pcxAA.noiseCorrW1000ms pcxH.noiseCorrW1000ms];
scPcxMB = [pcx.noiseCorrB1000ms ];%pcxAA.noiseCorrB1000ms pcxH.noiseCorrB1000ms];
sccoaMW = [coa.noiseCorrW1000ms ];%coaAA.noiseCorrW1000ms coaH.noiseCorrW1000ms];
sccoaMB = [coa.noiseCorrB1000ms ];%coaAA.noiseCorrB1000ms coaH.noiseCorrB1000ms];



scPcxMW1 = nanmean(scPcxMW);
scPcxMB1 = nanmean(scPcxMB);
scPcxSEW = nanstd(scPcxMW) ./ sqrt(size(scPcxMW,2));
scPcxSEB = nanstd(scPcxMB) ./ sqrt(size(scPcxMB,2));
scPcxM = [scPcxMW1 scPcxMB1];
scPcxSE = [scPcxSEW scPcxSEB];

scPcxAAMW = nanmean(pcxAA.noiseCorrW1000ms);
scPcxAAMB = nanmean(pcxAA.noiseCorrB1000ms);
scPcxAASEW = nanstd(pcxAA.noiseCorrW1000ms) ./ sqrt(size(pcxAA.noiseCorrW1000ms,2));
scPcxAASEB = nanstd(pcxAA.noiseCorrB1000ms) ./ sqrt(size(pcxAA.noiseCorrB1000ms,2));
scPcxAAM = [scPcxAAMW scPcxAAMB];
scPcxAASE = [scPcxAASEW scPcxAASEB];
% 
% scPcxHMW = nanmean(pcxH.noiseCorrW1000ms);
% scPcxHMB = nanmean(pcxH.noiseCorrB1000ms);
% scPcxHSEW = nanstd(pcxH.noiseCorrW1000ms) ./ sqrt(size(pcxH.noiseCorrW1000ms,2));
% scPcxHSEB = nanstd(pcxH.noiseCorrB1000ms) ./ sqrt(size(pcxH.noiseCorrB1000ms,2));
% scPcxHM = [scPcxHMW scPcxHMB];
% scPcxHSE = [scPcxHSEW scPcxHSEB];
% 
% scPcxLMW = nanmean(pcxL.noiseCorrW1000ms);
% scPcxLMB = nanmean(pcxL.noiseCorrB1000ms);
% scPcxLSEW = nanstd(pcxL.noiseCorrW1000ms) ./ sqrt(size(pcxL.noiseCorrW1000ms,2));
% scPcxLSEB = nanstd(pcxL.noiseCorrB1000ms) ./ sqrt(size(pcxL.noiseCorrB1000ms,2));
% scPcxLM = [scPcxLMW scPcxLMB];
% scPcxLSE = [scPcxLSEW scPcxLSEB];

sccoaMW1 = nanmean(sccoaMW);
sccoaMB1 = nanmean(sccoaMB);
sccoaSEW = nanstd(sccoaMW) ./ sqrt(size(sccoaMW,2));
sccoaSEB = nanstd(sccoaMB) ./ sqrt(size(sccoaMB,2));
sccoaM = [sccoaMW1 sccoaMB1];
sccoaSE = [sccoaSEW sccoaSEB];

sccoaAAMW = nanmean(coaAA.noiseCorrW1000ms);
sccoaAAMB = nanmean(coaAA.noiseCorrB1000ms);
sccoaAASEW = nanstd(coaAA.noiseCorrW1000ms) ./ sqrt(size(coaAA.noiseCorrW1000ms,2));
sccoaAASEB = nanstd(coaAA.noiseCorrB1000ms) ./ sqrt(size(coaAA.noiseCorrB1000ms,2));
sccoaAAM = [sccoaAAMW sccoaAAMB];
sccoaAASE = [sccoaAASEW sccoaAASEB];
% 
% sccoaHMW = nanmean(coaH.noiseCorrW1000ms);
% sccoaHMB = nanmean(coaH.noiseCorrB1000ms);
% sccoaHSEW = nanstd(coaH.noiseCorrW1000ms) ./ size(coaH.noiseCorrW1000ms,2);
% sccoaHSEB = nanstd(coaH.noiseCorrB1000ms) ./ size(coaH.noiseCorrB1000ms,2);
% sccoaHM = [sccoaHMW sccoaHMB];
% sccoaHSE = [sccoaHSEW sccoaHSEB];
% 
% sccoaLMW = nanmean(coaL.noiseCorrW1000ms);
% sccoaLMB = nanmean(coaL.noiseCorrB1000ms);
% sccoaLSEW = nanstd(coaL.noiseCorrW1000ms) ./ sqrt(size(coaL.noiseCorrW1000ms,2));
% sccoaLSEB = nanstd(coaL.noiseCorrB1000ms) ./ sqrt(size(coaL.noiseCorrB1000ms,2));
% sccoaLM = [sccoaLMW sccoaLMB];
% sccoaLSE = [sccoaLSEW sccoaLSEB];

figure;
errorbar(scPcxM, scPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaM, sccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('noise corr - 15 - first 1000 ms')
set(gcf,'Position',[100 615 198 420]);

figure;
errorbar(scPcxAAM, scPcxAASE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaAAM, sccoaAASE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('noise corr - AA - first 1000 ms')
set(gcf,'Position',[100 615 198 420]);
% 
% figure;
% errorbar(scPcxHM, scPcxHSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
% hold on
% errorbar(sccoaHM, sccoaHSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
% title('noise corr - Low - first 1000 ms')
% % 
% figure;
% errorbar(scPcxLM, scPcxLSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
% hold on
% errorbar(sccoaLM, sccoaLSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
% title('noise corr - High - first 1000 ms')
%%
%%
pcx.noiseCorrW300ms(isnan(pcx.noiseCorrW300ms)) = [];
pcx.noiseCorrB300ms(isnan(pcx.noiseCorrB300ms)) = [];
pcxAA.noiseCorrW300ms(isnan(pcxAA.noiseCorrW300ms)) = [];
pcxAA.noiseCorrB300ms(isnan(pcxAA.noiseCorrB300ms)) = [];
% pcxH.noiseCorrW300ms(isnan(pcxH.noiseCorrW300ms)) = [];
% pcxH.noiseCorrB300ms(isnan(pcxH.noiseCorrB300ms)) = [];
% pcxL.noiseCorrW300ms(isnan(pcxL.noiseCorrW300ms)) = [];
% pcxL.noiseCorrB300ms(isnan(pcxL.noiseCorrB300ms)) = [];

coa.noiseCorrW300ms(isnan(coa.noiseCorrW300ms)) = [];
coa.noiseCorrB300ms(isnan(coa.noiseCorrB300ms)) = [];
coaAA.noiseCorrW300ms(isnan(coaAA.noiseCorrW300ms)) = [];
coaAA.noiseCorrB300ms(isnan(coaAA.noiseCorrB300ms)) = [];
% coaH.noiseCorrW300ms(isnan(coaH.noiseCorrW300ms)) = [];
% coaH.noiseCorrB300ms(isnan(coaH.noiseCorrB300ms)) = [];
% coaL.noiseCorrW300ms(isnan(coaL.noiseCorrW300ms)) = [];
% coaL.noiseCorrB300ms(isnan(coaL.noiseCorrB300ms)) = [];


scPcxMW = [pcx.noiseCorrW300ms ];%pcxAA.noiseCorrW300ms pcxH.noiseCorrW300ms];
scPcxMB = [pcx.noiseCorrB300ms ];%pcxAA.noiseCorrB300ms pcxH.noiseCorrB300ms];
sccoaMW = [coa.noiseCorrW300ms ];%coaAA.noiseCorrW300ms coaH.noiseCorrW300ms];
sccoaMB = [coa.noiseCorrB300ms ];%coaAA.noiseCorrB300ms coaH.noiseCorrB300ms];



scPcxMW1 = nanmean(scPcxMW);
scPcxMB1 = nanmean(scPcxMB);
scPcxSEW = nanstd(scPcxMW) ./ sqrt(size(scPcxMW,2));
scPcxSEB = nanstd(scPcxMB) ./ sqrt(size(scPcxMB,2));
scPcxM = [scPcxMW1 scPcxMB1];
scPcxSE = [scPcxSEW scPcxSEB];

scPcxAAMW = nanmean(pcxAA.noiseCorrW300ms);
scPcxAAMB = nanmean(pcxAA.noiseCorrB300ms);
scPcxAASEW = nanstd(pcxAA.noiseCorrW300ms) ./ sqrt(size(pcxAA.noiseCorrW300ms,2));
scPcxAASEB = nanstd(pcxAA.noiseCorrB300ms) ./ sqrt(size(pcxAA.noiseCorrB300ms,2));
scPcxAAM = [scPcxAAMW scPcxAAMB];
scPcxAASE = [scPcxAASEW scPcxAASEB];
% 
% scPcxHMW = nanmean(pcxH.noiseCorrW300ms);
% scPcxHMB = nanmean(pcxH.noiseCorrB300ms);
% scPcxHSEW = nanstd(pcxH.noiseCorrW300ms) ./ sqrt(size(pcxH.noiseCorrW300ms,2));
% scPcxHSEB = nanstd(pcxH.noiseCorrB300ms) ./ sqrt(size(pcxH.noiseCorrB300ms,2));
% scPcxHM = [scPcxHMW scPcxHMB];
% scPcxHSE = [scPcxHSEW scPcxHSEB];
% 
% scPcxLMW = nanmean(pcxL.noiseCorrW300ms);
% scPcxLMB = nanmean(pcxL.noiseCorrB300ms);
% scPcxLSEW = nanstd(pcxL.noiseCorrW300ms) ./ sqrt(size(pcxL.noiseCorrW300ms,2));
% scPcxLSEB = nanstd(pcxL.noiseCorrB300ms) ./ sqrt(size(pcxL.noiseCorrB300ms,2));
% scPcxLM = [scPcxLMW scPcxLMB];
% scPcxLSE = [scPcxLSEW scPcxLSEB];

sccoaMW1 = nanmean(sccoaMW);
sccoaMB1 = nanmean(sccoaMB);
sccoaSEW = nanstd(sccoaMW) ./ sqrt(size(sccoaMW,2));
sccoaSEB = nanstd(sccoaMB) ./ sqrt(size(sccoaMB,2));
sccoaM = [sccoaMW1 sccoaMB1];
sccoaSE = [sccoaSEW sccoaSEB];

sccoaAAMW = nanmean(coaAA.noiseCorrW300ms);
sccoaAAMB = nanmean(coaAA.noiseCorrB300ms);
sccoaAASEW = nanstd(coaAA.noiseCorrW300ms) ./ sqrt(size(coaAA.noiseCorrW300ms,2));
sccoaAASEB = nanstd(coaAA.noiseCorrB300ms) ./ sqrt(size(coaAA.noiseCorrB300ms,2));
sccoaAAM = [sccoaAAMW sccoaAAMB];
sccoaAASE = [sccoaAASEW sccoaAASEB];
% 
% sccoaHMW = nanmean(coaH.noiseCorrW300ms);
% sccoaHMB = nanmean(coaH.noiseCorrB300ms);
% sccoaHSEW = nanstd(coaH.noiseCorrW300ms) ./ size(coaH.noiseCorrW300ms,2);
% sccoaHSEB = nanstd(coaH.noiseCorrB300ms) ./ size(coaH.noiseCorrB300ms,2);
% sccoaHM = [sccoaHMW sccoaHMB];
% sccoaHSE = [sccoaHSEW sccoaHSEB];
% 
% sccoaLMW = nanmean(coaL.noiseCorrW300ms);
% sccoaLMB = nanmean(coaL.noiseCorrB300ms);
% sccoaLSEW = nanstd(coaL.noiseCorrW300ms) ./ sqrt(size(coaL.noiseCorrW300ms,2));
% sccoaLSEB = nanstd(coaL.noiseCorrB300ms) ./ sqrt(size(coaL.noiseCorrB300ms,2));
% sccoaLM = [sccoaLMW sccoaLMB];
% sccoaLSE = [sccoaLSEW sccoaLSEB];

figure;
errorbar(scPcxM, scPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaM, sccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('noise corr - 15 - first 300 ms')
set(gcf,'Position',[100 615 198 420]);

figure;
errorbar(scPcxAAM, scPcxAASE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaAAM, sccoaAASE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('noise corr - AA - first 300 ms')
set(gcf,'Position',[100 615 198 420]);
% 
% figure;
% errorbar(scPcxHM, scPcxHSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
% hold on
% errorbar(sccoaHM, sccoaHSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
% title('noise corr - Low - first 300 ms')
% % 
% figure;
% errorbar(scPcxLM, scPcxLSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
% hold on
% errorbar(sccoaLM, sccoaLSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
% title('noise corr - High - first 300 ms')
%%
pcx.sigCorrW1000ms(isnan(pcx.sigCorrW1000ms)) = [];
pcx.sigCorrB1000ms(isnan(pcx.sigCorrB1000ms)) = [];
pcxAA.sigCorrW1000ms(isnan(pcxAA.sigCorrW1000ms)) = [];
pcxAA.sigCorrB1000ms(isnan(pcxAA.sigCorrB1000ms)) = [];


coa.sigCorrW1000ms(isnan(coa.sigCorrW1000ms)) = [];
coa.sigCorrB1000ms(isnan(coa.sigCorrB1000ms)) = [];
coaAA.sigCorrW1000ms(isnan(coaAA.sigCorrW1000ms)) = [];
coaAA.sigCorrB1000ms(isnan(coaAA.sigCorrB1000ms)) = [];



scPcxMW = [pcx.sigCorrW1000ms pcxAA.sigCorrW1000ms];
scPcxMB = [pcx.sigCorrB1000ms pcxAA.sigCorrB1000ms];
sccoaMW = [coa.sigCorrW1000ms coaAA.sigCorrW1000ms];
sccoaMB = [coa.sigCorrB1000ms coaAA.sigCorrB1000ms];



scPcxMW1 = nanmean(scPcxMW);
scPcxMB1 = nanmean(scPcxMB);
scPcxSEW = nanstd(scPcxMW) ./ sqrt(size(scPcxMW,2));
scPcxSEB = nanstd(scPcxMB) ./ sqrt(size(scPcxMB,2));
scPcxM = [scPcxMW1 scPcxMB1];
scPcxSE = [scPcxSEW scPcxSEB];



sccoaMW1 = nanmean(sccoaMW);
sccoaMB1 = nanmean(sccoaMB);
sccoaSEW = nanstd(sccoaMW) ./ sqrt(size(sccoaMW,2));
sccoaSEB = nanstd(sccoaMB) ./ sqrt(size(sccoaMB,2));
sccoaM = [sccoaMW1 sccoaMB1];
sccoaSE = [sccoaSEW sccoaSEB];



figure;
errorbar(scPcxM, scPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaM, sccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('sig corr - ALL - first 1000 ms')
set(gcf,'Position',[100 615 198 420]);

%%
pcx.sigCorrW300ms(isnan(pcx.sigCorrW300ms)) = [];
pcx.sigCorrB300ms(isnan(pcx.sigCorrB300ms)) = [];
pcxAA.sigCorrW300ms(isnan(pcxAA.sigCorrW300ms)) = [];
pcxAA.sigCorrB300ms(isnan(pcxAA.sigCorrB300ms)) = [];


coa.sigCorrW300ms(isnan(coa.sigCorrW300ms)) = [];
coa.sigCorrB300ms(isnan(coa.sigCorrB300ms)) = [];
coaAA.sigCorrW300ms(isnan(coaAA.sigCorrW300ms)) = [];
coaAA.sigCorrB300ms(isnan(coaAA.sigCorrB300ms)) = [];



scPcxMW = [pcx.sigCorrW300ms pcxAA.sigCorrW300ms];
scPcxMB = [pcx.sigCorrB300ms pcxAA.sigCorrB300ms];
sccoaMW = [coa.sigCorrW300ms coaAA.sigCorrW300ms];
sccoaMB = [coa.sigCorrB300ms coaAA.sigCorrB300ms];



scPcxMW1 = nanmean(scPcxMW);
scPcxMB1 = nanmean(scPcxMB);
scPcxSEW = nanstd(scPcxMW) ./ sqrt(size(scPcxMW,2));
scPcxSEB = nanstd(scPcxMB) ./ sqrt(size(scPcxMB,2));
scPcxM = [scPcxMW1 scPcxMB1];
scPcxSE = [scPcxSEW scPcxSEB];



sccoaMW1 = nanmean(sccoaMW);
sccoaMB1 = nanmean(sccoaMB);
sccoaSEW = nanstd(sccoaMW) ./ sqrt(size(sccoaMW,2));
sccoaSEB = nanstd(sccoaMB) ./ sqrt(size(sccoaMB,2));
sccoaM = [sccoaMW1 sccoaMB1];
sccoaSE = [sccoaSEW sccoaSEB];



figure;
errorbar(scPcxM, scPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaM, sccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('sig corr - ALL - first 300 ms')
set(gcf,'Position',[100 615 198 420]);

%%
pcx.noiseCorrW300ms(isnan(pcx.noiseCorrW300ms)) = [];
pcx.noiseCorrB300ms(isnan(pcx.noiseCorrB300ms)) = [];
pcxAA.noiseCorrW300ms(isnan(pcxAA.noiseCorrW300ms)) = [];
pcxAA.noiseCorrB300ms(isnan(pcxAA.noiseCorrB300ms)) = [];


coa.noiseCorrW300ms(isnan(coa.noiseCorrW300ms)) = [];
coa.noiseCorrB300ms(isnan(coa.noiseCorrB300ms)) = [];
coaAA.noiseCorrW300ms(isnan(coaAA.noiseCorrW300ms)) = [];
coaAA.noiseCorrB300ms(isnan(coaAA.noiseCorrB300ms)) = [];



scPcxMW = [pcx.noiseCorrW300ms pcxAA.noiseCorrW300ms];
scPcxMB = [pcx.noiseCorrB300ms pcxAA.noiseCorrB300ms];
sccoaMW = [coa.noiseCorrW300ms coaAA.noiseCorrW300ms];
sccoaMB = [coa.noiseCorrB300ms coaAA.noiseCorrB300ms];



scPcxMW1 = nanmean(scPcxMW);
scPcxMB1 = nanmean(scPcxMB);
scPcxSEW = nanstd(scPcxMW) ./ sqrt(size(scPcxMW,2));
scPcxSEB = nanstd(scPcxMB) ./ sqrt(size(scPcxMB,2));
scPcxM = [scPcxMW1 scPcxMB1];
scPcxSE = [scPcxSEW scPcxSEB];



sccoaMW1 = nanmean(sccoaMW);
sccoaMB1 = nanmean(sccoaMB);
sccoaSEW = nanstd(sccoaMW) ./ sqrt(size(sccoaMW,2));
sccoaSEB = nanstd(sccoaMB) ./ sqrt(size(sccoaMB,2));
sccoaM = [sccoaMW1 sccoaMB1];
sccoaSE = [sccoaSEW sccoaSEB];



figure;
errorbar(scPcxM, scPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaM, sccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('noise corr - ALL - first 300 ms')
set(gcf,'Position',[100 615 198 420]);

%%

pcx.noiseCorrW1000ms(isnan(pcx.noiseCorrW1000ms)) = [];
pcx.noiseCorrB1000ms(isnan(pcx.noiseCorrB1000ms)) = [];
pcxAA.noiseCorrW1000ms(isnan(pcxAA.noiseCorrW1000ms)) = [];
pcxAA.noiseCorrB1000ms(isnan(pcxAA.noiseCorrB1000ms)) = [];


coa.noiseCorrW1000ms(isnan(coa.noiseCorrW1000ms)) = [];
coa.noiseCorrB1000ms(isnan(coa.noiseCorrB1000ms)) = [];
coaAA.noiseCorrW1000ms(isnan(coaAA.noiseCorrW1000ms)) = [];
coaAA.noiseCorrB1000ms(isnan(coaAA.noiseCorrB1000ms)) = [];



scPcxMW = [pcx.noiseCorrW1000ms pcxAA.noiseCorrW1000ms];
scPcxMB = [pcx.noiseCorrB1000ms pcxAA.noiseCorrB1000ms];
sccoaMW = [coa.noiseCorrW1000ms coaAA.noiseCorrW1000ms];
sccoaMB = [coa.noiseCorrB1000ms coaAA.noiseCorrB1000ms];



scPcxMW1 = nanmean(scPcxMW);
scPcxMB1 = nanmean(scPcxMB);
scPcxSEW = nanstd(scPcxMW) ./ sqrt(size(scPcxMW,2));
scPcxSEB = nanstd(scPcxMB) ./ sqrt(size(scPcxMB,2));
scPcxM = [scPcxMW1 scPcxMB1];
scPcxSE = [scPcxSEW scPcxSEB];



sccoaMW1 = nanmean(sccoaMW);
sccoaMB1 = nanmean(sccoaMB);
sccoaSEW = nanstd(sccoaMW) ./ sqrt(size(sccoaMW,2));
sccoaSEB = nanstd(sccoaMB) ./ sqrt(size(sccoaMB,2));
sccoaM = [sccoaMW1 sccoaMB1];
sccoaSE = [sccoaSEW sccoaSEB];



figure;
errorbar(scPcxM, scPcxSE, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(sccoaM, sccoaSE, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('noise corr - ALL - first 1000 ms')
set(gcf,'Position',[100 615 198 420]);