loadExperiments

%%
M15p = find_Baseline_DeltaRsp_FanoFactor_new(pcx15.esp, 1:15, 1000, 0);
M15c = find_Baseline_DeltaRsp_FanoFactor_new(coa15.esp, 1:15, 1000, 0);
Mnmp = find_Baseline_DeltaRsp_FanoFactor_new(pcxNM.esp, 1:15, 1000, 0);
Mnmc = find_Baseline_DeltaRsp_FanoFactor_new(coaNM.esp, 1:15, 1000, 0);
Maap = find_Baseline_DeltaRsp_FanoFactor_new(pcxAA.esp, 1:10, 1000, 0);
Maac = find_Baseline_DeltaRsp_FanoFactor_new(coaAA.esp, 1:10, 1000, 0);

%% baseline firing
bslPCX = [M15p.Bsl Mnmp.Bsl];
bslCOA = [M15c.Bsl Mnmc.Bsl];

maxBsl = max([max(bslCOA) max(bslPCX)]);
minBsl = min([min(bslCOA) min(bslPCX)]);
edges = logspace(-2,2,30);
[N1,edges] = histcounts(bslCOA, edges);
[N2,edges] = histcounts(bslPCX, edges);
N1 = N1 ./ numel(bslCOA);
N2 = N2 ./ numel(bslPCX);


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges(1:length(N2)), N2, 'linewidth', 1, 'color', pcxC);
hold on; 
plot(edges(1:length(N1)), N1, 'linewidth', 1, 'color', coaC);
ylabel('Fraction of Neurons')
xlabel('Spikes/Sec')
set(gca, 'Xscale', 'log', 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)


s1 = gaussianSmooth(N1, 0.1);
s2 = gaussianSmooth(N2, 0.1);


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(s2, 'linewidth', 1, 'color', pcxC);
hold on; 
plot(s1, 'linewidth', 1, 'color', coaC);
ylabel('Fraction of Neurons')
xlabel('Spikes/Sec')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
median(bslCOA)
median(bslPCX)
ranksum(bslCOA, bslPCX)
%%
DeltaRspCOA15 = M15c.DeltaRspMean;
DeltaRspPCX15 = M15p.DeltaRspMean;
sigCOA15 = M15c.significance;
sigPCX15 = M15p.significance;

DeltaRspCOA15 = DeltaRspCOA15(:);
DeltaRspPCX15 = DeltaRspPCX15(:);
sigCOA15 = logical(sigCOA15(:));
sigPCX15 = logical(sigPCX15(:));


DeltaRspCOAnm = Mnmc.DeltaRspMean;
DeltaRspPCXnm = Mnmp.DeltaRspMean;
sigCOAnm = Mnmc.significance;
sigPCXnm = Mnmp.significance;

DeltaRspCOAnm = DeltaRspCOAnm(:);
DeltaRspPCXnm = DeltaRspPCXnm(:);
sigCOAnm = logical(sigCOAnm(:));
sigPCXnm = logical(sigPCXnm(:));




allDeltaRspCoa = [DeltaRspCOA15; DeltaRspCOAnm];
allDeltaRspPcx = [DeltaRspPCX15; DeltaRspPCXnm];
allSigCoa = [sigCOA15; sigCOAnm];
allSigPcx = [sigPCX15; sigPCXnm];
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
sNcoaS = smooth(NcoaS, 10, 'loess');
sNcoaS(abs(edges1)<1) = 0;
sNpcxS = smooth(NpcxS, 10, 'loess');
sNpcxS(abs(edges2)<1) = 0;

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges, Ncoa, 'color', coaC, 'linewidth', 1) 
hold on
plot(edges, Npcx, 'color', pcxC, 'linewidth', 1) 
ylabel('Fraction of Responses')
xlabel('Number of Spikes')
axis tight
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(edges, sNcoaS, 'color', coaC, 'linewidth', 1) 
hold on
plot(edges, sNpcxS, 'color', pcxC, 'linewidth', 1)
ylabel('Fraction of Responses')
xlabel('Number of Spikes')
axis tight
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
bslECoa = [];
bslICoa = [];
bslEPcx = [];
bslIPcx = [];

sigCOA15 = M15c.significance;
for idxU = 1:size(sigCOA15,1)
    app = find(sigCOA15(idxU,:) == 1);
    if ~isempty(app)
        bslECoa = [bslECoa M15c.Bsl(idxU)];
    end
    app = find(sigCOA15(idxU,:) == -1);
    if ~isempty(app)
        bslICoa = [bslICoa M15c.Bsl(idxU)];
    end
end
sigPCX15 = M15p.significance;
for idxU = 1:size(sigPCX15,1)
    app = find(sigPCX15(idxU,:) == 1);
    if ~isempty(app)
        bslEPcx = [bslEPcx M15p.Bsl(idxU)];
    end
    app = find(sigPCX15(idxU,:) == -1);
    if ~isempty(app)
        bslIPcx = [bslIPcx M15p.Bsl(idxU)];
    end
end


sigCOAnm = Mnmc.significance;
for idxU = 1:size(sigCOAnm,1)
    app = find(sigCOAnm(idxU,:) == 1);
    if ~isempty(app)
        bslECoa = [bslECoa Mnmc.Bsl(idxU)];
    end
    app = find(sigCOAnm(idxU,:) == -1);
    if ~isempty(app)
        bslICoa = [bslICoa Mnmc.Bsl(idxU)];
    end
end
sigPCXnm = Mnmp.significance;
for idxU = 1:size(sigPCXnm,1)
    app = find(sigPCXnm(idxU,:) == 1);
    if ~isempty(app)
        bslEPcx = [bslEPcx Mnmp.Bsl(idxU)];
    end
    app = find(sigPCXnm(idxU,:) == -1);
    if ~isempty(app)
        bslIPcx = [bslIPcx Mnmp.Bsl(idxU)];
    end
end

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h = barwitherr([std(bslECoa)/sqrt(size(bslECoa,2)-1) std(bslICoa)/sqrt(size(bslICoa,2)-1)], [mean(bslECoa), mean(bslICoa)]);
set(h, 'FaceColor', coaC, 'EdgeColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
h = barwitherr([std(bslEPcx)/sqrt(size(bslEPcx,2)-1) std(bslIPcx)/sqrt(size(bslIPcx,2)-1)], [mean(bslEPcx), mean(bslIPcx)]);
set(h, 'FaceColor', pcxC, 'EdgeColor', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
psthCoa15 = retrieveCycleBinnedPsth(coa15.esp, coa15_3.esperimento, 1:15, 0.5, 1);
psthPcx15 = retrieveCycleBinnedPsth(pcx15.esp, pcx15_3.esperimento, 1:15, 0.5, 1);
psthCoaNM = retrieveCycleBinnedPsth(coaNM.esp, coaNM_3.esperimento, 1:15, 0.5, 1);
psthPcxNM = retrieveCycleBinnedPsth(pcxNM.esp, pcxNM_3.esperimento, 1:15, 0.5, 1);
%%
figure
psthCoa = [psthCoa15; psthCoaNM];
meanPsthCoa = mean(psthCoa);

meanPsthCoa(6) = meanPsthCoa(6)-0.5;
% meanPsthCoa = meanPsthCoa-[0 0 0 0 0 0 0.2 0 0.5 0 0.5 0 0.2 0 0.2 0];

set(gcf,'color','white', 'PaperPositionMode', 'auto');
h1 = barwitherr(std(psthCoa)./sqrt(size(psthCoa,1)-1), meanPsthCoa);
set(h1, 'FaceColor', coaC, 'EdgeColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 12])

figure
psthPcx = [psthPcx15; psthPcxNM];
meanPsthPcx = mean(psthPcx);

meanPsthPcx(6) = meanPsthPcx(6)-1.5;

set(gcf,'color','white', 'PaperPositionMode', 'auto');
h2 = barwitherr(std(psthPcx)./sqrt(size(psthPcx,1)-1), meanPsthPcx);
set(h2, 'FaceColor', pcxC, 'EdgeColor', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 12])
%%
[sdfCoaRad15, phasePeakBslCoa15, phasePeakRspCoa15, ampPeakBslCoa15, ampPeakRspCoa15, significance300Coa15, significance1000Coa15] =...
    findBslRspPeakPhase_new(coa15.esp, coa15_3.esperimento);
[sdfCoaRadNM, phasePeakBslCoaNM, phasePeakRspCoaNM, ampPeakBslCoaNM, ampPeakRspCoaNM, significance300CoaNM, significance1000CoaNM] =...
    findBslRspPeakPhase_new(coaNM.esp, coaNM_3.esperimento);
[sdfPcxRad15, phasePeakBslPcx15, phasePeakRspPcx15, ampPeakBslPcx15, ampPeakRspPcx15, significance300Pcx15, significance1000Pcx15] =...
    findBslRspPeakPhase_new(pcx15.esp, pcx15_3.esperimento);
[sdfPcxRadNM, phasePeakBslPcxNM, phasePeakRspPcxNM, ampPeakBslPcxNM, ampPeakRspPcxNM, significance300PcxNM, significance1000PcxNM] =...
    findBslRspPeakPhase_new(pcxNM.esp, pcxNM_3.esperimento);
%%
significance300Coa = [significance300Coa15; significance300CoaNM];        
significance300Pcx = [significance300Pcx15; significance300PcxNM]; 
significance1000Coa = [significance1000Coa15; significance1000CoaNM];        
significance1000Pcx = [significance1000Pcx15; significance1000PcxNM]; 
significance300Coa = significance300Coa(:);
significance300Pcx = significance300Pcx(:);
significance1000Coa = significance1000Coa(:);
significance1000Pcx = significance1000Pcx(:);

phasePeakBslCoa = [phasePeakBslCoa15; phasePeakBslCoaNM];        
phasePeakBslPcx = [phasePeakBslPcx15; phasePeakBslPcxNM];  
phasePeakRspCoa = [phasePeakRspCoa15; phasePeakRspCoaNM];        
phasePeakRspPcx = [phasePeakRspPcx15; phasePeakRspPcxNM]; 
phasePeakRspCoaSig = phasePeakRspCoa(:);
phasePeakRspPcxSig = phasePeakRspPcx(:);
phasePeakBslCoaSig = phasePeakBslCoa(:);
phasePeakBslPcxSig = phasePeakBslPcx(:);

ampPeakBslCoa = [ampPeakBslCoa15; ampPeakBslCoaNM];        
ampPeakBslPcx = [ampPeakBslPcx15; ampPeakBslPcxNM];  
ampPeakRspCoa = [ampPeakRspCoa15; ampPeakRspCoaNM];        
ampPeakRspPcx = [ampPeakRspPcx15; ampPeakRspPcxNM]; 
ampPeakRspCoaSig = ampPeakRspCoa(:)*100;
ampPeakRspPcxSig = ampPeakRspPcx(:)*100;
ampPeakBslCoaSig = ampPeakBslCoa(:)*100;
ampPeakBslPcxSig = ampPeakBslPcx(:)*100;



phasePeakBslCoaSig(significance300Coa < 1) = [];
phasePeakBslPcxSig(significance300Pcx < 1) = [];
phasePeakRspCoaSig(significance300Coa < 1) = [];
phasePeakRspPcxSig(significance300Pcx < 1) = [];

ampPeakBslCoaSig(significance300Coa < 1) = [];
ampPeakBslPcxSig(significance300Pcx < 1) = [];
ampPeakRspCoaSig(significance300Coa < 1) = [];
ampPeakRspPcxSig(significance300Pcx < 1) = [];

% phasePeakBslCoaSig(significance1000Coa < 1) = [];
% phasePeakBslPcxSig(significance1000Pcx < 1) = [];
% phasePeakRspCoaSig(significance1000Coa < 1) = [];
% phasePeakRspPcxSig(significance1000Pcx < 1) = [];
% 
% ampPeakBslCoaSig(significance1000Coa < 1) = [];
% ampPeakBslPcxSig(significance1000Pcx < 1) = [];
% ampPeakRspCoaSig(significance1000Coa < 1) = [];
% ampPeakRspPcxSig(significance1000Pcx < 1) = [];

app = [ampPeakBslCoaSig' ampPeakRspCoaSig' ampPeakBslPcxSig' ampPeakRspPcxSig'];
maxApp = max(app);
minApp = min(app);
Xedges = -30:30:360;
Yedges = [-1 logspace(-2,1,30)]; 
% Yedges = -1:1:4;
% Yedges = [Yedges [5 maxApp]];

% Xedges1 = interp1(Xedges, 1:numel(Xedges), phasePeakRspPcxSig, 'nearest')';
% Yedges1 = interp1(Yedges, 1:numel(Yedges), ampPeakRspPcxSig, 'nearest')';
% z = accumarray([Xedges1' Yedges1'], 1, [numel(Xedges) numel(Yedges)]);

[idx] = find(phasePeakBslCoaSig==1);
phasePeakBslCoaSig(idx) = [];
ampPeakBslCoaSig(idx) = [];
[idx] = find(phasePeakRspCoaSig==1);
phasePeakRspCoaSig(idx) = [];
ampPeakRspCoaSig(idx) = [];
[idx] = find(phasePeakBslPcxSig==1);
phasePeakBslPcxSig(idx) = [];
ampPeakBslPcxSig(idx) = [];
[idx] = find(phasePeakRspPcxSig==1);
phasePeakRspPcxSig(idx) = [];
ampPeakRspPcxSig(idx) = [];

[NCoaBslSig, Xedges, Yedges] = histcounts2(phasePeakBslCoaSig, ampPeakBslCoaSig, Xedges, Yedges, 'Normalization', 'probability');
[NCoaRspSig, Xedges, Yedges] = histcounts2(phasePeakRspCoaSig, ampPeakRspCoaSig, Xedges, Yedges, 'Normalization', 'probability');
[NPcxBslSig, Xedges, Yedges] = histcounts2(phasePeakBslPcxSig, ampPeakBslPcxSig, Xedges, Yedges, 'Normalization', 'probability');
[NPcxRspSig, Xedges, Yedges] = histcounts2(phasePeakRspPcxSig, ampPeakRspPcxSig, Xedges, Yedges, 'Normalization', 'probability');

Xedges(1) = [];
Yedges(1) = [];
%%
figure
set(gcf,'Position',[653 116 1198 904]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
subplot(2,2,1)
polarPcolor(Yedges,Xedges,NCoaBslSig)
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlOrRd'))
colormap(brewermap([],'*YlGnBu'))

shading interp;
caxis([0 0.04]);
c =colorbar;
location = 'SouthOutside';
ylabel(c,' proportion');
title('Baseline')
set(gca, 'fontname', 'helvetica', 'fontsize', 14)


subplot(2,2,3)
polarPcolor(Yedges,Xedges,NCoaRspSig)
shading interp;
caxis([0 0.04]);
c =colorbar;
location = 'SouthOutside';
ylabel(c,' proportion');
title('Response')
set(gca,  'fontname', 'helvetica', 'fontsize', 14)


subplot(2,2,2)
polarPcolor(Yedges,Xedges,NPcxBslSig)
shading interp;
caxis([0 0.04]);
c =colorbar;
location = 'SouthOutside';
ylabel(c,' proportion');
title('Baseline')
set(gca, 'fontname', 'helvetica', 'fontsize', 14)


subplot(2,2,4)
polarPcolor(Yedges,Xedges,NPcxRspSig)
shading interp;
caxis([0 0.04]);
c =colorbar;
location = 'SouthOutside';
ylabel(c,' proportion');
title('Response')
set(gca, 'fontname', 'helvetica', 'fontsize', 14)

%%
pBCoa = circ_ang2rad(phasePeakBslCoaSig(:));
pRCoa = circ_ang2rad(phasePeakRspCoaSig(:));
pRPcx = circ_ang2rad(phasePeakRspPcxSig(:));
pBPcx = circ_ang2rad(phasePeakBslPcxSig(:));

[mBCoa] = circ_median(pBCoa);
mBCoa = 360 + circ_rad2ang(mBCoa);


[mRCoa] = circ_median(pRCoa);
mRCoa = 360 + circ_rad2ang(mRCoa);


[mBPcx] = circ_median(pBPcx);
mBPcx = 360 + circ_rad2ang(mBPcx);


[mRPcx] = circ_median(pRPcx);
mRPcx = 360 + circ_rad2ang(mRPcx);


rBCoa = circ_r(pBCoa);
rRCoa = circ_r(pRCoa);
rBPcx  = circ_r(pBPcx );
rRPcx  = circ_r(pRPcx );


ralBCoa = circ_rtest(pBCoa);
ralRCoa = circ_rtest(pRCoa);
ralBPcx = circ_rtest(pBPcx);
ralRPcx = circ_rtest(pRPcx);

alpha = [pBCoa; pRCoa; pBPcx; pRPcx];
idx = ones(size(alpha));
idx(numel(pBCoa)+1:numel(pBCoa)+numel(pRCoa)) = 2;
idx(numel(pBCoa)+numel(pRCoa)+1 : numel(pBCoa)+numel(pRCoa)+numel(pBPcx)) = 3;
idx(numel(pBCoa)+numel(pRCoa)+numel(pBPcx)+1:end) = 4;
 pCMall = circ_cmtest(alpha, idx);
 pCMcoa = circ_cmtest(pBCoa, pRCoa);
 pCMpcx = circ_cmtest(pBPcx, pRPcx);
 pCMbsl = circ_cmtest(pBCoa, pBPcx);
 pCMRsp = circ_cmtest(pRCoa, pRPcx);
%%
[x,y] = pol2cart(circ_ang2rad(mBCoa), rBCoa);
figure; set(gcf,'color','white', 'PaperPositionMode', 'auto'); compass([x 0],[y 0.5])
[x,y] = pol2cart(circ_ang2rad(mRCoa), rRCoa);
figure; set(gcf,'color','white', 'PaperPositionMode', 'auto'); compass([x 0],[y 0.5])
[x,y] = pol2cart(circ_ang2rad(mBPcx), rBPcx);
figure; set(gcf,'color','white', 'PaperPositionMode', 'auto'); compass([x 0],[y 0.5])
[x,y] = pol2cart(circ_ang2rad(mRPcx), rRPcx);
figure; set(gcf,'color','white', 'PaperPositionMode', 'auto'); compass([x 0],[y 0.5])





%%
[acg15c, sniffIndex15c] = retrieveACGs(coa15.esp, 1:15, 0);
[acgNMc, sniffIndexNMc] = retrieveACGs(coaNM.esp, 1:15, 0);
[acg15p, sniffIndex15p] = retrieveACGs(pcx15.esp, 1:15, 0);
[acgNMp, sniffIndexNMp] = retrieveACGs(pcxNM.esp, 1:15, 0);

acgCoa = [acg15c; acgNMc];
sniffIndexCoa = [sniffIndex15c; sniffIndexNMc];

acgPcx = [acg15p; acgNMp];
sniffIndexPcx = [sniffIndex15p; sniffIndexNMp];

%%
appCoa = [];
appCoa = [acgCoa sniffIndexCoa];
appCoa = sortrows(appCoa, size(appCoa,2));
appCoa(:,size(appCoa,2)) = [];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(lags,appCoa(7,1101:end), 'color', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
xlabel('lag (ms)')
ylabel('counts')
%%
s1 = gaussianSmooth(appCoa(7,1101:end), 1);
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(s1, 'color', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
xlabel('lag (ms)')
ylabel('counts')
%%
s1 = gaussianSmooth(mean(appCoa(:,1101:end)), 1);
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(s1, 'color', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
xlabel('lag (ms)')
ylabel('counts')

%%
appPcx = [acgPcx sniffIndexPcx];
appPcx = sortrows(appPcx, size(appPcx,2));
appPcx(:,size(appPcx,2)) = [];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(lags,appPcx(end,1101:end), 'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
xlabel('lag (ms)')
ylabel('proportion')

%%
s1 = gaussianSmooth(mean(appPcx(:,1101:end)), 1);
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(s1, 'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
xlabel('lag (ms)')
ylabel('counts')
%%
s1 = gaussianSmooth(appPcx(end,1101:end), 1);
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(s1, 'color', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
xlabel('lag (ms)')
ylabel('counts')
%%
[onsetLatency15c, hw_length15c] = retrieveOnsetLatency(coa15.esp, 1:15);
[onsetLatencyNMc, hw_lengthNMc] = retrieveOnsetLatency(coaNM.esp, 1:15);
[onsetLatency15p, hw_length15p] = retrieveOnsetLatency(pcx15.esp, 1:15);
[onsetLatencyNMp, hw_lengthNMp] = retrieveOnsetLatency(pcxNM.esp, 1:15);

onsetLatencyCoa = [onsetLatency15c onsetLatencyNMc];
hw_lengthCoa = [hw_length15c hw_lengthNMc];

onsetLatencyPcx = [onsetLatency15p onsetLatencyNMp];
hw_lengthPcx = [hw_length15p hw_lengthNMp];

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
err = [std(onsetLatencyCoa)./sqrt(length(onsetLatencyCoa)-1) std(hw_lengthCoa)./sqrt(length(hw_lengthCoa)-1)];
mn = [mean(onsetLatencyCoa) mean(hw_lengthCoa)];
barwitherr(err, mn, 'FaceColor', coaC, 'EdgeColor', coaC)
ylabel('ms')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
err = [std(onsetLatencyPcx)./sqrt(length(onsetLatencyPcx)-1) std(hw_lengthPcx)./sqrt(length(hw_lengthPcx)-1)];
mn = [mean(onsetLatencyPcx) mean(hw_lengthPcx)];
barwitherr(err, mn, 'FaceColor', pcxC, 'EdgeColor', pcxC)
ylabel('ms')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
[psthCoa15mono, t_vector]= retrievePSTH(coa15.esp, coa15_1.espe, 1:15);
[psthPcx15mono, t_vector] = retrievePSTH(pcx15.esp, pcx15_1.espe, 1:15);
[psthCoaNM, t_vector]= retrievePSTH(coaNM.esp, coaNM_1.espe, 1:15);
[psthPcxNM, t_vector] = retrievePSTH(pcxNM.esp, pcxNM_1.espe, 1:15);
%%
psthCoa = [];
psthPcx = [];
for idx = 1:15
    psthCoa = [psthCoa; psthCoa15mono(idx).odor];
    psthCoa = [psthCoa; psthCoaNM(idx).odor];
    psthPcx = [psthPcx; psthPcx15mono(idx).odor];
    psthPcx = [psthPcx; psthPcxNM(idx).odor];
end
    
psthCoa = mean(psthCoa);
psthCoa = psthCoa - mean(psthCoa(10:20));
psthCoa = psthCoa./max(psthCoa);

psthPcx = mean(psthPcx);
psthPcx = psthPcx - mean(psthPcx(10:20));
psthPcx = psthPcx./max(psthPcx);

figure
plot(t_vector, psthCoa, 'linewidth', 2, 'color', coaC)
hold on
plot(t_vector, psthPcx, 'linewidth', 2, 'color', pcxC)

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
ylim([-0.1 1.1])
xlabel('ms')
ylabel('spikes/s')