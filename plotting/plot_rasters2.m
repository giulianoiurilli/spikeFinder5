function plot_rasters2(tetrodes)


MarkerFormat.MarkerSize = 5;
% for i=1:3
%     stringa = sprintf('ACC%d.mat', i);
%     load(stringa);
%     up_Acc_Samples(i,:) = Acc_Samples; 
% end


k=1;
z=1;
keep=[];

keep_separated = 1;

if keep_separated == 1
    
    for i=1:length(tetrodes)
        stringa = sprintf('cd t%d', i);
        eval(stringa)
        load('spikes.mat');
        
        
        for j = 1:size(spikes.labels,1)
            if ~isempty(find(spikes.labels(j,2) == 2))
                sua{k} = spikes.spiketimes(find(spikes.assigns == spikes.labels(j, 1)));
                k=k+1;
            end
%             if ~isempty(find(spikes.labels(j,2) == 3))
%                 mua{z} = spikes.spiketimes(find(spikes.assigns == spikes.labels(j, 1)));
%                 z=z+1;
%             end
        end
        clear spikes
        cd ..
    end
    
    figure
    
    %plotSpikeRaster(unit_spikes,'PlotType','scatter', 'MarkerFormat', MarkerFormat,'XLimForCell',[0 1800]);
    plotSpikeRaster(sua,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[0 1800]);
    xlabel('Time (s)');
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
    ylabel('Units');
    
    
%     figure
%     
%     
%     plotSpikeRaster(mua,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[0 1200]);
%     xlabel('Time (s)');
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
%     ylabel('Units');
    
else
 for i=1:length(tetrodes)
        stringa = sprintf('cd t%d', i);
        eval(stringa)
        load('spikes.mat');
        
        
        for j = 1:size(spikes.labels,1)
            if ~isempty(find(spikes.labels(j,2) == 2)) | ~isempty(find(spikes.labels(j,2) == 3))
                sua{k} = spikes.spiketimes(find(spikes.assigns == spikes.labels(j, 1)));
                k=k+1;
            end
        end
        clear spikes
        cd ..
 end
end
 
 figure
    
    %plotSpikeRaster(unit_spikes,'PlotType','scatter', 'MarkerFormat', MarkerFormat,'XLimForCell',[0 1800]);
    plotSpikeRaster(sua,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[0 1800]);
    xlabel('Time (s)');
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
    ylabel('Units');
    
    save('all_sua_spiketimes.mat', 'sua');
    
    
   
    edges_1ms_app = [1690:0.005:1730];
    edges_10ms_app = [1690:0.01:1730];
    edges_100ms_app = [1690:.2:1730];
    
    edges_1ms = [0:0.005:1800];
    edges_10ms = [0:0.01:1800];
    edges_100ms = [0:.2:1800];
    
  
    for i = 1:length(sua)
        sua_app = sua{i}(find(sua{i}>= 1690 & sua{i}<= 1730));
        psth_1ms_app(i,:) = histc(sua_app,edges_1ms_app)';
        psth_10ms_app(i,:) = histc(sua_app,edges_10ms_app)';
        psth_100ms_app(i,:) = histc(sua_app,edges_100ms_app)';
        psth_1ms(i,:) = histc(sua{i},edges_1ms)';
        sigma = .05;
        edges1=[-3*sigma:.005:3*sigma];
        kernel = normpdf(edges1,0,sigma);
        kernel = kernel*.005;
        psth_1ms_app1(i,:)=conv(psth_1ms(i,:),kernel);
        center = ceil(length(edges1)/2);
        psth_1ms(i,:) = psth_1ms_app1(i,center:length(psth_1ms(i,:))+center-1);
        
        psth_10ms(i,:) = histc(sua{i},edges_10ms)';
        clear edges1;clear kernel; 
        sigma = .1;
        edges1=[-3*sigma:.01:3*sigma];
        kernel = normpdf(edges1,0,sigma);
        kernel = kernel*.01;
        psth_10ms_app1(i,:)=conv(psth_10ms(i,:),kernel);
        center = ceil(length(edges1)/2);
        psth_10ms(i,:) = psth_10ms_app1(i,center:length(psth_10ms(i,:))+center-1);
        
        psth_100ms(i,:) = histc(sua{i},edges_100ms)';
        clear edges1;clear kernel;
        sigma = .5;
        edges1=[-3*sigma:.2:3*sigma];
        kernel = normpdf(edges1,0,sigma);
        kernel = kernel*.2;
        psth_100ms_app1(i,:)=conv(psth_100ms(i,:),kernel);
        center = ceil(length(edges1)/2);
        psth_100ms(i,:) = psth_100ms_app1(i,center:length(psth_100ms(i,:))+center-1);
    end
%     figure, imagesc(edges_10ms, units, psth_10ms), colormap('bone')
%         xlabel('Time (s)');
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
%     ylabel('Units');
    
%     
%     psth_1ms(6,:)=[];
%     psth_10ms(6,:)=[];
%     psth_100ms(6,:)=[];
%         psth_1ms(10,:)=[];
%     psth_10ms(10,:)=[];
%     psth_100ms(10,:)=[];
%     
%     
%     sigma = .1;
%     edges=[-3*sigma:.001:3*sigma];
%     kernel = normpdf(edges,0,sigma);
%     kernel = kernel*.001;
%     for i=1:size(psth_1ms,1)
%     s_1ms(i,:)=conv(psth_1ms(i,:),kernel);
%     end
%     
%     figure, imagesc(s_1ms)
    
    
    
    
    
    
    
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
    save('assembly.mat', 'edges_1ms', 'activities_1ms');
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
    save('assembly.mat', 'edges_10ms', 'activities_10ms','-append');
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
    save('assembly.mat', 'edges_100ms', 'activities_100ms','-append');
        figure,
    for i = 1:size(assemblies_100ms,2)
        subplot(size(assemblies_100ms,2),1,i), stem(assemblies_100ms(:,i))
    end
%     
%         assemblies_1ms1 = assembly_patterns(s_1ms, opts);
%     activities_1ms1 = assembly_activity(assemblies_1ms1, s_1ms);
%     figure, 
%     for i = 1:size(activities_1ms1,1)
%         subplot(size(activities_1ms1,1),1,i)
%         plot(activities_1ms1(i,:))
%     end
%         figure,
%     for i = 1:size(assemblies_1ms1,2)
%         subplot(size(assemblies_1ms1,2),1,i), stem(assemblies_1ms1(:,i))
%     end
    
   
end
