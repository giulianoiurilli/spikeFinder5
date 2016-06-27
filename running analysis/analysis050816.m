%% fraction excitatory peak trials
FRspCOA = [Mcoa15.rspPeakFractionExc;McoaAA.rspPeakFractionExc];
FRspPCX = [Mpcx15.rspPeakFractionExc;MpcxAA.rspPeakFractionExc];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);
fractionExcitatoryPeakTrialsCOA = sum(FRspCOA(:) .* 10)./(10*(length(FRspCOA(:))));
fractionExcitatoryPeakTrialsPCX = sum(FRspPCX(:) .* 10)./(10*(length(FRspPCX(:))));
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];
fractionExcitatoryPeakTrialsCOAsig = sum(FRspCOAsig(:) .* 10)./(10*(length(FRspCOA(:))));
fractionExcitatoryPeakTrialsPCXsig = sum(FRspPCXsig(:) .* 10)./(10*(length(FRspPCX(:))));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[109 69 1800 988]);
subplot(2,2,1)
s1 = bar(0:3, [0 fractionExcitatoryPeakTrialsCOA*100 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
s2 = bar(0:3, [0 0 fractionExcitatoryPeakTrialsPCX*100 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s2, .5)
hold on
bar(0:3, [0 fractionExcitatoryPeakTrialsCOAsig*100 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
hold on
bar(0:3, [0 0 fractionExcitatoryPeakTrialsPCXsig*100 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
title('Fraction of Trials with a Significant Excitatory Peak (and auROC significance)') 
ylabel('%')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
set(gca,'XColor','w')
%% fraction excitatory window trials
FRspCOA = [Mcoa15.rspWindFractionExc;McoaAA.rspWindFractionExc];
FRspPCX = [Mpcx15.rspWindFractionExc;MpcxAA.rspWindFractionExc];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);
fractionExcitatoryWindTrialsCOA = sum(FRspCOA(:) .* 10)./(10*(length(FRspCOA(:))));
fractionExcitatoryWindTrialsPCX = sum(FRspPCX(:) .* 10)./(10*(length(FRspPCX(:))));
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];
fractionExcitatoryWindTrialsCOAsig = sum(FRspCOAsig(:) .* 10)./(10*(length(FRspCOA(:))));
fractionExcitatoryWindTrialsPCXsig = sum(FRspPCXsig(:) .* 10)./(10*(length(FRspPCX(:))));

% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[533 392 904 608]);
subplot(2,2,2)
s1 = bar(0:3, [0 fractionExcitatoryWindTrialsCOA*100 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
s2 = bar(0:3, [0 0 fractionExcitatoryWindTrialsPCX*100 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s2, .5)
hold on
bar(0:3, [0 fractionExcitatoryWindTrialsCOAsig*100 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
hold on
bar(0:3, [0 0 fractionExcitatoryWindTrialsPCXsig*100 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
title('Fraction of Trials with a Significant Excitatory Spike Count (and auROC significance)') 
ylabel('%')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
set(gca,'XColor','w')
%% fraction inhibitory peak trials
FRspCOA = [Mcoa15.rspPeakFractionInh;McoaAA.rspPeakFractionInh];
FRspPCX = [Mpcx15.rspPeakFractionInh;MpcxAA.rspPeakFractionInh];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);
fractionInhibitoryPeakTrialsCOA = sum(FRspCOA(:) .* 10)./(10*(length(FRspCOA(:))));
fractionInhibitoryPeakTrialsPCX = sum(FRspPCX(:) .* 10)./(10*(length(FRspPCX(:))));
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa>-1) = [];
FRspPCXsig(logSignificantPcx>-1) = [];
fractionInhibitoryPeakTrialsCOAsig = sum(FRspCOAsig(:) .* 10)./(10*(length(FRspCOA(:))));
fractionInhibitoryPeakTrialsPCXsig = sum(FRspPCXsig(:) .* 10)./(10*(length(FRspPCX(:))));

% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[533 392 904 608]);
subplot(2,2,3)
s1 = bar(0:3, [0 fractionInhibitoryPeakTrialsCOA*100 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
s2 = bar(0:3, [0 0 fractionInhibitoryPeakTrialsPCX*100 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s2, .5)
hold on
bar(0:3, [0 fractionInhibitoryPeakTrialsCOAsig*100 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
hold on
bar(0:3, [0 0 fractionInhibitoryPeakTrialsPCXsig*100 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
title('Fraction of Trials with a Significant Inhibitory Trough (and auROC significance)') 
ylabel('%')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
set(gca,'XColor','w')
%% fraction inhibitory window trials
FRspCOA = [Mcoa15.rspWindFractionInh;McoaAA.rspWindFractionInh];
FRspPCX = [Mpcx15.rspWindFractionInh;MpcxAA.rspWindFractionInh];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);
fractionInhibitoryWindTrialsCOA = sum(FRspCOA(:) .* 10)./(10*(length(FRspCOA(:))));
fractionInhibitoryWindTrialsPCX = sum(FRspPCX(:) .* 10)./(10*(length(FRspPCX(:))));
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa>-1) = [];
FRspPCXsig(logSignificantPcx>-1) = [];
fractionInhibitoryWindTrialsCOAsig = sum(FRspCOAsig(:) .* 10)./(10*(length(FRspCOA(:))));
fractionInhibitoryWindTrialsPCXsig = sum(FRspPCXsig(:) .* 10)./(10*(length(FRspPCX(:))));

% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[533 392 904 608]);
subplot(2,2,4)
s1 = bar(0:3, [0 fractionInhibitoryWindTrialsCOA*100 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
s2 = bar(0:3, [0 0 fractionInhibitoryWindTrialsPCX*100 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s2, .5)
hold on
bar(0:3, [0 fractionInhibitoryWindTrialsCOAsig*100 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
hold on
bar(0:3, [0 0 fractionInhibitoryWindTrialsPCXsig*100 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
title('Fraction of Trials with a Significant Inhibitory Spike Count (and auROC significance)') 
ylabel('%')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
set(gca,'XColor','w')    
%%
bslCOA = [Mcoa15.Bsl';McoaAA.Bsl'];
bslPCX = [Mpcx15.Bsl';MpcxAA.Bsl'];
bslCOAAll = [Mcoa15.BslAll';McoaAA.BslAll'];
bslPCXAll = [Mpcx15.BslAll';MpcxAA.BslAll'];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];

bslCOAsigE = [];
bslCOAsigI = [];
for cCoa = 1:size(logSignificantCoa,1)
    appE = find(logSignificantCoa(cCoa,:)>0);
    appI = find(logSignificantCoa(cCoa,:)<0);
    if numel(appE) > 0
        bslCOAsigE = [bslCOAsigE, bslCOA(cCoa)];
    end
    if numel(appI) > 0
        bslCOAsigI = [bslCOAsigI, bslCOA(cCoa)];
    end
end

bslPCXsigE = [];
bslPCXsigI = [];
for cPcx = 1:size(logSignificantPcx,1)
    appE = find(logSignificantPcx(cPcx,:)>0);
    appI = find(logSignificantPcx(cPcx,:)<0);
    if numel(appE) > 0
        bslPCXsigE = [bslPCXsigE, bslPCX(cPcx)];
    end
    if numel(appI) > 0
        bslPCXsigI = [bslPCXsigI, bslPCX(cPcx)];
    end
end

allBsl = [Mcoa15.BslAll McoaAA.BslAll Mpcx15.BslAll MpcxAA.BslAll];
maxBsl = max(allBsl);
minBsl = min(allBsl);
edges = logspace(-2,2,30);
[N1,edges] = histcounts(bslPCXAll, edges);
[N2,edges] = histcounts(bslCOAAll, edges);
[N3,edges] = histcounts(bslPCXsigE, edges);
[N4,edges] = histcounts(bslCOAsigE, edges);
[N5,edges] = histcounts(bslPCXsigI, edges);
[N6,edges] = histcounts(bslCOAsigI, edges);
N1 = N1 ./ numel(bslPCXAll);
N2 = N2 ./ numel(bslCOAAll);
N3 = N3 ./ numel(bslPCXAll);
N4 = N4 ./ numel(bslCOAAll);
N5 = N5 ./ numel(bslPCXAll);
N6 = N6 ./ numel(bslCOAAll);
edges = log10(edges(1:end-1));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[109 69 1800 988]);
subplot(2,2,1)
h1 = area(edges, N1*100);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, N3*100);
h2.FaceColor = pcxC;
h2.EdgeColor = pcxC;
ylabel('%')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

subplot(2,2,2)
h1 = area(edges, N1*100);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, N5*100);
h2.FaceColor = pcxC;
h2.EdgeColor = pcxC;
ylabel('%')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

subplot(2,2,3)
h3 = area(edges, N2*100);
h3.FaceColor = coaC;
h3.EdgeColor = coaC;
alpha(h3, 0.5)
hold on; 
h4 = area(edges, N4*100);
h4.FaceColor = coaC;
h4.EdgeColor = coaC;
ylabel('%')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

subplot(2,2,4)
h3 = area(edges, N2*100);
h3.FaceColor = coaC;
h3.EdgeColor = coaC;
alpha(h3, 0.5)
hold on; 
h4 = area(edges, N6*100);
h4.FaceColor = coaC;
h4.EdgeColor = coaC;
ylabel('%')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
meanBslEICoa = [mean(bslCOAsigE) mean(bslCOAsigI)];
meanBslEIPcx = [mean(bslPCXsigE) mean(bslPCXsigI)];

figure
bar([0 meanBslEICoa 0], 'FaceColor', coaC, 'EdgeColor', coaC)
figure
bar([0 meanBslEIPcx 0], 'FaceColor', pcxC, 'EdgeColor', pcxC)

x = [bslCOAsigE bslCOAsigI];
gX = zeros(1,size(x,2));
gX(1:size(bslCOAsigE,2)) = 1;
y = [bslPCXsigE bslPCXsigI];
gY = zeros(1,size(y,2));
gY(1:size(bslPCXsigE,2)) = 1;
figure
boxplot(x, gX)
figure
boxplot(y, gY)


semBslEICoa = [std(bslCOAsigE)/sqrt(numel(bslCOAsigE)-1) std(bslCOAsigI)/sqrt(numel(bslCOAsigI)-1)]
semBslEIPcx = [std(bslPCXsigE)/sqrt(numel(bslPCXsigE)-1) std(bslPCXsigI)/sqrt(numel(bslPCXsigI)-1)]













