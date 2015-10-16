idxShank = 4;
idxUnit = 3;


odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];

useColorOnset = 'ForestGreen';

Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);

p.pack('h',{50 50});

p(1).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});
p(2).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});

idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(1,idxPlot).select();
        plotSpikeRaster(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeTimesTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-1 3]);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        %ylabel(listOdors(idxPlot))
%         set(gca, 'XTick' , rasterTicks);
%         set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxPlot).select();
        plotSpikeRaster(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeTimesTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-1 3] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        %ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end


idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(2,idxPlot).select();
        plotSpikeRaster(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeTimesTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-0.4 0.4]);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        %ylabel(listOdors(idxPlot))
%         set(gca, 'XTick' , rasterTicks);
%         set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(2,idxPlot).select();
        plotSpikeRaster(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeTimesTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-0.4 0.4] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        %ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

%p.de.margin = 1;
p.margin = [8 6 4 6];
%p(1).marginright = 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');


figure; sniff = squeeze(breath(1:5,20*(14550:16000),14));
xtime = -450:1000;
hold on
for i = 1:5
    plot(xtime, sniff(i,:) - (i-1)*1.2, 'k', 'linewidth', 2); axis tight
end
xlabel('ms');
ymax = get(gca, 'YLim');
plot([0 0], ymax, 'r', 'linewidth', 2);
hold off
title('Sniffs');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
set(gca,'YTick',[])
set(gcf,'Color','w')