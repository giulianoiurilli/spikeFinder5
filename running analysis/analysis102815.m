startingFolder = pwd;
%%
odorsRearranged = 1:15; %15 odors
%odorsRearranged = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
%odorsRearranged = [1,2,3,4,5,6,7]; %7 odors low
%odorsRearranged = [12 13 14 15 1]; %3 odors pen
%odorsRearranged = [2 3 4 5 6]; %3 odors iaa
%odorsRearranged = [7 8 9 10 11]; %3 odors etg
%odorsRearranged = [1 6 11]; %3 odors high
%odorsRearranged = [14 4 9]; %3 odors medium
%odorsRearranged = [12 2 7]; %3 odors low
%odorsRearranged  = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
%odorsRearranged = [1 2 3 4 5 6 7 8 9 10]; %aveatt 
%odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
%odorsRearranged = [1 13 14 15]; %mixTMT


odors = length(odorsRearranged);

%%
excCellOdorPairs = 0;
inhCellOdorPairs = 0;
for idxExp = 1: length(List) - 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            reliabilityExc = zeros(1,odors);
            reliabilityInh = zeros(1,odors);
            for idxOdor = 1:15
                %                 responsivenessExc(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 responsivenessInh(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == -1;
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                %                 reliabilityExc(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                %                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc) > 0 %&& sum(reliabilityExc) > 0
                excCellOdorPairs = excCellOdorPairs + sum(responsivenessExc);
            end
            if sum(responsivenessInh) > 0 %&& sum(reliabilityInh) > 0
                inhCellOdorPairs = inhCellOdorPairs + sum(responsivenessInh);
            end
        end
    end
end

%%

church = [];
churchRad = [];
churchSniff = [];

fromRad = 360 * 7;
toRad = 360 * 19;
responseWindowSizeRad = toRad - fromRad;
edgesRad = 1:30:responseWindowSizeRad;
edgesSniff = 1:360:responseWindowSizeRad;
angleStamps = 1:responseWindowSizeRad; angleStamps = repmat(angleStamps, n_trials,1);
from = 14500;
to = 18000;
responseWindowSize = to-from;
edgesMs = 1:20:responseWindowSize;
timeStamps = 1:responseWindowSize; timeStamps = repmat(timeStamps, n_trials,1);

excResponsesMs = zeros(excCellOdorPairs,length(edgesMs));
inhResponsesMs = zeros(inhCellOdorPairs,length(edgesMs));
excFFMs = zeros(excCellOdorPairs,length(edgesMs));
inhFFMs = zeros(inhCellOdorPairs,length(edgesMs));
excResponsesRad = zeros(excCellOdorPairs,length(edgesRad));
inhResponsesRad = zeros(inhCellOdorPairs,length(edgesRad));
excFFRad = zeros(excCellOdorPairs,length(edgesRad));
inhFFRad = zeros(inhCellOdorPairs,length(edgesRad));
excResponsesSniff = zeros(excCellOdorPairs,length(edgesSniff));
inhResponsesSniff = zeros(inhCellOdorPairs,length(edgesSniff));
excFFSniff = zeros(excCellOdorPairs,length(edgesSniff));
inhFFSniff = zeros(inhCellOdorPairs,length(edgesSniff));


%%

idxCellOdorPairExc = 1;
idxCellOdorPairInh = 1;
for idxExp = 1: length(List) - 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            reliabilityExc = zeros(1,odors);
            reliabilityInh = zeros(1,odors);
            for idxOdor = 1:odors
%                 responsivenessExc(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
%                 responsivenessInh(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == -1;
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
%                 reliabilityExc(idxO) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
%                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc) > 0
                goodResps = [];
                goodResps = find(responsivenessExc > 0);
                for idxO = goodResps;
%                     if exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                        app = [];
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        app = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixNoWarp(:, from:to-1);
                        app = app .* timeStamps;
                        appHist = histc(app, edgesMs,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        excResponsesMs(idxCellOdorPairExc,:) = appHistMean;
                        excFFMs(idxCellOdorPairExc,:) = appHistFano;
                        
                        app = [];
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        app = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        app = app .* angleStamps;
                        appHist = histc(app, edgesRad,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        excResponsesRad(idxCellOdorPairExc,:) = appHistMean;
                        excFFRad(idxCellOdorPairExc,:) = appHistFano;
                        
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        appHist = histc(app, edgesSniff,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        excResponsesSniff(idxCellOdorPairExc,:) = appHistMean;
                        excFFSniff(idxCellOdorPairExc,:) = appHistVar;
                        
                        churchMs(idxCellOdorPairExc).spikes = logical(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixNoWarp(:, from:to-1));
                        churchRad(idxCellOdorPairExc).spikes = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        churchSniff(idxCellOdorPairExc).spikes = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        idxCellOdorPairExc = idxCellOdorPairExc + 1;
%                     end
                end
            end
            if sum(responsivenessInh) > 0
                goodResps = [];
                goodResps = find(responsivenessInh > 0);
                for idxO = goodResps;
%                     if exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
                        app = [];
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        app = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixNoWarp(:, from:to-1);
                        app = app .* timeStamps;
                        appHist = histc(app, edgesMs,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        inhResponsesMs(idxCellOdorPairInh,:) = appHistMean;
                        inhFFMs(idxCellOdorPairInh,:) = appHistFano;
                        
                        app = [];
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        app = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        app = app .* angleStamps;
                        appHist = histc(app, edgesRad,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        inhResponsesRad(idxCellOdorPairInh,:) = appHistMean;
                        inhFFRad(idxCellOdorPairInh,:) = appHistFano;
                        
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        appHist = histc(app, edgesSniff,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        inhResponsesSniff(idxCellOdorPairInh,:) = appHistMean;
                        inhFFSniff(idxCellOdorPairInh,:) = appHistVar;
                        
                        
                        
                        churchMsInh(idxCellOdorPairInh).spikes = logical(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixNoWarp(:, from:to-1));
                        churchRadInh(idxCellOdorPairInh).spikes = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        churchSniffInh(idxCellOdorPairInh).spikes = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        
                        
                        idxCellOdorPairInh = idxCellOdorPairInh + 1;
%                     end
                end
            end
        end
    end
end

%%
idxCellOdorPairInh = idxCellOdorPairInh - 1;
idxCellOdorPairExc = idxCellOdorPairExc - 1;
allResp = [];
allResp = idxCellOdorPairInh + idxCellOdorPairExc;
k = [];
for i = 1:allResp
    if i <= idxCellOdorPairExc
        churchMsAll(i).spikes = churchMs(i).spikes;
        churchRadAll(i).spikes = churchRad(i).spikes;
        churchSniffAll(i).spikes = churchSniff(i).spikes;
    else
      k = i - idxCellOdorPairExc;
      churchMsAll(i).spikes = churchMsInh(k).spikes;
      churchRadAll(i).spikes = churchRadInh(k).spikes;
      churchSniffAll(i).spikes = churchSniffInh(k).spikes;
    end
end


%%

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[100 41 1273 739]);

times = 60:50:3000;
fanoParams.alignTime = 500;
fanoParams.boxWidth = 50;
fanoParams.matchReps = 0;
myResult = VarVsMean(churchMs, times, fanoParams);
%plotFano(myResult)
subplot(3,3,1)
title('50 ms bins')
hold on
plot(myResult.times,myResult.meanRateAll, 'k', 'lineWidth', 1);
%plot(myResult.times,myResult.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('time (ms)')
ylabel('spikes/s')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,4)
plot(myResult.scatterDataAll(15).mn, myResult.scatterDataAll(15).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
%plot(myResult.scatterData(15).mn, myResult.scatterData(15).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off

set(gca,'xlim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
set(gca,'ylim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,7)
plot(myResult.times, myResult.FanoFactorAll)%, myResult.times, myResult.FanoFactor);

xlabel('time (ms)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');





fanoParamsRad.alignTime = 360*3;
fanoParamsSniff.boxWidth = 60;
timesRad = 361:60:360*10;
myResultRad = VarVsMean(churchRad, timesRad, fanoParamsRad);
% plotFano(myResultRad)
subplot(3,3,2)
title('60 deg bins')
hold on
plot(myResultRad.times,myResultRad.meanRateAll, 'k', 'lineWidth', 1);
%plot(myResultRad.times,myResultRad.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phase (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,5)
plot(myResultRad.scatterDataAll(16).mn, myResultRad.scatterDataAll(16).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
%plot(myResultRad.scatterData(16).mn, myResultRad.scatterData(16).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
set(gca,'ylim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,8)
 plot(myResultRad.times, myResultRad.FanoFactorAll)

xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');




timesSniff = 361:360:360*10;
fanoParamsSniff.boxWidth = 360;
fanoParamsSniff.alignTime = 360*3;
myResultSniff = VarVsMean(churchSniff, timesSniff, fanoParamsSniff);
% plotFano(myResultSniff)
subplot(3,3,3)
title('whole sniff bins')
hold on
plot(myResultSniff.times,myResultSniff.meanRateAll, 'k', 'lineWidth', 1);

hold off
xlabel('respiration phases (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,6)
plot(myResultSniff.scatterDataAll(4).mn, myResultSniff.scatterDataAll(4).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on

plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
set(gca,'ylim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,9)
plot(myResultSniff.times, myResultSniff.FanoFactorAll)

xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

savefig('FanoFactors.fig')

%%

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[100 41 1273 739]);

times = 60:50:3000;
fanoParams.alignTime = 500;
fanoParams.boxWidth = 50;
myResult = VarVsMean(churchMsAll, times, fanoParams);
%plotFano(myResult)
subplot(3,3,1)
title('50 ms bins')
hold on
plot(myResult.times,myResult.meanRateAll, 'k', 'lineWidth', 1);

hold off
xlabel('time (ms)')
ylabel('spikes/s')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,4)
plot(myResult.scatterDataAll(15).mn, myResult.scatterDataAll(15).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on

plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off

set(gca,'xlim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
set(gca,'ylim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,7)
plot(myResult.times, myResult.FanoFactorAll)

xlabel('time (ms)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');





fanoParamsRad.alignTime = 360*3;
fanoParamsSniff.boxWidth = 60;
timesRad = 361:60:360*10;
myResultRad = VarVsMean(churchRadAll, timesRad, fanoParamsRad);
% plotFano(myResultRad)
subplot(3,3,2)
title('60 deg bins')
hold on
plot(myResultRad.times,myResultRad.meanRateAll, 'k', 'lineWidth', 1);

hold off
xlabel('respiration phase (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,5)
plot(myResultRad.scatterDataAll(16).mn, myResultRad.scatterDataAll(16).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on

plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
set(gca,'ylim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,8)
plot(myResultRad.times, myResultRad.FanoFactorAll)

xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');




timesSniff = 361:360:360*10;
fanoParamsSniff.boxWidth = 360;
fanoParamsSniff.alignTime = 360*3;
myResultSniff = VarVsMean(churchSniffAll, timesSniff, fanoParamsSniff);
% plotFano(myResultSniff)
subplot(3,3,3)
title('whole sniff bins')
hold on
plot(myResultSniff.times,myResultSniff.meanRateAll, 'k', 'lineWidth', 1);

hold off
xlabel('respiration phases (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,6)
plot(myResultSniff.scatterDataAll(4).mn, myResultSniff.scatterDataAll(4).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on

plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
set(gca,'ylim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,9)
plot(myResultSniff.times, myResultSniff.FanoFactorAll)

xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

savefig('FanoFactorsAll.fig')
%%
% plotAuRocTuning
% title('Tuning (auROC)')
% xlabel('odor id')
% ylabel('unit id')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% savefig('auROCtunings.fig')



























