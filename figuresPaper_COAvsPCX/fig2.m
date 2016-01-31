%% Load data
% pcx1 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_1.mat');
% pcx2 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_2.mat');
% pcxR = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/responses.mat');
% 
% coa1 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_1.mat');
% coa2 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_2.mat');
% coaR = load('/Volumes/Tetrodes Backup1/january2/coa/aa/responses.mat');


odorsRearranged = 1:15;
%% Set figure size
figure
set(gcf,'Name', 'Figure 2: Odor Responses', 'NumberTitle', 'off');
set(gcf,'Position',[235 470 1010 590]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%% Set panels
p = panel();
p.pack('v', {30 70});
p(1).pack('v', {1/2 1/2});
p(1,1).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(1,2).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(2).pack('h', {30 70});
p(2,1).pack('v', {1/4 1/4 1/4 1/4});
p(2,2).pack('v', {45 10 45});
p(2,2,1).pack('h', {20 40 20 20});
p(2,2,3).pack('h', {40 60});
p(2,2,3,1).pack('h', {95 5});
p(2,2,3,2).pack('h', {1/3 1/3 1/3});



% p.select('all');
% p.identify()
%% A - rasters
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

%plot pcx rasters
odorLabels = {'2-methyl thiazol', 'trimethylamine', 'phenetol', 'heptanol', 'hexanal'};
idxPlot = 0;
LineFormat.Color =  'k';
for idxOdor = 1:length(odorsToUse)
    idxPlot = idxPlot + 1;
    p(1, 1, idxPlot).select();
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
    p(1, 1, idxPlot).title(odorLabels(idxOdor));
end
l1 = p(1,1).ylabel({'Piriform'; 'Cortex'});
set(l1, 'Color', 'k');

%plot coa rasters 
odorLabels = {' ', ' ', ' ', ' ', ' '};
idxPlot = 0;
LineFormat.Color =  'r';
for idxOdor = 1:length(odorsToUse)
    idxPlot = idxPlot + 1;
    p(1, 2, idxPlot).select();
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
    p(1, 2, idxPlot).title(odorLabels(idxOdor));
end
l2 = p(1,2).ylabel({'Cortical'; 'Amygdala'});
set(l2, 'Color', 'r');

%% B - excatatory response grand averages of mean
%plot mean
meanPCX = mean(pcxR.respCellOdorPairPSTHExcMn);
app = std(pcxR.respCellOdorPairPSTHExcMn)./sqrt(size(pcxR.respCellOdorPairPSTHExcMn,1));
semPCX = [app; app];
meanCOA = mean(coaR.respCellOdorPairPSTHExcMn);
app = std(coaR.respCellOdorPairPSTHExcMn)./sqrt(size(coaR.respCellOdorPairPSTHExcMn,1));
semCOA = [app; app];
t = 1:length(meanPCX); 
p(2, 1, 1).select();
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

%% C - excitatory response grand averages of coefficient of variation
%plot cv
meanFFPCX = nanmean(pcxR.respCellOdorPairPSTHExcFF);
app = nanstd(pcxR.respCellOdorPairPSTHExcCv)./sqrt(size(pcxR.respCellOdorPairPSTHExcFF,1));
semFFPCX = [app; app];
meanFFCOA = nanmean(coaR.respCellOdorPairPSTHExcFF);
app = nanstd(coaR.respCellOdorPairPSTHExcCv)./sqrt(size(coaR.respCellOdorPairPSTHExcFF,1));
semFFCOA = [app; app];
t = 1:length(meanFFPCX);
p(2, 1, 2).select();
hl(3) = PlotMeanWithFilledSemBand(t, meanFFPCX, semFFPCX(2,:), semFFPCX(1,:), 'k', 2, 'k', 0.2);
hold on; 
hl(4) = PlotMeanWithFilledSemBand(t, meanFFCOA, semFFCOA(2,:), semFFCOA(1,:), 'r', 2, 'r', 0.2);
endPatch = 60;
for idx = 1:15
    patchX =  [idx*endPatch-10 idx*endPatch-10 idx*endPatch+5 idx*endPatch+5];
    patchY  = [1.4 2.8 2.8 1.4];
    p1 = patch(patchX, patchY, [1 1 1]);
    set(p1, 'EdgeColor', 'none'); 
end
VerticalLine(gca,60*4,'k--','LineWidth',1);
set(gca,'XColor','w')
ylabel('Fano factor -this plot is CV, change!')

%% B - inhibitory response grand averages of mean
%plot mean
meanPCX = mean(pcxR.respCellOdorPairPSTHInhMn);
app = std(pcxR.respCellOdorPairPSTHInhMn)./sqrt(size(pcxR.respCellOdorPairPSTHInhMn,1));
semPCX = [app; app];
meanCOA = mean(coaR.respCellOdorPairPSTHInhMn);
app = std(coaR.respCellOdorPairPSTHInhMn)./sqrt(size(coaR.respCellOdorPairPSTHInhMn,1));
semCOA = [app; app];
t = 1:length(meanPCX); 
p(2, 1, 1).select();
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

%% C - inhibitory response grand averages of coefficient of variation
%plot cv
meanFFPCX = nanmean(pcxR.respCellOdorPairPSTHInhFF);
app = nanstd(pcxR.respCellOdorPairPSTHInhCv)./sqrt(size(pcxR.respCellOdorPairPSTHInhFF,1));
semFFPCX = [app; app];
meanFFCOA = nanmean(coaR.respCellOdorPairPSTHInhFF);
app = nanstd(coaR.respCellOdorPairPSTHInhCv)./sqrt(size(coaR.respCellOdorPairPSTHInhFF,1));
semFFCOA = [app; app];
t = 1:length(meanFFPCX);
p(2, 1, 2).select();
hl(3) = PlotMeanWithFilledSemBand(t, meanFFPCX, semFFPCX(2,:), semFFPCX(1,:), 'k', 2, 'k', 0.2);
hold on; 
hl(4) = PlotMeanWithFilledSemBand(t, meanFFCOA, semFFCOA(2,:), semFFCOA(1,:), 'r', 2, 'r', 0.2);
endPatch = 60;
for idx = 1:15
    patchX =  [idx*endPatch-10 idx*endPatch-10 idx*endPatch+5 idx*endPatch+5];
    patchY  = [1.4 2.8 2.8 1.4];
    p1 = patch(patchX, patchY, [1 1 1]);
    set(p1, 'EdgeColor', 'none'); 
end
VerticalLine(gca,60*4,'k--','LineWidth',1);
set(gca,'XColor','w')
ylabel('Fano factor')
%% D - baseline
[BslCOA, DeltaRspCOA, ffCOA, fanoFactorCOA]  = find_Baseline_DeltaRsp_FanoFactor(coa2.esp, odorsRearranged);
[BslPCX, DeltaRspPCX, ffPCX, fanoFactorPCX]  = find_Baseline_DeltaRsp_FanoFactor(pcx2.esp, odorsRearranged);
allBsl = [BslCOA BslPCX];
maxBsl = max(allBsl);
minBsl = min(allBsl);
edges = logspace(-2,2,30);
[N1,edges] = histcounts(BslPCX, edges,'normalization', 'probability');
[N2,edges] = histcounts(BslCOA, edges,'normalization', 'probability');


p(2, 2, 1, 1).select();
edges = log10(edges(1:end-1));
h1 = area(edges, N1);
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
alpha(h1, 0)
hold on; 
h2 = area(edges, N2);
h2.FaceColor = 'r';
h2.EdgeColor = 'r';
alpha(h2, 0)
xlabel('baseline firing (log10, Hz)')
set(gca,'YColor','w','box','off')


%% E - delta response
allD = [DeltaRspCOA DeltaRspPCX];
maxD = max(allD)+5;
minD = min(allD)-5;
edges = minD:maxD;
[N3,edges] = histcounts(DeltaRspPCX, edges,'normalization', 'probability');
[N4,edges] = histcounts(DeltaRspCOA, edges,'normalization', 'probability');
[N5,edges] = histcounts(pcx2.deltaExcR1000ms, edges); N5 = N5./length(DeltaRspPCX);
[N6,edges] = histcounts(coa2.deltaExcR1000ms, edges); N6 = N6./length(DeltaRspPCX);
[N7,edges] = histcounts(pcx2.deltaInhR1000ms, edges); N7 = N7./length(DeltaRspPCX);
[N8,edges] = histcounts(coa2.deltaInhR1000ms, edges); N8 = N8./length(DeltaRspPCX);


p(2, 2, 1, 2).select();
edges(end) = [];
h1 = area(edges, N3);
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
alpha(h1, 0)
hold on; 
h2 = area(edges, N4);
h2.FaceColor = 'r';
h2.EdgeColor = 'r';
alpha(h2, 0)
h3 = area(edges, N5);
h3.FaceColor = 'k';
h3.EdgeColor = 'k';
alpha(h3, 0.5)
hold on; 
h4 = area(edges, N6);
h4.FaceColor = 'r';
h4.EdgeColor = 'r';
alpha(h4, 0.5)
h5 = area(edges, N7);
h5.FaceColor = 'k';
h5.EdgeColor = 'k';
alpha(h5, 0.5)
hold on; 
h5 = area(edges, N8);
h5.FaceColor = 'r';
h5.EdgeColor = 'r';
alpha(h5, 0.5)
xlim([-5 20])
xlabel('response (Hz)')
set(gca,'YColor','w','box','off')

%% F - Fano factor
allD = [ffCOA ffPCX];
maxD = max(allD)+5;
minD = min(allD)-5;
edges = minD:0.5:maxD;
[N3,edges] = histcounts(ffPCX, edges,'normalization', 'probability');
[N4,edges] = histcounts(ffCOA, edges,'normalization', 'probability');
[N5,edges] = histcounts(pcx2.ffExcR1000ms, edges); N5 = N5./length(ffPCX);
[N6,edges] = histcounts(coa2.ffExcR1000ms, edges); N6 = N6./length(ffCOA);
[N7,edges] = histcounts(pcx2.ffInhR1000ms, edges); N7 = N7./length(ffPCX);
[N8,edges] = histcounts(coa2.ffInhR1000ms, edges); N8 = N8./length(ffCOA);


p(2, 2, 1, 3).select();
edges(end) = [];
h1 = area(edges, N3);
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
alpha(h1, 0)
hold on; 
h2 = area(edges, N4);
h2.FaceColor = 'r';
h2.EdgeColor = 'r';
alpha(h2, 0)
xlim([-1 10])

h3 = area(edges, N5);
h3.FaceColor = 'k';
h3.EdgeColor = 'k';
alpha(h3, 0.5)
hold on; 
h4 = area(edges, N6);
h4.FaceColor = 'r';
h4.EdgeColor = 'r';
alpha(h4, 0.5)
xlim([-1 10])

h5 = area(edges, N7);
h5.FaceColor = 'k';
h5.EdgeColor = 'k';
alpha(h5, 0.5)
hold on; 
h6 = area(edges, N8);
h6.FaceColor = 'r';
h6.EdgeColor = 'r';
alpha(h2, 0.5)
xlim([-1 10])
xlabel('Fano factor')
set(gca,'YColor','w','box','off')
%% G - auROC

edges = 0:0.1:1;
[N3,edges] = histcounts(pcxR.auROCTot1s, edges,'normalization', 'probability');
[N4,edges] = histcounts(coaR.auROCTot1s, edges,'normalization', 'probability');
[N5,edges] = histcounts(pcx2.rocExcR1000ms, edges); N5 = N5./length(pcxR.auROCTot1s);
[N6,edges] = histcounts(coa2.rocExcR1000ms, edges); N6 = N6./length(coaR.auROCTot1s);
[N7,edges] = histcounts(pcx2.rocInhR1000ms, edges); N7 = N7./length(pcxR.auROCTot1s);
[N8,edges] = histcounts(coa2.rocInhR1000ms, edges); N8 = N8./length(coaR.auROCTot1s);

p(2, 2, 1, 4).select();
edges(end) = [];
h1 = area(edges, N3);
h1.FaceColor = 'k';
h1.EdgeColor = 'k';
alpha(h1, 0)
hold on; 
h2 = area(edges, N4);
h2.FaceColor = 'r';
h2.EdgeColor = 'r';
alpha(h2, 0)
xlim([-1 10])

h3 = area(edges, N5);
h3.FaceColor = 'k';
h3.EdgeColor = 'k';
alpha(h3, 0.5)
hold on; 
h4 = area(edges, N6);
h4.FaceColor = 'r';
h4.EdgeColor = 'r';
alpha(h4, 0.5)
xlim([-1 10])

h5 = area(edges, N7);
h5.FaceColor = 'k';
h5.EdgeColor = 'k';
alpha(h5, 0.5)
hold on; 
h6 = area(edges, N8);
h6.FaceColor = 'r';
h6.EdgeColor = 'r';
alpha(h2, 0.5)
xlim([-0.05 1.05])
set(gca,'YColor','w','box','off')
xlabel('auROC')
title('')


% p(2, 2, 1, 4).select();
% h1 = cdfplot(pcxR.auROCTot1s);
% set(h1, 'linewidth', 2, 'color', 'k')
% hold on
% h2 = cdfplot(coaR.auROCTot1s);
% set(h2, 'linewidth', 2, 'color', 'r')
% set(gca,'YColor','w','box','off')
% xlabel('auROC')
% title('')
%%
p(2, 2, 2).select();
set(gca,'XColor','w', 'YColor','w')
%% G - response grand averages of kinetics
%plot kinetics
firstSniffResponsesPCX = pcxR.respCellOdorPairPSTHExcMn(:,60*4:60*5);
peaks = max(firstSniffResponsesPCX, [], 2);
firstSniffResponsesPCX = firstSniffResponsesPCX ./ repmat(peaks, 1, size(firstSniffResponsesPCX,2));
firstSniffResponsesPCXMean = nanmean(firstSniffResponsesPCX);
app = nanstd(firstSniffResponsesPCX) ./ sqrt(size(firstSniffResponsesPCX,1));;
firstSniffResponsesPCXSem = [app; app];

firstSniffResponsesCOA= coaR.respCellOdorPairPSTHExcMn(:,60*4:60*5);
peaks = max(firstSniffResponsesCOA, [], 2);
firstSniffResponsesCOA= firstSniffResponsesCOA./ repmat(peaks, 1, size(firstSniffResponsesCOA,2));
firstSniffResponsesCOAMean = nanmean(firstSniffResponsesCOA);
app = nanstd(firstSniffResponsesCOA) ./ sqrt(size(firstSniffResponsesCOA,1));
firstSniffResponsesCOASem = [app; app];

t = 1:length(firstSniffResponsesCOAMean); 
p(2, 2, 3, 1, 1).select();
[hl(5), hp] = PlotMeanWithFilledSemBand(t, firstSniffResponsesPCXMean, firstSniffResponsesPCXSem(2,:), firstSniffResponsesPCXSem(1,:), 'k', 2, 'k', 0.2);
hold on; 
[hl(2), hp] = PlotMeanWithFilledSemBand(t, firstSniffResponsesCOAMean, firstSniffResponsesCOASem(2,:), firstSniffResponsesCOASem(1,:), 'r', 2, 'r', 0.2);
xlim([0 60]);
plotTicks = 0:20:60;
plotLabels = {'0', '100', '200', '300'}; 
set(gca, 'XTick' , plotTicks);
set(gca, 'XTickLabel', plotLabels);
%set(gca,'XColor','w')
p(2, 2, 3, 1).xlabel('Time (ms)');
p(2, 2, 3, 1).ylabel('Fraction of peak');

%%
p(2, 2, 3, 1, 2).select();
set(gca,'XColor','w', 'YColor','w')
%% H - kinetics features
[onsetExc1Coa, peakExc1Coa, hwidthExc1Coa] =  findKineticsFeatures(coa2.esp, odorsRearranged);
[onsetExc1Pcx, peakExc1Pcx, hwidthExc1Pcx] =  findKineticsFeatures(pcx2.esp, odorsRearranged);
onsetMean1 = [mean(onsetExc1Coa) 0];
onsetMean2 = [0 mean(onsetExc1Pcx)];
onsetSem1 = [std(onsetExc1Coa)./sqrt(length(onsetExc1Coa)) 0];
onsetSem2 = [0 std(onsetExc1Pcx)./sqrt(length(onsetExc1Pcx))];
peakMean1 = [mean(peakExc1Coa) 0];
peakMean2 = [0 mean(peakExc1Pcx)];
peakSem1 = [std(peakExc1Coa)./sqrt(length(peakExc1Coa)) 0];
peakSem2 = [0 std(peakExc1Pcx)./sqrt(length(peakExc1Pcx))];
hwidthMean1 = [mean(hwidthExc1Coa) 0];
hwidthMean2 = [0 mean(hwidthExc1Pcx)];
hwidthSem1 = [std(hwidthExc1Coa)./sqrt(length(hwidthExc1Coa)) 0];
hwidthSem2 = [0 std(hwidthExc1Pcx)./sqrt(length(hwidthExc1Pcx))];


p(2, 2, 3, 2, 1).select();
b1 = barwitherr(onsetSem1, onsetMean1, [], '.r');
b1(1).FaceColor = 'r'; 
b1(1).EdgeColor = 'r';
hold on
b2 = barwitherr(onsetSem2, onsetMean2, [], '.k');
b2(1).FaceColor = 'k'; 
b2(1).EdgeColor = 'k';
xlim([0 3])
set(gca,'XColor','w', 'box','off')
hold on
p(2, 2, 3, 2, 1).title('Onset');



p(2, 2, 3, 2, 2).select();
b1 = barwitherr(peakSem1, peakMean1, [], '.r');
b1(1).FaceColor = 'r'; 
b1(1).EdgeColor = 'r';
hold on
b2 = barwitherr(peakSem2, peakMean2, [], '.k');
b2(1).FaceColor = 'k'; 
b2(1).EdgeColor = 'k';
xlim([0 3])
set(gca,'XColor','w', 'box','off')
hold on
p(2, 2, 3, 2, 2).title('Peak latency');



p(2, 2, 3, 2, 3).select();
b1 = barwitherr(hwidthSem1, hwidthMean1, [], '.r');
b1(1).FaceColor = 'r'; 
b1(1).EdgeColor = 'r';
hold on
b2 = barwitherr(hwidthSem2, hwidthMean2, [], '.k');
b2(1).FaceColor = 'k'; 
b2(1).EdgeColor = 'k';
xlim([0 3])
set(gca,'XColor','w', 'box','off')
hold on
p(2, 2, 3, 2, 3).title('Half-width');

p(2, 2, 3, 2).ylabel('Time (ms)');


%% show panels

p.select('all');
p.de.margin = 10;
p(1,1).marginbottom = 2;
p(1).marginbottom = 20;
p(2,1).marginright = 10;
p(2,1,1).marginbottom = 15;
p(2,2,1).marginbottom = 15;
p(2,2,3,2,1).marginleft = 15;
p.margin = [15 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';

%p.export('exportFig2', '-a1.4', '-rp')


   













