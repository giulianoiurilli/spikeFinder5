clear all
close all



fromFolders = uigetdir2;
toFolder = uigetdir('', 'Save in');


load('dig1.mat');


signal = Dig_inputs;

 
pre = 3;
post = 5;
response_window = 3;
odors = 7;
bin_size = 0.2;
fs = 20000;
thres = .5;


app=find(signal>thres);
app1=SplitVec(app,'consecutive'); %crea delle celle di segmenti soprasoglia consecutivi
app=[];
for j=1:length(app1) %per ogni segmento
    [maxvalue, maxind]=max(signal(app1{j})); %trova il picco (indice relativo all'inizio del segmento)
    app(j)=app1{j}(maxind); %e ne memorizza l'indice (relativo all'inizio della sweep) in un vettore dei timestamps degli AP nella sweep i
end

app_sec=app./fs;







for fol = 1:size(fromFolders, 2)
    cd(fromFolders{fol});
    load('spikes.mat');
    
    good = spikes.labels(find(spikes.labels(:,2) == 2));
k = 1;
r = 1;
edges = [-pre:bin_size:post];

    for s = 1: length(good)% = good       cycles through cells
        f = figure(s);
        unit_name = sprintf('cluster %d', good(s));
        title(unit_name);
        sua = spikes.spiketimes(find(spikes.assigns == good(s))); %recover spiketimes of unit s
        r = 0;
        psth{s} = zeros(length(edges),floor(length(app_sec)/odors),odors); %initialize psth (time x trials x odor)
        
        for k = 1:odors   %cycles through odors
            
            j = 1;
            
            for i = k:odors:length(app_sec)     %cycles through trials
                sua_trial{j} = sua(find((sua > app_sec(i) - pre) & (sua < app_sec(i) + post))) - app_sec(i);
                j=j+1;
            end
            
            
            
            subplot(odors,1,k);
            plotSpikeRaster(sua_trial,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[-pre post]); %plot average psth for cell s / odor x
            xlabel('Time (s)'), ylabel('Trials');
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
            
         
            
            
            
            exc_reliability{s}(k) = 0;
            
            for j=1:floor(length(app_sec)/odors) %number of trials
                excResponseCounter(j,k) = 0;
                inhResponseCounter(j,k) = 0;                
                psth{s}(:,j,k) =  histc(sua_trial{j}, edges)';
                baselineCellOdorTrial(j,k) = mean(psth{s}(1:pre/bin_size, j, k), 1);
                baselineSdCellOdorTrial(j,k) = std(psth{s}(1:pre/bin_size, j, k), 1);
                responseCellOdorTrial(:,j,k) = psth{s}(pre/bin_size+1:pre/bin_size+1+response_window/bin_size, j, k) - baselineCellOdorTrial(j,k);
                exc_bins(:,j,k) = find(responseCellOdorTrial(:,j,k) >= 3 * baselineSdCellOdorTrial(j,k);
                inh_bins(:,j,k) = find(responseCellOdorTrial(:,j,k) <= -1.5 * baselineSdCellOdorTrial(j,k);
                if ~isempty(exc_bins(:,j,k))
                    excResponseCounter(j,k) = excResponseCounter(j,k) + 1;
                end
                if ~isempty(inh_bins(:,j,k))
                    inhResponseCounter(j,k) = inhResponseCounter(j,k) + 1;
                end
            end
            
            if sum(excResponseCounter(j,k), 1) >= floor(length(app_sec)/odors)/2
                exc_reliability{s}(k) = 1;
            end
            if sum(inhResponseCounter(j,k), 1) >= floor(length(app_sec)/odors)/2
                inh_reliability{s}(k) = 1;
            end
            
            app_psth = psth{s}(:,:,k);
            baseline_cell_odor_pair{s}(k) = mean(mean(app_psth(1:pre/bin_size,:),2));
            response_cell_odor_pair{s}(:,k) = mean(app_psth(pre/bin_size+1:pre/bin_size+1+response_window/bin_size,:),2);
            app1 = response_cell_odor_pair{s}(:,k);
            delta_bin__response_cell_odor_pair{s}(:,k) = response_cell_odor_pair{s}(:,k) - baseline_cell_odor_pair{s}(k)' .* ones(size(app1,1),1);
            analog_response_intensity{s}(k) = sum(delta_bin__response_cell_odor_pair{s}(:,k) );
            
            
            peak_response_cell_odor_pair{s}(k) = max(response_cell_odor_pair{s}(:,k)) - baseline_cell_odor_pair{s}(k);
            
            
            if exc_reliability{s}(k) == 1
                exc_responsive_bins = find(response_cell_odor_pair{s}(:,k) >= 3.5 * baseline_cell_odor_pair{s}(k));
                if ~isempty(exc_responsive_bins)
                    excitatory_odors{s}(k) = 1;
                    exc_analog_response_intensity{s}(k) = analog_response_intensity{s}(k);
                else
                    excitatory_odors{s}(k) = 0;
                    exc_analog_response_intensity{s}(k) = 0;
                end
            else
                excitatory_odors{s}(k) = 0;
                exc_analog_response_intensity{s}(k) = 0;
            end
            
            if inh_reliability{s}(k) == 1
                inh_responsive_bins = find(response_cell_odor_pair{s}(:,k) <= -1 * baseline_cell_odor_pair{s}(k));
                if ~isempty(inh_responsive_bins)
                    inhibitory_odors{s}(k) = 1;
                else
                    inhibitory_odors{s}(k) = 0;
                end
            end
            
            
                
                
                
                
                
                
                
                
                
                
                
                ap{j} = find(sua_trial{j} > 0 & sua_trial{j} <= response_window);
                app_ap = ap{j}(:);
                if ~isempty(app_ap)
                    exc_reliability{s}(k) = exc_reliability{s}(k) + 1;
                end
            end
            
            app_psth = psth{s}(:,:,k);
            baseline_cell_odor_pair{s}(k) = mean(mean(app_psth(1:pre/bin_size,:),2));
            response_cell_odor_pair{s}(:,k) = mean(app_psth(pre/bin_size+1:pre/bin_size+1+response_window/bin_size,:),2);
            app1 = response_cell_odor_pair{s}(:,k);
            delta_bin__response_cell_odor_pair{s}(:,k) = response_cell_odor_pair{s}(:,k) - baseline_cell_odor_pair{s}(k)' .* ones(size(app1,1),1);
            analog_response_intensity{s}(k) = sum(delta_bin__response_cell_odor_pair{s}(:,k) );
            
            
            peak_response_cell_odor_pair{s}(k) = max(response_cell_odor_pair{s}(:,k)) - baseline_cell_odor_pair{s}(k);
            
            
            
            if exc_reliability{s}(k) > (floor(length(app_sec)/odors))/2
                
                exc_responsive_bins = find(response_cell_odor_pair{s}(:,k) >= 3.5 * baseline_cell_odor_pair{s}(k));
                
                
                if ~isempty(exc_responsive_bins)
                    excitatory_odors{s}(k) = 1;
                    exc_analog_response_intensity{s}(k) = analog_response_intensity{s}(k);
                else
                    excitatory_odors{s}(k) = 0;
                    exc_analog_response_intensity{s}(k) = 0;
                end
                

                
                clear exc_responsive_bins;
                clear inh_responsive_bins;
                
            else
                excitatory_odors{s}(k) = 0;
                exc_analog_response_intensity{s}(k) = 0;
            end
            
            inh_responsive_bins = find(response_cell_odor_pair{s}(:,k) <= -2 * baseline_cell_odor_pair{s}(k));
            if ~isempty(inh_responsive_bins)
                inhibitory_odors{s}(k) = 1;
            else
                inhibitory_odors{s}(k) = 0;
            end
            
        end
        app_baseline_cell_odor_pair = baseline_cell_odor_pair{s}(:);
        baseline_cell(s) = mean(app_baseline_cell_odor_pair);
        
        
        clear sua;
        clear sua_trial;
        
        
    end
    
    
    
    
    for s = 1: length(good)
        figure(s+1000);
        unit_name = sprintf('cluster %d', good(s));
        
        subplot(3,2,1)
        title(unit_name);
        plot_waveforms(spikes, good(s));
        subplot(3,2,2)
        plot_residuals(spikes, good(s));
        subplot(3,2,3)
        plot_detection_criterion(spikes, good(s));
        subplot(3,2,4)
        plot_isi(spikes, good(s));
        subplot(3,2,5)
        plot_stability(spikes, good(s));
        subplot(3,2,6)
        plot_distances(spikes, good(s));
    end
        
        
        
    
    
    D = dir([toFolder, '/*.mat']);
    num = length(D(not([D.isdir])));
    filename = sprintf('tt%d.mat', num + 1)
    save(fullfile(toFolder, filename), 'baseline_cell', 'analog_response_intensity', 'exc_analog_response_intensity', 'peak_response_cell_odor_pair', 'response_cell_odor_pair', 'baseline_cell_odor_pair', 'bin_size', 'excitatory_odors', 'inhibitory_odors', 'psth', 'delta_bin__response_cell_odor_pair', 'exc_reliability', 'pre', 'post', 'response_window');
    
    clearvars -except fol app_sec fs bin_size odors response_window pre post fromFolders toFolder
    
    cd ..
    
end

clear all













