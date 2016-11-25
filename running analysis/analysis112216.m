%%
Mcoa15 = find_Baseline_DeltaRsp_FanoFactor(coaCS.esp, 1:15, 1000);
Mpcx15 = find_Baseline_DeltaRsp_FanoFactor(pcxCS.esp, 1:15, 1000);




%%
DeltaRspCOA15 = Mcoa15.DeltaRspMean;
DeltaRspPCX15 = Mpcx15.DeltaRspMean;
sigCOA15 = Mcoa15.significance;
sigPCX15 = Mpcx15.significance;

DeltaRspCOA15 = DeltaRspCOA15(:);
DeltaRspPCX15 = DeltaRspPCX15(:);
sigCOA15 = logical(sigCOA15(:));
sigPCX15 = logical(sigPCX15(:));






allDeltaRspCoa = [DeltaRspCOA15];
allDeltaRspPcx = [DeltaRspPCX15];
allSigCoa = [sigCOA15];
allSigPcx = [sigPCX15];

%%

edges = min([allDeltaRspCoa; allDeltaRspPcx]): 0.5 : max([allDeltaRspCoa; allDeltaRspPcx]);
[Ncoa,edges1] = histcounts(allDeltaRspCoa,edges);

[Npcx,edges2] = histcounts(allDeltaRspPcx,edges);
edges(end) = [];
Ncoa = Ncoa./numel(allDeltaRspCoa);
Npcx = Npcx./numel(allDeltaRspPcx);


%%

edges = min([allDeltaRspCoa(allSigCoa); allDeltaRspPcx(allSigPcx)]): 0.5 : max([allDeltaRspCoa(allSigCoa); allDeltaRspPcx(allSigPcx)]);
[NcoaS,edges1] = histcounts(allDeltaRspCoa(allSigCoa),edges);

[NpcxS,edges2] = histcounts(allDeltaRspPcx(allSigPcx),edges);
edges(end) = [];
NcoaS = NcoaS./numel(allDeltaRspCoa(allSigCoa));
NpcxS = NpcxS./numel(allDeltaRspPcx(allSigPcx));
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[306 344 825 461]);
h1 = area(edges, NpcxS);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, NcoaS);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
alpha(h2, 0.5)
ylabel('Fraction of Responses')
xlabel('Spikes/Second')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges, Ncoa, 'color', coaC, 'linewidth', 1) 
hold on
plot(edges, Npcx, 'color', pcxC, 'linewidth', 1) 
ylabel('Fraction of Responses')
xlabel('Spikes/Second')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
bslCOA = [Mcoa15.Bsl'];
bslPCX = [Mpcx15.Bsl'];
% logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
% logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
% 
% bslCOAsigE = [];
% bslCOAsigI = [];
% for cCoa = 1:size(logSignificantCoa,1)
%     appE = find(logSignificantCoa(cCoa,:)>0);
%     appI = find(logSignificantCoa(cCoa,:)<0);
%     if numel(appE) > 0
%         bslCOAsigE = [bslCOAsigE, bslCOA(cCoa)];
%     end
%     if numel(appI) > 0
%         bslCOAsigI = [bslCOAsigI, bslCOA(cCoa)];
%     end
% end
% 
% bslPCXsigE = [];
% bslPCXsigI = [];
% for cPcx = 1:size(logSignificantPcx,1)
%     appE = find(logSignificantPcx(cPcx,:)>0);
%     appI = find(logSignificantPcx(cPcx,:)<0);
%     if numel(appE) > 0
%         bslPCXsigE = [bslPCXsigE, bslPCX(cPcx)];
%     end
%     if numel(appI) > 0
%         bslPCXsigI = [bslPCXsigI, bslPCX(cPcx)];
%     end
% end

maxBsl = max(bslCOA);
minBsl = min(bslPCX);
edges = logspace(-2,2,30);
[N1,edges] = histcounts(bslCOA, edges);
[N2,edges] = histcounts(bslPCX, edges);
N1 = N1 ./ numel(bslCOA);
N2 = N2 ./ numel(bslPCX);

edges = log10(edges(1:end-1));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[109 69 1800 988]);
h1 = area(edges, N2);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, N1);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
alpha(h2, 0.5)
ylabel('fraction of neurons')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
McoaNM = find_Baseline_DeltaRsp_FanoFactor_new(coaCS.esp, 1:15, 1000, 0);
MpcxNM = find_Baseline_DeltaRsp_FanoFactor_new(pcxCS.esp, 1:15, 1000, 0);




%%
DeltaRspCOANM = McoaNM.DeltaRspMean;
DeltaRspPCXNM = MpcxNM.DeltaRspMean;
sigCOANM = McoaNM.significance;
sigPCXNM = MpcxNM.significance;

DeltaRspCOANM = DeltaRspCOANM(:);
DeltaRspPCXNM = DeltaRspPCXNM(:);
sigCOANM = logical(sigCOANM(:));
sigPCXNM = logical(sigPCXNM(:));

allDeltaRspCoa = [DeltaRspCOANM];
allDeltaRspPcx = [DeltaRspPCXNM];
allSigCoa = [sigCOANM];
allSigPcx = [sigPCXNM];

%%

edges = min([allDeltaRspCoa; allDeltaRspPcx]): 0.5 : max([allDeltaRspCoa; allDeltaRspPcx]);
[Ncoa,edges1] = histcounts(allDeltaRspCoa,edges);

[Npcx,edges2] = histcounts(allDeltaRspPcx,edges);
edges(end) = [];
Ncoa = Ncoa./numel(allDeltaRspCoa);
Npcx = Npcx./numel(allDeltaRspPcx);


%%

edges = min([allDeltaRspCoa(allSigCoa); allDeltaRspPcx(allSigPcx)]): 0.5 : max([allDeltaRspCoa(allSigCoa); allDeltaRspPcx(allSigPcx)]);
[NcoaS,edges1] = histcounts(allDeltaRspCoa(allSigCoa),edges);

[NpcxS,edges2] = histcounts(allDeltaRspPcx(allSigPcx),edges);
edges(end) = [];
NcoaS = NcoaS./numel(allDeltaRspCoa(allSigCoa));
NpcxS = NpcxS./numel(allDeltaRspPcx(allSigPcx));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[306 344 825 461]);
h1 = area(edges, NpcxS);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, NcoaS);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
alpha(h2, 0.5)
ylabel('Fraction of Responses')
xlabel('Spikes/Second')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges, Ncoa, 'color', coaC, 'linewidth', 1) 
hold on
plot(edges, Npcx, 'color', pcxC, 'linewidth', 1) 
ylabel('Fraction of Responses')
xlabel('Spikes/Second')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
bslCOA = [McoaNM.Bsl'];
bslPCX = [MpcxNM.Bsl'];
% logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
% logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
% 
% bslCOAsigE = [];
% bslCOAsigI = [];
% for cCoa = 1:size(logSignificantCoa,1)
%     appE = find(logSignificantCoa(cCoa,:)>0);
%     appI = find(logSignificantCoa(cCoa,:)<0);
%     if numel(appE) > 0
%         bslCOAsigE = [bslCOAsigE, bslCOA(cCoa)];
%     end
%     if numel(appI) > 0
%         bslCOAsigI = [bslCOAsigI, bslCOA(cCoa)];
%     end
% end
% 
% bslPCXsigE = [];
% bslPCXsigI = [];
% for cPcx = 1:size(logSignificantPcx,1)
%     appE = find(logSignificantPcx(cPcx,:)>0);
%     appI = find(logSignificantPcx(cPcx,:)<0);
%     if numel(appE) > 0
%         bslPCXsigE = [bslPCXsigE, bslPCX(cPcx)];
%     end
%     if numel(appI) > 0
%         bslPCXsigI = [bslPCXsigI, bslPCX(cPcx)];
%     end
% end

maxBsl = max(bslCOA);
minBsl = min(bslPCX);
edges = logspace(-2,2,30);
[N1,edges] = histcounts(bslCOA, edges);
[N2,edges] = histcounts(bslPCX, edges);
N1 = N1 ./ numel(bslCOA);
N2 = N2 ./ numel(bslPCX);

edges = log10(edges(1:end-1));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[109 69 1800 988]);
h1 = area(edges, N2);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, N1);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
alpha(h2, 0.5)
ylabel('fraction of neurons')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%% auROC old
%%
auRocCOA15 = Mcoa15.auRoc;
auRocPCX15 = Mpcx15.auRoc;
sigCOA15 = Mcoa15.significance;
sigPCX15 = Mpcx15.significance;

auRocCOA15 = auRocCOA15(:);
auRocPCX15 = auRocPCX15(:);
sigCOA15 = logical(sigCOA15(:));
sigPCX15 = logical(sigPCX15(:));






allauRocCoa = [auRocCOA15];
allauRocPcx = [auRocPCX15];
allSigCoa = [sigCOA15];
allSigPcx = [sigPCX15];

%%
edges = 0 : 0.05 : 1.05;
[Ncoa,edges1] = histcounts(allauRocCoa,edges);

[Npcx,edges2] = histcounts(allauRocPcx,edges);
edges(end) = [];
Ncoa = Ncoa./numel(allauRocCoa);
Npcx = Npcx./numel(allauRocPcx);


%%
edges = 0 : 0.05 : 1.05;
[NcoaS,edges1] = histcounts(allauRocCoa(allSigCoa),edges);

[NpcxS,edges2] = histcounts(allauRocPcx(allSigPcx),edges);
edges(end) = [];
NcoaS = NcoaS./numel(allauRocCoa(allSigCoa));
NpcxS = NpcxS./numel(allauRocPcx(allSigPcx));
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[306 344 825 461]);
h1 = area(edges, NpcxS);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, NcoaS);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
alpha(h2, 0.5)
ylabel('Fraction of Responses')
xlabel('auROC')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges, Ncoa, 'color', coaC, 'linewidth', 1) 
hold on
plot(edges, Npcx, 'color', pcxC, 'linewidth', 1) 
ylabel('Fraction of Responses')
xlabel('auROC')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
%% auROC new
%%
auRocCOANM = McoaNM.auRoc;
auRocPCXNM = MpcxNM.auRoc;
sigCOANM = McoaNM.significance;
sigPCXNM = MpcxNM.significance;

auRocCOANM = auRocCOANM(:);
auRocPCXNM = auRocPCXNM(:);
sigCOANM = logical(sigCOANM(:));
sigPCXNM = logical(sigPCXNM(:));


allauRocCoa = [auRocCOANM];
allauRocPcx = [auRocPCXNM];
allSigCoa = [sigCOANM];
allSigPcx = [sigPCXNM];

%%
edges = 0 : 0.05 : 1.05;
[Ncoa,edges1] = histcounts(allauRocCoa,edges);

[Npcx,edges2] = histcounts(allauRocPcx,edges);
edges(end) = [];
Ncoa = Ncoa./numel(allauRocCoa);
Npcx = Npcx./numel(allauRocPcx);


%%
edges = 0 : 0.05 : 1.05;
[NcoaS,edges1] = histcounts(allauRocCoa(allSigCoa),edges);

[NpcxS,edges2] = histcounts(allauRocPcx(allSigPcx),edges);
edges(end) = [];
NcoaS = NcoaS./numel(allauRocCoa(allSigCoa));
NpcxS = NpcxS./numel(allauRocPcx(allSigPcx));
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gcf,'Position',[306 344 825 461]);
h1 = area(edges, NpcxS);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, NcoaS);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
alpha(h2, 0.5)
ylabel('Fraction of Responses')
xlabel('auROC')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges, Ncoa, 'color', coaC, 'linewidth', 1) 
hold on
plot(edges, Npcx, 'color', pcxC, 'linewidth', 1) 
ylabel('Fraction of Responses')
xlabel('auROC')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)