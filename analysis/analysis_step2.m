% clear all
% close all

load('units.mat');
clearvars -except shank cartella List ii
load('parameters.mat');

toFolder = pwd;
new_dir = 'Analysis figures';
toFolder = fullfile(toFolder, new_dir);
mkdir(toFolder)
fileSave = sprintf('units.mat');

base = [];
excitatory_odors_matrix = [];
inhibitory_odors_matrix = [];
peakResponse = [];
tuning_cell = [];
baselineCellOdorPair = [];
%tags = {'rose', 'clove', 'banana', 'f. urine', 'TMT', 'rotten meat', 'orange'};



%% loading
z = 1;
for sha = 1:4
    base = [base shank(sha).baseline_cell];
    for s = 1:length(shank(sha).excitatory_odors_t) %cycles through cells on a probe
        excitatory_odors_matrix = [excitatory_odors_matrix; shank(sha).excitatory_odors_t{s}];
        inhibitory_odors_matrix = [inhibitory_odors_matrix; shank(sha).inhibitory_odors_t{s}];
        baselineCellOdorPair = [baselineCellOdorPair; shank(sha).baseline_cell(s) ];
        anExcResponse(z,:) = shank(sha).exc_analog_response_intensity{s};
        anInhResponse(z,:) = shank(sha).inh_analog_response_intensity{s};
        app_psth{z}(:,:,:) = shank(sha).psth{s};
        %         X(z,1) = peakRatio(s);
        %         X(z,2) = peakDistance(s);
        %         X(z,3) = slope(s);
        z = z + 1;
    end
end
save(fileSave, 'base','excitatory_odors_matrix', 'inhibitory_odors_matrix',...
'baselineCellOdorPair', 'anExcResponse', 'anInhResponse', 'app_psth', '-append')

for s=1:size(anExcResponse,1)
    for k=1:size(anExcResponse,2)
        if abs(anExcResponse(s,k)) >= abs(anInhResponse(s,k))
            signalVector(s,k) = anExcResponse(s,k);
        else
            signalVector(s,k) = anInhResponse(s,k);
        end
    end
end

signalVector(isnan(signalVector(:))) = 0;
save(fileSave, 'signalVector', '-append')



exc_resp_odor = median(anExcResponse);
%resp_odor = floor(resp_odor*10)+1;
% h=figure('Name','Median excitatory intensity per odor', 'NumberTitle','off');
% plot(exc_resp_odor)
% ylabel('Excitatory intensity'), xlabel('odor label')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Excitatory intensity per odor.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'exc_resp_odor', '-append')

inh_resp_odor = median(anInhResponse);

% h=figure('Name','Median inhibitory intensity per odor', 'NumberTitle','off');
% plot(inh_resp_odor)
% ylabel('Inhibitory intensity'), xlabel('odor label')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Inhibitory intensity per odor.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'inh_resp_odor', '-append')


% h=figure('Name','Odor representation per selectivity class', 'NumberTitle','off');
for i = 1:odors
    mean_sel_tuning(i,:) = mean(anExcResponse(find(sum(excitatory_odors_matrix,2)==i),:),1);
    try
        max_sel_tuning(i,:) = max(anExcResponse(find(sum(excitatory_odors_matrix,2)==i),:),[],1);
    catch
        max_sel_tuning(i,:) = zeros(1,odors);
    end
end
mean_sel_tuning(isnan(mean_sel_tuning)) = 0;
max_sel_tuning(isnan(max_sel_tuning)) = 0;
% imagesc(max_sel_tuning)
% set(findobj(gcf, 'type','axes'), 'Visible','off')
% ylabel('selectivity class'); xlabel('odor label')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Odor representation per selectivity class.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'max_sel_tuning', '-append')




%% baseline firing
[baselineHist,edges1] = histcounts(base .* 1/bin_size, 100, 'Normalization', 'probability');
h=figure('Name','Baseline firing', 'NumberTitle','off');
histogram(base .* 1/bin_size, 100, 'Normalization', 'probability');
xlim([0 40]); ylim([0 0.3]);
title('Baseline firing'), xlabel('Hz'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Baseline firing.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'base', '-append')


%% probability of excitatory and inhibitory responses for any odor
pExcResponse = sum(excitatory_odors_matrix,2) ./ size(excitatory_odors_matrix,2);
pInhResponse = sum(inhibitory_odors_matrix,2) ./ size(excitatory_odors_matrix,2);
[pExcResponseHist, edges2] = histcounts(pExcResponse, 20, 'Normalization', 'probability');
[pInhResponseHist, edges3] = histcounts(pInhResponse, 20, 'Normalization', 'probability');
h=figure('Name','Response probability to any odor', 'NumberTitle','off');
subplot(1,2,1)
histogram(pExcResponse, 20, 'Normalization', 'probability')
ylim([0 1]);
title('Excitatory responses'), ylabel('Proportion of units'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(pInhResponse, 20, 'Normalization', 'probability')
ylim([0 1]);
title('Inhibitory responses'), ylabel('Proportion of units'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to any odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'pExcResponse', 'pInhResponse', '-append')

% probability of excitatory and inhibitory responses for each odor
pExcResponseOdor = sum(excitatory_odors_matrix,1) ./ size(excitatory_odors_matrix,1);
pInhResponseOdor = sum(inhibitory_odors_matrix,1) ./ size(inhibitory_odors_matrix,1);
h=figure('Name','Response probability to each odor', 'NumberTitle','off');
subplot(1,2,1)
bar(pExcResponseOdor)
ylim([0 1]);
title('Excitatory responses'), ylabel('Proportion of units')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
bar(pInhResponseOdor)
ylim([0 1]);
title('Inhibitory responses'), ylabel('Proportion of units')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'pExcResponseOdor', 'pInhResponseOdor', '-append')

% number of odors that elicit an excitatory/inhibitory response for each cell
edges4 = [-0.5:1:size(excitatory_odors_matrix,2)+0.5];
nOdorExcResponses = sum(excitatory_odors_matrix,2);
pnOdorExcResponses = histcounts(nOdorExcResponses, edges4, 'Normalization', 'probability');
nOdorInhResponses = sum(inhibitory_odors_matrix,2);
pnOdorInhResponses = histcounts(nOdorInhResponses, edges4, 'Normalization', 'probability');
h=figure('Name','Number of odors that elicit a response for each unit', 'NumberTitle','off');
subplot(1,2,1)
histogram(nOdorExcResponses, edges4, 'Normalization', 'probability')
title('Excitatory responses'), ylabel('Proportion of units'), xlabel('Number of odors')
xlim([-0.5 size(excitatory_odors_matrix,2)+0.5]); ylim([0 1]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(nOdorInhResponses, edges4, 'Normalization', 'probability')
title('Inhibitory responses'), ylabel('Proportion of units'), xlabel('Number of odors')
xlim([-0.5 size(excitatory_odors_matrix,2)+0.5]); ylim([0 1]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of odors that elicit a response for each unit.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'nOdorExcResponses', 'nOdorInhResponses', '-append')


%% # of delta spikes emitted for all odors
edges5 = -0.5:1:ceil(max(anExcResponse(:)))+0.5;
emittedSpikes = anExcResponse; %+ baselineCellOdorPair;
distEmSpikes = histcounts(round(emittedSpikes(:)), edges5, 'Normalization', 'probability');
h=figure('Name','Number of extra spikes emitted in response to an odor', 'NumberTitle','off');
histogram(emittedSpikes(:), edges5, 'Normalization', 'probability')
xlim([0.5 50.5]); ylim([0 0.1]);
title('Number of extra spikes emitted in response to an odor'), ylabel('Proportion of units'), xlabel('Number of spikes')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of extra spikes emitted in response to an odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'emittedSpikes', '-append')

% # of spikes emitted for each odor
% h=figure('Name','Number of extra spikes emitted in response to each odor', 'NumberTitle','off');
% for k=1:size(anExcResponse,2)
%     distEmSpikesOdor = histcounts(round(emittedSpikes(:,k)), edges5, 'Normalization', 'probability');
%     xlim([0.5 50.5]); ylim([0 0.1]);
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
%     subplot(3,5,k)
%     histogram(emittedSpikes(:,k), edges5, 'Normalization', 'probability')
%     xlim([0.5 50.5]); ylim([0 0.1]);
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% end
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Number of extra spikes emitted in response to each odor.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')


%% sparseness
% h=figure('Name','Sparseness measures', 'NumberTitle','off');
% edges7 = -0.005:0.01:1.005;
ps = population_sparseness(signalVector, size(anExcResponse,1), size(anExcResponse,2));
% distPs = histcounts(ps, edges7);
% subplot(1,2,1)
% histogram(ps, edges7)
% xlim([-0.05 1.05]); ylim([0 2.5]);
% ylabel('Number of odors'), xlabel('Population sparseness')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
ls = lifetime_sparseness(anExcResponse, size(anExcResponse,1), size(anExcResponse,2));
% distLs = histcounts(ls, edges7);
% subplot(1,2,2)
% histogram(ls, edges7)
% xlim([-0.05 1.05]); ylim([0 5]);
% ylabel('Number of units'), xlabel('Lifetime sparseness')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Sparseness measures.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'ps', 'ls', '-append')


%% tuning


energy_signalVector_matrix = signalVector * signalVector';
app_signalVector = [signalVector diag(energy_signalVector_matrix)];
sorted_signalVector = sortrows(app_signalVector, size(app_signalVector,2));
sorted_signalVector(:,size(app_signalVector,2)) = [];
h=figure;
imagesc(sorted_signalVector), colormap('jet')
h=figure;
imagesc(sorted_signalVector)
h=figure('Name','Tuning functions', 'NumberTitle','off');
imagesc(sorted_signalVector), colormap(b2r(-20, 20))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Tuning functions.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
responsiveCells = find(~(diag(energy_signalVector_matrix)==0)); %indices of  neurons that respond to at least one odor in signalVector
save(fileSave, 'signalVector', '-append')

selectedSignalVector = signalVector(responsiveCells',:);
save(fileSave, 'selectedSignalVector', '-append')
save(fileSave, 'responsiveCells', '-append')

clear app_signalVector



%% Signal correlation
%tuning functions in each shank

app = [];
app = signalVector>5;
masked_signalVector = signalVector .* app;

z=0;
for probe=1:4
    signalVectorProbe{probe} = masked_signalVector(z+1:z+length(shank(probe).psth),:);
    z = z + length(shank(probe).psth);
    energy_signalVector_matrixProbe = signalVectorProbe{probe} * signalVectorProbe{probe}';
    responsiveCellsProbe{probe} = find(~(diag(energy_signalVector_matrixProbe)==0));
    selectedSignalVectorProbe{probe} = signalVectorProbe{probe}(responsiveCellsProbe{probe}',:);
    if numel(responsiveCellsProbe{probe}) > 1
        try
            app = corr(selectedSignalVectorProbe{probe}', 'type', 'Spearman');
            index = find(triu(ones(size(app)), 1));
            appp = app(index);
            coefficientsWithinProbe{probe} = appp(~isnan(appp));
            clear index
            clear app
            clear appp
        catch
            disp('error')
            coefficientsWithinProbe{probe} = [];
        end
    else coefficientsWithinProbe{probe} = [];
    end
end

coefficientsBetweenProbes = [];
for probe = 1:3
    for next = probe+1 : 4
        if (numel(responsiveCellsProbe{probe}) >= 1) & (numel(responsiveCellsProbe{next}) >= 1)
            coefficientsBetweenProbes_app = [];
            try
                app = corr(selectedSignalVectorProbe{probe}', selectedSignalVectorProbe{next}', 'type', 'Spearman');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                coefficientsBetweenProbes_app = [coefficientsBetweenProbes_app apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            catch
                disp('error')
                coefficientsBetweenProbes_app = [];
            end
        else coefficientsBetweenProbes_app = [];
        end
        coefficientsBetweenProbes = [coefficientsBetweenProbes coefficientsBetweenProbes_app];
    end
end

coefficientsWithinProbes_together = [coefficientsWithinProbe{1}' coefficientsWithinProbe{2}' coefficientsWithinProbe{3}' coefficientsWithinProbe{4}'];

try
lengthWithin = length(coefficientsWithinProbe{1}) +  length(coefficientsWithinProbe{2}) + length(coefficientsWithinProbe{3}) + length(coefficientsWithinProbe{4});
labelWithin = repmat('within', lengthWithin, 1);
labelBetween = repmat('between', length(coefficientsBetweenProbes), 1);
labelsWB = strvcat(labelWithin, labelBetween);

app = [coefficientsWithinProbes_together coefficientsBetweenProbes];

h=figure('Name','Within and between shanks signal correlations', 'NumberTitle','off');
boxplot(app,labelsWB)
ylabel('Signal rank correlation')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Within and between shanks signal correlations.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
catch
    disp('error')
end

clear lengthWithin labelWithin labelBetween labelsWB app


save(fileSave, 'coefficientsWithinProbes_together', 'coefficientsBetweenProbes', '-append')




%% Noise correlation


% for sha=1:4
%     n_units = length(shank(sha).psth);
%     for s = 1:n_units
%         for k = 1:odors
%             app2_psth = shank(sha).psth{s}(:,:,k);
%             bsl_trials = mean(app2_psth(1:pre_bsl/bin_size,:));
%             rsp_trials = mean(app2_psth(pre/bin_size+1 : pre/bin_size+1+(response_window)/bin_size, :));
%             delta_trials = rsp_trials - bsl_trials;
%             delta_trials = zscore(delta_trials);
%             shank(sha).noisec(s,:,k) = delta_trials;
%         end
%     end
% end
% 
% for sha=1:4
%     n_units = length(shank(sha).psth);
%     if n_units > 1
%         for k = 1:odors
%             app_noise = squeeze(shank(sha).noisec(:,:,k));
%             app_noise = app_noise';
%             noise_c_app1(:,:,k) = corr(app_noise);
%         end
%         noise_c_app2 = nanmean(noise_c_app1,3);
%         index = find(triu(ones(size(noise_c_app2)), 1));
%         noise_c_app3 = noise_c_app2(index);
%         noiseWithinProbe{sha} =  noise_c_app3(~isnan(noise_c_app3));
%         clear app_noise noise_c_app1 noise_c_app2 noise_c_app3 
%     else noiseWithinProbe{sha} = [];
%     end
% end
% 
% noiseBetweenProbes = [];
% for sha = 1:3
%     for next = probe+1 : 4
%         app_noise1 = squeeze(shank(sha).noisec(:,:,k));
%         app_noise2 = squeeze(shank(next).noisec(:,:,k));
%         app = corr(app_noise1', app_noise2');
%         index = find(triu(ones(size(app))));
%         appp = app(index);
%         apppp = appp(~isnan(appp));
%         noiseBetweenProbes = [noiseBetweenProbes apppp(:)'];
%         clear app
%         clear appp
%         clear apppp
%         clear index
%     end
% end

for sha=1:4
    noise_corr_app2 = [];
    for k = 1:odors
        cesto = [];
        for z = 1:length(shank(sha).excitatory_odors_t)
            if shank(sha).excitatory_odors_t{z}(k) == 1 & sum(shank(sha).response_cell_odor_pair{z}(:,k)) > 5
                cesto = [cesto z];
            end
        end
        good{sha}.odor{k} = cesto;
        clear cesto;
        if ~isempty(good{sha}.odor{k}) 
            for un = 1:length(good{sha}.odor{k})
                clear s
                s = good{sha}.odor{k}(un);
                app2_psth = shank(sha).psth{s}(:,:,k);
                bsl_trials = mean(app2_psth(1:pre_bsl/bin_size,:));
                rsp_trials = mean(app2_psth(pre/bin_size+1 : pre/bin_size+1+(response_window)/bin_size, :));
                %delta_trials = rsp_trials - bsl_trials;
                bsl_trials = zscore(bsl_trials);
                rsp_trials = zscore(rsp_trials);
                zscored_good_response{sha}.odor{k}(un,:) = rsp_trials;
            end
            if length(good{sha}.odor{k}) > 1
                app_noise = zscored_good_response{sha}.odor{k}(:,:);
                app_noise = app_noise';
                noise_corr_app1 = corr(app_noise);
                index = find(triu(ones(size(noise_corr_app1)), 1));
                noise_corr_app2 = [noise_corr_app2 noise_corr_app1(index)'];
                clear app_noise
            end
        end
    end
    noiseWithinProbe{sha} =  noise_corr_app2(~isnan(noise_corr_app2));
end




app_noise1 =[];
app_noise2 =[];
noiseBetweenProbes = [];
for sha = 1:3
    for next = probe+1 : 4
        for k=1:odors
            if ~isempty(good{sha}.odor{k}) && ~isempty(good{next}.odor{k}) 
                app_noise1 = squeeze(zscored_good_response{sha}.odor{k}(:,:));
                app_noise2 = squeeze(zscored_good_response{next}.odor{k}(:,:));
                app = corr(app_noise1', app_noise2');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                noiseBetweenProbes = [noiseBetweenProbes apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
                app_noise1 =[];
                app_noise2 =[];
            end
        end
    end
end


noiseWithinProbe_together = [noiseWithinProbe{1} noiseWithinProbe{2} noiseWithinProbe{3} noiseWithinProbe{4}];

lengthWithin = length(noiseWithinProbe{1}) +  length(noiseWithinProbe{2}) + length(noiseWithinProbe{3}) + length(noiseWithinProbe{4});
labelWithin = repmat('within', lengthWithin, 1);
labelBetween = repmat('between', length(noiseBetweenProbes), 1);
labelsWB = strvcat(labelWithin, labelBetween);

app = [noiseWithinProbe_together noiseBetweenProbes];

h=figure('Name','Within and between shanks noise correlations', 'NumberTitle','off');
boxplot(app,labelsWB)
ylabel('Noise correlation')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Within and between shanks noise correlations.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')

clear lengthWithin labelWithin labelBetween labelsWB app


save(fileSave, 'noiseWithinProbe', 'noiseWithinProbe_together', 'noiseBetweenProbes', '-append')


%% entropy

v = ones(1, size(selectedSignalVector,2)) ./ size(selectedSignalVector,2);
k = 1 ./ (v * log2(v)');
for s = 1:size(selectedSignalVector,1)
    app_signalVector(s,:) = (selectedSignalVector(s,:) - min(selectedSignalVector(s,:))) + 0.001;
    p_signalVector(s,:) = app_signalVector(s,:) ./ sum(app_signalVector(s,:));
    ent(s) = k .* (p_signalVector(s,:) * log2(p_signalVector(s,:))');
end
% h=figure('Name','Entropy', 'NumberTitle','off');
% histogram(ent, 50, 'Normalization', 'probability');
% xlim([0 1]); ylim([0 0.8]);
% ylabel('Proportion of units'), xlabel('Entropy')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Entropy.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'ent', '-append')


%% reliability 
u = 1;
for s = 1:length(responsiveCells) %1:size(anExcResponse,1)
    unit = responsiveCells(s);
    for k=1:size(anExcResponse,2)
        for trial=1:size(app_psth{unit},2)
            app_base{u}(trial,k) = mean(app_psth{unit}(1:pre_bsl/bin_size,trial, k));
            app_response{u}(:,trial,k) = app_psth{unit}(pre/bin_size+1:pre/bin_size+1+response_window/bin_size,trial,k);
            app_delta_response{u}(:,trial,k) = app_response{u}(:,trial,k) - app_base{u}(trial,k);
            app_analog_delta_response_trial{u}(trial,k) = sum(app_delta_response{u}(:,trial,k));
        end
        cv_cellOdorPair(u,k) = std(abs(app_analog_delta_response_trial{u}(:,k))) ./ mean(abs(app_analog_delta_response_trial{u}(:,k)));
    end
    u = u+1;
end


for s = 1:length(responsiveCells)
    for k=1:size(anExcResponse,2)
        variance(s,k) = std(abs(app_analog_delta_response_trial{s}(:,k)))^2;
        mean_r(s,k) = mean(abs(app_analog_delta_response_trial{s}(:,k)));
    end
end


% [xData, yData] = prepareCurveData( mean_r, variance );
% % Set up fittype and options.
% ft = fittype( 'power1' );
% opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
% opts.Display = 'Off';
% opts.StartPoint = [2.04497797049253 1.18899589974064];
% 
% % Fit model to data.
% [fitresult, gof] = fit( xData, yData, ft, opts );
% 
% % Plot fit with data.
% figure( 'Name', 'firing rate vs variance', 'NumberTitle','off' );
% h = plot( fitresult, xData, yData );
% legend( h, 'variance vs. mean firing rate response', 'power fitting', 'Location', 'NorthEast' );
% % Label axes
% xlabel mean_r
% ylabel variance
% 
% stringa_fig=sprintf('Mean firing rate vs variance.eps');
% % saveas(h,fullfile(toFolder,stringa_fig),'epsc')


% h=figure('Name','Reliability for all odors', 'NumberTitle','off');
% histogram(cv_cellOdorPair(:), 100, 'Normalization', 'probability');
% xlim([0 4]); 
% ylim([0 0.06]);
% title('Reliability across trials for all odors'), ylabel('Proportion of units'), xlabel('Coefficient of variation')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Reliability for all odors.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
% h=figure('Name','Reliability for each odor', 'NumberTitle','off');
% for k=1:size(anExcResponse,2)
%     subplot(3,5,k)
%     histogram(cv_cellOdorPair(:,k), 100, 'Normalization', 'probability');
%     xlim([0 4]);  
%     ylim([0 0.06]);
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% end
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Reliability for each odor.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'cv_cellOdorPair', 'app_base', 'app_delta_response', 'app_analog_delta_response_trial', '-append')


% %% response adaptation
% 
% h=figure('Name','Response adaptation for each odor', 'NumberTitle','off');
% for k=1:size(anExcResponse,2)
%     for s=1:length(responsiveCells) %size(anExcResponse,1)
%         for trial=1:size(app_psth{s},2)
%             adapt_cellOdorPair(s,trial,k) = sum(app_delta_response{s}(:,trial,k));
%         end
%         if adapt_cellOdorPair(s,1,k) == 0
%             adapt_cellOdorPair(s,1,k) = 0.01;
%         end
%         norm_adapt_cellOdorPair(s,:,k) = (adapt_cellOdorPair(s,:,k) ./ adapt_cellOdorPair(s,1,k)) - 1;
%     end
%     subplot(3,5,k)
%     imagesc(squeeze(norm_adapt_cellOdorPair(:,:,k))), colormap(b2r(-5, 20))
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','TickDir','out', 'YDir','normal');
% end
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Response adaptation for each odor.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
% save(fileSave, 'norm_adapt_cellOdorPair', '-append')
% 
% 
% %% signal correlation (whole response window)
% signal_correlation = corr(selectedSignalVector');
% index = find(triu(ones(size(signal_correlation)), 1));
% coefficients = signal_correlation(index);
% mean_coefficient = mean(coefficients(:));
% sim_tuning = pdist(selectedSignalVector, 'correlation');
% squared_simTuning = squareform(sim_tuning);
% figure, imagesc(squared_simTuning, [0 2]), axis square, axis off
% B = squared_simTuning < 0.6;
% pp = symrcm(B);
% h = figure;
% imagesc(signal_correlation(pp,pp), [-1 1]), axis square, axis off, colorbar
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Signal correlation.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
% save(fileSave, 'signal_correlation', '-append')
% 
% % figure, imagesc(squareform(sim_tuning), [0 2]), axis square, axis off
% % Z1 = linkage(sim_tuning);
% % figure
% % [H,T,outperm] = dendrogram(Z1);
% 
% app1_selectedSignalVector = selectedSignalVector(pp',:);
% 
% h=figure;
% imagesc(app1_selectedSignalVector), colormap(b2r(-20, 20)), axis off
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Tuning functions clustered by similarity.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
% 
% 
% 
% 
for whichBin = 1:response_window./bin_size;
    for odor = 1:size(anExcResponse,2)
        unit = 1;
        for good = 1:length(responsiveCells) %1:size(anExcResponse,1)
            populationPattern{whichBin}(unit, odor) = mean(app_delta_response{good}(whichBin,:,odor),2);
            populatioPatternTrials{whichBin}(unit,:,odor) = app_delta_response{good}(whichBin,:,odor);
            unit = unit + 1;
        end
    end
end
save(fileSave, 'whichBin', 'populationPattern', 'populatioPatternTrials', '-append')
% 
% 
% %% noise correlation in a selected bin
% % h=figure('Name','Noise correlation', 'NumberTitle','off');
% noise_corr_rsp = [];
% noise_corr_bsl = [];
% useBin = 2;
% for odor = 1:size(anExcResponse,2)
%     popPatternTrial = squeeze(populatioPatternTrials{useBin}(:,:,odor));
%     popPatternTrial = popPatternTrial';
%     z_popPatternTrial = zscore(popPatternTrial);
%     rho = corr(z_popPatternTrial);
%     upper = triu(rho);
%     noise_corr_rsp = [noise_corr_rsp upper(:)];
%     for u = 1:size(popPatternTrial,2)
%         bsl_app(:,u) = app_base{u}(:,k);
%     end
%     z_bsl_app = zscore(bsl_app);
%     rho_bsl = corr(z_bsl_app);
%     upper_bsl = triu(rho_bsl);
%     noise_corr_bsl = [noise_corr_bsl upper_bsl(:)];
% end
%     energy_popPatternTrial = popPatternTrial * popPatternTrial';
%     app_energy_popPatternTrial = [popPatternTrial diag(energy_popPatternTrial)];
%     sorted_populationPattern = sortrows(app_energy_popPatternTrial , size(app_energy_popPatternTrial ,2));
%     sorted_populationPattern(:,size(app_energy_popPatternTrial,2)) = [];
%     subplot(3,5,odor)
%     
%     imagesc(sorted_populationPattern'), colormap(b2r(-20, 20))
%     set(findobj(gcf, 'type','axes'), 'Visible','off')
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% end
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Noise correlation.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
% 
% 
% %% hierarchical clustering in a selected bin
% for i=1:size(populationPattern{useBin},1)
%     meanResponses{useBin}(i) = mean(populationPattern{useBin}(i,:));
%     norm_Responses{useBin}(i) = norm(populationPattern{useBin}(i,:));
%     populationPattern{useBin}(i,:) = (populationPattern{useBin}(i,:) - meanResponses{useBin}(i)) ./ norm_Responses{useBin}(i);
% end
% 
% signal_correlation_bin = corr(populationPattern{useBin}');
% index = find(triu(ones(size(signal_correlation_bin)), 1));
% coefficients = signal_correlation_bin(index);
% mean_coefficient_bin = mean(coefficients(:));
% sim_tuning = pdist(populationPattern{useBin}, 'correlation');
% squared_simTuning = squareform(sim_tuning);
% figure, imagesc(squared_simTuning, [0 2]), axis square, axis off
% B = squared_simTuning < 0.6;
% pp = symrcm(B);
% h = figure;
% imagesc(signal_correlation_bin(pp,pp), [-1 1]), axis square, axis off, colorbar
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Signal correlation - selected bin.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
% save(fileSave, 'signal_correlation_bin', '-append')
% save(fileSave, 'useBin', '-append')
% 
% Distance = pdist(populationPattern{useBin}','correlation');
% distanceMatrix = squareform(Distance);
% Z = linkage(Distance);
% h=figure('Name','Categorization', 'NumberTitle','off');
% dendrogram(Z)
% ccc = cophenet(Z,Distance);
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Categorization.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
% save(fileSave, 'distanceMatrix', 'Z', 'ccc', '-append')

save('units.mat', 'shank', '-append')