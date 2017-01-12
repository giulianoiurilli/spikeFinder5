loadExperiments
%% odor ID decoding as in Fig. 4A
odors = 1:15;
option = [];
option.units = 'incrementing_by_one';
option.repetitions =500;
[performanceCoa15, confusionMatrixCoa15] = perform_linear_svm_decoding(coa15.esp, odors, option);
[performancePcx15, confusionMatrixPcx15] = perform_linear_svm_decoding(pcx15.esp, odors, option);
[performanceTogether15, confusionTogetherPcx15] = perform_linear_svm_decoding([pcx15.esp coa15.esp], 1:15, option);
%% negative controls as in Fig. 4A
option = [];
option.units = 'incrementing_by_one';
option.repetitions = 50;
option.shuffle  = 1;
option.number_of_shuffles = 10;
[performanceCoa15shuffled, confusionMatrixCoa15shuffled] = perform_linear_svm_decoding(coa15.esp, 1:15, option);
[performancePcx15shuffled, confusionMatrixPcx15shuffled] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);
%% figure accuracy
figure
shadedErrorBar(1:95, mean(performancePcx15(:,1:95),1), std(performancePcx15(:,1:95),1)./sqrt(499),{'color', pcxC, 'linewidth', 2});
hold on
shadedErrorBar(1:95, mean(performanceCoa15(:,1:95),1), std(performanceCoa15(:,1:95),1)./sqrt(499), {'color', coaC, 'linewidth', 2});
plot(mean(performanceTogether15,1), 'color', [77,175,74]./255, 'linewidth', 2);
plot(mean(performancePcx15shuffled,1), ':', 'color', pcxC, 'linewidth', 2);
plot(mean(performanceCoa15shuffled,1),':', 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
xlim([0 95])
ylabel('Accuracy %')
%% figure confusion matrix
clim = [0 1];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(confusionMatrixCoa15, clim)
colormap(brewermap([],'*YlGnBu'))
axis square
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

clim = [0 1];
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(confusionMatrixPcx15, clim)
colormap(brewermap([],'*YlGnBu'))
axis square
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%% remove signal correlation before decoding odor ID
option = [];
option.units = 'incrementing_by_one';
option.repetitions = 50;
option.decorr = 'signal';
option.number_of_decorrelations = 10;
[performanceCoa15NoSignalCorr, confusionMatrixCoa15NoSignalCorr] = perform_linear_svm_decoding(coa15.esp, 1:15, option);
[performancePcx15NoSignalCorr, confusionMatrixPcx15NoSignalCorr] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);
%% remove noise correlation before decoding odor ID
option = [];
option.units = 'incrementing_by_one';
option.repetitions = 50;
option.decorr = 'noise';
option.number_of_decorrelations = 10;
[performanceCoa15NoNoiseCorr, confusionMatrixCoa15shuffledNoNoiseCorr] = perform_linear_svm_decoding(coa15.esp, 1:15, option);
[performancePcx15shuffledNoNoiseCorr, confusionMatrixPcx15shuffledNoNoiseCorr] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);
%% valence l-svm decoding - 10 odors, 2classes  as in Fig. 4K
option = [];
option.units = 'incrementing_by_10';
option.repetitions = 500;
option.grouping = [ones(1,5) 2*ones(1,5)];

n_comb = nchoosek(10,5)/2;
odorsRearranged2Coa = nan*ones(n_comb,10);
odorsRearranged2Pcx = nan*ones(n_comb,10);
combinations = combnk(1:10, 5);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = [4     6     7     9    10     1     2     3     5     8];
odorsRearrangedPcx =  [4     6     7     9    10     1     2     3     5     8];
for idxRep = 1:n_comb
    if idxRep == 1
        odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
        app1 = perform_linear_svm_decoding(coaAA.esp, odorsRearranged2Coa(idxRep,:),option);
        odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
        app2 = perform_linear_svm_decoding(pcxAA.esp, odorsRearranged2Pcx(idxRep,:),option);
        performanceValenceShuffledCoa = nan*ones(n_comb,size(app1,2));
        performanceValenceShuffledPcx = nan*ones(n_comb,size(app2,2));
        performanceValenceShuffledCoa(idxRep,:) = mean(app1);
        performanceValenceShuffledPcx(idxRep,:) = mean(app2);
    else
        odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
        app1 = perform_linear_svm_decoding(coaAA.esp, odorsRearranged2Coa(idxRep,:),option);
        odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
        app2 = perform_linear_svm_decoding(pcxAA.esp, odorsRearranged2Pcx(idxRep,:),option);
        performanceValenceShuffledCoa(idxRep,:) = mean(app1);
        performanceValenceShuffledPcx(idxRep,:) = mean(app2);
    end
end

performanceValenceCoa = perform_linear_svm_decoding(coaAA.esp, odorsRearrangedCoa,option);
performanceValencePcx = perform_linear_svm_decoding(pcxAA.esp, odorsRearrangedPcx,option);
percentiles_CoaAA = prctile(performanceValenceShuffledCoa, [2.5, 97.5], 2);
percentiles_PcxAA = prctile(performanceValenceShuffledPcx, [2.5, 97.5], 2);

%% figure
figure
plot(2:10:10*(size(performanceValencePcx,2)-2), performanceValenceShuffledPcx(:,1:9)', 'o', 'color', [166,206,227]./255, 'MarkerSize', 2, 'MarkerFaceColor', pcxC);
hold on
plot(1:10:10*size(performanceValenceCoa,2), performanceValenceShuffledCoa', 'o', 'color', [251,154,153]./255, 'MarkerSize', 2, 'MarkerFaceColor', coaC);
hold on
plot(2:10:10*(size(performanceValencePcx,2)-2), mean(performanceValencePcx(:,1:9),1), '-o', 'color', pcxC, 'linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', pcxC);
hold on
plot(1:10:10*size(performanceValenceCoa,2), mean(performanceValenceCoa,1),'-o', 'color', coaC, 'linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', coaC);

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')

%% chemical class l-SVM decoding - 15 odors, 5 classes  as in Fig. 4H
% odors = [1 2 3 11 12 13 4 5 6 8 9 10 7 14 15];
option = [];
option.units = 'incrementing_by_10';
option.repetitions = 500;
option.grouping = [ones(1,3) 2*ones(1,3) 3*ones(1,3) 4*ones(1,3) 5*ones(1,3)];
lista = [];
odors = 1:15;
for k = 1:150
    app = odors;
    list = [];
    for j = 1:4
        idx = randperm(size(app,2));
        app = app(idx);
        list = [list app(1:3)];
        app = app(4:end);
    end
    list = [list app];
    lista(k,:) = list;
end
for idxRep = 1:150
    if idxRep == 1
        app1 = perform_linear_svm_decoding(coa15.esp, lista(idxRep,:),option);
        app2 = perform_linear_svm_decoding(pcx15.esp, lista(idxRep,:),option);
        performanceChemicalShuffledCoa = nan(150, size(app1,2));
        performanceChemicalShuffledPcx = nan(150, size(app2,2));
        performanceChemicalShuffledCoa(idxRep,:) = mean(app1);
        performanceChemicalShuffledPcx(idxRep,:) = mean(app2);
    else
        app1 = perform_linear_svm_decoding(coa15.esp, lista(idxRep,:),option);
        app2 = perform_linear_svm_decoding(pcx15.esp, lista(idxRep,:),option);
        performanceChemicalShuffledCoa(idxRep,:) = mean(app1);
        performanceChemicalShuffledPcx(idxRep,:) = mean(app2);
    end
end
performanceChemicalCoa = perform_linear_svm_decoding(coa15.esp, odors, option);
performanceChemicalPcx = perform_linear_svm_decoding(pcx15.esp, odors, option);
%% figure
figure
plot(2:10:10*size(performanceChemicalPcx,2)+1, performanceChemicalShuffledPcx', 'o', 'color', [166,206,227]./255, 'MarkerSize', 2, 'MarkerFaceColor', pcxC);
hold on
plot(1:10:10*(size(performanceChemicalCoa,2)-4), performanceChemicalShuffledCoa(:,1:10)', 'o', 'color', [251,154,153]./255, 'MarkerSize', 2, 'MarkerFaceColor', coaC);
hold on
plot(2:10:10*size(performanceChemicalPcx,2)+1, mean(performanceChemicalPcx,1), '-o', 'color', pcxC, 'linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', pcxC);
hold on
plot(1:10:10*(size(performanceChemicalCoa,2)-4), mean(performanceChemicalCoa(:,1:10),1),'-o', 'color', coaC, 'linewidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', coaC);

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
%%
n_odors = 15;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coa15.esp, 1:n_odors, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcx15.esp, 1:n_odors, 1, 0);

option = [];
option.repetitions = 100;
n_odors = 15;
sua_performance_coa = nan(1,totalResponsiveSUACoa);
sua_MI_coa = nan(1,totalResponsiveSUACoa);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(coa15.esp, 1:n_odors, option);
    sua_performance_coa(idxUnit) = mean(app);
    sua_MI_coa(idxUnit) = miApp;
end

sua_performance_pcx = nan(1,totalResponsiveSUAPcx);
sua_MI_pcx =  nan(1,totalResponsiveSUAPcx);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app2, app3, miApp] = perform_linear_svm_decoding(pcx15.esp, 1:n_odors, option);
    sua_performance_pcx(idxUnit) = mean(app);
    sua_MI_pcx(idxUnit) = miApp;
end


%% 
option = [];
option.units = 'sorted';
option.sorting_vector = sua_performance_coa;
option.repetitions = 500;
[performanceCoa15Sorted, confusionMatrixCoa15Sorted] = perform_linear_svm_decoding(coa15.esp, 1:15, option);

option = [];
option.units = 'sorted';
option.sorting_vector = sua_performance_pcx;
option.repetitions = 500;
[performancePcx15Sorted, confusionMatrixPcx15Sorted] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);

%% as in Fig. 4F
option = [];
option.units = 'remove';
option.sorting_vector = sua_performance_coa;
option.repetitions = 500;
[performanceCoa15Removed, confusionMatrixCoa15Removed] = perform_linear_svm_decoding(coa15.esp, 1:15, option);

option = [];
option.units = 'remove';
option.sorting_vector = sua_performance_pcx;
option.repetitions = 500;
[performancePcx15Removed, confusionMatrixPcx15Removed] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);

%% as in Fig. 4E
option = [];
option.units = 'sorted';
option.sorting_vector = sua_MI_coa;
option.repetitions = 500;
[performanceCoa15SortedMI, confusionMatrixCoa15Sorted] = perform_linear_svm_decoding(coa15.esp, 1:15, option);

option = [];
option.units = 'sorted';
option.sorting_vector = sua_MI_pcx;
option.repetitions = 500;
[performancePcx15SortedMI, confusionMatrixPcx15Sorted] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);


option = [];
option.units = 'remove';
option.sorting_vector = sua_MI_coa;
option.repetitions = 500;
[performanceCoa15RemovedMI, confusionMatrixCoa15Removed] = perform_linear_svm_decoding(coa15.esp, 1:15, option);

option = [];
option.units = 'remove';
option.sorting_vector = sua_MI_pcx;
option.repetitions = 500;
[performancePcx15RemovedMI, confusionMatrixPcx15Removed] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);
%% figure
figure
plot(mean(performancePcx15SortedMI,1), 'color', pcxC, 'linewidth', 2);
hold on
plot(mean(performanceCoa15SortedMI,1), 'color', coaC, 'linewidth', 2);

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')

figure
plot(mean(performancePcx15RemovedMI,1), 'color', pcxC, 'linewidth', 2);
hold on
plot(mean(performanceCoa15RemovedMI,1), 'color', coaC, 'linewidth', 2);
hold on
plot(repmat(max(sua_performance_pcx),1,size(performancePcx15RemovedMI,2)), '--', 'color', pcxC, 'linewidth', 2) 
hold on
plot(repmat(max(sua_performance_coa),1,size(performanceCoa15RemovedMI,2)), '--', 'color', coaC, 'linewidth', 2) 


set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')

%%
n_odors = 15;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coa15.esp, 1:n_odors, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcx15.esp, 1:n_odors, 1, 0);

option = [];
option.repetitions = 100;
option.grouping = [ones(1,3) 2*ones(1,3) 3*ones(1,3) 4*ones(1,3) 5*ones(1,3)];
n_odors = 15;
sua_performance_coaChemical = nan(1,totalResponsiveSUACoa);
sua_MI_coaChemical = nan(1,totalResponsiveSUACoa);
sua_MI_pcxChemical = nan(1,totalResponsiveSUACoa);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app1, app2, mi] = perform_linear_svm_decoding(coa15.esp, 1:n_odors, option);
    sua_performance_coaChemical(idxUnit) = mean(app);
    sua_MI_coaChemical(idxUnit) = mi;
end

sua_performance_pcxChemical = nan(1,totalResponsiveSUAPcx);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app1, app2, mi]  = perform_linear_svm_decoding(pcx15.esp, 1:n_odors, option);
    sua_performance_pcxChemical(idxUnit) = mean(app);
    sua_MI_pcxChemical(idxUnit) = mi;
end

%%
n_odors = 10;
odorsRearrangedCoa =  [4     6     7     9    10     1     2     3     5     8];
odorsRearrangedPcx =  [4     6     7     9    10     1     2     3     5     8];
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaAA.esp, odorsRearrangedCoa, 1, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxAA.esp, odorsRearrangedPcx, 1, 0);

option = [];
option.repetitions = 100;
option.grouping = [ones(1,5) 2*ones(1,5)];

sua_performance_coaValence = nan(1,totalResponsiveSUACoa);
sua_MI_coaValence = nan(1,totalResponsiveSUACoa);
sua_MI_pcxValence = nan(1,totalResponsiveSUACoa);
for idxUnit = 1:totalResponsiveSUACoa
    option.single_unit = idxUnit;
    [app, app1, app2, mi]  = perform_linear_svm_decoding(coaAA.esp, odorsRearrangedCoa, option);
    sua_performance_coaValence(idxUnit) = mean(app);
    sua_MI_coaValence(idxUnit) = mi;
end

sua_performance_pcxValence = nan(1,totalResponsiveSUAPcx);
for idxUnit = 1:totalResponsiveSUAPcx
    option.single_unit = idxUnit;
    [app, app1, app2, mi]  = perform_linear_svm_decoding(pcxAA.esp, odorsRearrangedPcx, option);
    sua_performance_pcxValence(idxUnit) = mean(app);
    sua_MI_pcxValence(idxUnit) = mi;
end


%%
classifySortingBySelectivity

%%
figure
plot(2.1:7.1, accuracyResponsesPcx15(2:7), '-o', 'markersize', 7, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC, 'linewidth', 1)
hold on
plot(2:7, accuracyResponsesCoa15(2:7), '-o', 'markersize', 7, 'markeredgecolor', coaC, 'markerfacecolor', coaC, 'linewidth', 1)
hold on
errbar(2.1:7.1, accuracyResponsesPcx15(2:7), accuracyResponsesSemPcx15(2:7), 'color', pcxC, 'linewidth', 1); %
hold on
errbar(2:7, accuracyResponsesCoa15(2:7), accuracyResponsesSemCoa15(2:7), 'color', coaC, 'linewidth', 1); %./sqrt(length(accuracyResponsesPcxAA(:)))
set(gcf,'color','white', 'PaperPositionMode', 'auto');
longList = {'1 (2)', '0.99 - 0.8 (34)', ' 0.79 - 0.6 (72)', '0.59 - 0.4 (85)', '0.39 - 0.2 (94)', '0.19 - 0 (96)' };
longTicks = 2.05:7.05;
set(gca, 'XTick' , longTicks);
set(gca, 'XTickLabel', longList);
ylim([0 100])
xlabel('Lifetime Sparseness')
ylabel('Accuracy %')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
odorClassCorrelationsPlot