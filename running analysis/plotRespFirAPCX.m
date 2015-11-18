%%
% latApcx = [];
% widApcx = [];
% eFano300Apcx = [];
% eFano4Apcx = [];
% eRsp300Apcx = [];
% eVar300Apcx = [];
% eVar4Apcx = [];
% eRsp4Apcx = [];
% eRoc300Apcx = [];
% iRoc300Apcx = [];
% eRoc4Apcx = [];
% iRoc4Apcx = [];
%%
latApcx = [latApcx; peakLat];
widApcx = [widApcx; hWidth];
eFano300Apcx = [eFano300Apcx; excFanoRsp300ms];
eFano4Apcx = [eFano4Apcx; excFanoRsp4cycles];
eRsp300Apcx = [eRsp300Apcx; excMeanRsp300ms];
eVar300Apcx = [eVar300Apcx; excVarRsp300ms];
eVar4Apcx = [eVar4Apcx; excVarRsp4cycles];
eRsp4Apcx = [eRsp4Apcx; excMeanRsp4cycles];
eRoc300Apcx = [eRoc300Apcx; excAuRoc300ms];
iRoc300Apcx = [iRoc300Apcx; inhAuRoc300ms];
eRoc4Apcx = [eRoc4Apcx; excAuRoc4cycles];
iRoc4Apcx = [iRoc4Apcx; inhAuRoc4cycles];
%%

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:10:1000;
hold on
h1 = histcounts(widApcx,edges, 'normalization', 'probability')
h2 = histcounts(widApcx,edges, 'normalization', 'probability')

edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('log10(half-peak width), ms')
nanmedian(widApcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(widApcx)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')

%%
latApcx(latApcx<30) = [];
latApcx(latApcx<30) = [];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:10:1000;
hold on
h1 = histcounts(latApcx,edges, 'normalization', 'probability')
h2 = histcounts(latApcx,edges, 'normalization', 'probability')

edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('peak latency (ms)')
nanmedian(latApcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(latApcx)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:0.5:10;
hold on
h1 = histcounts(eFano300Apcx,edges, 'normalization', 'probability')
h2 = histcounts(eFano300Apcx,edges, 'normalization', 'probability')

edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('log10(half-peak width), ms')
nanmedian(eFano300Apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(eFano300Apcx)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:0.5:10;
hold on
h1 = histcounts(eFano4Apcx,edges, 'normalization', 'probability')
h2 = histcounts(eFano4Apcx,edges, 'normalization', 'probability')


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('log10(half-peak width), ms')
nanmedian(eFano4Apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(eFano4Apcx)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')

%%
% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% h0 = scatter(eRsp4Apcx, eVar4Apcx, 'filled');
% h0.MarkerFaceColor = [34,94,168]/255;
% h0.MarkerEdgeColor = [34,94,168]/255;
% hold on
% h1 = scatter(eRsp4Plcoa, eVar4Plcoa, 'filled');
% h1.MarkerFaceColor = [179,0,0]/255/255;
% h1.MarkerEdgeColor = [179,0,0]/255/255;
% xlabel('mean spike count');
% ylabel('variance spike count');
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
% title('first 300 ms')
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0.5:0.05:1.05;
hold on
h1 = histcounts(eRoc300Apcx,edges, 'normalization', 'probability')
h2 = histcounts(eRoc300Apcx,edges, 'normalization', 'probability')


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('excitatory discriminability (auROC) - first 300 ms')
nanmedian(eRoc300Apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(eRoc300Apcx)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:0.05:0.55;
hold on
h1 = histcounts(iRoc300Apcx,edges, 'normalization', 'probability');
h2 = histcounts(iRoc300Apcx,edges, 'normalization', 'probability');


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('inhibitory discriminability (auROC) - first 300 ms')
nanmedian(iRoc300Apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(iRoc300Apcx)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0.5:0.05:1.05;
hold on
h1 = histcounts(eRoc4Apcx,edges, 'normalization', 'probability')
h2 = histcounts(eRoc4Apcx,edges, 'normalization', 'probability')


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('excitatory discriminability (auROC) - 1 s')
nanmedian(eRoc4Apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(eRoc4Apcx)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:0.05:0.55;
hold on
h1 = histcounts(iRoc4Apcx,edges, 'normalization', 'probability')
h2 = histcounts(iRoc4Apcx,edges, 'normalization', 'probability')


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('inhibitory discriminability (auROC) - 1 s')
nanmedian(iRoc4Apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(iRoc4Apcx)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')
%%
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[497 246 1102 748]);
% 
% violin(eRoc300Apcx, 'facecolor', [34,94,168]/255,  'edgecolor', 'none', 'facealpha', 0.5);
% set(gca,'XColor','w')
% set(gca,'YColor','w')
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% 
% hold on
% violin(eRoc300Plcoa, 'facecolor', [179,0,0]/255,  'edgecolor', 'none', 'facealpha', 0.5);
% set(gca,'XColor','w')
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% hold off
% title('excitatory response discriminability (auROC) - first 300 ms')

%%
% for idxFig = 1:6
%     saveas(gcf, sprintf('Figure %d', idxFig), 'epsc')
% end

