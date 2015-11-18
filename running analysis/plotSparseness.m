ls3apcx = [];
ls4apcx = [];

ls3plcoa = [];
ls4plcoa = [];

ps3apcx = [];
ps4apcx = [];

ps3plcoa = [];
ps4plcoa = [];


%%
ls3apcx = [ls3apcx ls300ms];
ls4apcx = [ls4apcx ls4Cycles];
ps3apcx = [ps3apcx ps300ms];
ps4apcx = [ps4apcx ps4Cycles];


%%
ls3plcoa = [ls3plcoa ls300ms];
ls4plcoa = [ls4plcoa ls4Cycles];
ps3plcoa = [ps3plcoa ps300ms];
ps4plcoa = [ps4plcoa ps4Cycles];

%%
ls3apcxL = ls3apcx;
ls4apcxL = ls4apcx;
ls3plcoaL = ls3plcoa;
ls4plcoaL = ls4plcoa;
%%
ls3apcxH = ls3apcx;
ls4apcxH = ls4apcx;
ls3plcoaH = ls3plcoa;
ls4plcoaH = ls4plcoa;

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
%edges = logspace(0,3,30);
edges = 0:0.05:1;
hold on
h1 = histcounts(ls3apcx,edges, 'normalization', 'probability')
h2 = histcounts(ls3plcoa,edges, 'normalization', 'probability')


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('lifetime sparseness Low - 300 ms')
nanmean(ls3apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmean(ls3plcoa)
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
edges = 0:0.05:1;
hold on
h1 = histcounts(ls4apcx,edges, 'normalization', 'probability');
h2 = histcounts(ls4plcoa,edges, 'normalization', 'probability');


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('lifetime sparseness Low - 1 s')
nanmean(ls4apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmean(ls4plcoa)
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
edges = 0.5:0.01:1;
hold on
h1 = histcounts(ps3apcx,edges, 'normalization', 'probability');
h2 = histcounts(ps3plcoa,edges, 'normalization', 'probability');


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('population sparseness - 300 ms')
nanmean(ps3apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmean(ps3plcoa)
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
edges = 0.5:0.01:1;
hold on
h1 = histcounts(ls4apcx,edges, 'normalization', 'probability');
h2 = histcounts(ls4plcoa,edges, 'normalization', 'probability');


edges(end) = [];
%edges = log10(edges(1:end-1));
area(edges,h1, 'FaceColor', [34,94,168]/255, 'EdgeColor', [34,94,168]/255)
alpha(0.5)
% h1(1).FaceColor = [229,245,249]/255;
% h1(2).Color = [0,109,44]/255;
xlabel('population sparseness - 1 s')
nanmean(ps4apcx)

area(edges,h2, 'FaceColor', [179,0,0]/255, 'EdgeColor', [179,0,0]/255)
alpha(0.5)
nanmean(ps4plcoa)
% h2(1).FaceColor = [254,232,200]/255;
% h2(2).Color = [179,0,0]/255;
hold off
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');

legend('piriform cortex', 'amygdalar cortex')
%%
ls3apcxL = ls3apcx;
ls4apcxL = ls4apcx;
ls3plcoaL = ls3plcoa;
ls4plcoaL = ls4plcoa;
%%
ls3apcxH = ls3apcx;
ls4apcxH = ls4apcx;
ls3plcoaH = ls3plcoa;
ls4plcoaH = ls4plcoa;
%%
ls3meanapcx = [nanmean(ls3apcxL) nanmean(ls3apcxH)];
ls3stdapcx = [nanstd(ls3apcxL)./sqrt(length(ls3apcxL)) nanstd(ls3apcxH)./sqrt(length(ls3apcxH))];

ls3meanplcoa = [nanmean(ls3plcoaL) nanmean(ls3plcoaH)];
ls3stdplcoa= [nanstd(ls3plcoaL)./sqrt(length(ls3plcoaL)) nanstd(ls3plcoaH)./sqrt(length(ls3plcoaH))];

ls4meanapcx = [nanmean(ls4apcxL) nanmean(ls4apcxH)];
ls4stdapcx = [nanstd(ls4apcxL)./sqrt(length(ls4apcxL)) nanstd(ls4apcxH)./sqrt(length(ls4apcxH))];

ls4meanplcoa= [nanmean(ls4plcoaL) nanmean(ls4plcoaH)];
ls4stdplcoa = [nanstd(ls4plcoaL)./sqrt(length(ls4plcoaL)) nanstd(ls4plcoaH)./sqrt(length(ls4plcoaH))];
%%


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
p = panel();
p.pack('h',{50 50});

xAxi = 1:2;
p(1).select();
hold on
errorbar(xAxi, ls3meanapcx , ls3stdapcx, 'o-')
errorbar(xAxi, ls3meanplcoa , ls3stdplcoa, 'o-')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p(1).title('lifetime sparseness  - first 300 ms');

p(2).select();
hold on
errorbar(xAxi, ls4meanapcx , ls4stdapcx, 'o-')
errorbar(xAxi, ls4meanplcoa , ls4stdplcoa, 'o-')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p(2).title('lifetime sparseness  - 1 s');

%p.de.margin = 1;
p.margin = [20 10 10 10];
p(1).marginleft= 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');
