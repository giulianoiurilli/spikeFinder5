
for idxShank = 1:4
    for idxUnit = 1:length(shankNowarp(idxShank).cell)
        Xfig = 900;
        Yfig = 800;
        figure;
        p = panel();
        set(gcf, 'Position',[1,5,Xfig,Yfig]);
        titolo = sprintf('shank %d, unit %d', idxShank, idxUnit);
        p.pack('h',{50 50});
        
        p(1).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
            1/15 1/15 1/15 1/15 1/15 ...
            1/15 1/15 1/15 1/15 1/15});
        p(2).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
            1/15 1/15 1/15 1/15 1/15 ...
            1/15 1/15 1/15 1/15 1/15});
        idxPlot = 1;
        for idxOdor = 1:odors
            p(1,idxPlot).select();
            plotSpikeRaster(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeTimesTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
                [-3 3]);
            p(1).title(titolo);
            
            p(2,idxPlot).select();
            plot(mean(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:,12000:18000)));
            
            idxPlot = idxPlot+1;
        end
        
        %p.de.margin = 1;
        p.margin = [8 6 4 6];
        %p(1).marginright = 10;
        p(2).marginleft = 30;
        %p(3).marginleft = 10;
        p.select('all');
    end
end