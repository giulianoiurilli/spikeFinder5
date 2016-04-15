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