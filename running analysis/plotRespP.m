%%
I300Apcx = [];
I4Apcx = [];
excP300Apcx = [];
excP4Apcx = [];
inhP300Apcx = [];
inhP4Apcx = [];
%%
I300Plcoa = [];
I4Plcoa = [];
excP300Plcoa = [];
excP4Plcoa = [];
inhP300Plcoa = [];
inhP4Plcoa = [];

%%
I300Apcx = [I300Apcx; Icell300ms];
I4Apcx = [I4Apcx; Icell4Cycles];
excP300Apcx = [excP300Apcx; excP300ms];
excP4Apcx = [excP4Apcx; excP4Cycles];
inhP300Apcx = [inhP300Apcx; inhP300ms];
inhP4Apcx = [inhP4Apcx; inhP4Cycles];

%%
I300Plcoa = [I300Plcoa; Icell300ms];
I4Plcoa = [I4Plcoa; Icell4Cycles];
excP300Plcoa = [excP300Plcoa; excP300ms];
excP4Plcoa = [excP4Plcoa; excP4Cycles];
inhP300Plcoa = [inhP300Plcoa; inhP300ms];
inhP4Plcoa = [inhP4Plcoa; inhP4Cycles];
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

labelApcx = repmat('piriform cortex', size(I300Apcx,1), 1);
labelPlcoa = repmat('amygdalar cortex', size(I300Plcoa,1), 1);
labels = strvcat(labelApcx, labelPlcoa);
app = [I300Apcx' I300Plcoa'];
boxplot(app,labels,'notch', 'on', 'symbol', 'o', 'outliersize', 4, 'orientation', 'horizontal',  'colors', [34,94,168;179,0,0]./255) 
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
xlabel('information (bit/spike) - 300 ms')

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

labelApcx = repmat('piriform cortex', size(I4Apcx,1), 1);
labelPlcoa = repmat('amygdalar cortex', size(I4Plcoa,1), 1);
labels = strvcat(labelApcx, labelPlcoa);
app = [I4Apcx' I4Plcoa'];
boxplot(app,labels,'notch', 'on', 'symbol', 'o', 'outliersize', 4, 'orientation', 'horizontal',  'colors', [34,94,168;179,0,0]./255) 
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
xlabel('information (bit/spike) - 1 s')

%%

edges4 = -0.05:0.1:1.05;
edges300 = -0.05:0.1:1.05;


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(excP4Cycles, edges4);
% edges(end) = [];
% h1 = area(edges, N./length(excP4Cycles));
hold on
h1 = histogram(excP4Apcx,edges4, 'normalization', 'probability');
h1.FaceColor = [34,94,168]/255;
h1.EdgeColor = [34,94,168]/255;
alpha(0.5)
h2 = histogram(excP4Plcoa,edges4, 'normalization', 'probability');
h2.FaceColor = [179,0,0]/255;
h2.EdgeColor = [179,0,0]/255;
alpha(0.5)
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('excitatory probability - 1 s')


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(excP300ms, edges300);
% edges(end) = [];
% h1 = area(edges, N./length(excP300ms));
hold on
h1 = histogram(excP300Apcx,edges300, 'normalization', 'probability');
h1.FaceColor = [34,94,168]/255;
h1.EdgeColor = [34,94,168]/255;
alpha(0.5)
h2 = histogram(excP300Plcoa,edges300, 'normalization', 'probability');
h2.FaceColor = [179,0,0]/255;
h2.EdgeColor = [179,0,0]/255;
alpha(0.5)
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('excitatory probability - first 300 ms')

%%

edges4 = -0.05:0.1:1.05;
edges300 = -0.05:0.1:1.05;


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(excP4Cycles, edges4);
% edges(end) = [];
% h1 = area(edges, N./length(excP4Cycles));
hold on
h1 = histogram(inhP4Apcx,edges4, 'normalization', 'probability');
h1.FaceColor = [34,94,168]/255;
h1.EdgeColor = [34,94,168]/255;
alpha(0.5)
h2 = histogram(inhP4Plcoa,edges4, 'normalization', 'probability');
h2.FaceColor = [179,0,0]/255;
h2.EdgeColor = [179,0,0]/255;
alpha(0.5)
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('inhibitory probability - 1 s')


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(excP300ms, edges300);
% edges(end) = [];
% h1 = area(edges, N./length(excP300ms));
hold on
h1 = histogram(inhP300Apcx,edges300, 'normalization', 'probability');
h1.FaceColor = [34,94,168]/255;
h1.EdgeColor = [34,94,168]/255;
alpha(0.5)
h2 = histogram(inhP300Plcoa,edges300, 'normalization', 'probability');
h2.FaceColor = [179,0,0]/255;
h2.EdgeColor = [179,0,0]/255;
alpha(0.5)
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('inhibitory probability - first 300 ms')


%%
hfigs = get(0, 'children');                          %Get list of figures

for m = 1:length(hfigs)
    figure(hfigs(m)) 
    saveas(hfigs(m), sprintf('figure%d.eps', m), 'epsc')
end
