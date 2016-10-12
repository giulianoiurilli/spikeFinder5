clear all
close all
load('breathing.mat');
load('units.mat');
load('paramsExperiment.mat');


% n_trials = size(sec_on_rsp,1);
for sha = 1:4
    for s = 1:length(shank(sha).spiketimesUnit)
        sua = shank(sha).spiketimesUnit{s};
        sua=sua';
        r = 0;
        shank1(sha).psth{s} = zeros(length(edgesPSTH),n_trials,odors); %initialize psth (time x trials x odor)
        nameFigure = sprintf('Shank %d - Unit %d', sha, s);
        h = figure('Name', nameFigure, 'NumberTitle', 'off');
        shank1(sha).spike_matrix{s} = zeros(n_trials,(pre1+post1)*1000,odors); %consider the idea of sparsifying here
        kk=1;
        for k = 1:odors   %cycles through odors
            for i = 1:n_trials     %cycles through trials
                sua_trial{i} = sua(find((sua > sec_on_rsp(i,k) - pre1) & (sua < sec_on_rsp(i,k) + post1))) - sec_on_rsp(i,k);
                app_bsl_cycle_on = sec_on_rsp(i,k) - sec_on_bsl(i,k);
                if app_bsl_cycle_on < pre1 & app_bsl_cycle_on > response_window
                    shank1(sha).bsl_cycle_on{s}(i,k) = app_bsl_cycle_on;
                else shank1(sha).bsl_cycle_on{s}(i,k) = pre1;
                end
                indexes = round((sua_trial{i} + pre1)*1000);
                indexes(indexes==0) = 1;
                shank1(sha).spike_matrix{s}(i,indexes,k) = 1; %consider the idea of sparsifying here
                shank1(sha).sdf_trial{s}(i,:,k) = spikeDensity(shank1(sha).spike_matrix{s}(i,:,k),0.02);
            end
            
            subplot(odors,2,kk);
            plotSpikeRaster(sua_trial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-1 2]); %plot average psth for cell s / odor x
            xlabel('Time (s)'), ylabel('Trials');
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
            set(gca,'YTick',[])
            set(gca,'YColor','w')
            kk=kk+1;
            subplot(odors,2,kk);
            sdf = mean(shank1(sha).sdf_trial{s}(:,:,k),1);   %(spikeDensity(mean(shank1(sha).spike_matrix{s}(:,:,k),1),sigma);
            t_axis = -pre1:1/1000:post1; t_axis(end-1:end)=[];
% %  don't use           bsl_sdf = mean(sdf(1:(pre1*1000)-1));
% %  don't use           std_sdf = std(sdf(1:(pre1*1000)-1));
% %  don't use           sdf = (sdf - bsl_sdf) / std_sdf;
            plot(t_axis,sdf,'r', 'linewidth', 2); axis tight; ylim([0, 0.05]);
            set(gca,'YTick',[])
            set(gca,'YColor','w')
            shank1(sha).sdf{s}(k,:) = sdf;
            kk = kk+1;
            

            
            for j=1:n_trials %number of trials
                shank1(sha).psth{s}(:,j,k) =  histc(sua_trial{j}, edgesPSTH)';
            end            
            clear sua_trial
        end
    end
    clear sua
    
end
    
save('units1.mat', 'shank1', '-append');
%save('parameters.mat', 'n_trials', '-append')

