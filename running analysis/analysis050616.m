FRspCOA = [rspFractioncoa15;rspFractioncoaAA];
FRspPCX = [rspFractionpcx15;rspFractionpcxAA];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [significancepcx15; significancepcxAA];
logSignificantPcx = logSignificantPcx(:);
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];


%%
distributionPlot(FRspCOA(:),'histOpt', 0,'histOri','right','color',coaC,'widthDiv',[2 2],'showMM',0, 'globalNorm', 2, 'xyOri', 'flipped')
distributionPlot(FRspPCX(:),'histOpt', 0,'histOri','left','color',pcxC,'widthDiv',[2 1],'showMM',0, 'globalNorm', 2, 'xyOri', 'flipped')
hold on
dataToPlot = {FRspPCXsig,FRspCOAsig};
catIdx = [ones(length(FRspPCXsig),1); zeros(length(FRspCOAsig),1)];
colori = {coaC, pcxC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
alpha(0.5)
%%
a = 2;
figure
distributionPlot(ffCoaSig(:), 'histOpt', 0, 'histOri','right','color',coaC,'widthDiv',[2 2],'showMM',0, 'globalNorm', a, 'xyOri', 'flipped')
distributionPlot(ffPcxSig(:),'histOpt', 0, 'histOri','left','color',pcxC,'widthDiv',[2 1],'showMM',0, 'globalNorm', a, 'xyOri', 'flipped')
hold on
distributionPlot(ffCOA(:), 'histOpt', 0, 'histOri','right','color',coaC,'widthDiv',[2 2],'showMM',0, 'globalNorm', a, 'xyOri', 'flipped')
distributionPlot(ffPCX(:),'histOpt', 0, 'histOri','left','color',pcxC,'widthDiv',[2 1],'showMM',0, 'globalNorm', a, 'xyOri', 'flipped')
%%
edges = -0.05:0.1:1.05;
figure
h = histcounts(FRspCOA(:),edges);
s1 = bar(0:0.1:1, h./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
h1 = histcounts(FRspCOAsig(:),edges);
s2 = bar(0:0.1:1, h1./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);


figure
h = histcounts(FRspPCX(:),edges);
s3 = bar(0:0.1:1, h./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s3, .5)
hold on
h1 = histcounts(FRspPCXsig(:),edges);
s4 = bar(0:0.1:1, h1./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);


%%
figure
bar(0:0.1:1, [(h./size(ffCOA(:),1))', (h1./size(ffCOA(:),1))'])