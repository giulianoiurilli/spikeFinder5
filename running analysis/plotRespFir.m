%%
latPlcoa = [];
widPlcoa = [];
eFano300Plcoa = [];
eFano4Plcoa = [];
eRsp300Plcoa = [];
eVar300Plcoa = [];
eVar4Plcoa = [];
eRsp4Plcoa = [];
eRoc300Plcoa = [];
iRoc300Plcoa = [];
eRoc4Plcoa = [];
iRoc4Plcoa = [];
%%
latPlcoa = [latPlcoa; peakLat];
widPlcoa = [widPlcoa; hWidth];
eFano300Plcoa = [eFano300Plcoa; excFanoRsp300ms];
eFano4Plcoa = [eFano4Plcoa; excFanoRsp4cycles];
eRsp300Plcoa = [eRsp300Plcoa; excMeanRsp300ms];
eVar300Plcoa = [eVar300Plcoa; excVarRsp300ms];
eVar4Plcoa = [eVar4Plcoa; excVarRsp4cycles];
eRsp4Plcoa = [eRsp4Plcoa; excMeanRsp4cycles];
eRoc300Plcoa = [eRoc300Plcoa; excAuRoc300ms];
iRoc300Plcoa = [iRoc300Plcoa; inhAuRoc300ms];
eRoc4Plcoa = [eRoc4Plcoa; excAuRoc4cycles];
iRoc4Plcoa = [iRoc4Plcoa; inhAuRoc4cycles];
%%

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:10:1000;
hold on
h1 = histcounts(widApcx,edges, 'normalization', 'probability')
h2 = histcounts(widPlcoa,edges, 'normalization', 'probability')

edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('half-peak width, ms')
nanmedian(widApcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(widPlcoa)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')

%%
latApcx(latApcx<30) = [];
latPlcoa(latPlcoa<30) = [];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:50:1000;
hold on
h1 = histcounts(latApcx,edges, 'normalization', 'probability')
h2 = histcounts(latPlcoa,edges, 'normalization', 'probability')

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
nanmedian(latPlcoa)
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
h2 = histcounts(eFano300Plcoa,edges, 'normalization', 'probability')

edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('Fano factor (ms) , first 300 ms')
nanmedian(eFano300Apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(eFano300Plcoa)
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
h2 = histcounts(eFano4Plcoa,edges, 'normalization', 'probability')


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('Fano factor (ms), 1 s')
nanmedian(eFano4Apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(eFano4Plcoa)
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
h2 = histcounts(eRoc300Plcoa,edges, 'normalization', 'probability')


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
nanmedian(eRoc300Plcoa)
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
h2 = histcounts(iRoc300Plcoa,edges, 'normalization', 'probability');


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
nanmedian(iRoc300Plcoa)
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
h2 = histcounts(eRoc4Plcoa,edges, 'normalization', 'probability')


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
nanmedian(eRoc4Plcoa)
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
h2 = histcounts(iRoc4Plcoa,edges, 'normalization', 'probability')


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
nanmedian(iRoc4Plcoa)
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
hfigs = get(0, 'children');                          %Get list of figures

for m = 1:length(hfigs)
    figure(hfigs(m)) 
    saveas(hfigs(m), sprintf('figure%d.eps', m), 'epsc')
end

