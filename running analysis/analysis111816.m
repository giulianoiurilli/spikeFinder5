%load
pcxNM = load('aPCx_natMix_2.mat');
coaNM = load('plCoA_natMix_2.mat');
pcxCS2 = load('aPCx_CS2_2.mat');
coaCS2 = load('plCoA_CS2_2.mat');
coa15 = load('plCoA_15_2.mat');
coaAA = load('plCoA_AAmix_2.mat');
coaCS = load('coa_CS_2_2.mat');
pcx15 = load('aPCx_15_2.mat');
pcxAA = load('aPCx_AAmix_2.mat');
pcxCS = load('pcx_CS_2_2.mat');
%%
% Number of odors
odors = 1:15; 
% Colors
coaC = [227,26,28] ./ 255;
pcxC = [82,82,82]./255;

%%
Mcoa15 = find_Baseline_DeltaRsp_FanoFactor_new(coa15.esp, 1:15, 1000, 0);
McoaAA = find_Baseline_DeltaRsp_FanoFactor_new(coaAA.esp, 1:10, 1000, 0);
Mpcx15 = find_Baseline_DeltaRsp_FanoFactor_new(pcx15.esp, 1:15, 1000, 0);
MpcxAA = find_Baseline_DeltaRsp_FanoFactor_new(pcxAA.esp, 1:10, 1000, 0);
% McoaCS = find_Baseline_DeltaRsp_FanoFactor_new(coaCS.esp, 1:15, 1000);
% MpcxCS = find_Baseline_DeltaRsp_FanoFactor_new(pcxCS.esp, 1:15, 1000);



%%
DeltaRspCOA15 = Mcoa15.DeltaRspMean;
DeltaRspPCX15 = Mpcx15.DeltaRspMean;
sigCOA15 = Mcoa15.significance;
sigPCX15 = Mpcx15.significance;

DeltaRspCOA15 = DeltaRspCOA15(:);
DeltaRspPCX15 = DeltaRspPCX15(:);
sigCOA15 = logical(sigCOA15(:));
sigPCX15 = logical(sigPCX15(:));

DeltaRspCOAAA = McoaAA.DeltaRspMean;
DeltaRspPCXAA = MpcxAA.DeltaRspMean;
sigCOAAA = McoaAA.significance;
sigPCXAA = MpcxAA.significance;

DeltaRspCOAAA = DeltaRspCOAAA(:);
DeltaRspPCXAA = DeltaRspPCXAA(:);
sigCOAAA = logical(sigCOAAA(:));
sigPCXAA = logical(sigPCXAA(:));




allDeltaRspCoa = [DeltaRspCOA15; DeltaRspCOAAA];
allDeltaRspPcx = [DeltaRspPCX15; DeltaRspPCXAA];
allSigCoa = [sigCOA15; sigCOAAA];
allSigPcx = [sigPCX15; sigPCXAA];

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
bslCOA = [Mcoa15.Bsl';McoaAA.Bsl'];
bslPCX = [Mpcx15.Bsl';MpcxAA.Bsl'];
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
McoaNM = find_Baseline_DeltaRsp_FanoFactor_new(coaNM.esp, 1:13, 1000, 0);
MpcxNM = find_Baseline_DeltaRsp_FanoFactor_new(pcxNM.esp, 1:13, 1000, 0);




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

%% nat mix
%%
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaNM.esp, 1:15, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxNM.esp, 1:15, 0);

fractionExcitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxExc.idxO1,2));
fractionExcitedNeuronsMeanCoa = nanmean(fractionExcitedNeuronsCoa);
fractionExcitedNeuronsSemCoa = nanstd(fractionExcitedNeuronsCoa)./sqrt(size(fractionExcitedNeuronsCoa,1)-1);

fractionInhibitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanCoa = nanmean(fractionInhibitedNeuronsCoa);
fractionInhibitedNeuronsSemCoa = nanstd(fractionInhibitedNeuronsCoa)./sqrt(size(fractionInhibitedNeuronsCoa,1)-1);

fractionExcitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxExc.idxO1,2));
fractionExcitedNeuronsMeanPcx = nanmean(fractionExcitedNeuronsPcx);
fractionExcitedNeuronsSemPcx = nanstd(fractionExcitedNeuronsPcx)./sqrt(size(fractionExcitedNeuronsPcx,1)-1);

fractionInhibitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanPcx = nanmean(fractionInhibitedNeuronsPcx);
fractionInhibitedNeuronsSemPcx = nanstd(fractionInhibitedNeuronsPcx)./sqrt(size(fractionInhibitedNeuronsPcx,1)-1);


%%
figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr([fractionExcitedNeuronsSemCoa' fractionExcitedNeuronsSemPcx'], [fractionExcitedNeuronsMeanCoa' fractionExcitedNeuronsMeanPcx']);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fraction Excited Neuron')
xlabel('odor I.D.')
ylim([0 0.35])

figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr([fractionInhibitedNeuronsSemCoa' fractionInhibitedNeuronsSemPcx'], [fractionInhibitedNeuronsMeanCoa' fractionInhibitedNeuronsMeanPcx']);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fraction Inhibited Neuron')
xlabel('odor I.D.')
ylim([0 0.35])
%% 15 odors
%%
odorsRearranged = 1:15;

[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua_old(coaCS.esp, odorsRearranged);

odorsRearranged = 1:15;
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua_old(pcxCS.esp, odorsRearranged);
%%
fractionExcitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxExc.idxO1,2));
fractionExcitedNeuronsMeanCoa = nanmean(fractionExcitedNeuronsCoa);
fractionExcitedNeuronsSemCoa = nanstd(fractionExcitedNeuronsCoa)./sqrt(size(fractionExcitedNeuronsCoa,1)-1);

fractionInhibitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanCoa = nanmean(fractionInhibitedNeuronsCoa);
fractionInhibitedNeuronsSemCoa = nanstd(fractionInhibitedNeuronsCoa)./sqrt(size(fractionInhibitedNeuronsCoa,1)-1);

fractionExcitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxExc.idxO1,2));
fractionExcitedNeuronsMeanPcx = nanmean(fractionExcitedNeuronsPcx);
fractionExcitedNeuronsSemPcx = nanstd(fractionExcitedNeuronsPcx)./sqrt(size(fractionExcitedNeuronsPcx,1)-1);

fractionInhibitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanPcx = nanmean(fractionInhibitedNeuronsPcx);
fractionInhibitedNeuronsSemPcx = nanstd(fractionInhibitedNeuronsPcx)./sqrt(size(fractionInhibitedNeuronsPcx,1)-1);


%%
figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(fractionExcitedNeuronsSemCoa, fractionExcitedNeuronsMeanCoa);
b.EdgeColor = coaC;
b.FaceColor = coaC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fraction Excited Neuron - Coa15')
xlabel('odor I.D.')
ylim([0 0.35])

figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(fractionInhibitedNeuronsSemCoa, fractionInhibitedNeuronsMeanCoa);
b.EdgeColor = coaC;
b.FaceColor = coaC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fraction Inhibited Neuron - Coa15')
xlabel('odor I.D.')
ylim([0 0.35])

figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(fractionExcitedNeuronsSemPcx, fractionExcitedNeuronsMeanPcx);
b.EdgeColor = pcxC;
b.FaceColor = pcxC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fraction Excited Neuron - Pcx15')
xlabel('odor I.D.')
ylim([0 0.35])

figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(fractionInhibitedNeuronsSemPcx, fractionInhibitedNeuronsMeanPcx);
b.EdgeColor = pcxC;
b.FaceColor = pcxC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fraction Inhibited Neuron - Pcx15')
xlabel('odor I.D.')
ylim([0 0.35])

%% AA
%%
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua_old(coaAA.esp, 1:10);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua_old(pcxAA.esp, 1:10);

fractionExcitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxExc.idxO1,2));
fractionExcitedNeuronsMeanCoa = nanmean(fractionExcitedNeuronsCoa);
fractionExcitedNeuronsSemCoa = nanstd(fractionExcitedNeuronsCoa)./sqrt(size(fractionExcitedNeuronsCoa,1)-1);

fractionInhibitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanCoa = nanmean(fractionInhibitedNeuronsCoa);
fractionInhibitedNeuronsSemCoa = nanstd(fractionInhibitedNeuronsCoa)./sqrt(size(fractionInhibitedNeuronsCoa,1)-1);

fractionExcitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxExc.idxO1,2));
fractionExcitedNeuronsMeanPcx = nanmean(fractionExcitedNeuronsPcx);
fractionExcitedNeuronsSemPcx = nanstd(fractionExcitedNeuronsPcx)./sqrt(size(fractionExcitedNeuronsPcx,1)-1);

fractionInhibitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanPcx = nanmean(fractionInhibitedNeuronsPcx);
fractionInhibitedNeuronsSemPcx = nanstd(fractionInhibitedNeuronsPcx)./sqrt(size(fractionInhibitedNeuronsPcx,1)-1);


%%
figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr([fractionExcitedNeuronsSemCoa' fractionExcitedNeuronsSemPcx'], [fractionExcitedNeuronsMeanCoa' fractionExcitedNeuronsMeanPcx']);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fraction Excited Neuron')
xlabel('odor I.D.')
ylim([0 0.35])

figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr([fractionInhibitedNeuronsSemCoa' fractionInhibitedNeuronsSemPcx'], [fractionInhibitedNeuronsMeanCoa' fractionInhibitedNeuronsMeanPcx']);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fraction Inhibited Neuron')
xlabel('odor I.D.')
ylim([0 0.35])

% figure
% set(gcf,'Position',[207 388 722 344]);
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% b = barwitherr(fractionExcitedNeuronsSemPcx, fractionExcitedNeuronsMeanPcx);
% b.EdgeColor = pcxC;
% b.FaceColor = pcxC;
% set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
% ylabel('Fraction Excited Neuron - PcxAA')
% xlabel('odor I.D.')
% ylim([0 0.35])
% 
% figure
% set(gcf,'Position',[207 388 722 344]);
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% b = barwitherr(fractionInhibitedNeuronsSemPcx, fractionInhibitedNeuronsMeanPcx);
% b.EdgeColor = pcxC;
% b.FaceColor = pcxC;
% set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
% ylabel('Fraction Inhibited Neuron - PcxAA')
% xlabel('odor I.D.')
% ylim([0 0.35])

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

auRocCOAAA = McoaAA.auRoc;
auRocPCXAA = MpcxAA.auRoc;
sigCOAAA = McoaAA.significance;
sigPCXAA = MpcxAA.significance;

auRocCOAAA = auRocCOAAA(:);
auRocPCXAA = auRocPCXAA(:);
sigCOAAA = logical(sigCOAAA(:));
sigPCXAA = logical(sigPCXAA(:));


allauRocCoa = [auRocCOA15; auRocCOAAA];
allauRocPcx = [auRocPCX15; auRocPCXAA];
allSigCoa = [sigCOA15; sigCOAAA];
allSigPcx = [sigPCX15; sigPCXAA];

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

%%
longList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'};
shortList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13'};
longTicks = 0.15:15.15;
shortTicks = 0.15:13.15;
[actOdorPcx, supOdorPcx] = proportionActivatingOdors(pcx15.esp, 1:15);
[actOdorCoa, supOdorCoa] = proportionActivatingOdors(coa15.esp, 1:15);

N = histcounts(actOdorPcx,0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(actOdorCoa,0:16); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:15, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-1 16.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , longTicks);
set(gca, 'XTickLabel', longList);
xlabel({'Excitatory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)


N = histcounts(supOdorPcx,0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(supOdorCoa,0:16); 
PCoa = N./ sum(N);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:15, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-1 16.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , longTicks);
set(gca, 'XTickLabel', longList);
xlabel({'Inhibitory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
longList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'};
shortList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13'};
longTicks = 0.15:15.15;
shortTicks = 0.15:13.15;
[actOdorPcx, supOdorPcx] = proportionActivatingOdors_new(pcxNM.esp, 1:13, 0);
[actOdorCoa, supOdorCoa] = proportionActivatingOdors_new(coaNM.esp, 1:13, 0);

N = histcounts(actOdorPcx,0:14); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(actOdorCoa,0:14); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:13, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:13.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-1 14.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , shortTicks);
set(gca, 'XTickLabel', shortList);
xlabel({'Excitatory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)


N = histcounts(supOdorPcx,0:14); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(supOdorCoa,0:14); 
PCoa = N./ sum(N);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(0:13, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:13.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-1 14.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , shortTicks);
set(gca, 'XTickLabel', shortList);
xlabel({'Inhibitory Odors'});
ylabel({'Proportion of Neurons'});
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%% Distribution of lifetime sparseness
%% 
[lsCoa, cellLogCoa, lsSigCoa, cellLogSigCoa] = findLifetimeSparseness(coaNM.esp, 1:13);
[lsPcx, cellLogPcx, lsSigPcx, cellLogSigPcx] = findLifetimeSparseness(pcxNM.esp, 1:13);
edges = 0:0.05:1.05;
[Ncoa,edges1] = histcounts(lsCoa(~isnan(lsCoa)),edges);
[Npcx,edges2] = histcounts(lsPcx(~isnan(lsPcx)),edges);
edges(end) = [];
Ncoa = Ncoa./numel(lsCoa(~isnan(lsCoa)));
Npcx = Npcx./numel(lsPcx(~isnan(lsPcx)));
figure
h1 = area(edges, Npcx);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, Ncoa);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
alpha(h2, 0.5)
ylabel('Fraction of Neurons')
xlabel('Lifetime Sparseness')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%% 
[lsCoa, cellLogCoa] = findLifetimeSparseness2(coa15.esp, 1:15);
[lsPcx, cellLogPcx] = findLifetimeSparseness2(pcx15.esp, 1:15);
edges = 0:0.05:1.05;
[Ncoa,edges1] = histcounts(lsCoa(~isnan(lsCoa)),edges);
[Npcx,edges2] = histcounts(lsPcx(~isnan(lsPcx)),edges);
edges(end) = [];
Ncoa = Ncoa./numel(lsCoa(~isnan(lsCoa)));
Npcx = Npcx./numel(lsPcx(~isnan(lsPcx)));
figure
h1 = area(edges, Npcx);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, Ncoa);
h2.FaceColor = coaC;
h2.EdgeColor = coaC;
alpha(h2, 0.5)
ylabel('Fraction of Neurons')
xlabel('Lifetime Sparseness')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%% Distribution Tuning Correlations
%% 

[tuningCurvesCoa, tuningCurvesSigCoa, tuningCurvesCoaAuRoc, tuningCurvesCoaAuRocSig] = findTuningCurves(coaNM.esp, 1:6, 0);

tuningCurvesSigNormCoa = zscore(tuningCurvesSigCoa');
tuningCurvesSigNormCoa = tuningCurvesSigNormCoa';

tuningCurvesNormCoa = zscore(tuningCurvesCoa');
tuningCurvesNormCoa = tuningCurvesNormCoa';


[tuningCurvesPcx, tuningCurvesSigPcx, tuningCurvesPcxAuRocSig] = findTuningCurves(pcxNM.esp, 1:6, 0);

tuningCurvesSigNormPcx = zscore(tuningCurvesSigPcx');
tuningCurvesSigNormPcx = tuningCurvesSigNormPcx';

tuningCurvesNormPcx = zscore(tuningCurvesPcx');
tuningCurvesNormPcx = tuningCurvesNormPcx';



%%
Y = [];
Z = [];
Y = pdist(tuningCurvesSigNormCoa);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesSigNormCoa,1));
app = [];
app = [tuningCurvesCoaAuRocSig outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesSig = app;

clims = [0 1];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(tuningCurvesSig,clims);
colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])


clims = [-1 1];
Ccoa = corr(tuningCurvesSigNormCoa');
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(Ccoa,clims);
colormap(brewermap([],'*PuBuGn')); axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

Y = [];
Z = [];
Y = pdist(tuningCurvesNormCoa);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesNormCoa,1));


clims = [-1 1];
Ccoa = corr(tuningCurvesNormCoa');
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(Ccoa,clims);
colormap(brewermap([],'*PuBuGn')); axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])


%%
Y = [];
Z = [];
Y = pdist(tuningCurvesSigNormPcx);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesSigNormPcx,1));
app = [];
app = [tuningCurvesPcxAuRocSig outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesSig = app;

clims = [0 1];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(tuningCurvesSig,clims);
colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])


clims = [-1 1];
Cpcx = corr(tuningCurvesSigNormPcx');
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(Cpcx,clims);
colormap(brewermap([],'*PuBuGn')); axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

Y = [];
Z = [];
Y = pdist(tuningCurvesNormPcx);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesNormPcx,1));


clims = [-1 1];
Cpcx = corr(tuningCurvesNormPcx');
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(Cpcx,clims);
colormap(brewermap([],'*PuBuGn')); axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

%%
%%
odorsRearranged = 1:13;
[noiseCorrW1000msCoaNM, noiseCorrB1000msCoaNM, noiseCorrW1000msCoaNMSig, noiseCorrB1000msCoaNMSig] = findNoiseCorrelation_new(coaNM.esp, odorsRearranged);
[noiseCorrW1000msPcxNM, noiseCorrB1000msPcxNM, noiseCorrW1000msPcxNMSig, noiseCorrB1000msPcxNMSig] = findNoiseCorrelation_new(pcxNM.esp, odorsRearranged);


B = [noiseCorrW1000msCoaNM, noiseCorrB1000msCoaNM]; 
A = [noiseCorrW1000msPcxNM, noiseCorrB1000msPcxNM];
BSig = [noiseCorrW1000msCoaNMSig, noiseCorrB1000msCoaNMSig]; 
ASig = [noiseCorrW1000msPcxNMSig, noiseCorrB1000msPcxNMSig];



%%
clims = [-1 1];
odorsRearranged = 1:6;
[sigCorrCoaNM, corrMatCoaNM, sigCorrCoaNMSig, corrMatCoaNMSig] = findSignalCorrelation_new(coaNM.esp, odorsRearranged);
[sigCorrPcxNM, corrMatPcxNM, sigCorrPcxNMSig, corrMatPcxNMSig] = findSignalCorrelation_new(pcxNM.esp, odorsRearranged);
figure
imagesc(corrMatCoaNM, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
figure
imagesc(corrMatPcxNM, clims)
axis square
colormap(brewermap([],'*PuBuGn'))


%%
figure;
plot([2 8], [nanmean(sigCorrCoaNM(:)) nanmean(B(:))], 's', 'markersize', 10, 'markeredgecolor', coaC)
hold on
plot([4 10], [nanmean(sigCorrPcxNM(:)) nanmean(A(:))], 's', 'markersize', 10, 'markeredgecolor', pcxC)
hold on
errbar([2 8], [nanmean(sigCorrCoaNM(:)) nanmean(B(:))], [nanstd(sigCorrCoaNM(:))./sqrt(length(sigCorrCoaNM(:))) nanstd(B(:))./sqrt(length(B(:)))], 'color', coaC, 'linewidth', 1); %
hold on
errbar([4 10], [nanmean(sigCorrPcxNM(:)) nanmean(A(:))], [nanstd(sigCorrPcxNM)./sqrt(length(sigCorrPcxNM)) nanstd(A(:))./sqrt(length(A(:)))], 'color', pcxC, 'linewidth', 1); %./sqrt(length(accuracyResponsesPcxAA(:)))


hold on;
plot([2.5 8.5], [nanmean(sigCorrCoaNMSig(:)) nanmean(BSig(:))], 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([4.5 10.5], [nanmean(sigCorrPcxNMSig(:)) nanmean(ASig(:))], 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2.5 8.5], [nanmean(sigCorrCoaNMSig(:)) nanmean(BSig(:))], [nanstd(sigCorrCoaNMSig(:))./sqrt(length(sigCorrCoaNMSig(:))) nanstd(BSig(:))./sqrt(length(BSig(:)))], 'color', coaC, 'linewidth', 1); %
hold on
errbar([4.5 10.5], [nanmean(sigCorrPcxNMSig(:)) nanmean(ASig(:))], [nanstd(sigCorrPcxNMSig)./sqrt(length(sigCorrPcxNMSig)) nanstd(ASig(:))./sqrt(length(ASig(:)))], 'color', pcxC, 'linewidth', 1);
ylim([-1 1])
xlim([0 13])
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
sigCorrCoaNM = sigCorrCoaNM(:);
sigCorrPcxNM = sigCorrPcxNM(:);
sigCorrCoaNMSig = sigCorrCoaNMSig(:);
sigCorrPcxNMSig = sigCorrPcxNMSig(:);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(sigCorrCoaNM(~isnan(sigCorrCoaNM)));
plot(xiCoa,fCoa,':', 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(sigCorrPcxNM(~isnan(sigCorrPcxNM)));
plot(xiPcx,fPcx, ':','linewidth', 1,'color', pcxC)
hold on
[fCoa,xiCoa] = ksdensity(sigCorrCoaNMSig(~isnan(sigCorrCoaNMSig)));
plot(xiCoa,fCoa,  'linewidth', 1,'color', coaC)
hold on
line([mean(sigCorrCoaNMSig(~isnan(sigCorrCoaNMSig))) mean(sigCorrCoaNMSig(~isnan(sigCorrCoaNMSig)))], [0 max(fCoa)], 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(sigCorrPcxNMSig(~isnan(sigCorrPcxNMSig)));
hold on
line([mean(sigCorrPcxNMSig(~isnan(sigCorrPcxNMSig))) mean(sigCorrPcxNMSig(~isnan(sigCorrPcxNMSig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)

plot(xiPcx,fPcx, 'linewidth', 1,'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylabel('p.d.f.')
xlabel('Signal Correlation')
%%
B = B(:);
A = A(:);
BSig = BSig(:);
ASig = ASig(:);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(B(~isnan(B)));
plot(xiCoa,fCoa,':', 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(A(~isnan(A)));
plot(xiPcx,fPcx, ':','linewidth', 1,'color', pcxC)
hold on
[fCoa,xiCoa] = ksdensity(BSig(~isnan(BSig)));
plot(xiCoa,fCoa,  'linewidth', 1,'color', coaC)
hold on
line([mean(BSig(~isnan(BSig))) mean(BSig(~isnan(BSig)))], [0 max(fCoa)], 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(ASig(~isnan(ASig)));
plot(xiPcx,fPcx, 'linewidth', 1,'color', pcxC)
hold on
line([mean(ASig(~isnan(ASig))) mean(ASig(~isnan(ASig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylabel('p.d.f.')
xlabel('Noise Correlation')

%%
%%
odorsRearranged = 1:15;
[noiseCorrW1000msCoa15, noiseCorrB1000msCoa15, noiseCorrW1000msCoa15Sig, noiseCorrB1000msCoa15Sig] = findNoiseCorrelation(coa15.esp, odorsRearranged);
[noiseCorrW1000msPcx15, noiseCorrB1000msPcx15, noiseCorrW1000msPcx15Sig, noiseCorrB1000msPcx15Sig] = findNoiseCorrelation(pcx15.esp, odorsRearranged);


B = [noiseCorrW1000msCoa15, noiseCorrB1000msCoa15]; 
A = [noiseCorrW1000msPcx15, noiseCorrB1000msPcx15];
BSig = [noiseCorrW1000msCoa15Sig, noiseCorrB1000msCoa15Sig]; 
ASig = [noiseCorrW1000msPcx15Sig, noiseCorrB1000msPcx15Sig];



%%
clims = [-1 1];
odorsRearranged = 1:15;
[sigCorrCoa15, corrMatCoa15, sigCorrCoa15Sig, corrMatCoa15Sig] = findSignalCorrelation(coa15.esp, odorsRearranged);
[sigCorrPcx15, corrMatPcx15, sigCorrPcx15Sig, corrMatPcx15Sig] = findSignalCorrelation(pcx15.esp, odorsRearranged);
figure
imagesc(corrMatCoa15, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
figure
imagesc(corrMatPcx15, clims)
axis square
colormap(brewermap([],'*PuBuGn'))


%%
figure;
plot([2 8], [nanmean(sigCorrCoa15(:)) nanmean(B(:))], 's', 'markersize', 10, 'markeredgecolor', coaC)
hold on
plot([4 10], [nanmean(sigCorrPcx15(:)) nanmean(A(:))], 's', 'markersize', 10, 'markeredgecolor', pcxC)
hold on
errbar([2 8], [nanmean(sigCorrCoa15(:)) nanmean(B(:))], [nanstd(sigCorrCoa15(:))./sqrt(length(sigCorrCoa15(:))) nanstd(B(:))./sqrt(length(B(:)))], 'color', coaC, 'linewidth', 1); %
hold on
errbar([4 10], [nanmean(sigCorrPcx15(:)) nanmean(A(:))], [nanstd(sigCorrPcx15)./sqrt(length(sigCorrPcx15)) nanstd(A(:))./sqrt(length(A(:)))], 'color', pcxC, 'linewidth', 1); %./sqrt(length(accuracyResponsesPcxAA(:)))


hold on;
plot([2.5 8.5], [nanmean(sigCorrCoa15Sig(:)) nanmean(BSig(:))], 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([4.5 10.5], [nanmean(sigCorrPcx15Sig(:)) nanmean(ASig(:))], 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2.5 8.5], [nanmean(sigCorrCoa15Sig(:)) nanmean(BSig(:))], [nanstd(sigCorrCoa15Sig(:))./sqrt(length(sigCorrCoa15Sig(:))) nanstd(BSig(:))./sqrt(length(BSig(:)))], 'color', coaC, 'linewidth', 1); %
hold on
errbar([4.5 10.5], [nanmean(sigCorrPcx15Sig(:)) nanmean(ASig(:))], [nanstd(sigCorrPcx15Sig)./sqrt(length(sigCorrPcx15Sig)) nanstd(ASig(:))./sqrt(length(ASig(:)))], 'color', pcxC, 'linewidth', 1);
ylim([-1 1])
xlim([0 13])
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
sigCorrCoa15 = sigCorrCoa15(:);
sigCorrPcx15 = sigCorrPcx15(:);
sigCorrCoa15Sig = sigCorrCoa15Sig(:);
sigCorrPcx15Sig = sigCorrPcx15Sig(:);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(sigCorrCoa15(~isnan(sigCorrCoa15)));
plot(xiCoa,fCoa,':', 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(sigCorrPcx15(~isnan(sigCorrPcx15)));
plot(xiPcx,fPcx, ':','linewidth', 1,'color', pcxC)
hold on
[fCoa,xiCoa] = ksdensity(sigCorrCoa15Sig(~isnan(sigCorrCoa15Sig)));
plot(xiCoa,fCoa,  'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(sigCorrPcx15Sig(~isnan(sigCorrPcx15Sig)));
plot(xiPcx,fPcx, 'linewidth', 1,'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylabel('p.d.f.')
xlabel('Signal Correlation')
%%
B = B(:);
A = A(:);
BSig = BSig(:);
ASig = ASig(:);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
[fCoa,xiCoa] = ksdensity(B(~isnan(B)));
plot(xiCoa,fCoa,':', 'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(A(~isnan(A)));
plot(xiPcx,fPcx, ':','linewidth', 1,'color', pcxC)
hold on
[fCoa,xiCoa] = ksdensity(BSig(~isnan(BSig)));
plot(xiCoa,fCoa,  'linewidth', 1,'color', coaC)
hold on
[fPcx,xiPcx] = ksdensity(ASig(~isnan(ASig)));
plot(xiPcx,fPcx, 'linewidth', 1,'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylabel('p.d.f.')
xlabel('Noise Correlation')
%%
option.onlyexc = 0;
n_odors = 6;
option.classifierType = 3;
option.shuffle = 0;
option.splits = 9;
option.single_cell = 0;
folderPcx = fullfile(pwd, 'binnedSUA6odorsPcx');
folderCoa = fullfile(pwd, 'binnedSUA6odorsCoa');

mkdir(folder)
prepareDataForClassification(pcxNM.esp, n_odors, folderPcx, option);
mkdir(folder)
prepareDataForClassification(coaNM.esp, n_odors, folderCoa, option);
%%
[meanAccuracyPcx, stdevAccuracyPcx, meanInfoPcx, stdevInfoPcx, auROCsClasses_meanPcx, auROCsClasses_semPcx, confMatPcx] = findClassificationAccuracy(pcxNM.esp, n_odors, folderPcx, option);
[meanAccuracyCoa, stdevAccuracyCoa, meanInfoCoa, stdevInfoCoa, auROCsClasses_meanCoa, auROCsClasses_semCoa, confMatCoa] = findClassificationAccuracy(coaNM.esp, n_odors, folderCoa, option);

figure
shadedErrorBar(1:size(meanAccuracyPcx,2), meanAccuracyPcx, stdevAccuracyPcx/sqrt(50*option.splits), 'k');
hold on
shadedErrorBar(1:size(meanAccuracyCoa,2), meanAccuracyCoa, stdevAccuracyCoa/sqrt(50*option.splits), 'r');
alpha(0.5)
xlabel('number of neurons')
ylabel('accuracy %')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
shadedErrorBar(1:size(meanInfoPcx,2), meanInfoPcx, stdevInfoPcx/sqrt(50-1), 'k');
hold on
shadedErrorBar(1:size(meanInfoCoa,2), meanInfoCoa, stdevInfoCoa/sqrt(50-1), 'r');
alpha(0.5)
xlabel('number of neurons')
ylabel('accuracy %')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
auROCmean = [auROCsClasses_meanCoa' auROCsClasses_meanPcx'];
auROCsem = [auROCsClasses_semCoa' auROCsClasses_semPcx'];
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(auROCsem, auROCmean);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('population auROC')
xlabel('odor I.D.')
ylim([0.5 1])

clims = [0 1];
figure
imagesc(confMatCoa, clims); axis tight
colormap(brewermap([],'*PuBuGn'))
axis square
title('Coa')
set(gca, 'XColor', 'w', 'box','off')
set(gca, 'YColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
figure
imagesc(confMatPcx, clims); axis tight
colormap(brewermap([],'*PuBuGn'))
axis square
title('Pcx')
set(gca, 'XColor', 'w', 'box','off')
set(gca, 'YColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)