% exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).
%
% smoothedPsth
%
% peakDigitalResponsePerCycle
%
% peakAnalogicResponsePerCycle
%
% peakLatencyPerCycle
%
% fullCycleDigitalResponsePerCycle
%
% fullCycleAnalogicResponsePerCycle
%
% aurocMax
%
% bestBinSize
%
% bestPhasePoint
%
% odorDriveAllCycles
%
% popCouplingAllCycles
%
% fullCycleAnalogicResponsePerCycleAllTrials
%
% peakAnalogicResponsePerCycleAllTrials
%
% spikeMatrix
%
% bslSpikeRate
%
% bslPeakRate
%
% bslPeakLatency
%
% cycleBslSdf
%
% baselinePhases
%
% responsePhases
%
% spikeMatrixNoWarp 
%
% sdf_trialNoWarp
%
%
%% plot average response timecourse for each odor


odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
    'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
    'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};



for idxOdor = 1:odors
    idxNeuron = 1;
    responseProfiles{idxOdor} = [];
    responseProfilesZ{idxOdor} = [];
    peakLatency{idxOdor} = [];
    unitOdorResponseLog{idxOdor} = [];
    for idxExp = 1:length(List)
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
                app1 = [];
                app1 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax > 0.75);
                app2 = [];
                app2 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1:4) > 0);
                app3 = [];
                app3 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1:4) > 0);
                app4 = [];
                app4 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax < 0.4);
                %app5 = [];
                %app5 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1:4) < 0);
                app6 = [];
                app6 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1:4) < 0);
                exc = 0;
                if (~isempty(app1) && ~isempty(app2)) || (~isempty(app1) && ~isempty(app3))
                    exc = 1;
                end
                inh = 0;
                if ~isempty(app4)
                    inh = 1;
                end
                responseProfiles{idxOdor}(idxNeuron,:) = mean(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth);
%                 if std(responseProfiles{idxOdor}(idxNeuron,1:preInhalations*cycleLengthDeg)) > 0
%                     responseProfilesZ{idxOdor}(idxNeuron,:) = (responseProfiles{idxOdor}(idxNeuron,:) - mean(responseProfiles{idxOdor}(idxNeuron,1:preInhalations*cycleLengthDeg))) /...
%                         std(responseProfiles{idxOdor}(idxNeuron,1:preInhalations*cycleLengthDeg));
%                 else
                    responseProfilesZ{idxOdor}(idxNeuron,:) = responseProfiles{idxOdor}(idxNeuron,:);
%                 end
                app7 = [];
                %app7= exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakLatencyPerCycle(1:4);
                app7= exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakLatencyPerCycle(1);
                app8 = [];
                app8 = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakAnalogicResponsePerCycle(1:4);
                [~, maxI] = max(app8);
                %peakLatency{idxOdor}(idxNeuron) = app7(maxI) + (maxI-1)*cycleLengthDeg;
                peakLatency{idxOdor}(idxNeuron) = app7;
                unitOdorResponseLog{idxOdor}(idxNeuron, :) = [idxExp idxShank idxUnit idxOdor exc inh exc+inh];
                idxNeuron = idxNeuron+1;
            end
        end
    end
end

%% plot responses by pairs of concentrations

idxOdor1 = 2;
idxOdor2 = 9;

responseProfiles1 = [];
responseProfiles2 = [];
responseProfilesZ1 = [];
responseProfilesZ2 = [];
peakLatency1 = [];
peakLatency2 = [];
popResponse1 = [];
popResponse2 = [];
odorLog1 = [];
odorLog2 = [];


responseProfiles1 = responseProfiles{idxOdor1};
responseProfilesZ1 = responseProfilesZ{idxOdor1};
peakLatency1 = peakLatency{idxOdor1};
odorLog1 = unitOdorResponseLog{idxOdor1};

responseProfiles2 = responseProfiles{idxOdor2};
responseProfilesZ2 = responseProfilesZ{idxOdor2};
peakLatency2 = peakLatency{idxOdor2};
odorLog2 = unitOdorResponseLog{idxOdor2};

noSpikeUnits1 = mean(responseProfiles1,2);
noSpikeUnits2 = mean(responseProfiles2,2);
noSpikeUnits = noSpikeUnits1 + noSpikeUnits2;
responseProfiles1(noSpikeUnits<0.1,:) = [];
responseProfiles2(noSpikeUnits<0.1,:) = [];
responseProfilesZ1(noSpikeUnits<0.1,:) = [];
responseProfilesZ2(noSpikeUnits<0.1,:) = [];
peakLatency1(noSpikeUnits<0.1) = [];
peakLatency2(noSpikeUnits<0.1) = [];
odorLog1(noSpikeUnits<0.1,:) = [];
odorLog2(noSpikeUnits<0.1,:) = [];
popResponses1 = mean(responseProfiles1);
popResponses2 = mean(responseProfiles2);
noRespUnits1 = odorLog1(:,7) == 0;
noRespUnits2 = odorLog2(:,7) == 0;
noRespUnitsApp = noRespUnits1 + noRespUnits2;
noRespUnits = noRespUnitsApp == 2;
responseProfiles1(noRespUnits,:) = [];
responseProfiles2(noRespUnits,:) = [];
responseProfilesZ1(noRespUnits,:) = [];
responseProfilesZ2(noRespUnits,:) = [];
peakLatency1(noRespUnits) = [];
peakLatency2(noRespUnits) = [];
odorLog1(noRespUnits,:) = [];
odorLog2(noRespUnits,:) = [];

idxExc1 = find(odorLog1(:,5) == 1);
excResponses1 =  responseProfiles1(idxExc1, :);
idxExc2 = find(odorLog2(:,5) == 1);
excResponses2 = responseProfiles2(idxExc2, :);
idxInh1 = find(odorLog1(:,6) == 1);
inhResponses1 =  responseProfiles1(idxInh1, :);
idxInh2 = find(odorLog2(:,6) == 1);
inhResponses2 = responseProfiles2(idxInh2, :);
peakLatency1(~(odorLog1(:,5) == 1)) = 1000;
peakLatency2(~(odorLog2(:,5) == 1)) = 1000;


if numel(idxExc1) > numel(idxExc2)
    app1 = [];
    app1 = [responseProfilesZ1 peakLatency1'];
    app1 = sortrows(app1, size(app1,2));
    app1(:,end) = [];
    responseProfilesZ1 = app1;
    app2 = [];
    app2 = [responseProfilesZ2 peakLatency1'];
    app2 = sortrows(app2, size(app2,2));
    app2(:,end) = [];
    responseProfilesZ2 = app2;
    app3 = [];
    app3 = [odorLog1 peakLatency1'];
    app3 = sortrows(app3, size(app3,2));
    app3(:,end) = [];
    odorLog1 = app3;
    app4 = [];
    app4 = [odorLog2 peakLatency1'];
    app4 = sortrows(app4, size(app4,2));
    app4(:,end) = [];
    odorLog2 = app4;
else
    app1 = [];
    app1 = [responseProfilesZ1 peakLatency2'];
    app1 = sortrows(app1, size(app1,2));
    app1(:,end) = [];
    responseProfilesZ1 = app1;
    app2 = [];
    app2 = [responseProfilesZ2 peakLatency2'];
    app2 = sortrows(app2, size(app2,2));
    app2(:,end) = [];
    responseProfilesZ2 = app2;
    app3 = [];
    app3 = [odorLog1 peakLatency2'];
    app3 = sortrows(app3, size(app3,2));
    app3(:,end) = [];
    odorLog1 = app3;
    app4 = [];
    app4 = [odorLog2 peakLatency2'];
    app4 = sortrows(app4, size(app4,2));
    app4(:,end) = [];
    odorLog2 = app4;
end


responseProfiles1Final = excResponses1(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles1FinalMean = mean(responseProfiles1Final);
responseProfiles1FinalMean = smooth(responseProfiles1FinalMean, 0.05, 'rloess');
responseProfiles2Final = excResponses2(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles2FinalMean = mean(responseProfiles2Final);
responseProfiles2FinalMean = smooth(responseProfiles2FinalMean, 0.05, 'rloess');
% responseProfiles1FinalIn = inhResponses1(:,2*cycleLengthDeg:8*cycleLengthDeg);
% responseProfiles1FinalMeanIn = mean(responseProfiles1FinalIn);
% responseProfiles1FinalMeanIn = smooth(responseProfiles1FinalMeanIn, 0.05, 'rloess');
% responseProfiles2FinalIn = inhResponses2(:,2*cycleLengthDeg:8*cycleLengthDeg);
% responseProfiles2FinalMeanIn = mean(responseProfiles2FinalIn);
% responseProfiles2FinalMeanIn = smooth(responseProfiles2FinalMeanIn, 0.05, 'rloess');
popResponses1Final = popResponses1(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses1Final = smooth(popResponses1Final, 0.05, 'rloess');
popResponses2Final = popResponses2(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses2Final = smooth(popResponses2Final, 0.05, 'rloess');
responseProfilesZ1Final = responseProfilesZ1(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfilesZ2Final = responseProfilesZ2(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfilesZ1Final95prctile = prctile(responseProfilesZ1Final(:), 97.9);
responseProfilesZ2Final95prctile = prctile(responseProfilesZ2Final(:), 97.9);
responseProfilesZ1Final2prctile = prctile(responseProfilesZ1Final(:), 0.5);
responseProfilesZ2Final2prctile = prctile(responseProfilesZ2Final(:), 0.5);
if responseProfilesZ1Final95prctile >= responseProfilesZ2Final95prctile
    maxL = responseProfilesZ1Final95prctile;
else
    maxL = responseProfilesZ2Final95prctile;
end

if responseProfilesZ1Final2prctile <= responseProfilesZ2Final2prctile
    minL = responseProfilesZ1Final2prctile;
else
    minL = responseProfilesZ2Final2prctile;
end
clims = [minL maxL];

responseProfiles1FinalMeanMax = max(responseProfiles1FinalMean);
responseProfiles2FinalMeanMax = max(responseProfiles2FinalMean);
if responseProfiles1FinalMeanMax >= responseProfiles2FinalMeanMax
    maxMean = responseProfiles1FinalMeanMax;
else
    maxMean = responseProfiles2FinalMeanMax;
end
% responseProfiles1FinalMeanMaxIn = max(responseProfiles1FinalMeanIn);
% responseProfiles2FinalMeanMaxIn = max(responseProfiles2FinalMeanIn);
% if responseProfiles1FinalMeanMaxIn >= responseProfiles2FinalMeanMaxIn
%     maxMeanIn = responseProfiles1FinalMeanMaxIn;
% else
%     maxMeanIn = responseProfiles2FinalMeanMaxIn;
% end


popResponses1FinalMax = max(popResponses1Final);
popResponses2FinalMax = max(popResponses2Final);
if popResponses1FinalMax > popResponses2FinalMax
    maxPop = popResponses1FinalMax;
else
    maxPop = popResponses2FinalMax;
end


Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')

p.pack({1/3 1/3 1/3}, {50 50})

p(1,1).select()
imagesc(responseProfilesZ1Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')
p(1).title('Responses of units responding to butanedione 1:10000 (left) and-or 1:100 (right)');

p(1,2).select()
imagesc(responseProfilesZ2Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')
%p(1,2).title('TMT 1:100');

p(2,1).select()
xAxis = 1:6*cycleLengthDeg+1;
hold on
for i = 1:size(responseProfiles1Final,1)
    plot(xAxis, responseProfiles1Final(i,:), 'Color', [224,236,244]/255);
end
plot(xAxis, responseProfiles1FinalMean, 'Color', [158,188,218]/255, 'LineWidth', 3);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxMean], 'Color', [136,86,167]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
%xlabel('Respiration cycles')
ylim([-0.1 maxMean]);
p(2,1).title('Average of responsive neurons');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(2,2).select()
xAxis = 1:6*cycleLengthDeg+1;
hold on
for i = 1:size(responseProfiles2Final,1)
    plot(xAxis, responseProfiles2Final, 'Color', [224,236,244]/255);
end
plot(xAxis, responseProfiles2FinalMean, 'Color', [158,188,218]/255, 'LineWidth', 3);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxMean], 'Color', [136,86,167]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
%xlabel('Respiration cycles')
p(2,2).title('Average of responsive neurons');
ylim([-0.1 maxMean]);
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

% p(3,1).select()
% xAxis = 1:6*cycleLengthDeg+1;
% hold on
% for i = 1:size(responseProfiles1FinalIn,1)
%     plot(xAxis, responseProfiles1FinalIn(i,:), 'Color', [231,225,239]/255);
% end
% plot(xAxis, responseProfiles1FinalMeanIn, 'Color', [201,148,199]/255, 'LineWidth', 3);
% line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxMeanIn], 'Color', [136,86,167]/255);
% axis tight
% xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
% xticklabel = {'-2', '-1', '1', '2', '3', '4'};
% set(gca, 'XTick', xticks);
% set(gca, 'XTickLabel', xticklabel);
% set(gca,'YColor','w')
% xlabel('Respiration cycles')
% ylim([-0.1 maxMeanIn]);
% p(3,1).title('Inhibitory responses');
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
% 
% p(3,2).select()
% xAxis = 1:6*cycleLengthDeg+1;
% hold on
% for i = 1:size(responseProfiles2FinalIn,1)
%     plot(xAxis, responseProfiles2FinalIn, 'Color', [231,225,239]/255);
% end
% plot(xAxis, responseProfiles2FinalMeanIn, 'Color', [201,148,199]/255, 'LineWidth', 3);
% line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxMeanIn], 'Color', [136,86,167]/255);
% axis tight
% xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
% xticklabel = {'-2', '-1', '1', '2', '3', '4'};
% set(gca, 'XTick', xticks);
% set(gca, 'XTickLabel', xticklabel);
% set(gca,'YColor','w')
% xlabel('Respiration cycles')
% p(3,2).title('Inhibitory responses');
% ylim([-0.1 maxMeanIn]);
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');


p(3,1).select()
xAxis = 1:6*cycleLengthDeg+1;
area(popResponses1Final, 'FaceColor',[253,192,134]/255);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxPop], 'Color', [240,59,32]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
xlabel('Respiration cycles')
ylim([0 maxPop]);
p(3,1).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(3,2).select()
xAxis = 1:6*cycleLengthDeg+1;
area(popResponses2Final, 'FaceColor',[253,192,134]/255);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxPop], 'Color', [240,59,32]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
xlabel('Respiration cycles')
ylim([0 maxPop]);
p(3,2).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p.de.margin = 2;
p.margin = [8 15 4 10];
p(1).marginbottom = 20;
p(1,1).marginright = 10;
p(1,1).de.marginright = 2;
p(1,2).de.marginright = 2;
p(2).marginbottom = 20;
p(2,1).marginright = 10;
%p(3).marginbottom = 20;
p(3,1).marginright = 10;
%p(4,1).marginright = 10;
p.select('all');
                


%% population responses without breating warping (only first sniff alignement)

odorsRearranged = [1 8 2 9 3 10 4 11 5 12 6 13 7 14 15];

Xfig = 900;
Yfig = 800;
figure;
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')
idxPlot = 1;
for idxOdor = odorsRearranged
    idxNeuron = 1;
    responseProfiles{idxOdor} = [];
    for idxExp = 1:length(List)
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
                responseProfiles{idxOdor}(idxNeuron,:) = mean(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp);
                idxNeuron = idxNeuron + 1;
            end
        end
    end
    subplot(8,2,idxPlot)
    A = responseProfiles{idxOdor};
    A = A(:,14000:16000);
    app1 = [];
    app1 = sum(A,2);
    A(app1==0,:) = [];
    A = mean(A);
    %A = smooth(A, 0.005, 'rloess');
    xAxis = 1:length(A);
    xticks = [1 1000 2000];
    xlab = {'-1', '0', '1'};
    area(A, 'FaceColor',[153,216,201]/255)
    set(gca, 'XTick', xticks);
    set(gca, 'XTickLabel', xlab);
    set(gca,'YColor','w')
    xlabel('sec')
    axis tight 
    set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
    idxPlot =idxPlot + 1;
end
 %% plot responses and demixed responses of odor A vs odor B
% 
% 
% odorA = [15 15];
% odorB = [1 8];
% figure
% Xfig = 900;
% Yfig = 500;
% p = panel();
% set(gcf, 'Position',[1,5,Xfig,Yfig]);
% p.pack({1/2 1/2},{25 25 25 25});
% 
% for idxShank = 1:4
%     k = 1;
%     odorY = [];
%     rosa_demixed = [];
%     odorX = [];
%     odorX_demixed = [];
%     for idxExp = 1:length(List)
%         for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
% %                         rosa(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(15).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
% %                         rosa_demixed(k) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(15).odorDriveAllCycles;
%             app1 = []; app2 = [];
%             app1 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).fullCycleAnalogicResponsePerCycle);
%             app2 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).fullCycleAnalogicResponsePerCycle);
%             if app1 >= app2
%                 odorX(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).fullCycleAnalogicResponsePerCycle)-...
%                     exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             else
%                 odorX(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).fullCycleAnalogicResponsePerCycle) -...
%                     exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             end
%             app1 = []; app2 = [];
%             if app1 >= app2
%                 odorX_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).odorDriveAllCycles);
%             else
%                 odorX_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).odorDriveAllCycles);
%             end
%             
%             
%             app1 = []; app2 = [];
%             app1 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).fullCycleAnalogicResponsePerCycle);
%             app2 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).fullCycleAnalogicResponsePerCycle);
%             if app1 >= app2
%                 odorY(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             else
%                 odorY(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             end
%             app1 = []; app2 = [];
%             if app1 >= app2
%                 rosa_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).odorDriveAllCycles);
%             else
%                 rosa_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).odorDriveAllCycles);
%             end
%             k = k + 1;
%         end
%     end
%     
%     together = []; app = [];
%     app = odorY + odorX;
%     odorY(app==0) = []; odorX(app==0) = [];
%     odorY(isnan(app)) = []; odorX(isnan(app)) = [];
%     [maxvalue, idxmax] = max(odorX);
%     odorY(idxmax) = []; odorX(idxmax) = [];
%     together = [odorY; odorX];
%     maxTogether = max(together);
%     %together = together ./ repmat(maxTogether,2,1);
%     together = together';
%     p(1,idxShank).select()
%     scatter(together(:,1), together(:,2), 7,'filled');
% % %     m = sum(together(:,1) .* together(:,2))/sum(together(:,1).^2);
% % %     y = m*together(:,1);
% % %     hold on
% % %     plot(together(:,1), y, 'r')
% % %     A = together(:,1)\together(:,2);
% % %     hold on;plot(together(:,1), A*together(:,1),'g');
%     maxAx = max(together(:));
%     minAx = abs(min(together(:)));
%     limit = max([minAx maxAx]);
%     xlim([-limit limit]); ylim([-limit limit]);
%     line([0 0], [-limit limit], 'Color', 'k')
%     line([-limit limit], [0 0], 'Color', 'k')
%     axis square
%     axis off
% 
%     
%     
%     together = []; app = [];
%     app = rosa_demixed + odorX_demixed;
%     rosa_demixed(app==0) = []; odorX_demixed(app==0) = [];
%     rosa_demixed(isnan(app)) = []; odorX_demixed(isnan(app)) = [];
%     [maxvalue, idxmax] = max(odorX_demixed);
%     rosa_demixed(idxmax) = []; odorX_demixed(idxmax) = [];
%     together = [rosa_demixed; odorX_demixed];
%     maxTogether = max(together);
%     %together = together ./ repmat(maxTogether,2,1);
%     together = together';
%     p(2,idxShank).select()
%     scatter(together(:,1), together(:,2), 7,'filled');
% %     m = sum(together(:,1) .* together(:,2))/sum(together(:,1).^2);
% %     y = m*together(:,1);
% %     hold on
% %     plot(together(:,1), y, 'r')
% %     A = together(:,1)\together(:,2);
% %     hold on;plot(together(:,1), A*together(:,1),'g');
%     maxAx = max(together(:));
%     minAx = abs(min(together(:)));
%     limit = max([minAx maxAx]);
%     xlim([-limit limit]); ylim([-limit limit]);
%     line([0 0], [-limit limit], 'Color', 'k')
%     line([-limit limit], [0 0], 'Color', 'k')
%     axis square
%     axis off
%     %set(gca,'XTick',[])
% end
% 
% p.margin = [15 15 4 6];
% p.select('all');
% 
% 
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% 
% 
% 
 %% plot distribution of the best bin size
% 
% bestBinWidth = [];
% for idxExp = 1:length(List)
%     for idxShank = 1:4
%         for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
%             for idxOdor = 1:odors
%                 app1 = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax;
%                 app2 = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinSize;
%                 app2(app1<0.75) = [];
%                 app2 = app2(:);
%                 bestBinWidth  = [bestBinWidth app2'];
%             end
%         end
%     end
% end
% 
% 
% binSizes = 5:5:cycleLengthDeg;
% figure
% histogram(bestBinWidth, binSizes)
% xlabel('bin width (deg)');
% axis tight
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% medianBestBinWidth = median(bestBinWidth)
% meanBestBinWidth = mean(bestBinWidth)
% 
% 
% %% plot bsl spike rate
% 
% k = 1;  
% for idxExp = 1:length(List)
%     for idxShank = 1:4
%         for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
%             bkgSpikeRate(k)  = exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             k = k+1;
%         end
%     end
% end
% 
% figure
% histogram(bkgSpikeRate, 100)
% xlabel('background firing rate (Hz)');
% axis tight
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% medianbkgSpikeRate = median(bkgSpikeRate)
% meanbkgSpikeRate = mean(bkgSpikeRate)
% prctile25bkgSpikeRate = prctile(bkgSpikeRate, 25)



%% information vs time
% THIS IS NOT WORKING. NOT ENOUGH MEMORY.
% The best bin size seems to be 100 ms. Let's move 100ms bin by 5 ms step
% from the -2 cycle to the 10th cycle and let's calculate the information
% carried by the population for each bin. The population includes only
% units that had at least 1 aurocMax > 0.75 or a significant peak
% amplitude. Let's make 8 equipopulated bins for the responses. Let's
% consider only odors at the same concentration.

% binWidth = 100;
% odorList = 8:15;
% 
% bslActivityRemodeled =[];
% neuronActivity =[];
% idxNeuron = 1;
% for idxExp = 1:length(List)
%     for idxShank = 1:4
%         for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
%             peakResponses = [];
%             rocMax = [];
%             for idxOdor = odorList
%                 peakResponses = [peakResponses find(exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).peakDigitalResponsePerCycle > 0)];
%                 rocMax =  [rocMax find(exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).aurocMax > 0.75)];
%             end
%             if ~isempty(peakResponses) || ~isempty(rocMax)
%                 bslActivity = exp(idxExp).shank(idxShank).cell(idxNeuron).cycleBslSdf;
%                 for idxTrial = 1:n_trials
%                     v = zeros(1,cycleLengthDeg);
%                     v = v + mean(bslActivity(randi(floor(size(bslActivity,1)/n_trials)),:));
%                     bslActivityRemodeled{idxNeuron}(idxTrial, :) = v;
%                 end
%                 %                 for step = 1:5: 10*cycleLength - 105
%                 %                     airResponse(idxNeuron,:,step) = mean(bslActivityRemodeled(:,step:step + binWidth),2);
%                 %                 end
%                 idxOdor = 1;
%                 for idxOdor = odorList
%                     neuronActivity{idxNeuron}(:, :, idxOdor) = exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).smoothedPsth(:,2*cycleLengthDeg + 1: end);
%                     idxOdor = idxOdor+1;
%                 end
%                 idxNeuron = idxNeuron+1;
%             end
%         end
%     end
% end
% 
% R = [];
% bslR = [];
% oR = [];
% 
% idxPasso = 1;
% for passo = 1:5:cycleLengthDeg-binWidth
%     B = zeros(length(bslActivityRemodeled), n_trials);
%     B = zeros(1, n_trials);
%     for idxNeuron = 1:1%:length(bslActivityRemodeled)
%         v= zeros(n_trials,1);
%         v = v + mean(bslActivityRemodeled{idxNeuron}(:,passo:passo+binWidth), 2);
%         v = v';
%         B(idxNeuron,:) = v;
%     end
%     bslR{idxPasso} = B;
%     idxPasso = idxPasso+1;
% end
% 
% 
% X = [];
% R = [];
% for idxCycle = 1:postInhalations + 2
%     idxPasso = 1;
%     for passo = 1:5:cycleLengthDeg-binWidth
%         oR = zeros(length(bslActivityRemodeled), n_trials, length(odorList));
%         oR = zeros(1, n_trials, length(odorList));
%         for idxNeuron = 1:1%:length(bslActivityRemodeled)
%             v = zeros(n_trials,1,length(odorList));
%             v = v + mean(neuronActivity{idxNeuron}(:, idxCycle * passo:idxCycle * passo+binWidth, :), 2);
%             v = permute(v,[2,1,3]);
%             oR(idxNeuron,:,:) = v;
%         end
%         R = cat(3, oR, bslR{idxPasso});
%         R = binr(R, n_trials, 9, 'eqspace');
%         opts.nt = repmat(n_trials, 1, size(R,3));
%         opts.method = 'dr';
%         opts.bias = 'pt';
%         X(idxCycle,idxPasso) = information(R, opts, 'Ish');
%         idxPasso = idxPasso + 1;
%     end
% end
        
            
% X = reshape(X',1,size(X,1)*size(X,2));
% figure; plot(X)


%% data high


% odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
%     'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
%     'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};

% odor_list = { 'tmt1', 'dmt1', 'mmt1',...
%             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};
% 
% 
% 
% cycleLength = 360;
% odorList = [8:15];
% 
% idxTrial = 1;
% idxOdor = 1;
% for idxTrialOdor=1:n_trials * length(odorList)
%     idxUnit=0;
%     for idxExp = 1:length(List)
%         for idxShank = 1:4
%             for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
%                 idxUnit = idxUnit + 1;
%                 D(idxTrialOdor).data(idxUnit,:) =  exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).spikeMatrix(idxTrial, 3*cycleLength:6*cycleLength);
%             end
%         end
%     end
% %     label = sprintf('reach%d', k);
% %     D(i).condition = label;
%     D(idxTrialOdor).condition = odor_list{idxOdor};
%     idxTrial = idxTrial + 1;
%     if idxTrial > n_trials
%         idxTrial = 1;
%         idxOdor = idxOdor + 1;
%     end
%     %D(i).epochStarts = [1 ante+1 ante+1+window]; 
% end
% 
% DataHigh(D, 'DimReduce')


% a=[];
% b=[];
% s=[];
% for m = 1:40
%     a = sum(D(m).data);
%     b = spikeDensityRad(a,10);
%     s(m,:) = b;
% end
% 
% c = []; c = mean(s(6:10,:));
% figure; plot(c)




%% SPIKE PHASE-LOCKING


% idxBslUnit = 1;
% idxRspUnit = 1;
% for idxExp = 1:length(List)
%     for idxShank = 1:4
%         for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
%             app1 = exp(idxExp).shank(idxShank).cell(idxNeuron).baselinePhases;
%             app2 = exp(idxExp).shank(idxShank).cell(idxNeuron).responsePhases;
%             if ~isempty(app1) && numel(app1) > 50 && ~isempty(app2)
%                 baselinePhases = app1;
%                 unitAngleLog(idxBslUnit, :) = [idxExp idxShank idxNeuron];
%                 baselinePhases = radtodeg(baselinePhases);
%                 [N,edges] = histcounts(baselinePhases, 36, 'Normalization', 'probability');
%                 [peak peakbin] = max(N);
%                 baselinePhases = baselinePhases - (edges(peakbin) + 5);
%                 baselinePhases(baselinePhases<0) = baselinePhases(baselinePhases<0) + 360;
%                 [N,edges] = histcounts(baselinePhases, 36, 'Normalization', 'probability');
%                 angleBslCounts(idxBslUnit,:) = N;
%                 alphaMeanBsl(idxBslUnit) = circ_mean(app1, [], 2);
%                 alphaVarBsl(idxBslUnit) = circ_var(app1, [], [], 2);
%                 
%                 responsePhases = app2;
%                 responsePhases = radtodeg(responsePhases);
%                 [N,edges] = histcounts(responsePhases, 36, 'Normalization', 'probability');
%                 [peak peakbin] = max(N);
%                 responsePhases = responsePhases - (edges(peakbin) + 5);
%                 responsePhases(responsePhases<0) = responsePhases(responsePhases<0) + 360;
%                 [N,edges] = histcounts(responsePhases, 36, 'Normalization', 'probability');
%                 angleRspCounts(idxBslUnit,:) = N;
%                 alphaMeanRsp(idxBslUnit) = circ_mean(app2, [], 2);
%                 alphaVarRsp(idxBslUnit) = circ_var(app2, [], [], 2);
%                  
%                 idxBslUnit = idxBslUnit + 1;
%             end
% %             if ~isempty(app2) && numel(app2) > 50
% %                 responsePhases = app2;
% %                 unitRspLog(idxRspUnit, :) = [idxExp idxShank idxNeuron];
% %                 responsePhases = radtodeg(responsePhases);
% %                 [N,edges] = histcounts(responsePhases, 36, 'Normalization', 'probability');
% %                 [peak peakbin] = max(N);
% %                 responsePhases = responsePhases - (edges(peakbin) + 5);
% %                 responsePhases(responsePhases<0) = responsePhases(responsePhases<0) + 360;
% %                 [N,edges] = histcounts(responsePhases, 36, 'Normalization', 'probability');
% %                 angleRspCounts(idxRspUnit,:) = N;
% %                 alphaMeanRsp(idxRspUnit) = circ_mean(app2, [], 2);
% %                 alphaVarRsp(idxRspUnit) = circ_var(app2, [], [], 2);
% %                 idxRspUnit = idxRspUnit + 1;
% %             end
%         end
%     end
% end
% 
% angleBslCountsMean = mean(angleBslCounts);
% angleBslCountsStd = std(angleBslCounts);
% shiftedangleBslCountsMean = [angleBslCountsMean(19:end) angleBslCountsMean(1:18)];
% shiftedangleBslCountsStd = [angleBslCountsStd(19:end) angleBslCountsStd(1:18)];
% angleRspCountsMean = mean(angleRspCounts);
% angleRspCountsStd = std(angleRspCounts);
% shiftedangleRspCountsMean= [angleRspCountsMean(19:end) angleRspCountsMean(1:18)];
% shiftedangleRspCountsStd = [angleRspCountsStd(19:end) angleRspCountsStd(1:18)];
% 
% x = 1:length(shiftedangleBslCountsMean);
% 
% 
% Xfig = 600;
% Yfig = 800;
% h = figure;
% set(h,'Color','w')
% set(gcf, 'Position',[1,5,Xfig,Yfig]);
% 
% p = panel();
% p.pack('v', {1/3 1/3 1/3});
% p(1).pack('h',{40 20 40});
% p(2).pack('h', {40 20 40});
% p(3).pack('h',{50 50});
% 
% 
% p(1,1).select()
% h11 = rose(alphaMeanBsl);
% set(h11, 'Color', [222,45,38]/255)
% titolo = sprintf('Distribution of average phase\n during baseline');
% p(1,1).title(titolo);
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% p(1,3).select()
% h21 = rose(alphaMeanRsp);
% set(h21, 'Color', [49,130,189]/255)
% titolo = sprintf('Distribution of average phase\n during response');
% p(1,3).title(titolo)
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% 
% p(1,2).select()
% labels = {'baseline', 'odor'};
% ba = radtodeg(alphaMeanBsl);
% re = radtodeg(alphaMeanRsp);
% ba(ba<0) = ba(ba<0)+360;
% re(re<0) = re(re<0)+360;
% my_ttest2_boxplot(ba, re, labels)
% 
% 
% % hold on
% % for ii=1:length(ba)
% %     plot(1,ba(ii),'-ok',...
% %         'MarkerFaceColor',[252,146,114]/255, 'MarkerSize', alphaVarBsl(ii)/max([alphaVarBsl alphaVarRsp])*5)
% %     plot(2,re(ii),'-ok',...
% %         'MarkerFaceColor',[158,202,225]/255, 'MarkerSize', alphaVarRsp(ii)/max([alphaVarBsl alphaVarRsp])*5)
% % end
% set(gca, 'xTick', [1 2]);
% set(gca, 'XTickLabel', labels) ;
% hold off
% ylim([0 360])
% set(gca,'yTick', [0 180 360]);
% p(1,2).title('Average phase')
% 
% p(2,2).select()
% labels = {'baseline', 'odor'};
% my_ttest2_boxplot(alphaVarBsl, alphaVarRsp, labels)
% set(gca,'yTick', [0 0.5 1]);
% p(2,2).title('Average spread')
% ylim([0 1]);
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% 
% p(2,1).select()
% violin(alphaVarBsl', 'facecolor', [252,146,114]/255,  'edgecolor', 'none', 'facealpha', 0.5);
% ylim([0 1]);
% set(gca,'XColor','w')
% set(gca,'YColor','w')
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% p(2,3).select()
% violin(alphaVarRsp', 'facecolor', [158,202,225]/255,  'edgecolor', 'none', 'facealpha', 0.5);
% ylim([0 1]);
% set(gca,'XColor','w')
% set(gca,'YColor','w')
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% 
% p(3,1).select()
% shadedErrorBar(x, shiftedangleBslCountsMean, shiftedangleBslCountsStd, {'r', 'markerfacecolor', [222,45,38]/255});
% ticks = [1 36]; ticksLabel = {'0','2\pi'};
% set(gca, 'XTick', ticks);
% set(gca, 'XTickLabel', ticksLabel);
% set(gca,'YColor','w')
% xlabel('Width (rad)')
% ylabel('Average frequency')
% p(3,1).title('Average phase tuning - Baseline')
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% 
% p(3,2).select()
% shadedErrorBar(x, shiftedangleRspCountsMean, shiftedangleRspCountsStd, {'b', 'markerfacecolor', [49,130,189]/255});
% ticks = [1 36]; ticksLabel = {'0','2\pi'};
% set(gca, 'XTick', ticks);
% set(gca, 'XTickLabel', ticksLabel);
% set(gca,'YColor','w')
% xlabel('Width (rad)')
% ylabel('Average frequency')
% p(3,2).title('Average phase tuning - Response')
% axis tight
% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
% 
% p.de.margin = 2;
% p.margin = [8 10 4 10];
% p(1).marginbottom = 20;
% p(1,2).marginleft = 15; p(1,2).marginright = 15;
% p(2,2).marginleft = 15; p(2,2).marginright = 15;
% p(2,1).marginleft = 10; p(2,3).marginright = 10;
% p(2).marginbottom = 20;
% p(2,1).marginright = 10;
% p(3,1).marginright = 10;
% p.select('all');
                

         