  figure
    
    %plotSpikeRaster(unit_spikes,'PlotType','scatter', 'MarkerFormat', MarkerFormat,'XLimForCell',[0 1800]);
    plotSpikeRaster(mua,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[0 1800]);
    xlabel('Time (s)');
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
    ylabel('Units');
    
    
   
    edges_1ms_app = [1690:0.005:1730];
    edges_10ms_app = [1690:0.01:1730];
    edges_100ms_app = [1690:.2:1730];
    
    edges_1ms = [0:0.005:1800];
    edges_10ms = [0:0.01:1800];
    edges_100ms = [0:.2:1800];
    
  
    for i = 1:length(mua)
        mua_app = mua{i}(find(mua{i}>= 1690 & mua{i}<= 1730));
        psth_1ms_app(i,:) = histc(mua_app,edges_1ms_app)';
        psth_10ms_app(i,:) = histc(mua_app,edges_10ms_app)';
        psth_100ms_app(i,:) = histc(mua_app,edges_100ms_app)';
        psth_1ms(i,:) = histc(mua{i},edges_1ms)';
        psth_10ms(i,:) = histc(mua{i},edges_10ms)';
        psth_100ms(i,:) = histc(mua{i},edges_100ms)';
    end


    
    opts.threshold.permutations_percentile = 95;
    opts.threshold.number_of_permutations = 20;
    opts.threshold.method = 'circularshift';
    opts.Patterns.method = 'ICA';
    opts.Patterns.number_of_iterations = 200;
    
    
    assemblies_1ms = assembly_patterns(psth_1ms, opts);
    activities_1ms = assembly_activity(assemblies_1ms, psth_1ms);
    figure, 
    for i = 1:size(activities_1ms,1)
        subplot(size(activities_1ms,1),1,i)
        plot(edges_1ms,activities_1ms(i,:))
    end
        figure,
    for i = 1:size(assemblies_1ms,2)
        subplot(size(assemblies_1ms,2),1,i), stem(assemblies_1ms(:,i))
    end
    
    assemblies_10ms = assembly_patterns(psth_10ms, opts);
    activities_10ms = assembly_activity(assemblies_10ms, psth_10ms);
    figure,
    for i = 1:size(activities_10ms,1)
        subplot(size(activities_10ms,1),1,i)
        plot(edges_10ms,activities_10ms(i,:))
    end
    figure,
    for i = 1:size(assemblies_10ms,2)
        subplot(size(assemblies_10ms,2),1,i), stem(assemblies_10ms(:,i))
    end
    
    assemblies_100ms = assembly_patterns(psth_100ms, opts);
    activities_100ms = assembly_activity(assemblies_100ms, psth_100ms);
    figure,
    for i = 1:size(activities_100ms,1)
        subplot(size(activities_100ms,1),1,i)
        plot(edges_100ms,activities_100ms(i,:))
    end
        figure,
    for i = 1:size(assemblies_100ms,2)
        subplot(size(assemblies_100ms,2),1,i), stem(assemblies_100ms(:,i))
    end
