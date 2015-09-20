


%% baseline firing 
[baselineHist,edges1] = histcounts(base .* 1/bin_size, 100, 'Normalization', 'probability');
h=figure('Name','Baseline firing', 'NumberTitle','off');
histogram(base .* 1/bin_size, 100, 'Normalization', 'probability');
title('Baseline firing'), xlabel('Hz'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Baseline firing.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, filename), 'base')




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
save(fullfile(toFolder, filename), 'pExcResponse', 'pInhResponse', '-append')

% probability of excitatory and inhibitory responses for each odor
pExcResponseOdor = sum(excitatory_odors_matrix,1) ./ size(excitatory_odors_matrix,1);
pInhResponseOdor = sum(inhibitory_odors_matrix,1) ./ size(inhibitory_odors_matrix,1);
h=figure('Name','Response probability to each odor', 'NumberTitle','off');
subplot(1,2,1)
bar(pExcResponseOdor)
title('Excitatory responses'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
bar(pInhResponseOdor)
title('Inhibitory responses'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, filename), 'pExcResponseOdor', 'pInhResponseOdor', '-append')

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
save(fullfile(toFolder, filename), 'nOdorExcResponses', 'nOdorInhResponses', '-append')


%% # of delta spikes emitted for all odors
edges5 = -0.5:1:ceil(max(anExcResponse(:)))+0.5;
emSpikes = anExcResponse; %+ baselineCellOdorPair;
distEmSpikes = histcounts(round(emSpikes(:)), edges5, 'Normalization', 'probability');
h=figure('Name','Number of extra spikes emitted in response to an odor', 'NumberTitle','off');
histogram(emSpikes(:), edges5, 'Normalization', 'probability')
xlim([0.5 50.5]); ylim([0 0.1]);
title('Number of extra spikes emitted in response to an odor'), ylabel('Proportion of units'), xlabel('Number of spikes')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of extra spikes emitted in response to an odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, filename), 'emSpikes', '-append')

% # of spikes emitted for each odor
h=figure('Name','Number of extra spikes emitted in response to each odor', 'NumberTitle','off');
for k=1:size(anExcResponse,2)
    distEmSpikesOdor = histcounts(round(emSpikes(:,k)), edges5, 'Normalization', 'probability');
    xlim([0.5 50.5]); ylim([0 0.1]);
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
    subplot(4,2,k)
    histogram(emSpikes(:,k), edges5, 'Normalization', 'probability')
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
save(fullfile(toFolder, filename), 'ps', 'ls', '-append')


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
save(fullfile(toFolder, filename), 'cv_cellOdorPair', 'app_base', 'app_delta_response', 'app_analog_delta_response_trial', '-append')


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
save(fullfile(toFolder, filename), 'norm_adapt_cellOdorPair', '-append')





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
save(fullfile(toFolder, filename), 'signalVector', '-append')


selectedSignalVector = signalVector(responsiveCells',:);
save(fullfile(toFolder, filename), 'selectedSignalVector', '-append')


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
save(fullfile(toFolder, filename), 'signal_correlation', '-append')


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




%% clustering

whichBin = 2;

for odor = 1:size(anExcResponse,2)
    unit = 1;
    for good = responsiveCells' %1:size(anExcResponse,1)
        populationPattern(unit, odor) = mean(app_delta_response{good}(whichBin,:,odor),2);
        populatioPatternTrials(unit,:,odor) = app_delta_response{good}(whichBin,:,odor);
        unit = unit + 1;
    end
end
save(fullfile(toFolder, filename), 'whichBin', 'populationPattern', 'populatioPatternTrials', '-append')

h=figure('Name','Noise correlation', 'NumberTitle','off');
for odor = 1:size(anExcResponse,2)
    popPatternTrial = squeeze(populatioPatternTrials(:,:,odor));
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

save(fullfile(toFolder, filename), 'distanceMatrix', 'Z', 'ccc', '-append')

% Y = mdscale(D,2,'criterion','stress');
% figure
% plot(Y(:,1),Y(:,2),'o','LineWidth',2);


%% population noise correlations

[rr,p] = corr(populatioPatternTrials(:,:,1));
meanCorr(1) = mean(rr(:));
[cc,p] = corr(populatioPatternTrials(:,:,2));
meanCorr(2) = mean(cc(:));
[bb,p] = corr(populatioPatternTrials(:,:,3));
meanCorr(3) = mean(bb(:));
[uu,p] = corr(populatioPatternTrials(:,:,4));
meanCorr(4) = mean(uu(:));
[tt,p] = corr(populatioPatternTrials(:,:,5));
meanCorr(5) = mean(tt(:));
[mm,p] = corr(populatioPatternTrials(:,:,6));
meanCorr(6) = mean(mm(:));
[oo,p] = corr(populatioPatternTrials(:,:,7));
meanCorr(7) = mean(oo(:));

save(fullfile(toFolder, filename), 'meanCorr', '-append')

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
[rc,p] = corr(populatioPatternTrials(:,:,1), populatioPatternTrials(:,:,2));
rc(:,2) = [];
mrc = mean(rc(:));
[rm,p] = corr(populatioPatternTrials(:,:,1), populatioPatternTrials(:,:,6));
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
imagesc([mr/mr mrc/mr mrm/mr], [0 1]), axis off, colorbar
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Average correlations between odors.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, filename), 'mrc', 'mrm', '-append')


%% linear discrimination

repetitions = 10;
targets = ones(1,10);
odorant = targets;
for k=1:6
    targets = [targets, odorant + k .* ones(1,10)];
end
targets = targets';

for k = 1 : repetitions
    for nSamples = 2 : size(populatioPatternTrials,1) - 1
        for odor = 1:size(populatioPatternTrials,3)
            trainingUnits(:,:,odor) = populatioPatternTrials(randsample(size(populatioPatternTrials,1), nSamples), :, odor);
        end
        reshaped_trainingUnits = reshape(trainingUnits, size(trainingUnits,1), size(trainingUnits,2) .* size(trainingUnits,3));
        rppt = reshaped_trainingUnits';
        obj = fitcdiscr(rppt,targets);
        resuberror(k, nSamples - 1) = resubLoss(obj);
        R (:,:,nSamples-1) = confusionmat(obj.Y,resubPredict(obj));
        clear trainingUnits
        clear reshaped_trainingUnits
        clear rppt
        clear obj
    end
end

avgResuberror = mean(resuberror);
stdResuberror = std(resuberror);

x = 2 : size(populatioPatternTrials,1) - 1;
figure
shadedErrorBar(1:100, avgResuberror(1:100), stdResuberror(1:100), 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');

save(fullfile(toFolder, filename), 'repetitions', 'targets', 'avgResuberror', 'stdResuberror', '-append')









