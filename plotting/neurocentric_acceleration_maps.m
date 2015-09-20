
clear all; close all;
load('accData.mat');
%% Spike Map


tetrode = 2;
unit = 1;

string = sprintf('tetrode%d_spikes.mat', tetrode);
load(string);


%h = fspecial('gaussian', [10 10]); 

spike = round(index(find(tetrodes_clusters{tetrode} == unit))./50);






%Save last 20 seconds for re-suffling
spike(spike > (length(acc_up) - 400000)) = [];

%Simulation with a Poisson neuron
n_spikes = numel(spike);
totalTime = spike(end)/20;
poisson_spike = poisson_neuron(n_spikes, totalTime) .* 20;


%Simulation by re-shuffling spikes

shuff_spike = repmat(spike,100,1);                                          %create spiketimes for 100 simulated neurons
rng('default');
shift = 399999 + randi(length(acc_up)-400000, 100, 1); 
shuff_spike = bsxfun(@plus, shuff_spike, shift);                            %shift time-shift their spiketimes by a random number of ms in a range from 20s  to total recording time - 20s

acc_up_sim = repmat(acc_up, 1, 2);









for k = 1:3
    acc_spikes(k,:) = acc_up(k,spike);                                      %Find the acceleration recorded at each spike
    acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike(randi(100,1),:));        %Find the acceleration recorded at each spike for a random, simulated neuron
end

acc_spikes = acc_spikes';
acc_spikes_sim = acc_spikes_sim';

x_y_spikes_map = hist3(acc_spikes(:,[1 2]), 'Edges', edges);                %Bin to generate spike maps
x_z_spikes_map = hist3(acc_spikes(:,[1 3]), 'Edges', edges);
y_z_spikes_map = hist3(acc_spikes(:,[2 3]), 'Edges', edges);

x_y_spikes_map = filter2(h, x_y_spikes_map);                                %Smooth spike maps
x_z_spikes_map = filter2(h, x_z_spikes_map);
y_z_spikes_map = filter2(h, y_z_spikes_map);


x_y_spikes_map_sim = hist3(acc_spikes_sim(:,[1 2]), 'Edges', edges);                %Bin to generate spike maps
x_z_spikes_map_sim = hist3(acc_spikes_sim(:,[1 3]), 'Edges', edges);
y_z_spikes_map_sim = hist3(acc_spikes_sim(:,[2 3]), 'Edges', edges);

x_y_spikes_map_sim = filter2(h, x_y_spikes_map_sim);                                %Smooth spike maps
x_z_spikes_map_sim = filter2(h, x_z_spikes_map_sim);
y_z_spikes_map_sim = filter2(h, y_z_spikes_map_sim);





%% Egocentric acceleration spike maps


mask_x_y(find(x_y_map < 2000)) = 0;                                         %Discard bins occupied for less than 100 ms
x_y_spikes_map(find(x_y_map < 2000)) = 0;
x_y_spikes_map_sim(find(x_y_map < 2000)) = 0;
mask_x_z(find(x_z_map < 2000)) = 0;
x_z_spikes_map(find(x_z_map < 2000)) = 0;
x_z_spikes_map_sim(find(x_z_map < 2000)) = 0;
mask_y_z(find(y_z_map < 2000)) = 0;
y_z_spikes_map(find(y_z_map < 2000)) = 0;
y_z_spikes_map_sim(find(y_z_map < 2000)) = 0;


acc_spikes_map_x_y = x_y_spikes_map ./ (x_y_map./20000);                             %Generate acceleration-spike maps
acc_spikes_map_x_y = filter2(h, acc_spikes_map_x_y);
acc_spikes_map_x_z = x_z_spikes_map  ./ (x_z_map./20000);
acc_spikes_map_x_z = filter2(h, acc_spikes_map_x_z);
acc_spikes_map_y_z = y_z_spikes_map ./ (y_z_map./20000); 
acc_spikes_map_y_z = filter2(h, acc_spikes_map_y_z);

weight = ones(5,5)./25;
    m_acc_spikes_map_x_y = moransI(acc_spikes_map_x_y,weight,'true');
    m_acc_spikes_map_x_z = moransI(acc_spikes_map_x_z,weight,'true');
    m_acc_spikes_map_y_z = moransI(acc_spikes_map_y_z,weight,'true');
    
    m_xy = nansum(m_acc_spikes_map_x_y(:));
    m_xz = nansum(m_acc_spikes_map_x_z(:));
    m_yz = nansum(m_acc_spikes_map_y_z(:));



acc_spikes_map_x_y_sim = x_y_spikes_map_sim ./ (x_y_map./20000);                             %Generate acceleration-spike maps
acc_spikes_map_x_y_sim = filter2(h, acc_spikes_map_x_y_sim);
acc_spikes_map_x_z_sim = x_z_spikes_map_sim  ./ (x_z_map./20000); 
acc_spikes_map_x_z_sim = filter2(h, acc_spikes_map_x_z_sim);
acc_spikes_map_y_z_sim = y_z_spikes_map_sim ./ (y_z_map./20000); 
acc_spikes_map_y_z_sim = filter2(h, acc_spikes_map_y_z_sim);

    m_acc_spikes_map_x_y_sim  = moransI(acc_spikes_map_x_y_sim ,weight,'true');
    m_acc_spikes_map_x_z_sim  = moransI(acc_spikes_map_x_z_sim ,weight,'true');
    m_acc_spikes_map_y_z_sim  = moransI(acc_spikes_map_y_z_sim ,weight,'true');
    
    m_xy_sim_1  = nansum(m_acc_spikes_map_x_y_sim (:));
    m_xz_sim  = nansum(m_acc_spikes_map_x_z_sim (:));
    m_yz_sim  = nansum(m_acc_spikes_map_y_z_sim (:));

% maxim_sim = max([max(acc_spikes_map_x_y_sim(:)) max(acc_spikes_map_x_z_sim(:)) max(acc_spikes_map_y_z_sim(:))]);
% maxim = max([max(acc_spikes_map_x_y(:)) max(acc_spikes_map_x_z(:)) max(acc_spikes_map_y_z(:))]);
% 
% 
% 
% 
% 
% acc_spikes_map_x_y_sim = acc_spikes_map_x_y_sim ./ maxim_sim;                             %Generate acceleration-spike maps
% 
% acc_spikes_map_x_z_sim = acc_spikes_map_x_z_sim  ./ maxim_sim; 
% 
% acc_spikes_map_y_z_sim = acc_spikes_map_y_z_sim ./ maxim_sim; 
% 
% acc_spikes_map_x_y = acc_spikes_map_x_y ./ maxim;                             %Generate acceleration-spike maps
% 
% acc_spikes_map_x_z = acc_spikes_map_x_z  ./ maxim; 
% 
% acc_spikes_map_y_z = acc_spikes_map_y_z ./ maxim; 




%% Plot

range = [0 10];

f = figure;

subplot(3,3,1); imagesc(edges{1}, edges{2}, x_y_map);colormap('hot'); xlabel('backward-forward'); ylabel('down-up'); colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,2); imagesc(edges{1}, edges{2}, acc_spikes_map_x_y_sim, range);colormap('hot'); xlabel('backward-forward'); ylabel('down-up');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,3); imagesc(edges{1}, edges{2}, acc_spikes_map_x_y, range); colormap('hot');  xlabel('backward-forward'); ylabel('down-up');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,4); imagesc(edges{1}, edges{2}, x_z_map);colormap('hot'); xlabel('backward-forward'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,5); imagesc(edges{1}, edges{2}, acc_spikes_map_x_z_sim, range);colormap('hot');  xlabel('backward-forward'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,6); imagesc(edges{1}, edges{2},acc_spikes_map_x_z, range); colormap('hot');  xlabel('backward-forward'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,7); imagesc(edges{1}, edges{2}, y_z_map);colormap('hot'); xlabel('down-up'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,8); imagesc(edges{1}, edges{2}, acc_spikes_map_y_z_sim, range);colormap('hot');  xlabel('down-up'); ylabel('left-right'); colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,9);imagesc(edges{1}, edges{2},acc_spikes_map_y_z, range);  colormap('hot');  xlabel('down-up'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
set(f,'color','white', 'PaperPositionMode', 'auto'); 







% [m_xy_sim, m_xz_sim, m_yz_sim, cc_xy, cc_xz, cc_yz] = spat_coherence(shuff_spike, acc_up_sim, edges, x_y_map, x_z_map,y_z_map, h); 








