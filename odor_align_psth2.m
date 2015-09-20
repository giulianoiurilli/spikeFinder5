% Align psth either to the valve onset or to the first inhalation after the
% valve opening


clear all
close all

fromFolders = uigetdir2;
toFolder = uigetdir('', 'Save in (Please, make a new folder)');
load('dig1.mat');
load('ADC0.mat');
signal = Dig_inputs; 
pre = 3;
post = 5;
response_window = 3;
odors = 15;
bin_size = 0.2;
edges = [-pre:bin_size:post];
fs = 20000;
thres = 0.5;
delay = 0.1;
max_delay = 0.6;

%find valve onsets
dig_supra_thresh = valve_onset(signal, thres); 
dig_supra_thresh = dig_supra_thresh./fs; %convert to seconds

%find inhalation onsets
inhal_on = respirationFilter(ADC); 
inhal_on = inhal_on/fs;

%find the first inhalation onset after the valve onset + a delay
[~,idx] = histc(dig_supra_thresh + delay, inhal_on); 
app = inhal_on(idx + 1);
%here I try to fix the instances when the respiration signal suddenly fails
%during the recording
delay_on = app - dig_supra_thresh;
delay_on(delay_on > max_delay) = nan;
n_nan = length(delay_on(isnan(delay_on)));
delay_on(isnan(delay_on)) = exprnd(nanmean(delay_on), [1, n_nan]); % I assign a random delay picked from an exponential distribution when the inhalation onset is > of some delay
app_sec = dig_supra_thresh + delay_on;
clear idx;
clear app;

%re-sort the inhalation onsets according to odors and trials
fileID = fopen('*.asc');
trial_log = textscan(fileID, '%d,%d,%d,%f,%f,%d,%f,%f,%s');
fclose(fileID)
trial_odor = read_odors
app = [app_sec' log_vector'];
app = sortrows(app, 2);
app_sec = app(:,1)';
n_trials = floor(length(app_sec)/odors);
app_sec = reshape(app_sec, odors, n_trials)


for fol = 1:size(fromFolders, 2) %folders containing the good cells on a single probe in a single experiment/depth
    cd(fromFolders{fol});
    load('spikes.mat');
    
    good = spikes.labels(find(spikes.labels(:,2) == 2));
    k = 1;
    r = 1;
    
    for s = 1 : length(good)% cycles through cells
%         f = figure;
%         unit_name = sprintf('cluster %d', good(s));
%         title(unit_name);
        sua = spikes.spiketimes(find(spikes.assigns == good(s))); %recover spiketimes of unit s
        r = 0;
        psth{s} = zeros(length(edges),n_trials,odors); %initialize psth (time x trials x odor)
        h = figure;
        for k = 1:odors   %cycles through odors
            for i = 1:n_trials     %cycles through trials
                sua_trial{i} = sua(find((sua > app_sec(k,i) - pre) & (sua < app_sec(k,i) + post))) - app_sec(k,i);
            end            
            subplot(odors,1,k);
            plotSpikeRaster(sua_trial,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[-pre post]); %plot average psth for cell s / odor x
            xlabel('Time (s)'), ylabel('Trials');
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
            exc_reliability{s}(k) = 0;
            for j=1:n_trials %number of trials
                psth{s}(:,j,k) =  histc(sua_trial{j}, edges)';
                ap{j} = find(sua_trial{j} > 0 & sua_trial{j} <= response_window);
                app_ap = ap{j}(:);
                if ~isempty(app_ap)
                    exc_reliability{s}(k) = exc_reliability{s}(k) + 1;
                end
            end
            
            app_psth = psth{s}(:,:,k);
            baseline_cell_odor_pair{s}(k) = mean(mean(app_psth(1:pre/bin_size,:),2));
            std_baseline_cell_odor_pair{s}(k) = std(mean(app_psth(1:pre/bin_size,:),1));
            response_cell_odor_pair{s}(:,k) = mean(app_psth(pre/bin_size+1:pre/bin_size+1+response_window/bin_size,:),2); %average response in each bin
            app1 = response_cell_odor_pair{s}(:,k);
            delta_bin_response_cell_odor_pair{s}(:,k) = response_cell_odor_pair{s}(:,k) - baseline_cell_odor_pair{s}(k)' .* ones(size(app1,1),1); %average delta response in each bin
            delta_bin_response_cell_odor_pair_trials{s}(:,:,k) = app_psth(pre/bin_size+1:pre/bin_size+1+response_window/bin_size,:) - baseline_cell_odor_pair{s}(k)' .* ones(size(app1,1),size(app_psth,2));
            analog_response_intensity{s}(k) = sum(delta_bin_response_cell_odor_pair{s}(:,k) ); %total delta spikes response in the response window 
            peak_response_cell_odor_pair{s}(k) = max(delta_bin_response_cell_odor_pair{s}(:,k)); %bin with the max delta response
            
            exc_responsive_bins = find(delta_bin_response_cell_odor_pair{s}(:,k) > 2.5 * std_baseline_cell_odor_pair{s}(k));
            for bin=1:size(app1,1)
                exc_responsive_bins_trials{bin} = find(delta_bin_response_cell_odor_pair_trials{s}(bin,:,k) > 2.5 * std_baseline_cell_odor_pair{s}(k));
                nerbt(bin) = numel(exc_responsive_bins_trials{bin}) >= size(app_psth,2)/2 - 1;
            end
            if numel(exc_responsive_bins) >= 2 & sum(nerbt) >1
                excitatory_odors{s}(k) = 1;
                if analog_response_intensity{s}(k) > 0
                    exc_analog_response_intensity{s}(k) = analog_response_intensity{s}(k); 
                else
                    exc_analog_response_intensity{s}(k) = 0;
                end
            else
                excitatory_odors{s}(k) = 0;
                exc_analog_response_intensity{s}(k) = 0;
            end
            
            
            
            
            inh_responsive_bins = find(delta_bin_response_cell_odor_pair{s}(:,k) < -1.5 * std_baseline_cell_odor_pair{s}(k));
%             for bin=1:size(app1,1)
%                 inh_responsive_bins_trials{bin} = find(delta_bin_response_cell_odor_pair_trials{s}(bin,:,k) < -1.5 * std_baseline_cell_odor_pair{s}(k));
%                 nerbt(bin) = numel(inh_responsive_bins_trials{bin}) > size(app_psth,2)/2;
%             end
            if  numel(inh_responsive_bins) >= 3 %& sum(nerbt) >=3
                inhibitory_odors{s}(k) = 1;
                if analog_response_intensity{s}(k) < 0
                    inh_analog_response_intensity{s}(k) = analog_response_intensity{s}(k);
                else
                    inh_analog_response_intensity{s}(k) = 0;
                end
            else
                inhibitory_odors{s}(k) = 0;
                inh_analog_response_intensity{s}(k) = 0;
            end
            
        end
        
        app_baseline_cell_odor_pair = baseline_cell_odor_pair{s}(:);
        baseline_cell(s) = mean(app_baseline_cell_odor_pair); % cell baseline averaged across odors
        clear sua;
        clear sua_trial;   
        waveforms(:,:) = squeeze(mean(spikes.waveforms(find(spikes.assigns == good(s)),:,:), 1));
        [v, idx2] = min(min(waveforms,[],1));
        waveform = double(waveforms(:,idx2)');
        [peakRatio(s),peakDistance(s),slope(s)] = spike_features(waveform,fs);
    end
    
    
    
    
    
    
%     for s = 1: length(good)
%         figure(s+1000);
%         unit_name = sprintf('cluster %d', good(s));
%         
%         subplot(3,2,1)
%         title(unit_name);
%         plot_waveforms(spikes, good(s));
%         subplot(3,2,2)
%         plot_residuals(spikes, good(s));
%         subplot(3,2,3)
%         plot_detection_criterion(spikes, good(s));
%         subplot(3,2,4)
%         plot_isi(spikes, good(s));
%         subplot(3,2,5)
%         plot_stability(spikes, good(s));
%         subplot(3,2,6)
%         plot_distances(spikes, good(s));
%     end
    
%     D = dir([toFolder, '/*.mat']);
%     num = length(D(not([D.isdir])));
    
    
date =  fromFolders{fol}(end-15:end-8);   
depth = fromFolders{fol}(end-6:end-3);
    probe = fromFolders{fol}(end);
    probeID = sprintf('probe_%s-%s-%s.mat', date, depth, probe)
    save(fullfile(toFolder, probeID), 'probeID', 'good', 'baseline_cell', 'analog_response_intensity', 'exc_analog_response_intensity',...
        'inh_analog_response_intensity', 'peak_response_cell_odor_pair', 'response_cell_odor_pair', 'baseline_cell_odor_pair', 'bin_size',...
        'excitatory_odors', 'inhibitory_odors', 'psth', 'delta_bin_response_cell_odor_pair', 'exc_reliability', 'pre', 'post', 'response_window',...
        'peakRatio', 'peakDistance', 'slope');
    clearvars -except fol app_sec fs bin_size odors response_window pre post fromFolders toFolder 
    cd ..    
end


clear all













