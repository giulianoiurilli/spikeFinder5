clear all
close all

experimentFolder = uigetdir2;
toFolder = uigetdir('', 'Save in');
fileSave = sprintf('analysisSummary.mat');
cd(experimentFolder{1});
load('valveTTLs.mat')
D1 = dir([experimentFolder{1}, '/*.mat']);
num1 = length(D1(not([D1.isdir])));

base = [];
excitatory_odors_matrix = [];
inhibitory_odors_matrix = [];
peakResponse = [];
tuning_cell = [];
baselineCellOdorPair = [];
labels = {'rose', 'clove', 'banana', 'f. urine', 'TMT', 'rotten meat', 'orange'};
z = 1;




%% loading

for index = 1:num1-1
    %probeName(index) = sprintf('probe%d.mat', index);
    %load(probeName(index));
    load(D1(index).name)
    ID = str2num(D1(index).name(end-4));
    goodClusters{ID} = good; % this is good only if you load a single experiment
    base = [base baseline_cell];
    for k = 1:size(excitatory_odors,2) %cycles through cells on a probe
        excitatory_odors_matrix = [excitatory_odors_matrix; excitatory_odors{k}];
        inhibitory_odors_matrix = [inhibitory_odors_matrix; inhibitory_odors{k}];
        baselineCellOdorPair = [baselineCellOdorPair; baseline_cell_odor_pair{k}];
        anExcResponse(z,:) = exc_analog_response_intensity{k};
        anInhResponse(z,:) = inh_analog_response_intensity{k};
        peakDeltaResponse_matrix(:,:,z) = delta_bin_response_cell_odor_pair{k};
        app_psth{z}(:,:,:) = psth{k};
        z = z + 1;
    end
    clear good
end
cd ..
save(fullfile(toFolder, fileSave), 'experimentFolder', 'goodClusters', 'excitatory_odors_matrix', 'inhibitory_odors_matrix',...
    'baselineCellOdorPair', 'anExcResponse', 'anInhResponse', 'peakDeltaResponse_matrix', 'app_psth')


%% ANALYSIS

%% baseline firing 
[baselineHist,edges1] = histcounts(base .* 1/bin_size, 100, 'Normalization', 'probability');
h=figure('Name','Baseline firing', 'NumberTitle','off');
histogram(base .* 1/bin_size, 100, 'Normalization', 'probability');
title('Baseline firing'), xlabel('Hz'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Baseline firing.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'base')


%% probability of excitatory and inhibitory responses for any odor
pExcResponse = sum(excitatory_odors_matrix,2) ./ size(excitatory_odors_matrix,2);
pInhResponse = sum(inhibitory_odors_matrix,2) ./ size(excitatory_odors_matrix,2);
[pExcResponseHist, edges2] = histcounts(pExcResponse, 20, 'Normalization', 'probability');
[pInhResponseHist, edges3] = histcounts(pInhResponse, 20, 'Normalization', 'probability');
h=figure('Name','Response probability to any odor', 'NumberTitle','off');
subplot(1,2,1)
histogram(pExcResponse, 20, 'Normalization', 'probability')
title('Excitatory responses'), ylabel('Proportion of units'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(pInhResponse, 20, 'Normalization', 'probability')
title('Inhibitory responses'), ylabel('Proportion of units'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to any odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'pExcResponse', 'pInhResponse', '-append')

% probability of excitatory and inhibitory responses for each odor
pExcResponseOdor = sum(excitatory_odors_matrix,1) ./ size(excitatory_odors_matrix,1);
pInhResponseOdor = sum(inhibitory_odors_matrix,1) ./ size(inhibitory_odors_matrix,1);
h=figure('Name','Response probability to each odor', 'NumberTitle','off');
subplot(1,2,1)
bar(pExcResponseOdor)
title('Excitatory responses'), ylabel('Proportion of units')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
bar(pInhResponseOdor)
title('Inhibitory responses'), ylabel('Proportion of units')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'pExcResponseOdor', 'pInhResponseOdor', '-append')

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
xlim([-0.5 size(excitatory_odors_matrix,2)+0.5]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(nOdorInhResponses, edges4, 'Normalization', 'probability')
title('Inhibitory responses'), ylabel('Proportion of units'), xlabel('Number of odors')
xlim([-0.5 size(excitatory_odors_matrix,2)+0.5]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of odors that elicit a response for each unit.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'nOdorExcResponses', 'nOdorInhResponses', '-append')


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
save(fullfile(toFolder, fileSave), 'emittedSpikes', '-append')

% # of spikes emitted for each odor
h=figure('Name','Number of extra spikes emitted in response to each odor', 'NumberTitle','off');
for k=1:size(anExcResponse,2)
    distEmSpikesOdor = histcounts(round(emittedSpikes(:,k)), edges5, 'Normalization', 'probability');
    xlim([0.5 50.5]); ylim([0 0.1]);
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
    subplot(4,2,k)
    histogram(emittedSpikes(:,k), edges5, 'Normalization', 'probability')
    xlim([0.5 50.5]); ylim([0 0.1]);
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
end
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of extra spikes emitted in response to each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


%% sparseness
h=figure('Name','Sparseness measures', 'NumberTitle','off');
edges7 = -0.005:0.01:1.005;
ps = population_sparseness(anExcResponse, size(anExcResponse,1), size(anExcResponse,2));
distPs = histcounts(ps, edges7);
subplot(1,2,1)
histogram(ps, edges7)
xlim([-0.05 1.05]);
ylabel('Number of odors'), xlabel('Population sparseness')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
ls = lifetime_sparseness(anExcResponse, size(anExcResponse,1), size(anExcResponse,2));
distLs = histcounts(ls, edges7);
subplot(1,2,2)
histogram(ls, edges7)
xlim([-0.05 1.05]);
ylabel('Number of units'), xlabel('Lifetime sparseness')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Sparseness measures.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'ps', 'ls', '-append')


%% reliability 
for s=1:size(anExcResponse,1)
    for k=1:size(anExcResponse,2)
        for trial=1:size(app_psth{s},2)
            app_base{s}(trial,k) = mean(app_psth{s}(1:pre/bin_size,trial, k));
            app_response{s}(:,trial,k) = app_psth{s}(pre/bin_size+1:pre/bin_size+1+response_window/bin_size,trial,k);
            app_delta_response{s}(:,trial,k) = app_response{s}(:,trial,k) - app_base{s}(trial,k);
            app_analog_delta_response_trial{s}(trial,k) = abs(sum(app_delta_response{s}(:,trial,k)));
        end
        cv_cellOdorPair(s,k) = std(app_analog_delta_response_trial{s}(:,k)) ./ mean(app_analog_delta_response_trial{s}(:,k));
    end
end
h=figure('Name','Reliability for all odors', 'NumberTitle','off');
histogram(cv_cellOdorPair(:), 100, 'Normalization', 'probability');
%xlim([0 2.9]); 
ylim([0 0.05]);
title('Reliability across trials for all odors'), ylabel('Proportion of units'), xlabel('Coefficient of variation')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Reliability for all odors.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
h=figure('Name','Reliability for each odor', 'NumberTitle','off');
for k=1:size(anExcResponse,2)
    subplot(4,2,k)
    histogram(cv_cellOdorPair(:,k), 100, 'Normalization', 'probability');
    %xlim([0 2.9]); 
    ylim([0 0.05]);
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
end
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Reliability for each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'cv_cellOdorPair', 'app_base', 'app_delta_response', 'app_analog_delta_response_trial', '-append')


%% response adaptation

h=figure('Name','Response adaptation for each odor', 'NumberTitle','off');
for k=1:size(anExcResponse,2)
    for s=1:size(anExcResponse,1)
        for trial=1:size(app_psth{s},2)
            adapt_cellOdorPair(s,trial,k) = sum(app_delta_response{s}(:,trial,k));
        end
        if adapt_cellOdorPair(s,1,k) == 0
            adapt_cellOdorPair(s,1,k) = 0.01;
        end
        norm_adapt_cellOdorPair(s,:,k) = (adapt_cellOdorPair(s,:,k) ./ adapt_cellOdorPair(s,1,k)) - 1;
    end
    subplot(4,2,k)
    imagesc(squeeze(norm_adapt_cellOdorPair(:,:,k))), colormap(b2r(-5, 20))
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','TickDir','out', 'YDir','normal');
end
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response adaptation for each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'norm_adapt_cellOdorPair', '-append')


%% tuning
for s=1:size(anExcResponse,1)
    for k=1:size(anExcResponse,2)
        if abs(anExcResponse(s,k)) >= abs(anInhResponse(s,k))
            signalVector(s,k) = anExcResponse(s,k);
        else
            signalVector(s,k) = anInhResponse(s,k);
        end
    end
end

energy_signalVector_matrix = signalVector * signalVector';
app_signalVector = [signalVector diag(energy_signalVector_matrix)];
sorted_signalVector = sortrows(app_signalVector, size(app_signalVector,2));
sorted_signalVector(:,size(app_signalVector,2)) = [];
% h=figure;
% imagesc(sorted_signalVector), colormap('jet')
% h=figure;
% imagesc(sorted_signalVector)
h=figure('Name','Tuning functions', 'NumberTitle','off');
imagesc(sorted_signalVector), colormap(b2r(-20, 20))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Tuning functions.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
responsiveCells = find(~(diag(energy_signalVector_matrix)==0)); %indices of  neurons that respond to at least one odor in signalVector/anExcResponse
save(fullfile(toFolder, fileSave), 'signalVector', '-append')

selectedSignalVector = signalVector(responsiveCells',:);
save(fullfile(toFolder, fileSave), 'selectedSignalVector', '-append')


%% signal correlation
signal_correlation = corr(selectedSignalVector');
coefficients = triu(signal_correlation, 0);
mean_coefficient = mean(coefficients(:));
sim_tuning = pdist(selectedSignalVector, 'correlation');
squared_simTuning = squareform(sim_tuning);
figure, imagesc(squared_simTuning, [0 2]), axis square, axis off
B = squared_simTuning < 0.6;
pp = symrcm(B);
h = figure;
imagesc(signal_correlation(pp,pp), [-1 1]), axis square, axis off, colorbar
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Signal correlation.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'signal_correlation', '-append')

% figure, imagesc(squareform(sim_tuning), [0 2]), axis square, axis off
% Z1 = linkage(sim_tuning);
% figure
% [H,T,outperm] = dendrogram(Z1);

app1_selectedSignalVector = selectedSignalVector(pp',:);

h=figure;
imagesc(app1_selectedSignalVector), colormap(b2r(-20, 20)), axis off
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Tuning functions clustered by similarity.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')




for whichBin = 1:response_window./bin_size;
    for odor = 1:size(anExcResponse,2)
        unit = 1;
        for good = responsiveCells' %1:size(anExcResponse,1)
            populationPattern{whichBin}(unit, odor) = mean(app_delta_response{good}(whichBin,:,odor),2);
            populatioPatternTrials{whichBin}(unit,:,odor) = app_delta_response{good}(whichBin,:,odor);
            unit = unit + 1;
        end
    end
end
save(fullfile(toFolder, fileSave), 'whichBin', 'populationPattern', 'populatioPatternTrials', '-append')

%% noise correlation in a selected bin
h=figure('Name','Noise correlation', 'NumberTitle','off');
useBin = 2;
for odor = 1:size(anExcResponse,2)
    popPatternTrial = squeeze(populatioPatternTrials{useBin}(:,:,odor));
    popPatternTrial = popPatternTrial';
    energy_popPatternTrial = popPatternTrial * popPatternTrial';
    app_energy_popPatternTrial = [popPatternTrial diag(energy_popPatternTrial)];
    sorted_populationPattern = sortrows(app_energy_popPatternTrial , size(app_energy_popPatternTrial ,2));
    sorted_populationPattern(:,size(app_energy_popPatternTrial,2)) = [];
    subplot(4,2,odor)
    
    imagesc(sorted_populationPattern'), colormap(b2r(-20, 20))
    set(findobj(gcf, 'type','axes'), 'Visible','off')
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
end
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Noise correlation.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
    

%% hierarchical clustering in a selected bin
for i=1:size(populationPattern,1)
    meanResponses(i) = mean(populationPattern(i,:));
    norm_Responses(i) = norm(populationPattern(i,:));
    populationPattern(i,:) = (populationPattern(i,:) - meanResponses(i)) ./ norm_Responses(i);
end

D = pdist(populationPattern','correlation');
distanceMatrix = squareform(D);
Z = linkage(D);
h=figure('Name','Categorization', 'NumberTitle','off');
dendrogram(Z)
ccc = cophenet(Z,D);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Categorization.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'distanceMatrix', 'Z', 'ccc', '-append')
% Y = mdscale(D,2,'criterion','stress');
% figure
% plot(Y(:,1),Y(:,2),'o','LineWidth',2);


%% population noise correlations in a selected bin

[rr,p] = corr(populatioPatternTrials{useBin}(:,:,1));
meanCorr(1) = mean(rr(:));
[cc,p] = corr(populatioPatternTrials{useBin}(:,:,2));
meanCorr(2) = mean(cc(:));
[bb,p] = corr(populatioPatternTrials{useBin}(:,:,3));
meanCorr(3) = mean(bb(:));
[uu,p] = corr(populatioPatternTrials{useBin}(:,:,4));
meanCorr(4) = mean(uu(:));
[tt,p] = corr(populatioPatternTrials{useBin}(:,:,5));
meanCorr(5) = mean(tt(:));
[mm,p] = corr(populatioPatternTrials{useBin}(:,:,6));
meanCorr(6) = mean(mm(:));
[oo,p] = corr(populatioPatternTrials{useBin}(:,:,7));
meanCorr(7) = mean(oo(:));

save(fullfile(toFolder, fileSave), 'meanCorr', '-append')

h = figure;
subplot(2,7,1)
imagesc(rr, [-1 1]),  axis square, axis off
subplot(2,7,2)
imagesc(cc, [-1 1]),  axis square, axis off
subplot(2,7,3)
imagesc(bb, [-1 1]),  axis square, axis off
subplot(2,7,4)
imagesc(uu, [-1 1]),  axis square, axis off
subplot(2,7,5)
imagesc(tt, [-1 1]),  axis square, axis off
subplot(2,7,6)
imagesc(mm, [-1 1]),  axis square, axis off
subplot(2,7,7)
imagesc(oo, [-1 1]),  axis square, axis off
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Autocorrelation.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
h = figure;
imagesc(meanCorr, [-1 1]), axis off, colorbar
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Average autocorrelations.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


%for three odors
[rc,p] = corr(populatioPatternTrials{useBin}(:,:,1), populatioPatternTrials{useBin}(:,:,2));
%rc(:,2) = [];
mrc = mean(rc(:));
[rm,p] = corr(populatioPatternTrials{useBin}(:,:,1), populatioPatternTrials{useBin}(:,:,6));
mrm = mean(rm(:));
h = figure;
subplot(2,3,1)
imagesc(rr, [-1 1]),  axis square, axis off
subplot(2,3,2)
imagesc(rc, [-1 1]),  axis square, axis off
subplot(2,3,3)
imagesc(rm, [-1 1]),  axis square, axis off
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Correlation between odors.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
h = figure;
imagesc([meanCorr(1)/meanCorr(1) mrc/meanCorr(1) mrm/meanCorr(1)], [0 1]), axis off, colorbar
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Average correlations between odors.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'mrc', 'mrm', '-append')


%% Linear classification (c-svm) for all bins in the response window
for whichBin = 1:response_window./bin_size;
    classes = 'all';
    dataAll = populatioPatternTrials{whichBin};
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    %populatioPatternTrials = zscore(populatioPatternTrials);
    % rescale to [0 1];
    dataAll = (dataAll - repmat(min(dataAll,[],1),size(dataAll,1),1))*spdiags(1./(max(dataAll,[],1)-min(dataAll,[],1))',0,size(dataAll,2),size(dataAll,2));
    dataAll = dataAll';
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    
    repetitions = 200;
    trainingNumber = 50;
    [mean_acc_svm, std_acc_svm] = odor_c_svm(dataAll, trainingNumber, repetitions, classes);
    meanAccuracy_svm{whichBin} = mean_acc_svm;
    sdAccuracy_svm{whichBin} = std_acc_svm;
end
save(fullfile(toFolder, fileSave), 'repetitions', 'meanAccuracy_svm', 'sdAccuracy_svm', '-append')









%% Assemblies
fromFolders = uigetdir2;
bin_sizeAss = 0.01;


app_sec = valveTTL;

edges = [0:bin_sizeAss:app_sec(end)+30];
% sigma = 0.1;
% edges1=[-3*sigma:bin_size:3*sigma];
% kernel = normpdf(edges1,0,sigma);
% kernel = kernel*bin_size;


opts.threshold.permutations_percentile = 95;
opts.threshold.number_of_permutations = 20;
opts.threshold.method = 'circularshift';
opts.Patterns.method = 'ICA';
opts.Patterns.number_of_iterations = 200;


k = 1;
for fol = 1:size(fromFolders, 2)
    cd(fromFolders{fol})
    load('spikes.mat')
    
    good = spikes.labels(find(spikes.labels(:,2) == 2));

    for s = 1: length(good)% = good       cycles through cells on that shank
        sua{k} = spikes.spiketimes(find(spikes.assigns == good(s)));
        psthAss(k,:) = histc(sua{k},edges)';
        %z_psth(k,:) = (psth(k,:) - mean(psth(k,:))) ./ std(psth(k,:));
%         density(k,:) = conv(psth(k,:),kernel);
%         center = ceil(length(edges1)/2);
%         density1(k,:)=density(k,center:length(edges) + center-1);
%         z_density(k,:) = (density1(k,:) - mean(density1(k,:))) ./ std(density1(k,:));
        k=k+1;
    end
    
end

%assemblies = assembly_patterns(z_density, opts);
%activities = assembly_activity(assemblies, psth);
[assemblies, corrMatrix] = assembly_patterns(psthAss, opts);
activities = assembly_activity(assemblies, psthAss);
figure,
for i = 1:size(activities,1)
    subplot(size(activities,1),1,i)
    plot(edges,activities(i,:))
end


h = figure;
for i = 1:size(assemblies,2)
    subplot(size(assemblies,2),1,i), stem(assemblies(:,i))
end
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('AssembliesMembers.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


for ass = 1:size(assemblies,2)
    h = figure;
    m=1;
    for k = 1:size(anExcResponse,2)
        j = 1;
        for i = k:size(anExcResponse,2):length(app_sec)
            assembly_trial{ass}(j,:,k) = activities(ass,round(app_sec(i)-pre).*(1/bin_sizeAss):round(app_sec(i)+post).*(1/bin_sizeAss));
            areaBaselineTrial{ass}(j, k) = sum(assembly_trial{ass}(j, 1 : pre./bin_sizeAss, k));
            areaResponseTrial{ass}(j, k) = sum(assembly_trial{ass}(j, pre./bin_sizeAss + 1 : (response_window + pre) ./ bin_sizeAss, k));
            j = j+1;
        end
        assembly_response{ass}(k,:) = mean(assembly_trial{ass}(:,:,k));
        meanBaselineAssemblyTrial{ass}(k) =  mean(areaBaselineTrial{ass}(:,k));
        meanResponseAssemblyTrial{ass}(k) =  mean(areaResponseTrial{ass}(:,k));
        responsiveAssemblyOdorPairTTest{ass}(k,1) = ttest2(areaResponseTrial{ass}(:,k), areaBaselineTrial{ass}(:,k), 'Tail', 'right');
        responsiveAssemblyOdorPairTTest{ass}(k,2) = ttest2(areaResponseTrial{ass}(:,k), areaBaselineTrial{ass}(:,k), 'Tail', 'left');
        %responsiveAssemblyOdorPairANOVA1{ass}(k,1) = 
        subplot(size(anExcResponse,2),1,k)
        plot([-pre:bin_sizeAss:post],assembly_response{ass}(k,:)), axis tight
    end
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
    set(h,'color','white', 'PaperPositionMode', 'auto');
    stringa_fig=sprintf('ResponsesAssembly%d.eps', ass);
    saveas(h,fullfile(toFolder,stringa_fig),'epsc')
end


save(fullfile(toFolder, fileSave), 'psthAss', 'corrMatrix', 'ass', 'assemblies', 'activities', 'assembly_trial', 'assembly_response',...
    'meanBaselineAssemblyTrial', 'meanResponseAssemblyTrial', 'responsiveAssemblyOdorPairTTest', 'bin_sizeAss', '-append')
cd ..

















