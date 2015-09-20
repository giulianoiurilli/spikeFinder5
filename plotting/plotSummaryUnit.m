% load('units.mat');
% load('parameters.mat');


cycleLength = round(2*pi, 2) / radPerMs;
bslWindow = floor(preInhalations * round(2*pi, 2) / radPerMs);
odorWindow = 0:postInhalations;
rasterTicks = [-preInhalations :0.5: postInhalations] * 2 * pi; rasterTicks(end) = [];
psthTicks = [0.5 : 2 * (preInhalations + postInhalations) + 0.5]; psthTicks(end) = [];
sdfTicks = [0 : floor(pi/radPerMs) : (preInhalations + postInhalations) * round(2*pi, 2) / radPerMs]; sdfTicks(end) = [];
ciclo = {'i', 'e'}; labels = repmat(ciclo, 1, preInhalations); labels{2 * preInhalations + 1} = '0'; labels{2 * preInhalations + 2} = 'e';
labelsPost = repmat(ciclo, 1, postInhalations - 1); labels = [labels labelsPost];
radTick = [1 cycleLength];
radLabels={'0','2\pi'};
useColorOnset = 'ForestGreen';

odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
             'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};


listOdors = {'TMT^-4', 'TMT^-2', 'DMT^-4', 'DMT^-2', 'MT^-4', 'MT^-2',...
             'IBA^-4', 'IBA^-2', 'IAA^-4', 'IAA^-2', 'HXD^-4', 'HXD^-2', 'BTD^-4', 'BTD^-2', 'rose'};
odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];

titolo = sprintf('shank %d, unit %d', idxShank, idxUnit);



Xfig = 1440;
Yfig = 800;

p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);

p.pack('h',{62 []});

p(1).pack({1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15}, {30 20 20 30});

p(2).pack('v', {75 []});
p(2,1).pack({1/4 1/4 1/4 1/4}, {50 []});
p(2,2).pack('h',{1/2 1/2});


%% Plot raster plots

i = 1;
for idxOdor = 1:odors
    if idxOdor == 15
        p(1,idxOdor,1).select();
        plotSpikeRaster(shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(i))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxOdor,1).select();
        plotSpikeRaster(shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylabel(listOdors(i))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    i = i+1;
end

p(1,1,1).title(titolo);




%% Plot cycle-binned PSTHs
barColor = 'DarkSlateGray';
for idxOdor = odorsRearranged
    if idxOdor == 15
        p(1,idxOdor,2).select();
        psthBreathingBins = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth);
        psthBreathingBins1 = psthBreathingBins - shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl;
        
        bar(psthBreathingBins1,1, 'FaceColor', rgb(barColor))
        axis tight; 
        line([2*preInhalations + 0.5 2*preInhalations + 0.5], [min(psthBreathingBins1) max(psthBreathingBins1)], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick', psthTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxOdor,2).select();
        psthBreathingBins = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth);
        psthBreathingBins1 = psthBreathingBins - shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl;
        
        bar(psthBreathingBins1,1, 'FaceColor', rgb(barColor))
        axis tight; 
        line([2*preInhalations + 0.5 2*preInhalations + 0.5], [min(psthBreathingBins1) max(psthBreathingBins1)], 'Color', rgb(useColorOnset))
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
end

p(1,1,2).title('PSTH (odd/even bins = exh/inh');

%% Plot spike density functions
for idxOdor = odorsRearranged
    areaColors = {'Moccasin', 'IndianRed'};
    if idxOdor == 15
        p(1,idxOdor,3).select();
        sdfMean = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs);
        sdfMeanBsl = sdfMean(1:bslWindow);
        sdfMeanOdor = sdfMean;
        sdfMeanOdor(1:floor(bslWindow)) = 0;
        hold on
        area(sdfMeanBsl, 'FaceColor', rgb(areaColors(1)))
        area(sdfMeanOdor, 'FaceColor',rgb(areaColors(2)))
        axis tight
        ylim([0 0.09])
        line([preInhalations * round(2*pi, 2) / radPerMs preInhalations * round(2*pi, 2) / radPerMs], [0 0.06], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick', sdfTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxOdor,3).select();
        sdfMean = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs);
        sdfMeanBsl = sdfMean(1:bslWindow);
        sdfMeanOdor = sdfMean;
        sdfMeanOdor(1:floor(bslWindow)) = 0;
        hold on
        area(sdfMeanBsl, 'FaceColor', rgb(areaColors(1)))
        area(sdfMeanOdor, 'FaceColor',rgb(areaColors(2)))
        axis tight
        ylim([0 0.09])
        line([preInhalations * round(2*pi, 2) / radPerMs preInhalations * round(2*pi, 2) / radPerMs], [0 0.06], 'Color', rgb(useColorOnset))
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
end
p(1,1,3).title('spike densities (sigma = 10ms)');
%% Plot reponse timecourse per cycle
for idxOdor = odorsRearranged
    colorsToUse = {'Navy', 'MediumBlue', 'DodgerBlue', 'LightSkyBlue'};
    if idxOdor == 15
        p(1,idxOdor,4).select();       
        rspAverageTrace = zeros(1,cycleLength);
        baselineAverageTrace = zeros(1,cycleLength);
        baselineAverageTrace = mean(shank(idxShank).cell(idxUnit).cycleBslMultiple);
        radAxis = 1:cycleLength;
        plot(radAxis, baselineAverageTrace, 'r', 'LineWidth', 1);
        hold on
        for idxCycle = 1:4
            rspAverageTrace = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs(:,(idxCycle-1) * cycleLength + 1 : idxCycle * cycleLength));
            plot(radAxis, rspAverageTrace, 'LineWidth', 2, 'Color', rgb(colorsToUse(idxCycle)));
        end
        axis tight
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca, 'XTick', radTick);
        %set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
        set(gca, 'XTickLabel', radLabels);
    else
        p(1,idxOdor,4).select();
        rspAverageTrace = zeros(5,cycleLength);
        baselineAverageTrace = zeros(1,cycleLength);
        baselineAverageTrace = mean(shank(idxShank).cell(idxUnit).cycleBslMultiple);
        radAxis = 1:cycleLength;
        plot(radAxis, baselineAverageTrace, 'r', 'LineWidth', 1);
        hold on
        for idxCycle = 1:4
            rspAverageTrace = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs(:,(idxCycle-1) * cycleLength + 1 : idxCycle * cycleLength));
            plot(radAxis, rspAverageTrace, 'LineWidth', 2, 'Color', rgb(colorsToUse(idxCycle)));
        end
        axis tight
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
end
p(1,1,4).title('response timecourses');

%% Plot peak tunings per cycle

dPrimeBaselineTheshold = prctile(shank(idxShank).cell(idxUnit).dPrimeNullDistribution, 95);

dPrimeResponse = zeros(odors, 4);
for idxOdor = odorsRearranged
    dPrimeResponse(idxOdor,:) = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDPrime(1:4);
end
dPrimeResponse = dPrimeResponse';
useColor = {'Maroon', 'SaddleBrown', 'Chocolate', 'Tan'};
for idxCycle = 1:4
    if idxCycle == 4
        p(2,1,idxCycle,1).select();
        bar(dPrimeResponse(idxCycle,:), 1, 'FaceColor', rgb(useColor(idxCycle)));
        hold on
        plot([-0.5 15.5], [dPrimeBaselineTheshold dPrimeBaselineTheshold], ':k')
        %         set(gca,'YTick',[])
        %         set(gca,'YColor','w')
        lab = sprintf('cycle %d', idxCycle);
        ylabel(lab)
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
        axis tight
    else
        p(2,1,idxCycle,1).select();
        bar(dPrimeResponse(idxCycle,:), 1, 'FaceColor', rgb(useColor(idxCycle)));
        hold on
        plot([-0.5 15.5], [dPrimeBaselineTheshold dPrimeBaselineTheshold], ':k')
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        %         set(gca,'YTick',[])
        %         set(gca,'YColor','w')
        lab = sprintf('cycle %d', idxCycle);
        ylabel(lab)
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
        axis tight
    end
end

p(2,1,1,1).title('peak amplitude tuning (d prime)');


%% Plot latency tunings per cycle
useColor = {'DimGray', 'DarkGray', 'Silver', 'Gainsboro'};
latencyOdor = zeros(odors, 4);
for idxOdor = odorsRearranged
    appLatency = [];
    appRsp = [];
    appLatency = shank(idxShank).cell(idxUnit).odor(idxOdor).cyclepeakLatency;
    appRsp = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDigital;
    appLatency(appRsp<1) = 0;
    latencyOdor(idxOdor,:) = appLatency(1:4);
end
latencyOdor = latencyOdor';

for idxCycle = 1:4
    if idxCycle == 4
        p(2,1,idxCycle,2).select(); 
        bar(latencyOdor(idxCycle,:), 1, 'FaceColor', rgb(useColor(idxCycle)));
%         set(gca,'YTick',[])
%         set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
        axis tight
        ylim([0 300])
    else
        p(2,1,idxCycle,2).select(); 
        bar(latencyOdor(idxCycle,:), 1, 'FaceColor', rgb(useColor(idxCycle)));
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
%         set(gca,'YTick',[])
%         set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
        axis tight
        ylim([0 300])
    end
end

p(2,1,1,2).title('peak latency tuning (ms)');


%% Plot signal correlations
% for idxOdor = 1:odors
%     app = [];
%     appCycle = [];
%     app = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial;
%     for idxCycle = 1:10
%         appCycle = app(:,idxCycle)';
%         bigMatrix(idxOdor, 1 + (idxCycle-1)*n_trials : idxCycle*n_trials) = appCycle;
%     end
% end
% distanceMatrix = pdist(bigMatrix);
% distanceMatrix = squareform(distanceMatrix);
% p(2,2,1).select();
% imagesc(distanceMatrix)
% axis square, axis off



%% Plot rose plot of phases

baselinePhases = shank(idxShank).cell(idxUnit).allBaselineSpikes;
responsePhases = shank(idxShank).cell(idxUnit).allResponseSpikes;
if isempty(baselinePhases)
    baselinePhases = 0;
end
if isempty(responsePhases)
    responsePhases = 0;
end
p(2,2,1).select(); 
rose(baselinePhases)
hold on
rose(responsePhases)
legend('air','odor')
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

p(2,2,1).title('spike phase distributions');

%% Plot autocorrelogram

p(2,2,2).select(); 
cross = shank(idxShank).cell(idxUnit).autocorrelogram;
lags = shank(idxShank).cell(idxUnit).autocorrelogramLags;
plot(lags,cross,'k','linewidth', 2);
xlim([-5,5])
xlabel('lag (s)')
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
set(gca,'YTick',[])
set(gca,'YColor','w')
axis tight
p(2,2,2).title('autocorrelogram');
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');







%%  Finalize figure


p.de.margin = 6;
p.margin = [8 6 4 6];
p(2).marginleft = 25;
p(2,1,1,2).marginleft = 15;
p(2,1,2,2).marginleft = 15;
p(2,1,3,2).marginleft = 15;
p(2,1,4,2).marginleft = 15;
p(2,2,2).marginleft = 15;
p(2,1).marginbottom = 20;
p.select('all');

set(gcf,'color','white', 'PaperPositionMode', 'auto');
%saveas(gcf,fullfile(toFolder,titolo),'png')

%p.export(titolo);

