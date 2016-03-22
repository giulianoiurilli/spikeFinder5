odors = 1:15;
[Bslcoa15, DeltaRspcoa15, ffcoa15, cvcoa15, fanoFactorcoa15, auRoccoa15, significancecoa15] = find_Baseline_DeltaRsp_FanoFactor(coa15.esp, odors);
[BslcoaAA, DeltaRspcoaAA, ffcoaAA, cvcoaAA, fanoFactorcoaAA, auRoccoaAA, significancecoaAA] = find_Baseline_DeltaRsp_FanoFactor(coaAA.esp, odors);
[Bslpcx15, DeltaRsppcx15, ffpcx15, cvpcx15, fanoFactorpcx15, auRocpcx15, significancepcx15] = find_Baseline_DeltaRsp_FanoFactor(pcx15.esp, odors);
[BslpcxAA, DeltaRsppcxAA, ffpcxAA, cvpcxAA, fanoFactorpcxAA, auRocpcxAA, significancepcxAA] = find_Baseline_DeltaRsp_FanoFactor(pcxAA.esp, odors);

%% Baseline
allBsl = [Bslcoa15 BslcoaAA Bslpcx15 BslpcxAA];
maxBsl = max(allBsl);
minBsl = min(allBsl);
edges = logspace(-2,2,30);
[N1,edges] = histcounts([Bslpcx15 BslpcxAA], edges,'normalization', 'probability');
[N2,edges] = histcounts([Bslcoa15 BslcoaAA], edges,'normalization', 'probability');


figure
set(gcf,'Position',[740 300 585 750]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
edges = log10(edges(1:end-1));
h1 = area(edges, N1);
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
alpha(h1, 0.5)
hold on; 
h2 = area(edges, N2);
h2.FaceColor = 'r';
h2.EdgeColor = 'r';
alpha(h2, 0.5)
xlabel('baseline firing (log10, Hz)')
set(gca,'YColor','w','box','off')

%% Delta response
DeltaRspCOA = [DeltaRspcoa15;DeltaRspcoaAA];
DeltaRspPCX = [DeltaRsppcx15;DeltaRsppcxAA];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [significancepcx15; significancepcxAA];
logSignificantPcx = logSignificantPcx(:);

figure
set(gca,'YColor','w','box','off')
distributionPlot(DeltaRspCOA(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(DeltaRspPCX(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
hold on
coaRsp = DeltaRspCOA;
coaRsp(logSignificantCoa == 0) = [];
pcxRsp = DeltaRspPCX;
pcxRsp(logSignificantPcx == 0) = [];
dataToPlot = {pcxRsp,coaRsp};
catIdx = [ones(length(pcxRsp),1); zeros(length(coaRsp),1)];
colori = {'r', 'k'};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
ylim([0.5 2.5]);
xlim([-5 20]);
xlabel('response (Hz)')
alpha(0.5)



%% G - Fano factor
ffCOA = [abs(ffcoa15(:)); abs(ffcoaAA(:))];
ffCOA = ffCOA(~isnan(ffCOA)); ffCOA = ffCOA(~isinf(ffCOA)); ffCOA = ffCOA(ffCOA<40);
logSignificantCoa = logSignificantCoa(~isnan(ffCOA)); logSignificantCoa = logSignificantCoa(~isinf(ffCOA)); logSignificantCoa = logSignificantCoa(ffCOA<40);
ffCoaSig = ffCOA;
ffCoaSig(logSignificantCoa == 0) = [];

ffPCX = [abs(ffpcx15(:)); abs(ffpcxAA(:))];
ffPCX = ffPCX(~isnan(ffPCX)); ffPCX = ffPCX(~isinf(ffPCX)); ffPCX = ffPCX(ffPCX<40);
logSignificantPcx = logSignificantPcx(~isnan(ffPCX)); logSignificantPcx = logSignificantPcx(~isinf(ffPCX)); logSignificantPcx = logSignificantPcx(ffPCX<40);
ffPcxSig = ffPCX;
ffPcxSig(logSignificantPcx == 0) = [];

figure
set(gca,'YColor','w','box','off')
distributionPlot(ffCOA(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(ffPCX(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
hold on
dataToPlot = {ffPcxSig,ffCoaSig};
catIdx = [ones(length(ffPcxSig),1); zeros(length(ffCoaSig),1)];
colori = {'r', 'k'};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
ylim([0.5 2.5]);
xlim([-1 30]);
xlabel('response (Hz)')
alpha(0.5)
xlabel('Fano factor')
set(gca,'YColor','w','box','off')

%% auROC
auRocCOA = [auRoccoa15;auRoccoaAA];
auRocPCX = [auRocpcx15;auRocpcxAA];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [significancepcx15; significancepcxAA];
logSignificantPcx = logSignificantPcx(:);

figure
set(gca,'YColor','w','box','off')
distributionPlot(auRocCOA(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(auRocPCX(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
hold on
coaRsp = auRocCOA;
coaRsp(logSignificantCoa == 0) = [];
pcxRsp = auRocPCX;
pcxRsp(logSignificantPcx == 0) = [];
dataToPlot = {pcxRsp,coaRsp};
catIdx = [ones(length(pcxRsp),1); zeros(length(coaRsp),1)];
colori = {'r', 'k'};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
ylim([0.5 2.5]);
xlim([-0.01 1.01]);
xlabel('auROC')
alpha(0.5)

%%