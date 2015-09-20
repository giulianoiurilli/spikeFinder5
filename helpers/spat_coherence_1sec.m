function  spat_coherence_1sec(shuff_spike, acc_up_sim, edges, x_y_map, x_z_map,y_z_map,h, shift)





for i = 1:201
    
   
    
    for k = 1:3
        acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike(i,:));        %Find the acceleration recorded at each spike for a random, simulated neuron
    end
    
    acc_spikes_sim = acc_spikes_sim';
    
    x_y_spikes_map_sim = hist3(acc_spikes_sim(:,[1 2]), 'Edges', edges);                %Bin to generate spike maps
    x_z_spikes_map_sim = hist3(acc_spikes_sim(:,[1 3]), 'Edges', edges);
    y_z_spikes_map_sim = hist3(acc_spikes_sim(:,[2 3]), 'Edges', edges);
    
    x_y_spikes_map_sim = filter2(h, x_y_spikes_map_sim);
    x_z_spikes_map_sim = filter2(h, x_z_spikes_map_sim);
    y_z_spikes_map_sim = filter2(h, y_z_spikes_map_sim);
    
    acc_spikes_map_x_y_sim = x_y_spikes_map_sim ./ (x_y_map./20000);
    acc_spikes_map_x_z_sim = x_z_spikes_map_sim  ./ (x_z_map./20000);
    acc_spikes_map_y_z_sim = y_z_spikes_map_sim ./ (y_z_map./20000);
    
    acc_spikes_map_x_y_sim = filter2(h, acc_spikes_map_x_y_sim);
    acc_spikes_map_x_z_sim = filter2(h, acc_spikes_map_x_z_sim);
    acc_spikes_map_y_z_sim = filter2(h, acc_spikes_map_y_z_sim);
    
    empty_xy(i) = numel(find(acc_spikes_map_x_y_sim == 0));
    empty_xz(i) = numel(find(acc_spikes_map_x_z_sim == 0));
    empty_yz(i) = numel(find(acc_spikes_map_y_z_sim == 0));

end




rank_xy = sort(empty_xy, 'descend');
for i=1:3
    for k = 1:3
        acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike(rank_xy(i),:));        %Find the acceleration recorded at each spike for a random, simulated neuron
    end
acc_spikes_sim = acc_spikes_sim';
x_y_spikes_map_sim = hist3(acc_spikes_sim(:,[1 2]), 'Edges', edges); 
x_y_spikes_map_sim = filter2(h, x_y_spikes_map_sim);
acc_spikes_map_x_y_sim = x_y_spikes_map_sim ./ (x_y_map./20000);
acc_spikes_map_x_y_sim = filter2(h, acc_spikes_map_x_y_sim);
string = sprintf('delay: % ms', - shift(rank_xy(i)) / 20);
subplot(3,3,i); imagesc(edges{1}, edges{2}, acc_spikes_map_x_y_sim);colormap('hot'); xlabel('backward-forward'); ylabel('down-up'); title(string); colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out');
end



rank_xz = sort(empty_xz, 'descend');
for i=1:3
    for k = 1:3
        acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike(rank_xz(i),:));        %Find the acceleration recorded at each spike for a random, simulated neuron
    end
acc_spikes_sim = acc_spikes_sim';
x_z_spikes_map_sim = hist3(acc_spikes_sim(:,[1 3]), 'Edges', edges); 
x_z_spikes_map_sim = filter2(h, x_z_spikes_map_sim);
acc_spikes_map_x_z_sim = x_z_spikes_map_sim ./ (x_z_map./20000);
acc_spikes_map_x_z_sim = filter2(h, acc_spikes_map_x_z_sim);
string = sprintf('delay: % ms', - shift(rank_xz(i)) / 20);
subplot(3,3,i + 3); imagesc(edges{1}, edges{2}, acc_spikes_map_x_z_sim);colormap('hot'); xlabel('backward-forward'); ylabel('down-up'); title(string); colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out');
end




rank_yz = sort(empty_yz, 'descend');
for i=1:3
    for k = 1:3
        acc_spikes_sim(k,:) = acc_up_sim(k,shuff_spike(rank_yz(i),:));        %Find the acceleration recorded at each spike for a random, simulated neuron
    end
acc_spikes_sim = acc_spikes_sim';
y_z_spikes_map_sim = hist3(acc_spikes_sim(:,[2 3]), 'Edges', edges); 
y_z_spikes_map_sim = filter2(h, y_z_spikes_map_sim);
acc_spikes_map_y_z_sim = y_z_spikes_map_sim ./ (y_z_map./20000);
acc_spikes_map_y_z_sim = filter2(h, acc_spikes_map_y_z_sim);
string = sprintf('delay: % ms', - shift(rank_yz(i)) / 20);
subplot(3,3,i + 6); imagesc(edges{1}, edges{2}, acc_spikes_map_y_z_sim);colormap('hot'); xlabel('backward-forward'); ylabel('down-up'); title(string); colorbar;
set(gca,'YDir','normal'); set(gca,'dataAspectRatio',[1 1 1],'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out');
end





