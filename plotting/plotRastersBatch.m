


bslWindow = preInhalations * cycleLengthDeg;
odorWindow = 0:postInhalations;
rasterTicks = [-preInhalations :0.5: postInhalations] * 2 * pi; rasterTicks(end) = [];
psthTicks = [0.5 : 2 * (preInhalations + postInhalations) + 0.5]; psthTicks(end) = [];
sdfTicks = [0 : 180 : (preInhalations + postInhalations) * cycleLengthDeg]; %sdfTicks(end) = [];
ciclo = {'i', 'e'}; labels = repmat(ciclo, 1, preInhalations); labels{2 * preInhalations + 1} = '0'; labels{2 * preInhalations + 2} = 'e';
labelsPost = repmat(ciclo, 1, postInhalations - 1); labels = [labels labelsPost];
radTick = [1 cycleLengthDeg];
radLabels={'0','2\pi'};
useColorOnset = 'ForestGreen';

odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
    'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
    'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};


listOdors = {'TMT^-4', 'TMT^-2', 'DMT^-4', 'DMT^-2', 'MT^-4', 'MT^-2',...
    'IBA^-4', 'IBA^-2', 'IAA^-4', 'IAA^-2', 'HXD^-4', 'HXD^-2', 'BTD^-4', 'BTD^-2', 'rose'};
odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];

binSizes = 5:5:cycleLengthDeg;
timePoints = 5:5:cycleLengthDeg;





Xfig = 900;
Yfig = 800;




figure;
titolo = sprintf('shank %d, unit %d', idxShank, idxUnit);
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);

p.pack('h',{50 50});

p(1).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});
p(2).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});


%Find max peak for sdf plot
maxPeak = 0.1;
for idxOdor = odorsRearranged
    maxPeakOdor = max(shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz);
    if maxPeakOdor >= maxPeak
        maxPeak = maxPeakOdor;
    end
end


% Raster plots
idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(1,idxPlot).select();
        plotSpikeRaster(shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(idxPlot))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxPlot).select();
        plotSpikeRaster(shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(1).title(titolo);

idxPlot = 1;
% smoothed PSTHs
for idxOdor = odorsRearranged
    areaColors = {'Moccasin', 'IndianRed'};
    if idxPlot == 15
        p(2,idxPlot).select();
        app = [];
        app = sum(shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz) > 0;
        peakResponse = app > 0;
        app = [];
        app = sum(shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz) > 0;
        countResponse = app > 0;
        app = [];
        app = find(shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMaxHz > 0.75);
        aurocResponse = ~isempty(app);
        sdfMean = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz);
        sdfMeanBsl = sdfMean(1:bslWindow);
        sdfMeanOdor = sdfMean;
        sdfMeanOdor(1:floor(bslWindow)) = 0;
        hold on
        area(sdfMeanBsl, 'FaceColor', rgb(areaColors(1)))
        area(sdfMeanOdor, 'FaceColor',rgb(areaColors(2)))
        axis tight
        ylim([0 maxPeak])
        line([preInhalations * cycleLengthDeg preInhalations * cycleLengthDeg], [0 maxPeak], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick', sdfTicks);
        set(gca, 'XTickLabel', labels);
        %set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylab = sprintf('%d - %d - %d', peakResponse, countResponse, aurocResponse);
        ylabel(ylab)
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(2,idxPlot).select();
        app = [];
        app = sum(shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz(1:4)) > 0;
        peakResponse = app > 0;
        app = [];
        app = sum(shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz(1:4)) > 0;
        countResponse = app > 0;
        app = [];
        app = find(shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMaxHz > 0.75);
        aurocResponse = ~isempty(app);
        sdfMean = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz);
        sdfMeanBsl = sdfMean(1:bslWindow);
        sdfMeanOdor = sdfMean;
        sdfMeanOdor(1:floor(bslWindow)) = 0;
        hold on
        area(sdfMeanBsl, 'FaceColor', rgb(areaColors(1)))
        area(sdfMeanOdor, 'FaceColor',rgb(areaColors(2)))
        axis tight
        ylim([0 maxPeak])
        line([preInhalations * cycleLengthDeg preInhalations * cycleLengthDeg], [0 maxPeak], 'Color', rgb(useColorOnset))
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylab = sprintf('%d - %d - %d', peakResponse, countResponse, aurocResponse);
        ylabel(ylab)
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot + 1;
end
p(2).title('PSTH');






%p.de.margin = 1;
p.margin = [8 6 4 6];
%p(1).marginright = 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');
saveas(gcf,fullfile(toFolder,titolo),'png')

%p.export(titolo);


