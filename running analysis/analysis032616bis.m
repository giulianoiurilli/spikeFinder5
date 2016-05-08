[aurocBetweenMixCoa, aurocBetweenMixCoaSig, auRocMixCoa, respMixCoa, cellLogMixCoa] = mixAnalysis(coaAA.esp);
[aurocBetweenMixPcx, aurocBetweenMixPcxSig, auRocMixPcx, respMixPcx, cellLogMixPcx] = mixAnalysis(pcxAA.esp);

%%
appCoa = aurocBetweenMixCoa;
appPcx = aurocBetweenMixPcx;
appCoa = abs(appCoa - 0.5) * 2;
appPcx = abs(appPcx - 0.5) * 2;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
dataToPlot = {appCoa,appPcx};
catIdx = [ones(length(appCoa),1); zeros(length(appPcx),1)];
colori = {[189,189,189]./255,[252,141,89]./255};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
set(gca, 'YColor', 'w', 'box', 'off')
xlim([0 1])
xlabel('Mix includes odor X vs odor Y  -  |auROC - 0.5| x 2')
set(gca, 'TickDir', 'out')

hold on

appCoa = appCoa(abs(aurocBetweenMixCoaSig)==1);
appPcx = appPcx(abs(aurocBetweenMixPcxSig)==1);
dataToPlot = {appCoa,appPcx};
catIdx = [ones(length(appCoa),1); zeros(length(appPcx),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
set(gca, 'YColor', 'w', 'box', 'off')
xlim([0 1])
xlabel('Mix includes odor X vs odor Y  -  |auROC - 0.5| x 2')
set(gca, 'TickDir', 'out')

%%
x = numel(appCoa);
X = numel(aurocBetweenMixCoa);
y = numel(appPcx);
Y = numel(aurocBetweenMixPcx);
x/X
y/Y

[p, t, po] = propTest2(x,y,X,Y)
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
p = panel();
p.pack('h', {1/2 1/2});

app1 = sum(auRocMixCoa(:,1:3),2);
app2 = sum(auRocMixCoa(:,4:6),2);
app3 = app2 - app1;
app4 = [auRocMixCoa app3];
app4 = sortrows(app4, size(app4,2));
app4(:,size(app4,2)) = [];
clims = [0 1];
p(1).select()
imagesc(app4, clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
ylabel('Neuron ID')
title('Postero-Lateral Cortical Amygdala')

app1 = sum(auRocMixPcx(:,1:3),2);
app2 = sum(auRocMixPcx(:,4:6),2);
app3 = app2 - app1;
app4 = [auRocMixPcx app3];
app4 = sortrows(app4, size(app4,2));
app4(:,size(app4,2)) = [];
clims = [0 1];
p(2).select()
imagesc(app4, clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
ylabel('Neuron ID')
title('Anterior Piriform Cortex')

p.select('all');
p.de.margin = 2;
p(1).marginright = 30;

p.margin = [20 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';

%%
appCoa1 =  respMixCoa(:,11) ./ (respMixCoa(:,1) + respMixCoa(:,2)) ;
appCoa2 =  respMixCoa(:,12) ./ (respMixCoa(:,1) + respMixCoa(:,3));
appCoa3 =  respMixCoa(:,13) ./ (respMixCoa(:,6) + respMixCoa(:,7));
appCoa4 =  respMixCoa(:,14) ./ (respMixCoa(:,6) + respMixCoa(:,8));

appPcx1 =  respMixPcx(:,11) ./ (respMixPcx(:,1) + respMixPcx(:,2));
appPcx2 =  respMixPcx(:,12) ./ (respMixPcx(:,1) + respMixPcx(:,3));
appPcx3 =  respMixPcx(:,13) ./(respMixPcx(:,6) + respMixPcx(:,7));
appPcx4 =  respMixPcx(:,14) ./ (respMixPcx(:,6) + respMixPcx(:,8));

appCoa11 = respMixCoa(:,11) ./ max([respMixCoa(:,1) respMixCoa(:,2)], [], 2); %./ (respMixCoa(:,11) + max([respMixCoa(:,1); respMixCoa(:,2)]));
appCoa21 = respMixCoa(:,12) ./ max([respMixCoa(:,1) respMixCoa(:,3)], [], 2); %./ (respMixCoa(:,12) + max([respMixCoa(:,1); respMixCoa(:,3)]));
appCoa31 = respMixCoa(:,13) ./ max([respMixCoa(:,6) respMixCoa(:,7)], [], 2); %./ (respMixCoa(:,13) + max([respMixCoa(:,6); respMixCoa(:,7)]));
appCoa41 = respMixCoa(:,14) ./ max([respMixCoa(:,6) respMixCoa(:,8)], [], 2); %./ (respMixCoa(:,14) + max([respMixCoa(:,6); respMixCoa(:,8)]));

appPcx11 = respMixPcx(:,11) ./ max([respMixPcx(:,1) respMixPcx(:,2)], [], 2); %./ (respMixPcx(:,11) + max([respMixPcx(:,1); respMixPcx(:,2)]));
appPcx21 = respMixPcx(:,12) ./ max([respMixPcx(:,1) respMixPcx(:,3)], [], 2); %./ (respMixPcx(:,12) + max([respMixPcx(:,1); respMixPcx(:,3)]));
appPcx31 = respMixPcx(:,13) ./ max([respMixPcx(:,6) respMixPcx(:,7)], [], 2); %./ (respMixPcx(:,13) + max([respMixPcx(:,6); respMixPcx(:,7)]));
appPcx41 = respMixPcx(:,14) ./ max([respMixPcx(:,6) respMixPcx(:,8)], [], 2); %./ (respMixPcx(:,14) + max([respMixPcx(:,6); respMixPcx(:,8)]));




figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[-1607 407 1241 651]);
p = panel();
p.pack('v', {1/2 1/2});
p(1).pack('h', {1/4 1/4 1/4 1/4});
p(2).pack('h', {1/4 1/4 1/4 1/4});


p(1,1).select()
dataToPlot = {appCoa1,appPcx1};
catIdx = [ones(length(appCoa1),1); zeros(length(appPcx1),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
set(gca, 'XColor', 'w', 'box', 'off', 'TickDir', 'out')
title('butanedione & geraniol')
ylabel({'response(X+Y)'; '/'; '[response(X) + response(Y)]'})
ylim([0 6]);
p(2,1).select()
dataToPlot = {appCoa11,appPcx11};
catIdx = [ones(length(appCoa11),1); zeros(length(appPcx11),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
ylim([0 7]);
set(gca, 'XColor', 'w', 'box', 'off', 'TickDir', 'out')
ylabel({'response(X+Y)'; '/'; 'max(response(X), response(Y))'});


p(1,2).select()
dataToPlot = {appCoa2,appPcx2};
catIdx = [ones(length(appCoa2),1); zeros(length(appPcx2),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
set(gca, 'XColor', 'w', 'box', 'off', 'TickDir', 'out')
title('butanedione & phenylethanol')
ylim([0 6]);
p(2,2).select()
dataToPlot = {appCoa21,appPcx21};
catIdx = [ones(length(appCoa21),1); zeros(length(appPcx21),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
ylim([0 7]);
set(gca, 'XColor', 'w', 'box', 'off', 'TickDir', 'out')



p(1,3).select()
dataToPlot = {appCoa3,appPcx3};
catIdx = [ones(length(appCoa3),1); zeros(length(appPcx3),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
set(gca, 'XColor', 'w', 'box', 'off', 'TickDir', 'out')
title('TMT & 2-MB')
ylim([0 6]);
p(2,3).select()
dataToPlot = {appCoa31,appPcx31};
catIdx = [ones(length(appCoa31),1); zeros(length(appPcx31),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
ylim([0 7]);
set(gca, 'XColor', 'w', 'box', 'off', 'TickDir', 'out')


p(1,4).select()
dataToPlot = {appCoa4,appPcx4};
catIdx = [ones(length(appCoa4),1); zeros(length(appPcx4),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
set(gca, 'XColor', 'w', 'box', 'off', 'TickDir', 'out')
title('TMT & 2-PT')
ylim([0 6]);
p(2,4).select()
dataToPlot = {appCoa41,appPcx41};
catIdx = [ones(length(appCoa41),1); zeros(length(appPcx41),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
ylim([0 7]);
set(gca, 'XColor', 'w', 'box', 'off', 'TickDir', 'out')


p.select('all');
p.de.margin = 2;
p(1).marginbottom = 30;
p(1,1).marginright = 10;
p(1,2).marginright = 10;
p(1,3).marginright = 10;
p(2,1).marginright = 10;
p(2,2).marginright = 10;
p(2,3).marginright = 10;

p.margin = [30 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';


%%
[aurocBetweenValenceCoa, aurocBetweenValenceSigCoa, auRocValenceCoa, cellLogValenceCoa] = valenceAnalysis(coaAA.esp);
[aurocBetweenValencePcx, aurocBetweenValenceSigPcx, auRocValencePcx, cellLogValencePcx] = valenceAnalysis(pcxAA.esp);

%%
appCoa = aurocBetweenValenceCoa;
appPcx = aurocBetweenValencePcx;
appCoa = abs(appCoa - 0.5) * 2;
appPcx = abs(appPcx - 0.5) * 2;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
dataToPlot = {appCoa,appPcx};
catIdx = [ones(length(appCoa),1); zeros(length(appPcx),1)];
colori = {[189,189,189]./255,[252,141,89]./255};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
set(gca, 'YColor', 'w', 'box', 'off')
xlim([0 1])
set(gca, 'TickDir', 'out')


hold on

appCoa = appCoa(abs(aurocBetweenValenceSigCoa)==1);
appPcx = appPcx(abs(aurocBetweenValenceSigPcx)==1);
dataToPlot = {appCoa,appPcx};
catIdx = [ones(length(appCoa),1); zeros(length(appPcx),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
set(gca, 'YColor', 'w', 'box', 'off')
xlim([0 1])
set(gca, 'TickDir', 'out')

%%
x = numel(appCoa)
X = numel(aurocBetweenValenceCoa);
x/X
y = numel(appPcx);
Y = numel(aurocBetweenValencePcx);
y/Y

[p, t, po] = propTest2(x,y,X,Y)


