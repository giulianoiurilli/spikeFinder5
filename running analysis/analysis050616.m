FRspCOA = [rspFractioncoa15Exc;rspFractioncoaAAExc];
FRspPCX = [rspFractionpcx15Exc;rspFractionpcxAAExc];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [significancepcx15; significancepcxAA];
logSignificantPcx = logSignificantPcx(:);
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];
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
FRspCOA = [rspFractioncoa15Inh;rspFractioncoaAAInh];
FRspPCX = [rspFractionpcx15Inh;rspFractionpcxAAInh];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [significancepcx15; significancepcxAA];
logSignificantPcx = logSignificantPcx(:);
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa>-1) = [];
FRspPCXsig(logSignificantPcx>-1) = [];
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

