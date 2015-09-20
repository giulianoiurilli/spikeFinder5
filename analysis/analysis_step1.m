% clear all
close all
load('units.mat');
clearvars -except shank cartella List ii
load('parameters.mat');
load('breathing.mat');




%fields = {'response_cell_odor_pair', 'delta_bin_response_cell_odor_pair', 'delta_bin_response_cell_odor_pair_trials'};
%shank = rmfield(shank,fields);




timePeak = [];
halfWidthResp = [];
for sha = 1:length(shank)
    for s = 1:length(shank(sha).psth)
        for k = 1:odors
            
            app1_psth = shank(sha).psth{s}(:,:,k);
            shank(sha).baseline_cell_odor_pair{s}(k) = mean(mean(app1_psth(1:pre_bsl/bin_size,:),2));
            shank(sha).std_baseline_cell_odor_pair{s}(k) = std(mean(app1_psth(1:pre_bsl/bin_size,:),2));
            shank(sha).response_cell_odor_pair{s}(:,k) = mean(app1_psth((pre)/bin_size+1:(pre)/bin_size+1+(response_window)/bin_size,:),2); %average response in each bin
            app1 = shank(sha).response_cell_odor_pair{s}(:,k);
            shank(sha).delta_bin_response_cell_odor_pair{s}(:,k) = shank(sha).response_cell_odor_pair{s}(:,k) - shank(sha).baseline_cell_odor_pair{s}(k)' .* ones(size(app1,1),1); %average delta response in each bin
            shank(sha).delta_bin_response_cell_odor_pair_trials{s}(:,:,k) = app1_psth((pre)/bin_size+1:(pre)/bin_size+1+(response_window)/bin_size,:) - shank(sha).baseline_cell_odor_pair{s}(k)' .* ones(size(app1,1),size(app1_psth,2));
            shank(sha).analog_response_intensity{s}(k) = sum(shank(sha).delta_bin_response_cell_odor_pair{s}(:,k) ); %total delta spikes response in the response window
            shank(sha).peak_response_cell_odor_pair{s}(k) = max(shank(sha).delta_bin_response_cell_odor_pair{s}(:,k)); %bin with the max delta response
            
            %             exc_responsive_bins = find(shank(sha).delta_bin_response_cell_odor_pair{s}(:,k) > 2.5 * shank(sha).std_baseline_cell_odor_pair{s}(k));
            %             for bin=1:size(app1,1)
            %                 exc_responsive_bins_trials{bin} = find(shank(sha).delta_bin_response_cell_odor_pair_trials{s}(bin,:,k) > 3 * shank(sha).std_baseline_cell_odor_pair{s}(k));
            %                 nerbt(bin) = numel(exc_responsive_bins_trials{bin}) >= size(app_psth,2)/2;
            %             end
            %             if numel(exc_responsive_bins) >= 2 & sum(nerbt) >1
            %                 shank(sha).excitatory_odors{s}(k) = 1;
            %                 if shank(sha).analog_response_intensity{s}(k) > 0
            %                     shank(sha).exc_analog_response_intensity{s}(k) = shank(sha).analog_response_intensity{s}(k);
            %                 else
            %                     shank(sha).exc_analog_response_intensity{s}(k) = 0;
            %                 end
            %             else
            %                 shank(sha).excitatory_odors{s}(k) = 0;
            %                 shank(sha).exc_analog_response_intensity{s}(k) = 0;
            %             end
            %             exc_responsive_bins = find(shank(sha).delta_bin_response_cell_odor_pair{s}(:,k) > 2.5 * shank(sha).std_baseline_cell_odor_pair{s}(k));
            %             for bin=1:size(app1,1)
            %                 exc_responsive_bins_trials{bin} = find(shank(sha).delta_bin_response_cell_odor_pair_trials{s}(bin,:,k) > 2.5 * shank(sha).std_baseline_cell_odor_pair{s}(k));
            %                 nerbt(bin) = numel(exc_responsive_bins_trials{bin}) >= size(app_psth,2)/2 - 1;
            %             end
            %             if numel(exc_responsive_bins) >= 2 & sum(nerbt) >1
            %                 shank(sha).excitatory_odors_t{s}(k) = 1;
            %                 if shank(sha).analog_response_intensity{s}(k) > 0
            %                     shank(sha).exc_analog_response_intensity_t{s}(k) = shank(sha).analog_response_intensity{s}(k);
            %                 else
            %                     shank(sha).exc_analog_response_intensity_t{s}(k) = 0;
            %                 end
            %             else
            %                 shank(sha).excitatory_odors_t{s}(k) = 0;
            %                 shank(sha).exc_analog_response_intensity_t{s}(k) = 0;
            %             end
            %
            %
            %
            %
            %             inh_responsive_bins = find(shank(sha).delta_bin_response_cell_odor_pair{s}(:,k) < -1.5 * shank(sha).std_baseline_cell_odor_pair{s}(k));
            % %             for bin=1:size(app1,1)
            % %                 inh_responsive_bins_trials{bin} = find(delta_bin_response_cell_odor_pair_trials{s}(bin,:,k) < -1.5 * std_baseline_cell_odor_pair{s}(k));
            % %                 nerbt(bin) = numel(inh_responsive_bins_trials{bin}) > size(app_psth,2)/2;
            % %             end
            %             if  numel(inh_responsive_bins) >= 3 %& sum(nerbt) >=3
            %                 shank(sha).inhibitory_odors{s}(k) = 1;
            %                 if shank(sha).analog_response_intensity{s}(k) < 0
            %                     shank(sha).inh_analog_response_intensity_t{s}(k) = shank(sha).analog_response_intensity{s}(k);
            %                 else
            %                     shank(sha).inh_analog_response_intensity_t{s}(k) = 0;
            %                 end
            %             else
            %                 shank(sha).inhibitory_odors_t{s}(k) = 0;
            %                 shank(sha).inh_analog_response_intensity_t{s}(k) = 0;
            %             end
            
            
            
            
            
            spike_matrix_app = shank(sha).spike_matrix{s}(:,:,k);
            
            startBsl = repmat(pre*1000, n_trials, 1) - shank(sha).bsl_cycle_on{s}(:,k)*1000;
            for trialNumb = 1:n_trials
                splCountBsl(trialNumb) = sum(spike_matrix_app(trialNumb,startBsl:pre_bsl*1000));
            end
            
            a = {splCountBsl sum(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000), 2)'};
            %a = {sum(spike_matrix_app(:,1:pre_bsl*1000), 2)' sum(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000), 2)'};
            [t df pvals surog] = statcond(a, 'mode', 'bootstrap', 'naccu', 1000);
            %              shank(sha).excitatory_odors_t{s}(k) = 0;
            %              shank(sha).inhibitory_odors_t{s}(k) = 0;
            if pvals < 0.05
                for bin=1:size(app1,1)
                    exc_responsive_bins_trials{bin} = find(shank(sha).delta_bin_response_cell_odor_pair_trials{s}(bin,:,k) > 3 * shank(sha).std_baseline_cell_odor_pair{s}(k));
                    nerbt(bin) = numel(exc_responsive_bins_trials{bin}); %size(app1_psth,2)/2;
                end
                rel_flag = find(nerbt>4);
                
                sdf_response = [];
                lengthResp = [];
                if (mean(a{2}) > mean(a{1})) & mean(a{2})./response_window >= min_firingResp %& ~isempty(rel_flag) %& (shank(sha).baseline_cell_odor_pair{s}(k)./pre_bsl > 0) %((shank(sha).analog_response_intensity{s}(k) / response_window) > min_firingResp)
                    shank(sha).excitatory_odors_t{s}(k) = 1;
                    shank(sha).inhibitory_odors_t{s}(k) = 0;
                    shank(sha).exc_analog_response_intensity{s}(k) = shank(sha).analog_response_intensity{s}(k);
                    shank(sha).inh_analog_response_intensity{s}(k) = 0;
                    sdf_bsl = shank(sha).sdf{s}(k,1:pre_bsl*1000-49);
                    sdf_response = shank(sha).sdf{s}(k,pre*1000-49:pre*1000+1000);
                    mean_sdf_bsl = mean(sdf_bsl);
                    std_sdf_bsl = std(sdf_bsl);
                    [peak_sdf, idx] = max(sdf_response);
                    if ~isempty(idx) & peak_sdf > mean_sdf_bsl + 3 * std_sdf_bsl;
                        shank(sha).timePeak{s}(k) =  idx;
                        lengthResp  = find(sdf_response > max(sdf_response)/2);
                        shank(sha).halfWidthResp(s,k) = length(lengthResp);
                    else
                        shank(sha).timePeak{s}(k) =  nan;
                        shank(sha).halfWidthResp(s,k) = nan;
                    end
                    [onset_sdf, onset_idx] = find(sdf_response >=  mean_sdf_bsl + 2.5 * std_sdf_bsl, 1);
                    if ~isempty(onset_idx)
                        shank(sha).timeOnset{s}(k)  = onset_idx;
                    else shank(sha).timeOnset{s}(k)  = nan;
                    end
                    %                     for iii = 1:size(sdf_response,1)
                    %                         [onset_sdf, idx] = find(sdf_response(iii,:) > mean(sdf_bsl(iii,:)) + 2.5 * std(sdf_bsl(iii,:)),1);
                    %                         if ~isempty(idx)
                    %                             shank(sha).timeOnset{s}(iii,k) =  idx;
                    %                         else shank(sha).timeOnset{s}(iii,k) =  nan;
                    %                         end
                    %                     end
                    
                    if shank(sha).baseline_cell_odor_pair{s}(k) > 0
                        apppp = [];
                        for i = 1:n_trials
                            on_spikes = (pre-shank(sha).bsl_cycle_on{s}(i,k))*1000+1;
                            off_spikes = (pre-shank(sha).bsl_cycle_on{s}(i,k))*1000+1 + pre_bsl*1000;
                            on_phase = (pre-shank(sha).bsl_cycle_on{s}(i,k))*20000+1;
                            off_phase = (pre-shank(sha).bsl_cycle_on{s}(i,k))*20000+1+pre_bsl*20000;
                           apppp = [apppp findPhase(spike_matrix_app(i,on_spikes:off_spikes), sigphase(on_phase:off_phase,i,k), 1)];                    
                        end
                        shank(sha).cell(s).spike_resp_phase_bsl{k} = apppp;
                        shank(sha).cell(s).spike_resp_phase_rsp{k} =...
                            findPhase(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000), sigphase(pre*20000:pre*20000+response_window*20000,:,k), size(app1_psth,2));
                        
                        %                         nameFigure = sprintf('Shank %d - Unit %d', sha, s);
                        %                         h = figure('Name', nameFigure, 'NumberTitle', 'off');
                        %                         sua = shank(sha).spiketimesUnit{s};
                        %                         sua=sua';
                        %                         for sp = 1:100
                        %                             peri_spike_breath(sp,:) =  respiration(sua(i)*20000 - 0.2*20000 : sua(i)*20000 + 0.2*20000);
                        %                             peri_spike_lfp(sp,:) = lfp_data(sua(i)*1000 - 0.2*1000 : sua(i)*1000 + 0.2*1000);
                        %                         end
                        %                         xtime1 = -0.2:1/20000:0.2;
                        %                         xtime2 = -0.2:1/1000:0.2;
                        %                         subplot(1,2,1)
                        %                         plot(xtime1, mean(peri_spike_breath))
                        %                         subplot(1,2,2)
                        %                         plot(xtime2, mean(peri_spike_lfp))
                    else
                        shank(sha).cell(s).spike_resp_phase_bsl{k} = nan;
                        shank(sha).cell(s).spike_resp_phase_rsp{k} = nan;
                        
                    end
                    
                else
                    shank(sha).timeOnset{s}(k)  =  nan;
                    shank(sha).timePeak{s}(k)  =  nan;
                    shank(sha).halfWidthResp(s,k) = nan;
                    shank(sha).cell(s).spike_resp_phase_bsl{k} = nan;
                    shank(sha).cell(s).spike_resp_phase_rsp{k} = nan;
                    if mean(a{2}) < mean(a{1}) & (shank(sha).baseline_cell_odor_pair{s}(k) > 0)
                        shank(sha).inhibitory_odors_t{s}(k) = 1;
                        shank(sha).excitatory_odors_t{s}(k) = 0;
                        shank(sha).inh_analog_response_intensity{s}(k) = shank(sha).analog_response_intensity{s}(k);
                        shank(sha).exc_analog_response_intensity{s}(k) = 0;
                    else
                        shank(sha).excitatory_odors_t{s}(k) = 0;
                        shank(sha).inhibitory_odors_t{s}(k) = 0;
                        shank(sha).exc_analog_response_intensity{s}(k) = 0;
                        shank(sha).inh_analog_response_intensity{s}(k) = 0;
                    end
                end
                
            else
                shank(sha).excitatory_odors_t{s}(k) = 0;
                shank(sha).inhibitory_odors_t{s}(k) = 0;
                shank(sha).exc_analog_response_intensity{s}(k) = 0;
                shank(sha).inh_analog_response_intensity{s}(k) = 0;
                shank(sha).timeOnset{s}(k)  =  nan;
                shank(sha).timePeak{s}(k)  =  nan;
                shank(sha).halfWidthResp(s,k) = nan;
                shank(sha).cell(s).spike_resp_phase_bsl{k} = nan;
                shank(sha).cell(s).spike_resp_phase_rsp{k} = nan;
            end
            if isnan(shank(sha).excitatory_odors_t{s}(k))
                shank(sha).excitatory_odors_t{s}(k)=0;
                shank(sha).exc_analog_response_intensity{s}(k) = 0;
                shank(sha).timeOnset{s}(k)  =  nan;
                shank(sha).timePeak{s}(k)  =  nan;
                shank(sha).halfWidthResp(s,k) = nan;
                shank(sha).cell(s).spike_resp_phase_bsl{k} = nan;
                shank(sha).cell(s).spike_resp_phase_rsp{k} = nan;
            end
            if isnan(shank(sha).inhibitory_odors_t{s}(k))
                shank(sha).inhibitory_odors_t{s}(k)=0;
                shank(sha).inh_analog_response_intensity{s}(k) = 0;
                shank(sha).timeOnset{s}(k)  =  nan;
                shank(sha).timePeak{s}(k)  =  nan;
                shank(sha).halfWidthResp(s,k) = nan;
                shank(sha).cell(s).spike_resp_phase_bsl{k} = nan;
                shank(sha).cell(s).spike_resp_phase_rsp{k} = nan;
            end
            
            %              for m = 1:100
            %                  for n =1 :n_trials
            %                      tr = randi(10);
            %                      spike_matrix_app(n,:) = shank(sha).spike_matrix{s}(tr,:,k);
            %                  end
            %                  sdf = spikeDensity(mean(spike_matrix_app,1),sigma);
            %                  peak(m) = max(sdf(pre*1000+1:pre*1000+1+response_window*1000));
            %                  through(m) = min(sdf(pre*1000+1:pre*1000+1+response_window*1000));
            %                  resp(m) = mean(sdf(pre*1000+1:pre*1000+1+response_window*1000));
            %                  bsl(m) = mean(sdf(1:pre*1000));
            %              end
            %              shank(sha).excitatory_odors_t{s}(k) = ttest2(resp, bsl, 'Alpha', 0.01, 'Tail', 'Right');
            %              shank(sha).inhibitory_odors_t{s}(k) = ttest2(resp, bsl,'Tail', 'Left');
            %              if  isnan(shank(sha).excitatory_odors_t{s}(k))
            %                  shank(sha).excitatory_odors_t{s}(k) = 0;
            %              end
            %              if  isnan(shank(sha).inhibitory_odors_t{s}(k))
            %                  shank(sha).inhibitory_odors_t{s}(k) = 0;
            %              end
            %
            %              if shank(sha).excitatory_odors_t{s}(k)==1
            %                  if shank(sha).analog_response_intensity{s}(k) > 0
            %                      shank(sha).exc_analog_response_intensity{s}(k) = shank(sha).analog_response_intensity{s}(k);
            %                  else
            %                      shank(sha).exc_analog_response_intensity{s}(k) = 0;
            %                  end
            %              else
            %                  shank(sha).exc_analog_response_intensity{s}(k) = 0;
            %              end
            %              if  shank(sha).inhibitory_odors_t{s}(k)==1
            %                  if shank(sha).analog_response_intensity{s}(k) < 0
            %                      shank(sha).inh_analog_response_intensity{s}(k) = shank(sha).analog_response_intensity{s}(k);
            %                  else
            %                      shank(sha).inh_analog_response_intensity{s}(k) = 0;
            %                  end
            %              else
            %                  shank(sha).inh_analog_response_intensity{s}(k) = 0;
            %              end
        end
        
        
        
        
        
        
        %             inh_responsive_bins = find(shank(sha).delta_bin_response_cell_odor_pair{s}(:,k) < -1.5 * shank(sha).std_baseline_cell_odor_pair{s}(k));
        %             for bin=1:size(app1,1)
        %                 inh_responsive_bins_trials{bin} = find(delta_bin_response_cell_odor_pair_trials{s}(bin,:,k) < -1.5 * std_baseline_cell_odor_pair{s}(k));
        %                 nerbt(bin) = numel(inh_responsive_bins_trials{bin}) > size(app_psth,2)/2;
        %             end
        %             if  numel(inh_responsive_bins) >= 3 %& sum(nerbt) >=3
        %                 shank(sha).inhibitory_odors{s}(k) = 1;
        %                 if shank(sha).analog_response_intensity{s}(k) < 0
        %                     shank(sha).inh_analog_response_intensity{s}(k) = shank(sha).analog_response_intensity{s}(k);
        %                 else
        %                     shank(sha).inh_analog_response_intensity{s}(k) = 0;
        %                 end
        %             else
        %                 shank(sha).inhibitory_odors{s}(k) = 0;
        %                 shank(sha).inh_analog_response_intensity{s}(k) = 0;
        %             end
        %
        %         end
        
        app_baseline_cell_odor_pair = shank(sha).baseline_cell_odor_pair{s}(:);
        shank(sha).baseline_cell(s) = mean(app_baseline_cell_odor_pair); % cell baseline averaged across odors
        clear sua;
        clear sua_trial;
        % waveforms(:,:) = squeeze(mean(spikes.waveforms(find(spikes.assigns == good(s)),:,:), 1));
        % [v, idx2] = min(min(waveforms,[],1));
        % waveform = double(waveforms(:,idx2)');
        % [peakRatio(s),peakDistance(s),slope(s)] = spike_features(waveform,fs);
    end
end
save('units.mat', 'shank');