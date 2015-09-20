toFolder = pwd;
new_dir = 'Analysis figures';
toFolder = fullfile(toFolder, new_dir);
mkdir(toFolder)
filename = sprintf('conc_series_analysis_summary-apcx.mat');
fileSave = fullfile(toFolder, filename);



parameters
baseline_firing = [];
delta_response = [];
tuning_curves = [];
selected_tuning_curves = [];
signal_correlation_within = [];
signal_correlation_between = [];
noise_correlation_within = [];
noise_correlation_between = [];
onsetTime =[];
peakTime = [];
respWidth = [];
mean_phase_bsl = [];
var_phase_bsl = [];
peakness_phase_bsl = [];
mean_phase_rsp = [];
var_phase_rsp = [];
peakness_phase_rsp = [];
exc_stim_matrix = [];
inh_stim_matrix =[];
d_prime = [];
bsl = [];
rsp_m = [];
rsp_v = [];
FF = [];


unit = 1;

for ii = 1 : length(List)
    cartella = List{ii};
%     folder1 = cartella(end-11:end-6)
%     folder2 = cartella(end-4:end)
%     cartella = [];
%     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/%s/%s', folder1, folder2);
    cd(cartella)
    load('units.mat');
    baseline_firing = [baseline_firing base];
    %delta_response = [delta_response; emittedSpikes];
    tuning_curves = [tuning_curves; signalVector];
    selected_tuning_curves = [selected_tuning_curves; selectedSignalVector];
    signal_correlation_within = [signal_correlation_within coefficientsWithinProbes_together];
    signal_correlation_between = [signal_correlation_between coefficientsBetweenProbes];
    noise_correlation_within = [noise_correlation_within noiseWithinProbe_together];
    noise_correlation_between = [noise_correlation_between noiseBetweenProbes];
    
    for sha=1:4
        for s=1:length(shank(sha).timeOnset)
            exc_stim_matrix = [exc_stim_matrix; shank(sha).excitatory_odors_t{s}];
            inh_stim_matrix = [inh_stim_matrix; shank(sha).inhibitory_odors_t{s}];
            for k=1:odors
                if sum(~isnan(shank(sha).cell(s).spike_resp_phase_bsl{k})) > 0
                    app = shank(sha).cell(s).spike_resp_phase_bsl{k};
                    app1 = app(~isnan(app));
                    mean_phase_bsl = [mean_phase_bsl circ_mean(app1, [], 2)];
                    var_phase_bsl = [var_phase_bsl circ_var(app1, [], [], 2)];
                    [ku ku0] = circ_kurtosis(app1, [], 2);
                    if ku0 > 5
                        ku0 = [];
                    end
                    peakness_phase_bsl = [peakness_phase_bsl ku0];
                    clear app app1
                end
                if sum(~isnan(shank(sha).cell(s).spike_resp_phase_rsp{k})) > 0
                    app = shank(sha).cell(s).spike_resp_phase_rsp{k};
                    app1 = app(~isnan(app));
                    mean_phase_rsp = [mean_phase_rsp circ_mean(app1, [], 2)];
                    var_phase_rsp = [var_phase_rsp circ_var(app1, [], [], 2)];
                    [ku ku0] = circ_kurtosis(app1, [], 2);
                    if ku0 > 5
                        ku0 = [];
                    end
                    peakness_phase_rsp = [peakness_phase_rsp ku0];
                    clear app app1
                end
                
                if ~(shank(sha).excitatory_odors_t{s}(k) == 0 && shank(sha).inhibitory_odors_t{s}(k) == 0)
                    spike_matrix_app = shank(sha).spike_matrix{s}(:,:,k);
                    bsl_mean = mean(sum(spike_matrix_app(:,1:pre_bsl*1000),2));
                    %if bsl_mean/bin_size < 3
                    bsl_var = var(sum(spike_matrix_app(:,1:pre_bsl*1000),2));
                    rsp_mean = mean(sum(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000),2));
                    resp_mean(unit,k) = rsp_mean;
                    rsp_var = var(sum(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000),2));
                    d_prime(unit,k) = (rsp_mean - bsl_mean)./sqrt(0.5*(rsp_var+bsl_var));
                    d_prime(isnan(d_prime)) = 0;
                    bsl = [bsl bsl_mean];
                    rsp_m = [rsp_m rsp_mean];
                    delta_response = [delta_response rsp_mean-bsl_mean];
                    rsp_v = [rsp_v rsp_var];
                    FF = [FF rsp_var./rsp_mean];
                    spsth(unit,:,k) = shank(sha).sdf{s}(k,:);
                    %end
                    d_p = [];
                    for i = 1:1000
                        perm_app = [];
                        perm_app1 = [];
                        perm_app(:,1) = sum(spike_matrix_app(:,1:pre_bsl*1000),2);
                        perm_app(:,2) = sum(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000),2);
                        [nRows,nCols] = size(perm_app);
                        [~,idx] = sort(rand(nRows,nCols),2);
                        % convert column indices into linear indices
                        idx = (idx-1)*nRows + ndgrid(1:nRows,1:nCols);
                        % rearrange perm_app
                        perm_app1 = perm_app;
                        perm_app1(:) = perm_app1(idx);
                        b_mean = mean(perm_app1(:,1));
                        b_var = var(perm_app1(:,1));
                        r_mean = mean(perm_app1(:,2));
                        r_var = var(perm_app1(:,2));
                        d_p(i) = (r_mean - b_mean)./sqrt(0.5*(r_var+b_var));
                    end
                    mean_d_p = mean(d_p);
                    std_d_p = std(d_p);
                    
                    
                    if normcdf(d_prime(unit,k), mean_d_p, std_d_p) < 0.95
                        d_prime(unit,k) = 0;
                    end
                else d_prime(unit,k) = 0;
                    unit = unit+1;
                end 
                
                if ~(shank(sha).excitatory_odors_t{s}(k) == 0)
                    sdf_bsl = shank(sha).sdf{s}(k,1:pre_bsl*1000-49);
                    sdf_response = shank(sha).sdf{s}(k,pre*1000-49:pre*1000+(response_window)*1000);
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
                    [onset_sdf, onset_idx] = find(sdf_response >=  mean_sdf_bsl + 1.5 * std_sdf_bsl, 1);
                    if ~isempty(onset_idx)
                        shank(sha).timeOnset{s}(k)  = onset_idx;
                    else shank(sha).timeOnset{s}(k)  = nan;
                    end
                end
                onsetTime = [onsetTime nanmean(shank(sha).timeOnset{s})];
                peakTime = [peakTime nanmean(shank(sha).timePeak{s})];
                respWidth = [respWidth nanmean(shank(sha).halfWidthResp(s,:))];
            end
        end
    end
end

exc_odor_matrix = exc_stim_matrix(:,1:15);
inh_odor_matrix = inh_stim_matrix(:,1:15);
rsp_odor_matrix = exc_odor_matrix + inh_odor_matrix;
app = [];
app = sum(rsp_odor_matrix,2);
responsive_units = find(app>0);
numberOfResponsiveUnits = length(responsive_units);
totalNumberUnits = size(rsp_odor_matrix,1);
save(fileSave, 'responsive_units', 'numberOfResponsiveUnits', 'totalNumberUnits')


%% baseline firing
[baselineHist,edges] = histcounts(baseline_firing .* 1/bin_size, 100, 'Normalization', 'probability');
h=figure('Name','Baseline firing', 'NumberTitle','off');
histogram(baseline_firing .* 1/bin_size, 100, 'Normalization', 'probability');
xlim([-1 40]); ylim([0 0.25]);
title('Baseline firing'), xlabel('Hz'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Baseline firing.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'baseline_firing', '-append')


%% # of delta spikes emitted for all odors
edges1 = floor(min(delta_response(:)))-0.5:1:ceil(max(delta_response(:)))+0.5;
distEmSpikes = histcounts(round(delta_response(:)), edges1, 'Normalization', 'probability');
h=figure('Name','Number of extra spikes emitted in response to an odor', 'NumberTitle','off');
histogram(delta_response(:), edges1, 'Normalization', 'probability')
xlim([-30 30]); ylim([0 0.25]);
title('Number of extra spikes emitted in response to an odor'), ylabel('Proportion of units'), xlabel('Number of spikes')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of extra spikes emitted in response to an odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'delta_response', '-append')



%% probability of excitatory and inhibitory responses for any odor
pExcResponse = sum(exc_odor_matrix,2) ./ size(exc_odor_matrix,2);
pInhResponse = sum(inh_odor_matrix,2) ./ size(inh_odor_matrix,2);
[pExcResponseHist, edges0] = histcounts(pExcResponse, 20, 'Normalization', 'probability');
[pInhResponseHist, edges3] = histcounts(pInhResponse, 20, 'Normalization', 'probability');
h=figure('Name','Response probability to any odor', 'NumberTitle','off');
subplot(1,2,1)
histogram(pExcResponse, 20, 'Normalization', 'probability')
ylim([0 0.7]);
title('Excitatory responses'), ylabel('Proportion of units'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(pInhResponse, 20, 'Normalization', 'probability')
ylim([0 0.7]);
title('Inhibitory responses'), ylabel('Proportion of units'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to any odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'pExcResponse', 'pInhResponse', '-append')

%% probability of excitatory and inhibitory responses for each odor
pExcResponseOdor = sum(exc_odor_matrix,1) ./ size(exc_odor_matrix,1);
pInhResponseOdor = sum(inh_odor_matrix,1) ./ size(inh_odor_matrix,1);
h=figure('Name','Response probability to each odor', 'NumberTitle','off');
subplot(1,2,1)
bar(pExcResponseOdor)
ylim([0 0.25]);
title('Excitatory responses'), ylabel('Proportion of units')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
bar(pInhResponseOdor)
ylim([0 0.25]);
title('Inhibitory responses'), ylabel('Proportion of units')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'pExcResponseOdor', 'pInhResponseOdor', '-append')

%% number of odors that elicit an excitatory/inhibitory response for each cell
edges2 = -0.5:1:size(exc_odor_matrix,2)+0.5;
nOdorExcResponses = sum(exc_odor_matrix,2);
pnOdorExcResponses = histcounts(nOdorExcResponses, edges2, 'Normalization', 'probability');
nOdorInhResponses = sum(inh_odor_matrix,2);
pnOdorInhResponses = histcounts(inh_odor_matrix, edges2, 'Normalization', 'probability');
h=figure('Name','Number of odors that elicit a response for each unit', 'NumberTitle','off');
subplot(1,2,1)
histogram(nOdorExcResponses, edges2, 'Normalization', 'probability')
title('Excitatory responses'), ylabel('Proportion of units'), xlabel('Number of odors')
xlim([-0.5 size(exc_odor_matrix,2)+0.5]); ylim([0 1]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(nOdorInhResponses, edges2, 'Normalization', 'probability')
title('Inhibitory responses'), ylabel('Proportion of units'), xlabel('Number of odors')
xlim([-0.5 size(inh_odor_matrix,2)+0.5]); ylim([0 1]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of odors that elicit a response for each unit.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'nOdorExcResponses', 'nOdorInhResponses', '-append')


%% Onset, peak and width

h=figure('Name','Onset time', 'NumberTitle','off');
histogram(onsetTime, 100, 'Normalization', 'probability');
xlim([0 1050]); ylim([0 0.25]);
title('Onset time'), xlabel('ms'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Onset time.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'onsetTime', '-append')

h=figure('Name','Peak time', 'NumberTitle','off');
histogram(onsetTime, 100, 'Normalization', 'probability');
xlim([0 1050]); ylim([0 0.25]);
title('Peak time'), xlabel('ms'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Peak time.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'peakTime', '-append')

h=figure('Name','Response width', 'NumberTitle','off');
histogram(respWidth, 100, 'Normalization', 'probability');
xlim([0 1050]); ylim([0 0.25]);
title('Response width'), xlabel('ms'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response width.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'respWidth', '-append')


%% Breathing phase

var_phase_bsl(var_phase_bsl==0) = [];
var_phase_rsp(var_phase_rsp==0) = [];


h=figure('Name','Spike-respiration locking (baseline)', 'NumberTitle','off');
rose(mean_phase_bsl);
title('Spike-respiration locking (baseline)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Spike-respiration locking (baseline).eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'mean_phase_bsl', '-append')

h=figure('Name','Spike-respiration locking (response)', 'NumberTitle','off');
rose(mean_phase_rsp);
title('Spike-respiration locking (response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Spike-respiration locking (response).eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'mean_phase_rsp', '-append')

h=figure('Name','Spike-respiration locking - variance (baseline)', 'NumberTitle','off');
histogram(var_phase_bsl, 100, 'Normalization', 'probability');
xlim([-0.05 1.05]); ylim([0 0.25]);
title('Spike-respiration locking - variance (baseline)'), xlabel('ms'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Spike-respiration locking - variance (baseline).eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'var_phase_bsl', '-append')

h=figure('Name','Spike-respiration locking - variance (response)', 'NumberTitle','off');
histogram(var_phase_rsp, 100, 'Normalization', 'probability');
xlim([-0.05 1.05]); ylim([0 0.25]);
title('Spike-respiration locking - variance (response)'), xlabel('ms'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Spike-respiration locking - variance (response).eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'var_phase_rsp', '-append')

h=figure('Name','Spike-respiration locking - peakedness (baseline)', 'NumberTitle','off');
histogram(peakness_phase_bsl, 100, 'Normalization', 'probability');
xlim([-0.5 1.5]); ylim([0 0.25]);
title('Spike-respiration locking - peakedness (baseline)'), xlabel('ms'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Spike-respiration locking - peakedness (baseline).eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'peakness_phase_bsl', '-append')

h=figure('Name','Spike-respiration locking - peakedness (response)', 'NumberTitle','off');
histogram(peakness_phase_rsp, 100, 'Normalization', 'probability');
xlim([-0.5 1.5]); ylim([0 0.25]);
title('Spike-respiration locking - peakedness (response)'), xlabel('ms'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Spike-respiration locking - peakedness (response).eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'peakness_phase_rsp', '-append')


%% Sparseness

app = [];
app = selected_tuning_curves(:,1:15);
% app(app<0) = 0;
h=figure('Name','Sparseness measures', 'NumberTitle','off');
edges7 = -0.005:0.02:1.005;
ps = population_sparseness(app, size(app,1), size(app,2));
distPs = histcounts(ps, edges7);
subplot(1,2,1)
histogram(ps, edges7)
xlim([-0.05 1.05]); ylim([0 4]);
ylabel('Number of odors'), xlabel('Population sparseness')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
ls = lifetime_sparseness(app, size(app,1), size(app,2));
distLs = histcounts(ls, edges7);
subplot(1,2,2)
histogram(ls, edges7)
xlim([-0.05 1.05]); ylim([0 30]);
ylabel('Number of units'), xlabel('Lifetime sparseness')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Sparseness measures.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'ps', 'ls', '-append')


%% Discriminability

h=figure('Name','Discriminability', 'NumberTitle','off');
histogram(d_prime, 100, 'Normalization', 'probability');
xlim([-5.5 5.5]); ylim([0 0.1]);
title('Discriminability'), xlabel('d'''), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Discriminability.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'd_prime', '-append')

h=figure('Name','Discriminability-baseline firing correlation', 'NumberTitle','off');
scatter(bsl/bin_size, d_prime); axis square
xlabel('baseline firing'); ylabel('d''');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Discriminability-baseline firing correlation.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'bsl', '-append')

h=figure('Name','Fano factor', 'NumberTitle','off');
histogram(FF, 100, 'Normalization', 'probability');
xlim([-0.5 40.5]); ylim([0 0.5]);
title('Fano factor'), xlabel('Fano factor'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Fano factor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'FF', '-append')

h=figure('Name','Response mean-variance correlation', 'NumberTitle','off');
scatter(rsp_m, rsp_v); axis square; xlabel('response mean (Hz)'); ylabel('response variance (Hz)');
xlim([-0.5 50.5]); ylim([0 50]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response mean-variance correlation.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'rsp_m', 'rsp_v', '-append')


%% Signal correlations

labelWithin = repmat('within', length(signal_correlation_within), 1);
labelBetween = repmat('between', length(signal_correlation_between), 1);
labelsWB = strvcat(labelWithin, labelBetween);

app = [];
app = [signal_correlation_within signal_correlation_between];

h=figure('Name','Within and between shanks signal correlations', 'NumberTitle','off');
boxplot(app,labelsWB)
ylabel('Signal rank correlation')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Within and between shanks signal correlations.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


clear labelWithin labelBetween labelsWB app


save(fileSave, 'signal_correlation_within', 'signal_correlation_between', '-append')
    
%% Noise correlations
noise_correlation_within = [noise_correlation_within noiseWithinProbe_together];
noise_correlation_between = [noise_correlation_between noiseBetweenProbes];

labelWithin = repmat('within', length(noise_correlation_within), 1);
labelBetween = repmat('between', length(noise_correlation_between), 1);
labelsWB = strvcat(labelWithin, labelBetween);

app = [];
app = [noise_correlation_within noise_correlation_between];

h=figure('Name','Within and between shanks signal correlations', 'NumberTitle','off');
boxplot(app,labelsWB)
ylabel('Noise correlation')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Within and between shanks noise correlations.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


clear labelWithin labelBetween labelsWB app


save(fileSave, 'noise_correlation_within', 'noise_correlation_between', '-append')

%% Tuning curves

pent = selected_tuning_curves(:,1:5);
etg =  selected_tuning_curves(:,6:10);
iaa = selected_tuning_curves(:,11:15);


h=figure('Name','Tuning functions', 'NumberTitle','off');
subplot(1,3,1)
imagesc(pent)
colormap(b2r(-20, 20))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
subplot(1,3,2)
imagesc(etg)
colormap(b2r(-20, 20))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
subplot(1,3,3)
imagesc(iaa)
colormap(b2r(-20, 20))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Tuning functions.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')

app = [];
app = sum(d_prime, 2);
d_prime(app == 0,:) = [];

pent_d = d_prime(:,1:5);
etg_d = d_prime(:,6:10);
iaa_d = d_prime(:,11:15);

pent_r = resp_mean(:,1:5);
etg_r = resp_mean(:,6:10);
iaa_r = resp_mean(:,11:15);

pent_spsth = sum(spsth(:,:,1:5),1);
etg_spsth = sum(spsth(:,:,6:10),1);
iaa_spsth = sum(spsth(:,:,11:15),1);

figure
t_axis = -pre:1/1000:post; t_axis(end-1:end)=[];
subplot(1,3,1)
for i=1:size(pent_spsth,3)
plot(t_axis,((pent_spsth(:,:,i)./mean(pent_spsth(:,1:200,i),2)) - 1)*100);
axis tight
hold on
end
subplot(1,3,2)
for i=1:size(pent_spsth,3)
plot(t_axis,((etg_spsth(:,:,i)./mean(etg_spsth(:,1:200,i),2)) - 1)*100);
axis tight
hold on
end
subplot(1,3,3)
for i=1:size(pent_spsth,3)
plot(t_axis,((iaa_spsth(:,:,i)./mean(iaa_spsth(:,1:200,i),2)) - 1)*100);
axis tight
hold on
end

app = [];
app = sum(pent_d, 2);
pent_d(app<=0,:) = [];
app = [];
app = sum(pent_d, 2);
pent_d(:,6) = app;
pent_d = sortrows(pent_d,6);
pent_d(:,6) = [];
pent_d = flipud(pent_d);

app = [];
app = sum(etg_d, 2);
etg_d(app<=0,:) = [];
app = [];
app = sum(etg_d, 2);
etg_d(:,6) = app;
etg_d = sortrows(etg_d,6);
etg_d(:,6) = [];
etg_d = flipud(etg_d);

app = [];
app = sum(iaa_d, 2);
iaa_d(app<=0,:) = [];
app = [];
app = sum(iaa_d, 2);
iaa_d(:,6) = app;
iaa_d = sortrows(iaa_d,6);
iaa_d(:,6) = [];
iaa_d = flipud(iaa_d);

amean_pent_d = sum(pent_d)./ sum(pent_d~=0,1);
amean_etg_d = sum(etg_d)./ sum(etg_d~=0,1);
amean_iaa_d = sum(iaa_d)./ sum(iaa_d~=0,1);


h=figure('Name','Tuning functions -d''', 'NumberTitle','off');
subplot(1,3,1)
imagesc(pent_d)
colormap(b2r(min(d_prime(:)), max(d_prime(:))))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
subplot(1,3,2)
imagesc(etg_d)
colormap(b2r(min(d_prime(:)), max(d_prime(:))))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
subplot(1,3,3)
imagesc(iaa_d)
colormap(b2r(min(d_prime(:)), max(d_prime(:))))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Tuning functions - discriminability.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')

save(fileSave, 'pent_d', 'etg_d', 'iaa_d', 'rsp_mean', 'mean_pent_d', 'mean_etg_d', 'mean_iaa_d', '-append')







% %% Classification
% 
% 
% for whichBin = 1:response_window./bin_size;
%     for odor = 1:10
%         unit = 1;
%         for good = 1:length(responsiveCells) %1:size(anExcResponse,1)
%             populationPattern{whichBin}(unit, odor) = mean(app_delta_response{good}(whichBin,:,odor),2);
%             populatioPatternTrials{whichBin}(unit,:,odor) = app_delta_response{good}(whichBin,:,odor);
%             unit = unit + 1;
%         end
%     end
% end
% save(fullfile(toFolder, fileSave), 'whichBin', 'populationPattern', 'populatioPatternTrials', '-append')
