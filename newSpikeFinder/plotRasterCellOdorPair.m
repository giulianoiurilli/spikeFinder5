function plotRasterCellOdorPair(espe, specs)


idxExp = specs(1);
idxShank = specs(2);
idxUnit = specs(3);
idxOdor = specs(4);


useColorOnset = [51,160,44]./255;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[440 660 560 140]);
t = -4:0.001:6;
t(end) = [];
for idxTrial = 1:10
    app = [];
    app = double(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:)));
    app1=[];
    app1 = find(app==1);
    app1 = (app1./1000) - 4;
    A.spikes{idxTrial} = app1;
end

plotSpikeRaster(A.spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 6]);
line([0 0], [0 11], 'Color', useColorOnset)
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'FontName','Helvetica','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');