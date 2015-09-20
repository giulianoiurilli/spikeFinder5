clear all
close all

experimentFolder = uigetdir2;
toFolder = uigetdir('', 'Save in');
fileSave = sprintf('analysisSummary.mat');
cd(experimentFolder{1});

D1 = dir([experimentFolder{1}, '/*.mat']);
num1 = length(D1(not([D1.isdir])));

base = [];
excitatory_odors_matrix = [];
inhibitory_odors_matrix = [];
peakResponse = [];
tuning_cell = [];
baselineCellOdorPair = [];
%tags = {'rose', 'clove', 'banana', 'f. urine', 'TMT', 'rotten meat', 'orange'};


%% loading

z = 1;
for index = 1:num1
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
        app_psth{z}(:,:,:) = psth{k};
        X(z,1) = peakRatio(k);
        X(z,2) = peakDistance(k);
        X(z,3) = slope(k);
        z = z + 1;
    end
    clear good
end
cd ..
save(fullfile(toFolder, fileSave), 'experimentFolder', 'goodClusters', 'excitatory_odors_matrix', 'inhibitory_odors_matrix',...
    'baselineCellOdorPair', 'anExcResponse', 'anInhResponse', 'app_psth')


%% ANALYSIS



% clusterize and sort broad vs narrow spikes

X(:,4) = base';

h = figure;

subplot(2,2,1)
scatter(X(:,1), X(:,2))
xlabel('peaks ratio'), ylabel('peaks distance')

subplot(2,2,2)
scatter(X(:,1), X(:,3))
xlabel('peaks ratio'), ylabel('slope')

subplot(2,2,3)
scatter(X(:,2), X(:,3))
xlabel('peaks distance'), ylabel('peaks slope')

subplot(2,2,4)
scatter(X(:,2), X(:,4))
xlabel('peaks distance'), ylabel('baseline firing')

set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');







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
save(fullfile(toFolder, fileSave), 'base')


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
save(fullfile(toFolder, fileSave), 'pExcResponse', 'pInhResponse', '-append')

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
xlim([-0.05 1.05]); ylim([0 3]);
ylabel('Number of odors'), xlabel('Population sparseness')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
ls = lifetime_sparseness(anExcResponse, size(anExcResponse,1), size(anExcResponse,2));
distLs = histcounts(ls, edges7);
subplot(1,2,2)
histogram(ls, edges7)
xlim([-0.05 1.05]); ylim([0 60]);
ylabel('Number of units'), xlabel('Lifetime sparseness')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Sparseness measures.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'ps', 'ls', '-append')


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
save(fullfile(toFolder, fileSave), 'responsiveCells', '-append')

clear app_signalVector


% entropy

v = ones(1, size(signalVector,2)) ./ size(signalVector,2);
k = 1 ./ (v * log2(v)');
for s = 1:size(signalVector,1)
    app_signalVector(s,:) = (signalVector(s,:) - min(signalVector(s,:))) + 0.001;
    p_signalVector(s,:) = app_signalVector(s,:) ./ sum(app_signalVector(s,:));
    ent(s) = k .* (p_signalVector(s,:) * log2(p_signalVector(s,:))');
end
h=figure('Name','Entropy', 'NumberTitle','off');
histogram(ent, 50, 'Normalization', 'probability');
xlim([0 1]); ylim([0 0.8]);
ylabel('Proportion of units'), xlabel('Entropy')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Entropy.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'ent', '-append')

%% reliability 
u = 1;
for s = 1:length(responsiveCells) %1:size(anExcResponse,1)
    unit = responsiveCells(s);
    for k=1:size(anExcResponse,2)
        for trial=1:size(app_psth{unit},2)
            app_base{u}(trial,k) = mean(app_psth{unit}(1:pre/bin_size,trial, k));
            app_response{u}(:,trial,k) = app_psth{unit}(pre/bin_size+1:pre/bin_size+1+response_window/bin_size,trial,k);
            app_delta_response{u}(:,trial,k) = app_response{u}(:,trial,k) - app_base{u}(trial,k);
            app_analog_delta_response_trial{u}(trial,k) = abs(sum(app_delta_response{u}(:,trial,k)));
        end
        cv_cellOdorPair(u,k) = std(app_analog_delta_response_trial{u}(:,k)) ./ mean(app_analog_delta_response_trial{u}(:,k));
    end
    u = u+1;
end
h=figure('Name','Reliability for all odors', 'NumberTitle','off');
histogram(cv_cellOdorPair(:), 100, 'Normalization', 'probability');
xlim([0 4]); 
ylim([0 0.06]);
title('Reliability across trials for all odors'), ylabel('Proportion of units'), xlabel('Coefficient of variation')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Reliability for all odors.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
h=figure('Name','Reliability for each odor', 'NumberTitle','off');
for k=1:size(anExcResponse,2)
    subplot(4,2,k)
    histogram(cv_cellOdorPair(:,k), 100, 'Normalization', 'probability');
    xlim([0 4]);  
    ylim([0 0.06]);
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
end
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Reliability for each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'cv_cellOdorPair', 'app_base', 'app_delta_response', 'app_analog_delta_response_trial', '-append')


%% response adaptation

h=figure('Name','Response adaptation for each odor', 'NumberTitle','off');
for k=1:size(anExcResponse,2)
    for s=1:length(responsiveCells) %size(anExcResponse,1)
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




%% signal correlation (whole response window)
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
        for good = 1:length(responsiveCells) %1:size(anExcResponse,1)
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
for i=1:size(populationPattern{useBin},1)
    meanResponses{useBin}(i) = mean(populationPattern{useBin}(i,:));
    norm_Responses{useBin}(i) = norm(populationPattern{useBin}(i,:));
    populationPattern{useBin}(i,:) = (populationPattern{useBin}(i,:) - meanResponses{useBin}(i)) ./ norm_Responses{useBin}(i);
end

signal_correlation_bin = corr(populationPattern{useBin}');
coefficients = triu(signal_correlation_bin, 0);
mean_coefficient = mean(coefficients(:));
sim_tuning = pdist(populationPattern{useBin}, 'correlation');
squared_simTuning = squareform(sim_tuning);
figure, imagesc(squared_simTuning, [0 2]), axis square, axis off
B = squared_simTuning < 0.6;
pp = symrcm(B);
h = figure;
imagesc(signal_correlation_bin(pp,pp), [-1 1]), axis square, axis off, colorbar
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Signal correlation - selected bin.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'signal_correlation_bin', '-append')
save(fullfile(toFolder, fileSave), 'useBin', '-append')

D = pdist(populationPattern{useBin}','correlation');
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



%% Single-neuron measure of linear separability between rose and TMT

for s = 1:size(selectedSignalVector, 1)
    if (selectedSignalVector(s,1) ~= 0 || selectedSignalVector(s,5) ~= 0)
        incl(s) = 1;
    end
end

idx = find(incl == 1);

for useBin = 1:response_window / bin_size;
    roseTmt_mean{useBin}(:,1) = mean(populatioPatternTrials{useBin}(idx,:,1), 2);
    roseTmt_std{useBin}(:,1) = std(populatioPatternTrials{useBin}(idx,:,1),0, 2);
    roseTmt_mean{useBin}(:,2) = mean(populatioPatternTrials{useBin}(idx,:,5), 2);
    roseTmt_std{useBin}(:,2) = std(populatioPatternTrials{useBin}(idx,:,5),0, 2);
    IL(:, useBin) = ((diff(roseTmt_mean{useBin},1,2)).^2) ./ mean(roseTmt_std{useBin},2);
    minim(:, useBin) = min(roseTmt_mean{useBin},[],2);
    ratioRoseTMT(:, useBin) = (roseTmt_mean{useBin}(:,1) - minim(:,useBin) + 1) ./ (roseTmt_mean{useBin}(:,2) - minim(:,useBin) + 1);
end

h=figure;
histogram(IL(:,2), 400, 'Normalization', 'probability');
xlim([0 5]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

h = figure;
time = 0:(response_window/bin_size)-1;
plot(time, ratioRoseTMT, '-'), axis tight
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('ratio RoseVsTMT over time.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')

save(fullfile(toFolder, fileSave), 'IL', 'ratioRoseTMT', '-append')


%% Linear classification (c-svm) for all bins in the response window

%% single bins - all odors
for whichBin = 1:response_window/bin_size;
    classes = 'all';
    dataAll = populatioPatternTrials{whichBin};
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    % rescale to [0 1];
    dataAll = (dataAll - repmat(min(dataAll,[],1),size(dataAll,1),1))*spdiags(1./(max(dataAll,[],1)-min(dataAll,[],1))',0,size(dataAll,2),size(dataAll,2));
    dataAll = dataAll';
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    
    % Make labels
    labels      = ones(1,size(dataAll,2));
    app_labels  = labels;
    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    labels      = labels';
    
    repetitions = 200;
    trainingNumber = 56;
    [mean_acc_svm, std_acc_svm] = odor_c_svm(dataAll, trainingNumber, labels, repetitions, classes, toFolder);
    meanAccuracy_svm{whichBin} = mean_acc_svm;
    sdAccuracy_svm{whichBin} = std_acc_svm;
%     x = 2 : size(mean_acc_svm{whichBin},2) + 1;
%     h = figure;
%     shadedErrorBar(x, mean_acc_svm{whichBin}, sd_acc_svm{whichBin}, 'r');
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
%     set(h,'color','white', 'PaperPositionMode', 'auto');
%     stringa_fig=sprintf('c_svm linear discrimination -%s .eps', clas);
%     saveas(h,fullfile(tofolder,stringa_fig),'epsc')
end
save(fullfile(toFolder, fileSave), 'repetitions', 'meanAccuracy_svm', 'sdAccuracy_svm', '-append')
clear dataAll labels

%% single bins - rose vs clove
for whichBin = 1:response_window./bin_size;
    classes = 'roseVSclove';
    dataAll1 = populatioPatternTrials{whichBin};
    data(:,:,1) = dataAll1(:,:,1);
    data(:,:,2) = dataAll1(:,:,2);
    neurons = size(data,1);
    trials = size(data,2);
    stimuli = size(data,3);
    data = reshape(data, neurons, trials .* stimuli);
    data = data';
    % rescale to [0 1];
    data = (data - repmat(min(data,[],1),size(data,1),1))*spdiags(1./(max(data,[],1)-min(data,[],1))',0,size(data,2),size(data,2));
    data = data';
    data = reshape(data, neurons, trials, stimuli);
    
    % Make labels
    labels      = ones(1,size(data,2));
    app_labels  = labels;
    for odor = 1:size(data,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(data,2))];
    end
    labels      = labels';
    
    
    repetitions = 200;
    trainingNumber = 16;
    [mean_acc_svm, std_acc_svm] = odor_c_svm(data, trainingNumber, labels, repetitions, classes,toFolder);
    meanAccuracy_svmRC{whichBin} = mean_acc_svm;
    sdAccuracy_svmRC{whichBin} = std_acc_svm;
    %     x = 2 : size(mean_acc_svm{whichBin},2) + 1;
    %     h = figure;
    %     shadedErrorBar(x, mean_acc_svm{whichBin}, std_acc_svm{whichBin}, 'r');
    %     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
    %     set(h,'color','white', 'PaperPositionMode', 'auto');
    %     stringa_fig=sprintf('c_svm linear discrimination -%s .eps', clas);
    %     saveas(h,fullfile(tofolder,stringa_fig),'epsc')
end
clear dataAll1 data labels

%% single bins - rose vs TMT
for whichBin = 1:response_window./bin_size;
    classes = 'roseVStmt';
    dataAll1 = populatioPatternTrials{whichBin};
    data(:,:,1) = dataAll1(:,:,1);
    data(:,:,2) = dataAll1(:,:,5);
    neurons = size(data,1);
    trials = size(data,2);
    stimuli = size(data,3);
    data = reshape(data, neurons, trials .* stimuli);
    data = data';
    % rescale to [0 1];
    data = (data - repmat(min(data,[],1),size(data,1),1))*spdiags(1./(max(data,[],1)-min(data,[],1))',0,size(data,2),size(data,2));
    data = data';
    data = reshape(data, neurons, trials, stimuli);
    
    % Make labels
    labels      = ones(1,size(data,2));
    app_labels  = labels;
    for odor = 1:size(data,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(data,2))];
    end
    labels      = labels';
    
    repetitions = 200;
    trainingNumber = 16;
    [mean_acc_svm, std_acc_svm] = odor_c_svm(data, trainingNumber, labels, repetitions, classes, toFolder);
    meanAccuracy_svmRT{whichBin} = mean_acc_svm;
    sdAccuracy_svmRT{whichBin} = std_acc_svm;
    %     x = 2 : size(mean_acc_svm{whichBin},2) + 1;
    %     h = figure;
    %     shadedErrorBar(x, mean_acc_svm{whichBin}, std_acc_svm{whichBin}, 'r');
    %     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
    %     set(h,'color','white', 'PaperPositionMode', 'auto');
    %     stringa_fig=sprintf('c_svm linear discrimination -%s .eps', clas);
    %     saveas(h,fullfile(tofolder,stringa_fig),'epsc')
end
save(fullfile(toFolder, fileSave), 'repetitions', 'meanAccuracy_svmRT', 'sdAccuracy_svmRT', '-append')
clear dataAll1 data labels

%% trajectories - all odors
classes = 'all-trajectories';

dataAllT = populatioPatternTrials{1};
n_neurons = size(dataAllT,1);
for whichBin = 2:response_window./bin_size;
    dataAllT = [dataAllT; populatioPatternTrials{whichBin}];
end
neurons = size(dataAllT,1);
trials = size(dataAllT,2);
stimuli = size(dataAllT,3);
dataAllT = reshape(dataAllT, neurons, trials .* stimuli);
dataAllT = dataAllT';
% rescale to [0 1];
dataAllT = (dataAllT - repmat(min(dataAllT,[],1),size(dataAllT,1),1))*spdiags(1./(max(dataAllT,[],1)-min(dataAllT,[],1))',0,size(dataAllT,2),size(dataAllT,2));
dataAllT = dataAllT';
dataAllT = reshape(dataAllT, neurons, trials, stimuli);

labels      = ones(1,size(dataAllT,2));
app_labels  = labels;
for odor = 1:size(dataAllT,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAllT,2))];
end
labels = repmat(labels, 1, response_window./bin_size);
labels      = labels';

repetitions = 200;
trainingNumber = 56;
[mean_acc_svmT, std_acc_svmT] = odor_c_svm_traj(dataAllT, n_neurons, trainingNumber, labels, repetitions, classes, toFolder);
meanAccuracy_svmT = mean_acc_svmT;
sdAccuracy_svmT = std_acc_svmT;

save(fullfile(toFolder, fileSave), 'repetitions', 'meanAccuracy_svmT', 'sdAccuracy_svmT', '-append')
clear dataAllT labels




%% Train with two odors and predict two different odors

for whichBin = 1:response_window./bin_size;
    classes = 'predict';
    dataAll = populatioPatternTrials{whichBin};
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    % rescale to [0 1];
    dataAll = (dataAll - repmat(min(dataAll,[],1),size(dataAll,1),1))*spdiags(1./(max(dataAll,[],1)-min(dataAll,[],1))',0,size(dataAll,2),size(dataAll,2));
    dataAll = dataAll';
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    

    repetitions = 200;
    [mean_acc_svm1, std_acc_svm1, mean_acc_svm2, std_acc_svm2] = odor_c_svm_pred(dataAll, repetitions, classes, toFolder);
    meanAccuracy_svm1{whichBin} = mean_acc_svm1;
    sdAccuracy_svm1{whichBin} = std_acc_svm1;
    meanAccuracy_svm2{whichBin} = mean_acc_svm2;
    sdAccuracy_svm2{whichBin} = std_acc_svm2;
%     x = 2 : size(meanAccuracy_svm1{whichBin} ,2) + 1;
%     h = figure;
%     shadedErrorBar(x, meanAccuracy_svm1{whichBin} , sdAccuracy_svm1{whichBin}, 'r');
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
%     set(h,'color','white', 'PaperPositionMode', 'auto');
%     stringa_fig=sprintf('c_svm linear discrimination -%s .eps', clas);
%     saveas(h,fullfile(toFolder,stringa_fig),'epsc')
%     h = figure;
%     shadedErrorBar(x, meanAccuracy_svm2{whichBin}, sdAccuracy_svm2{whichBin}, 'r');
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
%     set(h,'color','white', 'PaperPositionMode', 'auto');
%     stringa_fig=sprintf('c_svm linear discrimination -%s .eps', clas);
%     saveas(h,fullfile(toFolder,stringa_fig),'epsc')
end
save(fullfile(toFolder, fileSave), 'repetitions', 'meanAccuracy_svm1', 'sdAccuracy_svm1', 'meanAccuracy_svm2', 'sdAccuracy_svm2', '-append')
clear dataAll




