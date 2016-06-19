FRspCOA = [Mcoa15.rspPeakFractionExc;McoaAA.rspPeakFractionExc];
FRspPCX = [Mpcx15.rspPeakFractionExc;MpcxAA.rspPeakFractionExc];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];
%%
edges = -0.05:0.1:1.05;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[109 69 1800 988]);
subplot(2,2,1)
h = histcounts(FRspCOA(:),edges);
s1 = bar(0:0.1:1, h./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
h1 = histcounts(FRspCOAsig(:),edges);
s2 = bar(0:0.1:1, h1./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
xlabel('Number of Trials with a Significant Excitatory Peak') 
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

subplot(2,2,2)
h = histcounts(FRspPCX(:),edges);
s3 = bar(0:0.1:1, h./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s3, .5)
hold on
h1 = histcounts(FRspPCXsig(:),edges);
s4 = bar(0:0.1:1, h1./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
xlabel('Number of Trials with a Significant Excitatory Peak') 
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
FRspCOA = [Mcoa15.rspWindFractionExc;McoaAA.rspWindFractionExc];
FRspPCX = [Mpcx15.rspWindFractionExc;MpcxAA.rspWindFractionExc];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];
%%
edges = -0.05:0.1:1.05;
subplot(2,2,3)
h = histcounts(FRspCOA(:),edges);
s1 = bar(0:0.1:1, h./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
h1 = histcounts(FRspCOAsig(:),edges);
s2 = bar(0:0.1:1, h1./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
xlabel('Number of Trials with a Significant Excitatory Spike Count (1 s)') 
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

subplot(2,2,4)
h = histcounts(FRspPCX(:),edges);
s3 = bar(0:0.1:1, h./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s3, .5)
hold on
h1 = histcounts(FRspPCXsig(:),edges);
s4 = bar(0:0.1:1, h1./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
xlabel('Number of Trials with a Significant Excitatory Spike Count (1 s)') 
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
FRspCOA = [Mcoa15.rspPeakFractionInh;McoaAA.rspPeakFractionInh];
FRspPCX = [Mpcx15.rspPeakFractionInh;MpcxAA.rspPeakFractionInh];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa>-1) = [];
FRspPCXsig(logSignificantPcx>-1) = [];
%%
edges = -0.05:0.1:1.05;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[109 69 1800 988]);
subplot(2,2,1)
h = histcounts(FRspCOA(:),edges);
s1 = bar(0:0.1:1, h./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
h1 = histcounts(FRspCOAsig(:),edges);
s2 = bar(0:0.1:1, h1./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
xlabel('Number of Trials with a Significant Inhibitory Trough') 
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

subplot(2,2,2)
h = histcounts(FRspPCX(:),edges);
s3 = bar(0:0.1:1, h./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s3, .5)
hold on
h1 = histcounts(FRspPCXsig(:),edges);
s4 = bar(0:0.1:1, h1./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
xlabel('Number of Trials with a Significant Inhibitory Trough') 
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
FRspCOA = [Mcoa15.rspWindFractionInh;McoaAA.rspWindFractionInh];
FRspPCX = [Mpcx15.rspWindFractionInh;MpcxAA.rspWindFractionInh];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa>-1) = [];
FRspPCXsig(logSignificantPcx>-1) = [];
%%
edges = -0.05:0.1:1.05;
subplot(2,2,3)
h = histcounts(FRspCOA(:),edges);
s1 = bar(0:0.1:1, h./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
h1 = histcounts(FRspCOAsig(:),edges);
s2 = bar(0:0.1:1, h1./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
xlabel('Number of Trials with a Significant Inhibitory Spike Count (1 s)') 
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

subplot(2,2,4)
h = histcounts(FRspPCX(:),edges);
s3 = bar(0:0.1:1, h./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s3, .5)
hold on
h1 = histcounts(FRspPCXsig(:),edges);
s4 = bar(0:0.1:1, h1./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
xlabel('Number of Trials with a Significant Inhibitory Spike Count (1 s)') 
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

