function plotRasterResponse(espe,idxExp, idxShank, idxUnit, odorsRearranged)

odorsRearranged = 1:length(odorsRearranged);
A = [];
titolo = sprintf('exp%d, shank %d, unit %d', idxExp, idxShank, idxUnit);
app = espe(1).shankNowarp(1).cell(1).odor(1).spikeMatrix;
trialsN = size(app,1);
for idxOdor = odorsRearranged
    for idxTrial = 1:trialsN
        app = [];
        app = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
        app1=[];
        app1 = find(app==1);
        app1 = (app1./1000) - 15;
        A(idxOdor).spikes{idxTrial} = app1;
    end
end




useColorOnset = 'ForestGreen';
Xfig = 900;
Yfig = 800;
figure;
p = panel();
%set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Position',[302 611 666 418]);

p.pack('h',{50 50});
% 
p(1).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});
p(2).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});
% p(1).pack('v', {1/7 1/7 1/7 1/7 1/7 1/7 1/7});
% p(2).pack('v', {1/7 1/7 1/7 1/7 1/7 1/7 1/7});
% Raster plots
idxPlot = 1;
for idxOdor = 1:length(odorsRearranged)
    if idxPlot == length(odorsRearranged)
        p(1,idxPlot).select();
        plotSpikeRaster(A(idxOdor).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-3 3]);
        line([0 0], [0 trialsN+1], 'Color', rgb(useColorOnset))
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxPlot).select();
        plotSpikeRaster(A(idxOdor).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-3 3]);
        line([0 0], [0 trialsN+1], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(1).title(titolo);

idxPlot = 1;
for idxOdor = 1:length(odorsRearranged)
    if idxPlot == length(odorsRearranged)
        p(2,idxPlot).select();
        plotSpikeRaster(A(idxOdor).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-0.5 0.5]);
        line([0 0], [0 trialsN+1], 'Color', rgb(useColorOnset))
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(2,idxPlot).select();
        plotSpikeRaster(A(idxOdor).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-0.5 0.5]);
        line([0 0], [0 trialsN+1], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(2).title(titolo);


%p.de.margin = 1;
p.margin = [8 6 4 6];
%p(1).marginright = 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');