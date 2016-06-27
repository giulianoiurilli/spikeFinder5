%%
% Wind - auROC
appExcCoa = [];
appExcPcx = [];
appInhCoa = [];
appInhPcx = [];
DeltaRspCOATrials = [Mcoa15.DeltaRspTrialWind;McoaAA.DeltaRspTrialWind];
DeltaRspPCXTrials = [Mpcx15.DeltaRspTrialWind;MpcxAA.DeltaRspTrialWind];
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
for cCoa = 1:size(DeltaRspCOATrials,1)
    for oCoa = 1:15
        if logSignificantCoa(cCoa,oCoa) > 0
            appExcCoa = [appExcCoa squeeze(DeltaRspCOATrials(cCoa,:,oCoa))];
        end
    end
end
for cPcx = 1:size(DeltaRspPCXTrials,1)
    for oPcx = 1:15
        if logSignificantPcx(cPcx,oPcx) > 0
            appExcPcx= [appExcPcx squeeze(DeltaRspPCXTrials(cPcx,:,oPcx))];
        end
    end
end
for cCoa = 1:size(DeltaRspCOATrials,1)
    for oCoa = 1:15
        if logSignificantCoa(cCoa,oCoa) < 0
            appInhCoa = [appInhCoa squeeze(DeltaRspCOATrials(cCoa,:,oCoa))];
        end
    end
end
for cPcx = 1:size(DeltaRspPCXTrials,1)
    for oPcx = 1:15
        if logSignificantPcx(cPcx,oPcx) < 0
            appInhPcx= [appInhPcx squeeze(DeltaRspPCXTrials(cPcx,:,oPcx))];
        end
    end
end

minAx = min([DeltaRspCOATrials(:); DeltaRspPCXTrials(:)]);
maxAx = max([DeltaRspCOATrials(:); DeltaRspPCXTrials(:)]);
edges = minAx - 1:1: maxAx + 1;

h1 = histcounts(DeltaRspCOATrials(:), edges) ./ numel(DeltaRspCOATrials(:));
h2 = histcounts(DeltaRspPCXTrials(:), edges) ./ numel(DeltaRspPCXTrials(:));
h3 = histcounts(appExcCoa(:), edges) ./ numel(DeltaRspCOATrials(:));
h4 = histcounts(appExcPcx(:), edges) ./ numel(DeltaRspPCXTrials(:));
h5 = histcounts(appInhCoa(:), edges) ./ numel(DeltaRspCOATrials(:));
h6 = histcounts(appInhPcx(:), edges) ./ numel(DeltaRspPCXTrials(:));
edges(end) = [];

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[109 69 1800 988]);
subplot(2,3,1)
p1 = area(edges, h1*100);
p1.FaceColor = coaC;
p1.EdgeColor = coaC;
alpha(p1, 0.5)
hold on; 
p2 = area(edges, h2*100);
p2.FaceColor = pcxC;
p2.EdgeColor = pcxC;
alpha(p2, 0.5)
ylabel('%')
xlabel('Spike Count')
xlim([-40 40]);
title({'Distribution of Single Trial Spike Count Changes', 'for ALL Cell-Odor Pairs'})
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[533 392 904 608]);
subplot(2,3,2)
p3 = area(edges,h3*100);
p3.FaceColor = coaC;
p3.EdgeColor = coaC;
alpha(p3, 0.5)
hold on
p4 = area(edges,h4*100);
p4.FaceColor = pcxC;
p4.EdgeColor = pcxC;
alpha(p4, 0.5)
ylabel('%')
xlabel('Spike Count')
xlim([-40 40]);
title({'Distribution of Single Trial Spike Count Changes', 'for EXC auROC-significant Cell-Odor Pairs'})
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[533 392 904 608]);
subplot(2,3,3)
p5 = area(edges,h5*100);
p5.FaceColor = coaC;
p5.EdgeColor = coaC;
alpha(p5, 0.5)
hold on
p6 = area(edges,h6*100);
p6.FaceColor = pcxC;
p6.EdgeColor = pcxC;
alpha(p6, 0.5)
ylabel('%')
xlabel('Spike Count')
xlim([-40 40]);
title({'Distribution of Single Trial Spike Count Changes', 'for INH auROC-significant Cell-Odor Pairs'})
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%% % Wind - SD
appExcCoa = [];
appExcPcx = [];
appInhCoa = [];
appInhPcx = [];
logSignificantTrialExcCoa = [Mcoa15.DeltaRspExcWindSig; McoaAA.DeltaRspExcWindSig];
logSignificantTrialExcPcx = [Mpcx15.DeltaRspExcWindSig; MpcxAA.DeltaRspExcWindSig];
logSignificantTrialInhCoa = [Mcoa15.DeltaRspInhWindSig; McoaAA.DeltaRspInhWindSig];
logSignificantTrialInhPcx = [Mpcx15.DeltaRspInhWindSig; MpcxAA.DeltaRspInhWindSig];
for cCoa = 1:size(DeltaRspCOATrials,1)
    for oCoa = 1:15
        for tCoa = 1:10
            if logSignificantTrialExcCoa(cCoa, tCoa, oCoa) > 0
                appExcCoa = [appExcCoa; squeeze(DeltaRspCOATrials(cCoa,tCoa,oCoa))];
            end
        end
    end
end
appExcCoa(appExcCoa==0) = [];
for cPcx = 1:size(DeltaRspPCXTrials,1)
    for oPcx = 1:15
        for tPcx = 1:10
            if logSignificantTrialExcPcx(cPcx, tPcx, oPcx) > 0
                appExcPcx = [appExcPcx; squeeze(DeltaRspPCXTrials(cPcx,tPcx,oPcx))];
            end
        end
    end
end
appExcPcx(appExcPcx==0) = [];
for cCoa = 1:size(DeltaRspCOATrials,1)
    for oCoa = 1:15
        for tCoa = 1:10
            if logSignificantTrialInhCoa(cCoa, tCoa, oCoa) ~= 0
                appInhCoa = [appInhCoa; squeeze(DeltaRspCOATrials(cCoa,tCoa,oCoa))];
            end
        end
    end
end
for cPcx = 1:size(DeltaRspPCXTrials,1)
    for oPcx = 1:15
        for tPcx = 1:10
            if logSignificantTrialInhPcx(cPcx, tPcx, oPcx) ~= 0
                appInhPcx = [appInhPcx; squeeze(DeltaRspPCXTrials(cPcx,tPcx,oPcx))];
            end
        end
    end
end


minAx = min([DeltaRspCOATrials(:); DeltaRspPCXTrials(:)]);
maxAx = max([DeltaRspCOATrials(:); DeltaRspPCXTrials(:)]);
edges = minAx - 1:1: maxAx + 1;

h1 = histcounts(DeltaRspCOATrials(:), edges) ./ numel(DeltaRspCOATrials(:));
h2 = histcounts(DeltaRspPCXTrials(:), edges) ./ numel(DeltaRspPCXTrials(:));
h3 = histcounts(appExcCoa(:), edges) ./ numel(DeltaRspCOATrials(:));
h4 = histcounts(appExcPcx(:), edges) ./ numel(DeltaRspPCXTrials(:));
h5 = histcounts(appInhCoa(:), edges) ./ numel(DeltaRspCOATrials(:));
h6 = histcounts(appInhPcx(:), edges) ./ numel(DeltaRspPCXTrials(:));
edges(end) = [];

subplot(2,3,4)
p4 = area(edges, h1*100);
p4.FaceColor = coaC;
p4.EdgeColor = coaC;
alpha(p4, 0.5)
hold on; 
p5 = area(edges, h2*100);
p5.FaceColor = pcxC;
p5.EdgeColor = pcxC;
alpha(p5, 0.5)
ylabel('%')
xlabel('Spike Count')
xlim([-40 40]);
title({'Distribution of All Single Trial Spike Count Changes'})
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[533 392 904 608]);
subplot(2,3,5)
p6 = area(edges,h3*100);
p6.FaceColor = coaC;
p6.EdgeColor = coaC;
alpha(p6, 0.5)
hold on
p7 = area(edges,h4*100);
p7.FaceColor = pcxC;
p7.EdgeColor = pcxC;
alpha(p7, 0.5)
ylabel('%')
xlabel('Spike Count')
xlim([-40 40]);
title({'Distribution of Single Trial Spike Count Changes', 'that are Significantly Excitatory (>3 std)'})
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

% figure;
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[533 392 904 608]);
subplot(2,3,6)
p8 = area(edges,h5*100);
p8.FaceColor = coaC;
p8.EdgeColor = coaC;
alpha(p8, 0.5)
hold on
p9 = area(edges,h6*100);
p9.FaceColor = pcxC;
p9.EdgeColor = pcxC;
alpha(p9, 0.5)
ylabel('%')
xlabel('Spike Count')
xlim([-40 40]);
title({'Distribution of Single Trial Spike Count Changes', 'that are Significantly Inhibitory (<1 std)'})
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

