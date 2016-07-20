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

appCoa1 = appCoa(abs(aurocBetweenValenceSigCoa)==1);
appPcx1 = appPcx(abs(aurocBetweenValenceSigPcx)==1);
dataToPlot = {appCoa1,appPcx1};
catIdx = [ones(length(appCoa1),1); zeros(length(appPcx1),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
set(gca, 'YColor', 'w', 'box', 'off')
xlim([0 1])
set(gca, 'TickDir', 'out')

%%
x = numel(appCoa1)
X = numel(appCoa);
x/X
y = numel(appPcx1);
Y = numel(appPcx);
y/Y

[p, t, po] = propTest2(x,y,X,Y)

%%
p = ranksum(appCoa, appPcx)
p1 = ranksum(appCoa1, appPcx1)