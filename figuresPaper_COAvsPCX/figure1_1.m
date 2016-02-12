%% Load data
pcx1 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_1.mat');
pcx2 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_2.mat');
pcxR = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/responses.mat');

coa1 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_1.mat');
coa2 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_2.mat');
coaR = load('/Volumes/Tetrodes Backup1/january2/coa/aa/responses.mat');
pcxBrain = imread('/Volumes/Tetrodes Backup1/january2/PCX.jpg');
coaBrain = imread('/Volumes/Tetrodes Backup1/january2/plCOA.jpg');


odorsRearranged = 1:15;
%% Set figure size/position
figure
set(gcf,'Name', 'Figure 1: Summary of odor responses', 'NumberTitle', 'off');
set(gcf,'Position',[190 420 1100 590]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
%% Set panels
% p = panel();
% p.pack('h', {25 75});
% p(1).pack('v', {60 40});
% p(1,1).pack('h', {70 30});
% p(1,1,1).pack('v', {50 50});
% p(1,2).pack('v', {1/2 1/2});
% p(2).pack('v', {30 70});
% p(2,1).pack('v', {4 48 48});
% p(2,1,1).pack('h', {1/5 1/5 1/5 1/5 1/5});
% p(2,1,2).pack('h', {1/5 1/5 1/5 1/5 1/5});
% p(2,1,3).pack('h', {1/5 1/5 1/5 1/5 1/5});
% p(2,2).pack('v', {48 4 48});
% p(2,2,1).pack('h', {22 29 22 22});
% p(2,2,3).pack('h', {30 70});
% p(2,2,3,2).pack('h', {1/3 1/3 1/3});


p = panel();
p.pack('h', {20 80});
p(1).pack('v', {50 50});
p(2).pack('v', {1/3 1/3 1/3});
p(2,1).pack('v', {4 48 48});
p(2,1,1).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(2,1,2).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(2,1,3).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(2,2).pack('h', {50 50});
p(2,3).pack('h', {22 29 22 22});

% p.select('all');
% p.identify()



%% A - Leave room for electrode positions

p(1,1).select();
imshow(coaBrain)
set(gca, 'XTick' , []);
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'XColor','w')

p(1,2).select();
imshow(pcxBrain)
set(gca, 'XTick' , []);
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'XColor','w')
%% B - Rasters
odorsToUse = [1 4 9 11 13];
pcxUnit = [2 4 1];
coaUnit = [3 2 2];
trialsN = 10;
pcxResponses = [];
coaResponses = [];

patchY = [0 trialsN trialsN 0];
patchX = [0 0 2 2];

%load spiketimes
idxO = 0;
for idxOdor = odorsToUse
    idxO = idxO + 1;
    for idxTrial = 1:trialsN
        app = [];
        app = pcx1.espe(pcxUnit(1)).shankNowarp(pcxUnit(2)).cell(pcxUnit(3)).odor(idxOdor).spikeMatrix(idxTrial,:);
        app1=[];
        app1 = find(app==1);
        app1 = (app1./1000) - 15;
        pcxResponses(idxO).spikes{idxTrial} = app1;
        app = [];
        app = coa1.espe(coaUnit(1)).shankNowarp(coaUnit(2)).cell(coaUnit(3)).odor(idxOdor).spikeMatrix(idxTrial,:);
        app1=[];
        app1 = find(app==1);
        app1 = (app1./1000) - 15;
        coaResponses(idxO).spikes{idxTrial} = app1;
    end
end
for idxPlot = 1:5
    p(2,1,1, idxPlot).select();
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca, 'YTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
end
%plot coa rasters 
odorLabels = {'2-methyl thiazol', 'trimethylamine', 'phenetol', 'heptanol', 'hexanal'};
idxPlot = 0;
LineFormat.Color =  'r';
for idxOdor = 1:length(odorsToUse)
    idxPlot = idxPlot + 1;
    p(2,1,2, idxPlot).select();
    p1 = patch(patchX, patchY, [0.8 0.8 0.8]); 
    set(p1, 'EdgeColor', 'none'); 
    hold on
    plotSpikeRaster(coaResponses(idxOdor).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 6], 'LineFormat', LineFormat);
    %line([0 0], [0 trialsN+1], 'Color', rgb(useColorOnset))
    %ShadePlotForEmpahsis(odorWindow,'r',0.5);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
    p(2,1,2, idxPlot).title(odorLabels(idxOdor));
end
l2 = p(2,1,2).ylabel({'Cortical'; 'Amygdala'});
set(l2, 'Color', 'r');

%plot pcx rasters
idxPlot = 0;
LineFormat.Color =  'k';
for idxOdor = 1:length(odorsToUse)
    idxPlot = idxPlot + 1;
    p(2,1,3, idxPlot).select();
    p1 = patch(patchX, patchY, [0.8 0.8 0.8]); 
    set(p1, 'EdgeColor', 'none'); 
    hold on
    plotSpikeRaster(pcxResponses(idxOdor).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 6], 'LineFormat', LineFormat);
    %line([0 0], [0 trialsN+1], 'Color', rgb(useColorOnset))
    %ShadePlotForEmpahsis(odorWindow,'r',0.5);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
    %p(1, 1, idxPlot).title(odorLabels(idxOdor));
end
l1 = p(2,1,3).ylabel({'Piriform'; 'Cortex'});
set(l1, 'Color', 'k');



%% C - excitatory response grand averages of mean
%plot mean
meanPCX = mean(pcxR.respCellOdorPairPSTHExcMn);
app = std(pcxR.respCellOdorPairPSTHExcMn)./sqrt(size(pcxR.respCellOdorPairPSTHExcMn,1));
semPCX = [app; app];
meanCOA = mean(coaR.respCellOdorPairPSTHExcMn);
app = std(coaR.respCellOdorPairPSTHExcMn)./sqrt(size(coaR.respCellOdorPairPSTHExcMn,1));
semCOA = [app; app];
t = 1:length(meanPCX); 
p(2,2,1).select();
hl(1) = PlotMeanWithFilledSemBand(t, meanPCX, semPCX(2,:), semPCX(1,:), 'k', 2, 'k', 0.2);
hold on; 
hl(2) = PlotMeanWithFilledSemBand(t, meanCOA, semCOA(2,:), semCOA(1,:), 'r', 2, 'r', 0.2);
endPatch = 60;
for idx = 1:15
    patchX =  [idx*endPatch-10 idx*endPatch-10 idx*endPatch+5 idx*endPatch+5];
    patchY  = [0 1 1 0];
    p1 = patch(patchX, patchY, [1 1 1]);
    set(p1, 'EdgeColor', 'none'); 
end
VerticalLine(gca,60*4,'k--','LineWidth',1);
set(gca,'XColor','w')
plotTicks = 0:0.25:1;
plotLabels = {'0', '5', '10', '15', '20'}; 
set(gca, 'YTick' , plotTicks);
set(gca, 'YTickLabel', plotLabels);
ylabel('Firing rate (Hz)')
%% D - excitatory response grand averages of coefficient of variation
%plot cv
meanCVPCX = nanmean(pcxR.respCellOdorPairPSTHExcCV);
app = nanstd(pcxR.respCellOdorPairPSTHExcCV)./sqrt(size(pcxR.respCellOdorPairPSTHExcCV,1));
semCVPCX = [app; app];
meanCVCOA = nanmean(coaR.respCellOdorPairPSTHExcCV);
app = nanstd(coaR.respCellOdorPairPSTHExcCV)./sqrt(size(coaR.respCellOdorPairPSTHExcCV,1));
semCVCOA = [app; app];
t = 1:length(meanCVPCX);
p(2,2,2).select();
hl(3) = PlotMeanWithFilledSemBand(t, meanCVPCX, semCVPCX(2,:), semCVPCX(1,:), 'k', 2, 'k', 0.2);
hold on; 
hl(4) = PlotMeanWithFilledSemBand(t, meanCVCOA, semCVCOA(2,:), semCVCOA(1,:), 'r', 2, 'r', 0.2);
endPatch = 60;
for idx = 1:15
    patchX =  [idx*endPatch-10 idx*endPatch-10 idx*endPatch+5 idx*endPatch+5];
    patchY  = [1.4 2.8 2.8 1.4];
    p1 = patch(patchX, patchY, [1 1 1]);
    set(p1, 'EdgeColor', 'none'); 
end
VerticalLine(gca,60*4,'k--','LineWidth',1);
%ylim([0.9 1.4]);
set(gca,'XColor','w')
ylabel('Coefficient of variation')
%% E - baseline
% [BslCOA, DeltaRspCOA, ffCOA, cvCOA, fanoFactorCOA]  = find_Baseline_DeltaRsp_FanoFactor(coa2.esp, odorsRearranged);
% [BslPCX, DeltaRspPCX, ffPCX, cvPCX, fanoFactorPCX]  = find_Baseline_DeltaRsp_FanoFactor(pcx2.esp, odorsRearranged);
allBsl = [BslCOA BslPCX];
maxBsl = max(allBsl);
minBsl = min(allBsl);
edges = logspace(-2,2,30);
[N1,edges] = histcounts(BslPCX, edges,'normalization', 'probability');
[N2,edges] = histcounts(BslCOA, edges,'normalization', 'probability');


p(2,3,1).select();
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

%% F - delta response
p(2,3,2).select();
distributionPlot(DeltaRspCOA(:),'histOri','right','color','k','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(DeltaRspPCX(:),'histOri','left','color','r','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
alpha(0.5)
hold on
coaRsp = [coaR.deltaExcR1000ms(:); coaR.deltaInhR1000ms(:)];
idxCoaResponsiveCells = randsample(length(coaRsp), 100);
coaRsp = coaRsp(idxCoaResponsiveCells);
catIdx1 = ones(length(coaRsp),1);
plotSpread(coaRsp, 'xyOri', 'flipped',...
    'distributionMarkers',{'o'},'distributionColors',{'r'});
hold on
pcxRsp = [pcxR.deltaExcR1000ms(:); pcxR.deltaInhR1000ms(:)];
idxPcxResponsiveCells = randsample(length(pcxRsp), 100);
pcxRsp = pcxRsp(idxPcxResponsiveCells);
catIdx2 = ones(length(pcxRsp),1);
plotSpread(pcxRsp, 'xyOri', 'flipped',...
    'distributionMarkers',{'o'},'distributionColors',{'k'});
ylim([0.5 1.5]);
xlim([-5 20]);
xlabel('response (Hz)')
set(gca,'YColor','w','box','off')

%% G - Fano factor
p(2,3,3).select();
ffCOA = abs(ffCOA(:));
ffCOA = ffCOA(~isnan(ffCOA)); ffCOA = ffCOA(~isinf(ffCOA)); ffCOA = ffCOA(ffCOA<40);

ffPCX = abs(ffPCX(:));
ffPCX = ffPCX(~isnan(ffPCX)); ffPCX = ffPCX(~isinf(ffPCX)); ffPCX = ffPCX(ffPCX<40);
distributionPlot(ffCOA,'histOri','right','color','k','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(ffPCX,'histOri','left','color','r','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
alpha(0.5)
hold on
coaFF= [coaR.ffExcR1000ms(:); coaR.ffInhR1000ms(:)];
coaFF = abs(coaFF(idxCoaResponsiveCells));
catIdx1 = ones(length(coaFF),1);
plotSpread(coaFF, 'xyOri', 'flipped',...
    'distributionMarkers',{'o'},'distributionColors',{'r'});
hold on
pcxFF = [pcxR.ffExcR1000ms(:); pcxR.ffInhR1000ms(:)];
pcxFF = abs(pcxFF(idxPcxResponsiveCells));
catIdx2 = ones(length(pcxFF),1);
plotSpread(pcxFF, 'xyOri', 'flipped',...
    'distributionMarkers',{'o'},'distributionColors',{'k'});
ylim([0.5 1.5]);
xlim([-1 30]);
xlabel('Fano factor')
set(gca,'YColor','w','box','off')

%% H - auROC
p(2,3,4).select();
distributionPlot(coaR.auROCTot1s(:),'histOri','right','color','k','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(pcxR.auROCTot1s(:),'histOri','left','color','r','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
alpha(0.5)
hold on
coaROC= [coaR.rocExcR1000ms(:); coaR.rocInhR1000ms(:)];  
coaROC= coaROC(idxCoaResponsiveCells); coaROCE = coaROC(coaROC>=0.75); coaROCI = coaROC(coaROC<=0.35); coaROC = [coaROCE; coaROCI];
catIdx1 = ones(length(coaROC),1);
plotSpread(coaROC, 'xyOri', 'flipped',...
    'distributionMarkers',{'o'},'distributionColors',{'r'});
hold on
pcxROC= [pcxR.rocExcR1000ms(:); pcxR.rocInhR1000ms(:)]; 
pcxROC= pcxROC(idxPcxResponsiveCells); pcxROCE = pcxROC(pcxROC>=0.75); pcxROCI = pcxROC(pcxROC<=0.35); pcxROC = [pcxROCE; pcxROCI];
catIdx2 = ones(length(pcxROC),1);
plotSpread(pcxROC, 'xyOri', 'flipped',...
    'distributionMarkers',{'o'},'distributionColors',{'k'});
ylim([0.5 1.5]);
xlim([-0.05 1.05])
xlabel('auROC')
set(gca,'YColor','w','box','off')

%% show panels
p.select('all');
p.de.margin = 10;
p(1).marginright= 25;
p(2,1).marginbottom = 60;
p(2,2).marginbottom = 10;
p(2,1).marginbottom = 1;
p(2,2,1).marginright= 20;
p(2,3,1).marginright = 20;
p(2,3,2).marginright = 20;
p(2,3,3).marginright = 20;
p.margin = [15 15 5 1];
p.fontsize = 12;
p.fontname = 'Avenir';

%p.export('exportFig2', '-a1.4', '-rp')





   













