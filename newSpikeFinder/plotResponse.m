function plotResponse(spikeMatrix, options)

if isempty(options.plotType)
    options.plotType = 'raster';
end

if isempty(options.nTrials)
    options.nTrials = 10;
end

if isempty(options.odors)
    options.odors = 1:size(spikeMatrix,3);
end

if isempty(options.bin)
    options.bin = 100;
end

if isempty(options.sigma)
    options.sigma = 0.1;
end

if isempty(options.onset)
    options.onset = 0;
end

if isempty(options.window)
    options.onset = 0:round(size(spikeMatrix,2)/1000);
end


useColorOnset = 'ForestGreen';

figure
set(gcf,'Position',[302 611 666 418]);

if strcmp(options.plotType, 'raster')
    A = [];
    app = spikeMatrix;
    trialsN = size(app,1);
    odorsN = size(app,3);
    for idxOdor = 1:odorsN
        for idxTrial = 1:trialsN
            app = [];
            app = spikeMatrix(idxTrial,:, idxOdor);
            app1=[];
            app1 = find(app==1);
            app1 = (app1./1000) - options.onset;
            A(idxOdor).spikes{idxTrial} = app1;
        end
    end
    
    idxPlot = 1;
    for idxOdor = odors
        if idxPlot == length(odors)
            subplot(5,3,idxOdor);
            plotSpikeRaster(A(idxOdor).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell', options.window);
            line([0 0], [0 trialsN+1], 'Color', rgb(useColorOnset))
            set(gca,'YTick',[])
            set(gca,'YColor','w')
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
        else
            subplot(5,3,idxOdor);
            plotSpikeRaster(A(idxOdor).spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',options.window);
            line([0 0], [0 trialsN+1], 'Color', rgb(useColorOnset))
            set(gca, 'XTick' , []);
            set(gca, 'XTickLabel', []);
            set(gca,'YTick',[])
            set(gca,'YColor','w')
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
        end
        idxPlot = idxPlot+1;
    end    
else  
    t = options.window(1):0.001:options.window(2);
    t(end-1:end) = [];
    x = nan(length(options.odors),length(t));
    mass = nan(1,length(options.odors));
    mini = nan(1,length(options.odors));
    for idxOdor = options.odors
        spikes = zeros(options.nTrials,length(t));
        for idxTrial = 1:options.nTrials
            spikes(idxTrial,:) = spikeMatrix(idxTrial,(options.onset + options.window(1)) * 1000 : (options.onset + options.window(2)) * 1000, idxOdor);
        end
        x(idxOdor,:) = spikeDensity(nanmean(spikes), options.sigma);
        mass(idxOdor) = max(x(idxOdor,options.onset*1000:options.onset*1000 + 4000));
        mini(idxOdor) = min(x(idxOdor,:));
    end
    minimo = min(mini);
    massimo = max(mass);
    for idxOdor = odors
        subplot(5, 3, idxOdor)
        plot(t,x(idxOdor,:), 'linewidth', 1, 'color', k)
        line([0 0], [minimo massimo], 'Color', rgb(useColorOnset))
        ylim([minimo, massimo])
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
end