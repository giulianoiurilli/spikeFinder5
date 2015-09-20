function [m_xy_sim, m_xz_sim, m_yz_sim, cc_xy, cc_xz, cc_yz] = spat_coherence(shuff_spike, acc_up_sim, edges, x_y_map, x_z_map,y_z_map,h)





for i = 1:100
    
   
    acc_spikes_sim = [];
    
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
    
    
        cc_acc_spikes_map_x_y_sim = normxcorr2_general(acc_spikes_map_x_y_sim,acc_spikes_map_x_y_sim);
        cc_acc_spikes_map_x_z_sim = normxcorr2_general(acc_spikes_map_x_z_sim,acc_spikes_map_x_z_sim);
        cc_acc_spikes_map_y_z_sim = normxcorr2_general(acc_spikes_map_y_z_sim,acc_spikes_map_y_z_sim);
    
        cc_xy(i) = mean(cc_acc_spikes_map_x_y_sim(:));
        cc_xz(i) = mean(cc_acc_spikes_map_x_z_sim(:));
        cc_yz(i) = mean(cc_acc_spikes_map_y_z_sim(:));
    
    weight = ones(5,5)./25;
    
    m_acc_spikes_map_x_y_sim  = moransI(acc_spikes_map_x_y_sim ,weight,'true');
    m_acc_spikes_map_x_z_sim  = moransI(acc_spikes_map_x_z_sim ,weight,'true');
    m_acc_spikes_map_y_z_sim  = moransI(acc_spikes_map_y_z_sim ,weight,'true');
    
    m_xy_sim(i)  = nansum(m_acc_spikes_map_x_y_sim (:));
    m_xz_sim(i)  = nansum(m_acc_spikes_map_x_z_sim (:));
    m_yz_sim(i)  = nansum(m_acc_spikes_map_y_z_sim (:));
    
    
end



