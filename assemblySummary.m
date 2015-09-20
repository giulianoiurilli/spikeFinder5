clear all
close all

experimentFolder = uigetdir2;
toFolder = uigetdir('', 'Save in');
fileSave = sprintf('assemblySummary.mat');
cd(experimentFolder{1});

D1 = dir([experimentFolder{1}, '/*.mat']);
num1 = length(D1(not([D1.isdir])));

%% loading
base = [];
response = [];
exc_resp = [];
inh_resp = [];
z = 1;
for index = 1:num1
    load(D1(index).name)
    for ensemble = 1:length(meanBaselineAssemblyTrial)
        base(z,:) = meanBaselineAssemblyTrial{ensemble};
        response(z,:) = meanResponseAssemblyTrial{ensemble};
        exc_resp(z,:) = responsiveAssemblyOdorPair{ensemble}(:,1)';
        inh_resp(z,:) = responsiveAssemblyOdorPair{ensemble}(:,2)';
        z = z + 1;
    end
    clear good
end


deltaResponse = response - base;
deltaResponseZscored = zscore(deltaResponse, 0, 2);
resp = exc_resp + inh_resp;

for ensemble = 1:size(deltaResponseZscored, 1)
    idx = find(resp(ensemble,:) == 0); 
    deltaResponseZscored(ensemble, idx) = 0;
end

save(fullfile(toFolder, fileSave), 'deltaResponse', 'deltaResponseZscored')


%% tuning
signal_correlation = corr(deltaResponseZscored');
coefficients = triu(signal_correlation, 0);
mean_coefficient = mean(coefficients(:));
sim_tuning = pdist(deltaResponseZscored, 'correlation');
squared_simTuning = squareform(sim_tuning);
figure, imagesc(squared_simTuning, [0 2]), axis square, axis off
B = squared_simTuning < 0.6;
pp = symrcm(B);
app1_deltaResponseZscored = deltaResponseZscored(pp',:);
h=figure;
imagesc(app1_deltaResponseZscored), colormap(b2r(-1, 1))
set(findobj(gcf, 'type','axes'), 'Visible','off')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Assemblies tuning.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')

v = ones(1, size(deltaResponseZscored,2)) ./ size(deltaResponseZscored,2);
k = 1 ./ (v * log2(v)');
for s = 1:size(deltaResponseZscored,1)
    app_deltaResponseZscored(s,:) = (deltaResponseZscored(s,:) - min(deltaResponseZscored(s,:))) + 0.001;
    p_deltaResponseZscored(s,:) = app_deltaResponseZscored(s,:) ./ sum(app_deltaResponseZscored(s,:));
    ent(s) = k .* (p_deltaResponseZscored(s,:) * log2(p_deltaResponseZscored(s,:))');
end
h=figure('Name','Entropy', 'NumberTitle','off');
histogram(ent, 50, 'Normalization', 'probability');
xlim([0 1]);
ylabel('Proportion of assemblies'), xlabel('Entropy')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Entropy.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'ent', '-append')


%% probability of excitatory and inhibitory responses for any odor
pExcResponse = sum(exc_resp,2) ./ size(exc_resp,2);
pInhResponse = sum(inh_resp,2) ./ size(inh_resp,2);
[pExcResponseHist, edges2] = histcounts(pExcResponse, 20, 'Normalization', 'probability');
[pInhResponseHist, edges3] = histcounts(pInhResponse, 20, 'Normalization', 'probability');
h=figure('Name','Response probability to any odor', 'NumberTitle','off');
subplot(1,2,1)
histogram(pExcResponse, 20, 'Normalization', 'probability')
title('Excitatory responses'), ylabel('Proportion of assemblies'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(pInhResponse, 20, 'Normalization', 'probability')
title('Inhibitory responses'), ylabel('Proportion of assemblies'), xlabel('p(response)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to any odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'pExcResponse', 'pInhResponse', '-append')

% probability of excitatory and inhibitory responses for each odor
pExcResponseOdor = sum(exc_resp,1) ./ size(exc_resp,1);
pInhResponseOdor = sum(inh_resp,1) ./ size(inh_resp,1);
h=figure('Name','Response probability to each odor', 'NumberTitle','off');
subplot(1,2,1)
bar(pExcResponseOdor)
title('Excitatory responses'), ylabel('Proportion of assemblies')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
bar(pInhResponseOdor)
title('Inhibitory responses'), ylabel('Proportion of assemblies')
%set_xtick_label(labels, 90)
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Response probability to each odor.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'pExcResponseOdor', 'pInhResponseOdor', '-append')

% number of odors that elicit an excitatory/inhibitory response for each cell
edges4 = [-0.5:1:size(inh_resp,2)+0.5];
nOdorExcResponses = sum(exc_resp,2);
pnOdorExcResponses = histcounts(nOdorExcResponses, edges4, 'Normalization', 'probability');
nOdorInhResponses = sum(inh_resp,2);
pnOdorInhResponses = histcounts(nOdorInhResponses, edges4, 'Normalization', 'probability');
h=figure('Name','Number of odors that elicit a response for each assembly', 'NumberTitle','off');
subplot(1,2,1)
histogram(nOdorExcResponses, edges4, 'Normalization', 'probability')
title('Excitatory responses'), ylabel('Proportion of assemblies'), xlabel('Number of odors')
xlim([-0.5 size(exc_resp,2)+0.5]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(1,2,2)
histogram(nOdorInhResponses, edges4, 'Normalization', 'probability')
title('Inhibitory responses'), ylabel('Proportion of assemblies'), xlabel('Number of odors')
xlim([-0.5 size(exc_resp,2)+0.5]);
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Number of odors that elicit a response for each assembly.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fullfile(toFolder, fileSave), 'nOdorExcResponses', 'nOdorInhResponses', '-append')








cd ..
save(fullfile(toFolder, fileSave), 'base', 'response', 'exc_resp', 'inh_resp', 'deltaResponse', 'deltaResponseZscored')