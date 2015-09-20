%clear all
close all


toFolder = pwd;
new_dir = 'All experiments_long';
toFolder = fullfile(toFolder, new_dir);
mkdir(toFolder)
matfil = sprintf('units_T.mat');
fileSave = fullfile(toFolder, matfil);

baseT = [];
excitatory_odors_matrixT = [];
inhibitory_odors_matrixT = [];
peakResponseT = [];
tuning_cellT = [];
baselineCellOdorPairT = [];
anExcResponseT = [];
anInhResponseT = [];
pExcResponseT = [];
pInhResponseT = [];
pExcResponseOdorT = [];
pInhResponseOdorT = [];
nOdorExcResponsesT = [];
nOdorInhResponsesT = [];
emittedSpikesT = [];
psT = [];
lsT = [];
selectedSignalVectorT = [];
coefficientsWithinProbesT = [];
coefficientsBetweenProbesT = [];
entT = [];



% List = uipickfiles('FilterSpec', toFolder, ...
%     'Prompt',    'Pick all the folders you want to analyze');

for ii = 1 : length(List)
    folder = List{ii};
    cd(folder)
    
    load('units.mat');
    
    baseT = [baseT base];
    excitatory_odors_matrixT = [excitatory_odors_matrixT; excitatory_odors_matrix];
    inhibitory_odors_matrixT = [inhibitory_odors_matrixT; inhibitory_odors_matrix];
    baselineCellOdorPairT = [baselineCellOdorPairT; baselineCellOdorPair];
    anExcResponseT = [anExcResponseT; anExcResponse];
    anInhResponseT = [anInhResponseT; anInhResponse];
    pExcResponseT = [pExcResponseT; pExcResponse];
    pInhResponseT = [pInhResponseT; pInhResponse];
    pExcResponseOdorT = [pExcResponseOdorT; pExcResponseOdor];
    pInhResponseOdorT = [pInhResponseOdorT; pInhResponseOdor];
    nOdorExcResponsesT = [nOdorExcResponsesT; nOdorExcResponses];
    nOdorInhResponsesT = [nOdorInhResponsesT; nOdorInhResponses];
    emittedSpikesT = [emittedSpikesT; emittedSpikes];
    psT = [psT ps];
    lsT = [lsT ls];
    entT = [entT ent];
    selectedSignalVectorT = [selectedSignalVectorT; selectedSignalVector];
    coefficientsWithinProbesT = [coefficientsWithinProbesT coefficientsWithinProbes_together];
    coefficientsBetweenProbesT = [coefficientsBetweenProbesT coefficientsBetweenProbes];
end
load('parameters.mat');


%% baseline firing
[baselineHist,edges1] = histcounts(baseT .* 1/bin_size, 100, 'Normalization', 'probability');
h=figure('Name','Baseline firing', 'NumberTitle','off');
histogram(baseT .* 1/bin_size, 100, 'Normalization', 'probability');
xlim([0 40]); ylim([0 0.3]);
title('Baseline firing'), xlabel('Hz'), ylabel('Proportion of units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Baseline firing.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'baseT')
        
        


%%odor representations

exc_resp_odor = mean(anExcResponseT);
%resp_odor = floor(resp_odor*10)+1;
h=figure('Name','Excitatory intensity per odor', 'NumberTitle','off');
plot(exc_resp_odor)
ylabel('Excitatory intensity'), xlabel('odor label')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Excitatory intensity per odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'exc_resp_odor', '-append')

inh_resp_odor = mean(anInhResponseT);
%resp_odor = floor(resp_odor*10)+1;
h=figure('Name','Inhibitory intensity per odor', 'NumberTitle','off');
plot(inh_resp_odor)
ylabel('Inhibitory intensity'), xlabel('odor label')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Inhibitory intensity per odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'inh_resp_odor', '-append')


for i = 1:odors
    mean_sel_tuning(i,:) = mean(anExcResponseT(find(sum(excitatory_odors_matrixT,2)==i),:),1);
    try
        max_sel_tuning(i,:) = max(anExcResponseT(find(sum(excitatory_odors_matrixT,2)==i),:),[],1);
    catch
        max_sel_tuning(i,:) = zeros(1,odors);
    end
end
mean_sel_tuning(isnan(mean_sel_tuning)) = 0;
max_sel_tuning(isnan(max_sel_tuning)) = 0;
imagesc(max_sel_tuning)
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('selectivity class'); xlabel('odor label')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Odor representation per selectivity class.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'signalVector', '-append')



%% probability of excitatory and inhibitory responses for any odor
[pExcResponseHist, edges2] = histcounts(pExcResponseT, 20, 'Normalization', 'probability');
[pInhResponseHist, edges3] = histcounts(pInhResponseT, 20, 'Normalization', 'probability');
h=figure('Name','Response probability to any odor', 'NumberTitle','off');
subplot(1,2,1)
histogram(pExcResponseT, 20, 'Normalization', 'probability')
ylim([0 1]);
title('Excitatory responses'), ylabel('Proportion of units'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(pInhResponseT, 20, 'Normalization', 'probability')
ylim([0 1]);
title('Inhibitory responses'), ylabel('Proportion of units'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to any odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'pExcResponseT', 'pInhResponseT', '-append')       
        
% probability of excitatory and inhibitory responses for each odor
pExcResponseOdorT = sum(excitatory_odors_matrixT,1) ./ size(excitatory_odors_matrixT,1);
pInhResponseOdorT = sum(inhibitory_odors_matrixT,1) ./ size(inhibitory_odors_matrixT,1);
h=figure('Name','Response probability to each odor', 'NumberTitle','off');
subplot(1,2,1)
bar(pExcResponseOdorT)
ylim([0 1]);
title('Excitatory responses'), ylabel('Proportion of units')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
bar(pInhResponseOdorT)
ylim([0 1]);
title('Inhibitory responses'), ylabel('Proportion of units')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'pExcResponseOdorT', 'pInhResponseOdorT', '-append')       
        
% number of odors that elicit an excitatory/inhibitory response for each cell
edges4 = [-0.5:1:size(excitatory_odors_matrixT,2)+0.5];
h=figure('Name','Number of odors that elicit a response for each unit', 'NumberTitle','off');
subplot(1,2,1)
histogram(nOdorExcResponsesT, edges4, 'Normalization', 'probability')
title('Excitatory responses'), ylabel('Proportion of units'), xlabel('Number of odors')
xlim([-0.5 size(excitatory_odors_matrixT,2)+0.5]); ylim([0 1]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(nOdorInhResponsesT, edges4, 'Normalization', 'probability')
title('Inhibitory responses'), ylabel('Proportion of units'), xlabel('Number of odors')
xlim([-0.5 size(excitatory_odors_matrixT,2)+0.5]); ylim([0 1]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of odors that elicit a response for each unit.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'nOdorExcResponsesT', 'nOdorInhResponsesT', '-append')

%% # of delta spikes emitted for all odors
edges5 = -0.5:1:ceil(max(anExcResponseT(:)))+0.5;
distEmSpikes = histcounts(round(emittedSpikesT(:)), edges5, 'Normalization', 'probability');
h=figure('Name','Number of extra spikes emitted in response to an odor', 'NumberTitle','off');
histogram(emittedSpikesT(:), edges5, 'Normalization', 'probability')
xlim([0.5 50.5]); ylim([0 0.1]);
title('Number of extra spikes emitted in response to an odor'), ylabel('Proportion of units'), xlabel('Number of spikes')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of extra spikes emitted in response to an odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'emittedSpikesT', '-append')

%% sparseness
h=figure('Name','Sparseness measures', 'NumberTitle','off');
edges7 = -0.005:0.01:1.005;
ps = population_sparseness(anExcResponseT, size(anExcResponseT,1), size(anExcResponseT,2));
distPs = histcounts(ps, edges7);
subplot(1,2,1)
histogram(ps, edges7)
xlim([-0.05 1.05]); ylim([0 4.5]);
ylabel('Number of odors'), xlabel('Population sparseness')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
ls = lifetime_sparseness(anExcResponseT, size(anExcResponseT,1), size(anExcResponseT,2));
distLs = histcounts(ls, edges7);
subplot(1,2,2)
ls(ls>0.99) = [];
histogram(ls, edges7)
xlim([-0.05 1.05]); ylim([0 60]);
ylabel('Number of units'), xlabel('Lifetime sparseness')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Sparseness measures.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'ps', 'ls', '-append')

%% signal vectors correlations
% app = [coefficientsWithinProbesT coefficientsBetweenProbesT];
% labelWithin = repmat('within', length(coefficientsWithinProbesT), 1);
% labelBetween = repmat('between', length(coefficientsBetweenProbesT), 1);
% labelsWB = strvcat(labelWithin, labelBetween);
% h=figure('Name','Within and between shanks signal correlations', 'NumberTitle','off');
% boxplot(app,labelsWB)
% ylabel('Correlation')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('Within and between shanks signal correlations.eps');
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
h=figure('Name','Within and between correlations (cdf)', 'NumberTitle','off');
cdfplot(coefficientsWithinProbesT)
hold on
cdfplot(coefficientsBetweenProbesT)
title('tuning curves correlations')
xlabel('Pearson correlation')
legend('within','between','Location','NW')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Within and between correlations (cdf).eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
[f, p_corr_with_bet]=kstest2(coefficientsWithinProbesT,coefficientsBetweenProbesT);
 save(fileSave, 'coefficientsWithinProbesT', 'coefficientsBetweenProbesT', 'p_corr_with_bet', '-append')


 selectedSignalVectorT_app = zscore(selectedSignalVectorT');
 selectedSignalVectorT = selectedSignalVectorT_app';
signal_correlationT = corr(selectedSignalVectorT');
index = find(triu(ones(size(signal_correlationT)), 1));
coefficients = signal_correlationT(index);
mean_coefficient = mean(coefficients(:));
sim_tuning = pdist(selectedSignalVectorT, 'correlation');
squared_simTuning = squareform(sim_tuning);
figure, imagesc(squared_simTuning, [0 2]), axis square, axis off
B = squared_simTuning < 0.6;
pp = symrcm(B);
h = figure;
imagesc(signal_correlationT(pp,pp), [-1 1]), axis square, axis off, colorbar
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Signal correlation.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'signal_correlationT', '-append')

app1_selectedSignalVectorT = selectedSignalVectorT(pp',:);

h=figure;
imagesc(app1_selectedSignalVectorT), colormap(b2r(-20, 20)), axis off
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Tuning functions clustered by similarity.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
 save(fileSave, 'selectedSignalVectorT', '-append')


