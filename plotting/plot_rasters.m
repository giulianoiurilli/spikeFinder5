function plot_rasters

ciccio = 'matlabData.mat';
load(ciccio);
MarkerFormat.MarkerSize = 5;
% for i=1:3
%     stringa = sprintf('ACC%d.mat', i);
%     load(stringa);
%     up_Acc_Samples(i,:) = Acc_Samples; 
% end


k=1;
keep=[];
for i=1:length(tetrodes)
    stringa = sprintf('tetrode%d_spikes.mat', i);
    load(stringa);
    keep = clustersToKeep{i};
    clusters = tetrodes_clusters{i};
    for j = keep
        unit_spikes{k} = index(find(clusters==j))/1000000;
        k=k+1;
    end
    keep=[];
end

figure

%plotSpikeRaster(unit_spikes,'PlotType','scatter', 'MarkerFormat', MarkerFormat,'XLimForCell',[0 1500]);
plotSpikeRaster(unit_spikes,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[0 1500]);
xlabel('Time (s)');  
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
ylabel('Units');


% figure(2)
% 
% good_units = [1 2 4 6 8];
% for z=1:length(good_units)
%     app{z} = unit_spikes{good_units(z)};
% end
% 
% %subplot(2,1,1)
% plotSpikeRaster(app,'PlotType','scatter', 'MarkerFormat', MarkerFormat, 'XLimForCell',[0 1500]);
% subplot(2,1,2)
% plot(filt_Acc_Samples(3,1:1500*5000));
% subplot(4,1,3)
% plot(filt_Acc_Samples(2,1:1500*5000));
% subplot(4,1,4)
% plot(filt_Acc_Samples(3,1:1500*5000));




    