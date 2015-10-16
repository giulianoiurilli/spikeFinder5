function plotCycleRasters(idxShank, idxUnit)

load('parameters.mat')
load('units.mat', 'shank')

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

titolo = sprintf('shank %d, unit %d', idxShank, idxUnit);



Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf,'Position',[-1432 -78 600 800]);



p.pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});
idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(idxPlot).select();
        plotSpikeRaster(shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 11], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(idxPlot))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(idxPlot).select();
        plotSpikeRaster(shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 11], 'Color', rgb(useColorOnset))
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

%p.de.margin = 1;
p.margin = [8 6 4 6];

p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');