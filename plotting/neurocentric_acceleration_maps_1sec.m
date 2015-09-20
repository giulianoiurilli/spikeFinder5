
clear all; close all;
load('accData.mat');
%% Spike Map


tetrode = 5;
unit = 1;

string = sprintf('tetrode%d_spikes.mat', tetrode);
load(string);


%h = fspecial('gaussian', [10 10]); 

spike = round(index(find(tetrodes_clusters{tetrode} == unit))./50);


spike_1s = spike;
spike_20s = spike;


%Simulation by re-shuffling spikes

%Save outer ~1 seconds for delay finding
spike_20s(spike_20s > (length(acc_up) - 400000)) = [];
shuff_spike_20s = repmat(spike_20s,100,1);                                          %create spiketimes for 100 simulated neurons
rng('default');
shift = 399999 + randi(length(acc_up)-400000, 100, 1); 
shuff_spike_20s = bsxfun(@plus, shuff_spike_20s, shift);                            %shift time-shift their spiketimes by a random number of ms in a range from 20s  to total recording time - 20s

acc_up_sim_20s = repmat(acc_up, 1, 2);

shift = [];


%Save outer ~1 seconds for delay finding
spike_1s(spike > (length(acc_up) - 21000)) = [];
spike_1s(spike < 21000) = [];

%Save outer ~1 seconds for delay finding
% spike_20s(spike > (length(acc_up) - 400000)) = [];

%Simulation with a Poisson neuron
n_spikes = numel(spike);
totalTime = spike(end)/20;
poisson_spike = poisson_neuron(n_spikes, totalTime) .* 20;


%Simulation by re-shuffling spikes

shuff_spike_1s = repmat(spike_1s,201,1);                                          %create spiketimes for 100 simulated neurons
rng('default');
shift = -10000:100:10000;
shuff_spike_1s = bsxfun(@plus, shuff_spike_1s, shift');                            %shift time-shift their spiketimes by a random number of ms in a range from 20s  to total recording time - 20s

acc_up_sim = acc_up;









for k = 1:3
    acc_spikes(k,:) = acc_up(k,spike);                                      %Find the acceleration recorded at each spike
    acc_spikes_sim(k,:) = acc_up_sim(k,poisson_spike);        %Find the acceleration recorded at each spike for a random, simulated neuron
end

acc_spikes = acc_spikes';
acc_spikes_sim = acc_spikes_sim';

x_y_spikes_map = hist3(acc_spikes(:,[1 2]), 'Edges', edges);                %Bin to generate spike maps
x_z_spikes_map = hist3(acc_spikes(:,[1 3]), 'Edges', edges);
y_z_spikes_map = hist3(acc_spikes(:,[2 3]), 'Edges', edges);

x_y_spikes_map_f = filter2(h, x_y_spikes_map);                                %Smooth spike maps
x_z_spikes_map_f = filter2(h, x_z_spikes_map);
y_z_spikes_map_f = filter2(h, y_z_spikes_map);


x_y_spikes_map_sim = hist3(acc_spikes_sim(:,[1 2]), 'Edges', edges);                %Bin to generate spike maps
x_z_spikes_map_sim = hist3(acc_spikes_sim(:,[1 3]), 'Edges', edges);
y_z_spikes_map_sim = hist3(acc_spikes_sim(:,[2 3]), 'Edges', edges);

x_y_spikes_map_sim_f = filter2(h, x_y_spikes_map_sim);                                %Smooth spike maps
x_z_spikes_map_sim_f = filter2(h, x_z_spikes_map_sim);
y_z_spikes_map_sim_f = filter2(h, y_z_spikes_map_sim);





%% Egocentric acceleration spike maps


x_y_map(find(x_y_map < 2000)) = NaN;                                         %Discard bins occupied for less than 100 ms
x_y_spikes_map_f(find(x_y_map < 2000)) = NaN;
x_y_spikes_map_sim_f(find(x_y_map < 2000)) = NaN;
x_z_map(find(x_z_map < 2000)) = NaN;
x_z_spikes_map_f(find(x_z_map < 2000)) = NaN;
x_z_spikes_map_sim_f(find(x_z_map < 2000)) = NaN;
y_z_map(find(y_z_map < 2000)) = NaN;
y_z_spikes_map_f(find(y_z_map < 2000)) = NaN;
y_z_spikes_map_sim_f(find(y_z_map < 2000)) = NaN;




acc_spikes_map_x_y = x_y_spikes_map_f ./ (x_y_map./20000);                             %Generate acceleration-spike maps
acc_spikes_map_x_z = x_z_spikes_map_f  ./ (x_z_map./20000);
acc_spikes_map_y_z = y_z_spikes_map_f ./ (y_z_map./20000); 


acc_spikes_map_x_y_f = filter2(h, acc_spikes_map_x_y);
acc_spikes_map_x_z_f = filter2(h, acc_spikes_map_x_z);
acc_spikes_map_y_z_f = filter2(h, acc_spikes_map_y_z);




acc_spikes_map_x_y_sim = x_y_spikes_map_sim_f ./ (x_y_map./20000);                             %Generate acceleration-spike maps
acc_spikes_map_x_z_sim = x_z_spikes_map_sim_f  ./ (x_z_map./20000); 
acc_spikes_map_y_z_sim = y_z_spikes_map_sim_f ./ (y_z_map./20000); 


acc_spikes_map_x_y_sim_f = filter2(h, acc_spikes_map_x_y_sim);
acc_spikes_map_x_z_sim_f = filter2(h, acc_spikes_map_x_z_sim);
acc_spikes_map_y_z_sim_f = filter2(h, acc_spikes_map_y_z_sim);


%% Plot

range = [0 10];

f1 = figure;

subplot(3,3,1); imagesc(edges{1}, edges{2}, x_y_map);colormap('hot'); xlabel('backward-forward'); ylabel('down-up'); colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,2); imagesc(edges{1}, edges{2}, acc_spikes_map_x_y_sim_f, range);colormap('hot'); xlabel('backward-forward'); ylabel('down-up');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,3); imagesc(edges{1}, edges{2}, acc_spikes_map_x_y_f, range); colormap('hot');  xlabel('backward-forward'); ylabel('down-up');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,4); imagesc(edges{1}, edges{2}, x_z_map);colormap('hot'); xlabel('backward-forward'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,5); imagesc(edges{1}, edges{2}, acc_spikes_map_x_z_sim_f, range);colormap('hot');  xlabel('backward-forward'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,6); imagesc(edges{1}, edges{2},acc_spikes_map_x_z_f, range); colormap('hot');  xlabel('backward-forward'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,7); imagesc(edges{1}, edges{2}, y_z_map);colormap('hot'); xlabel('down-up'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,8); imagesc(edges{1}, edges{2}, acc_spikes_map_y_z_sim_f, range);colormap('hot');  xlabel('down-up'); ylabel('left-right'); colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
subplot(3,3,9);imagesc(edges{1}, edges{2},acc_spikes_map_y_z_f, range);  colormap('hot');  xlabel('down-up'); ylabel('left-right');colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out')
set(f1,'color','white', 'PaperPositionMode', 'auto'); 


acc_spikes_sim = [];
x_y_spikes_map_sim = [];
x_z_spikes_map_sim = [];
y_z_spikes_map_sim = [];
acc_spikes_map_x_y_sim = [];
acc_spikes_map_x_z_sim = [];
acc_spikes_map_y_z_sim = [];


for i = 1:201
    
   acc_spikes_sim = [];

    
   for k = 1:3
       acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike_1s(i,:));        %Find the acceleration recorded at each spike for a random, simulated neuron
   end
   
   acc_spikes_sim = acc_spikes_sim';
   
   x_y_spikes_map_sim = hist3(acc_spikes_sim(:,[1 2]), 'Edges', edges);                %Bin to generate spike maps
   x_z_spikes_map_sim = hist3(acc_spikes_sim(:,[1 3]), 'Edges', edges);
   y_z_spikes_map_sim = hist3(acc_spikes_sim(:,[2 3]), 'Edges', edges);
   
   %     x_y_spikes_map_sim = filter2(h, x_y_spikes_map_sim);
   %     x_z_spikes_map_sim = filter2(h, x_z_spikes_map_sim);
   %     y_z_spikes_map_sim = filter2(h, y_z_spikes_map_sim);
   %
   %
   x_y_spikes_map_sim(find(x_y_map < 2000)) = NaN;
   x_z_spikes_map_sim(find(x_z_map < 2000)) = NaN;
   y_z_spikes_map_sim(find(y_z_map < 2000)) = NaN;

   %
   acc_spikes_map_x_y_sim = x_y_spikes_map_sim ./ (x_y_map./20000);
   acc_spikes_map_x_z_sim = x_z_spikes_map_sim  ./ (x_z_map./20000);
   acc_spikes_map_y_z_sim = y_z_spikes_map_sim ./ (y_z_map./20000);
   
   app2_xy = acc_spikes_map_x_y_sim(~isnan(acc_spikes_map_x_y_sim));
   app2_xz = acc_spikes_map_x_z_sim(~isnan(acc_spikes_map_x_z_sim));
   app2_yz = acc_spikes_map_y_z_sim(~isnan(acc_spikes_map_y_z_sim));
   
   app1_x_y_map = x_y_map(~isnan(x_y_map));
   app1_x_z_map = x_z_map(~isnan(x_z_map));
   app1_y_z_map = y_z_map(~isnan(y_z_map));

   %
   %     acc_spikes_map_x_y_sim = filter2(h, acc_spikes_map_x_y_sim);
   %     acc_spikes_map_x_z_sim = filter2(h, acc_spikes_map_x_z_sim);
   %     acc_spikes_map_y_z_sim = filter2(h, acc_spikes_map_y_z_sim);
   %
   mi_xy(i) = numel(find(app2_xy == 0));
   mi_xz(i) = numel(find(app2_xz == 0));
   mi_yz(i) = numel(find(app2_yz == 0));
   
%    mi_xy(i) = mutualinfo(app1_x_y_map(:),app2_xy(:));
%    mi_xz(i) = mutualinfo(app1_x_z_map(:),app2_xz(:));
%    mi_yz(i) = mutualinfo(app1_y_z_map(:),app2_yz(:));
   
end



f2=figure(2);


rank_xy = sort(mi_xy,'descend');
for i=1:3
    index = find(mi_xy==rank_xy(i));
    acc_spikes_sim = [];
    for k = 1:3
        acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike_1s(index(1),:));        %Find the acceleration recorded at each spike for a random, simulated neuron
    end
    acc_spikes_sim = acc_spikes_sim';
    x_y_spikes_map_sim = hist3(acc_spikes_sim(:,[1 2]), 'Edges', edges);
    x_y_spikes_map_sim = filter2(h, x_y_spikes_map_sim);
    x_y_spikes_map_sim(find(x_y_map < 2000)) = NaN;
    acc_spikes_map_x_y_sim = x_y_spikes_map_sim ./ (x_y_map./20000);
    acc_spikes_map_x_y_sim = filter2(h, acc_spikes_map_x_y_sim);
    string = sprintf('delay: %d ms', - shift(index) / 20);
    
    subplot(3,3,i); imagesc(edges{1}, edges{2}, acc_spikes_map_x_y_sim, range);colormap('hot'); xlabel('backward-forward'); ylabel('down-up'); title(string); colorbar;
    set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out');
end



rank_xz = sort(mi_xz,'descend');
for i=1:3
    index = find(mi_xz==rank_xz(i));
    acc_spikes_sim = [];
    for k = 1:3
        acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike_1s(index(1),:));        %Find the acceleration recorded at each spike for a random, simulated neuron
    end
    acc_spikes_sim = acc_spikes_sim';
    x_z_spikes_map_sim = hist3(acc_spikes_sim(:,[1 3]), 'Edges', edges);
    x_z_spikes_map_sim = filter2(h, x_z_spikes_map_sim);
    x_z_spikes_map_sim(find(x_z_map < 2000)) = NaN;
    acc_spikes_map_x_z_sim = x_z_spikes_map_sim ./ (x_z_map./20000);
    acc_spikes_map_x_z_sim = filter2(h, acc_spikes_map_x_z_sim);
    string = sprintf('delay: %d ms', - shift(index) / 20);
    
    subplot(3,3,i + 3); imagesc(edges{1}, edges{2}, acc_spikes_map_x_z_sim, range);colormap('hot'); xlabel('backward-forward'); ylabel('down-up'); title(string); colorbar;
    set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out');
end




rank_yz = sort(mi_yz,'descend');
for i=1:3
    index = find(mi_yz==rank_yz(i));
    acc_spikes_sim = [];
    for k = 1:3
        acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike_1s(index(1),:));        %Find the acceleration recorded at each spike for a random, simulated neuron
    end
    acc_spikes_sim = acc_spikes_sim';
    y_z_spikes_map_sim = hist3(acc_spikes_sim(:,[2 3]), 'Edges', edges);
    y_z_spikes_map_sim = filter2(h, y_z_spikes_map_sim);
    y_z_spikes_map_sim(find(y_z_map < 2000)) = NaN;
    acc_spikes_map_y_z_sim = y_z_spikes_map_sim ./ (y_z_map./20000);
    acc_spikes_map_y_z_sim = filter2(h, acc_spikes_map_y_z_sim);
    string = sprintf('delay: %d ms', - shift(index) / 20);
    
    subplot(3,3,i + 6); imagesc(edges{1}, edges{2}, acc_spikes_map_y_z_sim, range);colormap('hot'); xlabel('backward-forward'); ylabel('down-up'); title(string); colorbar;
    set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out');
end

set(f2,'color','white', 'PaperPositionMode', 'auto');


acc_spikes_sim = [];
x_y_spikes_map_sim = [];
x_z_spikes_map_sim = [];
y_z_spikes_map_sim = [];
acc_spikes_map_x_y_sim = [];
acc_spikes_map_x_z_sim = [];
acc_spikes_map_y_z_sim = [];
app2_xy = [];
app2_xz = [];
app2_yz = [];

app1_x_y_map = [];
app1_x_z_map = [];
app1_y_z_map = [];



for i = 1:100
    
   acc_spikes_sim = [];

    
   for k = 1:3
       acc_spikes_sim(k,:) = acc_up_sim_20s(k,shuff_spike_20s(i,:));        %Find the acceleration recorded at each spike for a random, simulated neuron
   end
   
   acc_spikes_sim = acc_spikes_sim';
   
   x_y_spikes_map_sim = hist3(acc_spikes_sim(:,[1 2]), 'Edges', edges);                %Bin to generate spike maps
   x_z_spikes_map_sim = hist3(acc_spikes_sim(:,[1 3]), 'Edges', edges);
   y_z_spikes_map_sim = hist3(acc_spikes_sim(:,[2 3]), 'Edges', edges);
   
   %     x_y_spikes_map_sim = filter2(h, x_y_spikes_map_sim);
   %     x_z_spikes_map_sim = filter2(h, x_z_spikes_map_sim);
   %     y_z_spikes_map_sim = filter2(h, y_z_spikes_map_sim);
   %
   %
   x_y_spikes_map_sim(find(x_y_map < 2000)) = NaN;
   x_z_spikes_map_sim(find(x_z_map < 2000)) = NaN;
   y_z_spikes_map_sim(find(y_z_map < 2000)) = NaN;

   %
   acc_spikes_map_x_y_sim = x_y_spikes_map_sim ./ (x_y_map./20000);
   acc_spikes_map_x_z_sim = x_z_spikes_map_sim  ./ (x_z_map./20000);
   acc_spikes_map_y_z_sim = y_z_spikes_map_sim ./ (y_z_map./20000);
   
   app2_xy = acc_spikes_map_x_y_sim(~isnan(acc_spikes_map_x_y_sim));
   app2_xz = acc_spikes_map_x_z_sim(~isnan(acc_spikes_map_x_z_sim));
   app2_yz = acc_spikes_map_y_z_sim(~isnan(acc_spikes_map_y_z_sim));
   
   app1_x_y_map = x_y_map(~isnan(x_y_map));
   app1_x_z_map = x_z_map(~isnan(x_z_map));
   app1_y_z_map = y_z_map(~isnan(y_z_map));

   %
   %     acc_spikes_map_x_y_sim = filter2(h, acc_spikes_map_x_y_sim);
   %     acc_spikes_map_x_z_sim = filter2(h, acc_spikes_map_x_z_sim);
   %     acc_spikes_map_y_z_sim = filter2(h, acc_spikes_map_y_z_sim);
   %
   mi_xy(i) = numel(find(app2_xy == 0));
   mi_xz(i) = numel(find(app2_xz == 0));
   mi_yz(i) = numel(find(app2_yz == 0));
%    
%    mi_xy(i) = mutualinfo(app1_x_y_map(:),app2_xy(:));
%    mi_xz(i) = mutualinfo(app1_x_z_map(:),app2_xz(:));
%    mi_yz(i) = mutualinfo(app1_y_z_map(:),app2_yz(:));
   
end


figure
subplot(3,1,1)
hist(mi_xy, 50)
subplot(3,1,2)
hist(mi_xz, 50)
subplot(3,1,3)
hist(mi_yz, 50)

