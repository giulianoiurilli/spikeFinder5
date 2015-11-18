%% plot baseline
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

edges = logspace(-2,2,30);% log10([0.001:0.5:40]);
bslApcx(bslApcx<0.01) = [];
hold on
h1 = histcounts(bslApcx,edges, 'normalization', 'probability')
h2 = histcounts(bslPlcoa,edges, 'normalization', 'probability')


edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('log10(firing rate), Hz')
nanmedian(bslApcx)



area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmedian(bslPlcoa)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')


%%
