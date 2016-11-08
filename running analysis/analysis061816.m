%% valence l-svm - 10 odors
n_comb = nchoosek(10,5)/2;
odorsRearranged2Coa = nan*ones(n_comb,10);
odorsRearranged2Pcx = nan*ones(n_comb,10);
aa2CoaNoDecorr = nan*ones(n_comb,1);
aa2PcxNoDecorr = nan*ones(n_comb,1);
combinations = combnk(1:10, 5);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = 1:10;
odorsRearrangedPcx = 1:10;
for idxRep = 1:n_comb
    odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
    accuracyResponses2CoaAAaa = l_svmClassify(coaAA.esp, odorsRearranged2Coa(idxRep,:),2);
    aa2CoaNoDecorr(idxRep) = mean(accuracyResponses2CoaAAaa);
    odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
    accuracyResponses2PcxAAaa = l_svmClassify(pcxAA.esp, odorsRearranged2Pcx(idxRep,:),2);
    aa2PcxNoDecorr(idxRep) = mean(accuracyResponses2PcxAAaa);
end
accuracyResponses2CoaAAaaTrueNoDecorr = l_svmClassify(coaAA.esp, odorsRearrangedCoa,2);
accuracyResponses2PcxAAaaTrueNoDecorr = l_svmClassify(pcxAA.esp, odorsRearrangedPcx,2);
figure;
dataToPlot = {accuracyResponses2CoaAAaaTrueNoDecorr, accuracyResponses2PcxAAaaTrueNoDecorr, aa2CoaNoDecorr, aa2PcxNoDecorr};
catIdx = [zeros(1000,1); ones(1000,1); 2*ones(n_comb,1); 3*ones(n_comb, 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)

%%
accuracyResponsesPC_increasing_neurons = l_svmClassify2(pcx15.esp, odors);
accuracyResponsesCOA_increasing_neurons = l_svmClassify2(coa15.esp, odors);
accuracyResponsesPC_increasing_neurons_sorted = l_svmClassify3(pcx15.esp, odors);
accuracyResponsesCOA_increasing_neurons_sorted = l_svmClassify3(coa15.esp, odors);
%%
figure
shadedErrorBar(2:size(accuracyResponsesPC_increasing_neurons,2)+1, mean(accuracyResponsesPC_increasing_neurons,1), std(accuracyResponsesPC_increasing_neurons,1)/sqrt(size(accuracyResponsesPC_increasing_neurons,2)-1), 'k');
hold on
shadedErrorBar(2:size(accuracyResponsesCOA_increasing_neurons,2)+1, mean(accuracyResponsesCOA_increasing_neurons,1), std(accuracyResponsesCOA_increasing_neurons,1)/sqrt(size(accuracyResponsesCOA_increasing_neurons,2)-1), 'r');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

figure
shadedErrorBar(2:size(accuracyResponsesPC_increasing_neurons_sorted,2)+1, mean(accuracyResponsesPC_increasing_neurons_sorted,1), std(accuracyResponsesPC_increasing_neurons_sorted,1)/sqrt(size(accuracyResponsesPC_increasing_neurons_sorted,2)-1), 'k');
hold on
shadedErrorBar(2:size(accuracyResponsesCOA_increasing_neurons_sorted,2)+1, mean(accuracyResponsesCOA_increasing_neurons_sorted,1), std(accuracyResponsesCOA_increasing_neurons_sorted,1)/sqrt(size(accuracyResponsesCOA_increasing_neurons_sorted,2)-1), 'r');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
for j = 2:15
    c = combnk(1:15,j);
    appPCX = [];
    appCOA = [];
    for k = 1:size(c,1)
        accuracyResponses = l_svmClassify(pcx15.esp, c(k, :), 1);
        appPCX(k) = mean(accuracyResponses);
        accuracyResponses = l_svmClassify(coa15.esp, c(k, :), 1);
        appCOA(k) = mean(accuracyResponses);
    end
    accuracyResponses_increasingOdors_mean_PC(j) = mean(appPCX);
    accuracyResponses_increasingOdors_sem_PC(j) = std(appPCX)./sqrt(length(appPCX));
    accuracyResponses_increasingOdors_mean_COA(j) = mean(appCOA);
    accuracyResponses_increasingOdors_sem_COA(j) = std(appCOA)./sqrt(length(appCOA));
end
%%
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
    accuracyResponses2Coa15_sim = l_svmClassify(coa15.esp, lista(idxRep,:),6);
    CoaNoDecorr15_sim(idxRep) = mean(accuracyResponses2Coa15_sim);
    accuracyResponses2Pcx15_sim = l_svmClassify(pcx15.esp, lista(idxRep,:),6);
    PcxNoDecorr15_sim(idxRep) = mean(accuracyResponses2Pcx15_sim);
end

accuracyResponses2Coa15 = l_svmClassify(coa15.esp, 1:15,6);
accuracyResponses2Pcx15 = l_svmClassify(pcx15.esp, 1:15,6);

%% category class l-svm 

accuracyResponses2CoaAAValence = l_svmClassify(coaAA.esp, 1:10,2);
accuracyResponses2PcxAAValence = l_svmClassify(pcxAA.esp, 1:10,2);
accuracyResponses2Coa15 = l_svmClassify(coa15.esp, 1:15,6);
accuracyResponses2Pcx15 = l_svmClassify(pcx15.esp, 1:15,6);
accuracyResponses2CoaAAMixValence = l_svmClassify(coaAA.esp, 11:14,4);
accuracyResponses2PcxAAMixValence = l_svmClassify(pcxAA.esp, 11:14,4);

figure;
plot([2 6 10], [mean(accuracyResponses2Coa15(:)) mean(accuracyResponses2CoaAAValence(:)) mean(accuracyResponses2CoaAAMixValence(:))], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([3 7 11], [mean(accuracyResponses2Pcx15(:)) mean(accuracyResponses2PcxAAValence(:)) mean(accuracyResponses2PcxAAMixValence(:))], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([2 6 10], [mean(accuracyResponses2Coa15(:)) mean(accuracyResponses2CoaAAValence(:)) mean(accuracyResponses2CoaAAMixValence(:))],...
    [std(accuracyResponses2Coa15(:))./sqrt(length(accuracyResponses2Coa15(:)))...
    std(accuracyResponses2CoaAAValence)./sqrt(length(accuracyResponses2CoaAAValence(:)))...
    std(accuracyResponses2CoaAAMixValence(:))./sqrt(length(accuracyResponses2CoaAAMixValence(:)))], 'r', 'linewidth', 2); %
hold on
errbar([3 7 11], [mean(accuracyResponses2Pcx15(:)) mean(accuracyResponses2PcxAAValence(:)) mean(accuracyResponses2PcxAAMixValence(:))],...
    [std(accuracyResponses2Pcx15(:))./sqrt(length(accuracyResponses2Pcx15(:)))...
    std(accuracyResponses2PcxAAValence)./sqrt(length(accuracyResponses2PcxAAValence(:)))...
    std(accuracyResponses2PcxAAMixValence(:))./sqrt(length(accuracyResponses2PcxAAMixValence(:)))], 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 13])
ylim([50 100]);
%line([0 9], [100/8 100/8], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')

%%
accuracyResponsesPC_increasing_neurons_binarized = l_svmClassify4(pcx15.esp, 1:15, 1);
accuracyResponsesCOA_increasing_neurons_binarized = l_svmClassify4(coa15.esp, 1:15, 1);
%%
figure
shadedErrorBar(2:size(accuracyResponsesPC_increasing_neurons_binarized,2)+1, mean(accuracyResponsesPC_increasing_neurons_binarized,1), std(accuracyResponsesPC_increasing_neurons_binarized,1)/sqrt(size(accuracyResponsesPC_increasing_neurons_binarized,2)-1), 'k');
hold on
shadedErrorBar(2:size(accuracyResponsesCOA_increasing_neurons_binarized,2)+1, mean(accuracyResponsesCOA_increasing_neurons_binarized,1), std(accuracyResponsesCOA_increasing_neurons_binarized,1)...
    /sqrt(size(accuracyResponsesCOA_increasing_neurons_binarized,2)-1), 'r');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
%%
figure
shadedErrorBar(2:size(accuracyResponses2CoaAAaaTrueNoDecorr,2)+1, mean(accuracyResponses2CoaAAaaTrueNoDecorr,1), std(accuracyResponses2CoaAAaaTrueNoDecorr,1)/sqrt(size(accuracyResponses2CoaAAaaTrueNoDecorr,2)-1), 'r');
hold on
shadedErrorBar(2:size(accuracyResponses2PcxAAaaTrueNoDecorr,2)+1, mean(accuracyResponses2PcxAAaaTrueNoDecorr,1), std(accuracyResponses2PcxAAaaTrueNoDecorr,1)/sqrt(size(accuracyResponses2PcxAAaaTrueNoDecorr,2)-1), 'k');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
title('Valence')
ylabel('accuracy %')
xlabel('number of neurons')
set(gcf,'Position',[744 630 347 420]);
%%
figure
shadedErrorBar(2:size(accuracyResponses2Coa15,2)+1, mean(accuracyResponses2Coa15,1), std(accuracyResponses2Coa15,1)/sqrt(size(accuracyResponses2Coa15,2)-1), 'r');
hold on
shadedErrorBar(2:size(accuracyResponses2Pcx15,2)+1, mean(accuracyResponses2Pcx15,1), std(accuracyResponses2Pcx15,1)/sqrt(size(accuracyResponses2Pcx15,2)-1), 'k');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
title('Chemical class')
ylabel('accuracy %')
xlabel('number of neurons')
set(gcf,'Position',[744 630 347 420]);
%%
figure
shadedErrorBar(2:size(accuracyResponses2CoaAAMixValence,2)+1, mean(accuracyResponses2CoaAAMixValence,1), std(accuracyResponses2CoaAAMixValence,1)/sqrt(size(accuracyResponses2CoaAAMixValence,2)-1), 'r');
hold on
shadedErrorBar(2:size(accuracyResponses2PcxAAMixValence,2)+1, mean(accuracyResponses2PcxAAMixValence,1), std(accuracyResponses2PcxAAMixValence,1)/sqrt(size(accuracyResponses2PcxAAMixValence,2)-1), 'k');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
title('Valence mix')
set(gcf,'Position',[744 630 347 420]);
ylabel('accuracy %')
xlabel('number of neurons')

%% valence l-svm - 10 odors
n_comb = nchoosek(10,5)/2;
odorsRearranged2Coa = nan*ones(n_comb,10);
odorsRearranged2Pcx = nan*ones(n_comb,10);
aa2CoaNoDecorr = nan*ones(n_comb,15);
aa2PcxNoDecorr = nan*ones(n_comb,15);
combinations = combnk(1:10, 5);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = 1:10;
odorsRearrangedPcx = 1:10;
for idxRep = 1:n_comb
    odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
    accuracyResponses2CoaAAaa = l_svmClassify(coaAA.esp, odorsRearranged2Coa(idxRep,:),2);
    aa2CoaNoDecorr(idxRep,:) = mean(accuracyResponses2CoaAAaa);
    odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
    accuracyResponses2PcxAAaa = l_svmClassify(pcxAA.esp, odorsRearranged2Pcx(idxRep,:),2);
    aa2PcxNoDecorr(idxRep,:) = mean(accuracyResponses2PcxAAaa);
end
accuracyResponses2CoaAAaaTrueNoDecorr = l_svmClassify(coaAA.esp, odorsRearrangedCoa,2);
accuracyResponses2PcxAAaaTrueNoDecorr = l_svmClassify(pcxAA.esp, odorsRearrangedPcx,2);
percentiles_CoaAA = prctile(aa2CoaNoDecorr, [2.5, 97.5], 2);
percentiles_PcxAA = prctile(aa2PcxNoDecorr, [2.5, 97.5], 2);
%%
figure
errbar(2, mean(accuracyResponses2CoaAAaaTrueNoDecorr(:)), std(accuracyResponses2Coa15(:))./sqrt(length(accuracyResponses2Coa15(:))), 'r', 'linewidth', 2); %
hold on
errbar(4, mean(accuracyResponses2Pcx15(:)), std(accuracyResponses2Pcx15(:))./sqrt(length(accuracyResponses2Pcx15(:))), 'k', 'linewidth', 2); 
%%
%%
odors = 1:15;
accuracyResponsesPCcs1_increasing_neurons = l_svmClassify(pcxCS.esp, odors, 1);
accuracyResponsesCOAcs1_increasing_neurons = l_svmClassify(coaCS.esp, odors,1);
accuracyResponsesPCcs5_increasing_neurons = l_svmClassify(pcxCS.esp, odors, 5);
accuracyResponsesCOAcs5_increasing_neurons = l_svmClassify(coaCS.esp, odors,5);

accuracyResponsesPCcs11_increasing_neurons = l_svmClassify(pcxCS.esp, 1:5, 1);
accuracyResponsesCOAcs11_increasing_neurons = l_svmClassify(coaCS.esp, 1:5,1);
accuracyResponsesPCcs12_increasing_neurons = l_svmClassify(pcxCS.esp, 6:10, 1);
accuracyResponsesCOAcs12_increasing_neurons = l_svmClassify(coaCS.esp, 6:10,1);
accuracyResponsesPCcs13_increasing_neurons = l_svmClassify(pcxCS.esp, 11:15, 1);
accuracyResponsesCOAcs13_increasing_neurons = l_svmClassify(coaCS.esp, 11:15,1);

%%
figure
plot(10:10:150, mean(accuracyResponsesCOAcs1_increasing_neurons), 'o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(10:10:150, mean(accuracyResponsesPCcs1_increasing_neurons), 'o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(10:10:150, mean(accuracyResponsesCOAcs1_increasing_neurons),...
    std(accuracyResponsesCOAcs1_increasing_neurons)./sqrt(length(accuracyResponsesCOAcs1_increasing_neurons)), 'r', 'linewidth', 2); %
hold on
errbar(10:10:150, mean(accuracyResponsesPCcs1_increasing_neurons),...
    std(accuracyResponsesPCcs1_increasing_neurons)./sqrt(length(accuracyResponsesPCcs1_increasing_neurons)), 'k', 'linewidth', 2);
title('one vs all')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
xlabel('number of neurons')
ylabel('accuracy %')

figure
plot(10:10:150, mean(accuracyResponsesCOAcs5_increasing_neurons), 'o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(10:10:150, mean(accuracyResponsesPCcs5_increasing_neurons), 'o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(10:10:150, mean(accuracyResponsesCOAcs5_increasing_neurons),...
    std(accuracyResponsesCOAcs5_increasing_neurons)./sqrt(length(accuracyResponsesCOAcs5_increasing_neurons)), 'r', 'linewidth', 2); %
hold on
errbar(10:10:150, mean(accuracyResponsesPCcs5_increasing_neurons),...
    std(accuracyResponsesPCcs5_increasing_neurons)./sqrt(length(accuracyResponsesPCcs5_increasing_neurons)), 'k', 'linewidth', 2);
title('odor identity')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
xlabel('number of neurons')
ylabel('accuracy %')

aCoa = [accuracyResponsesCOAcs11_increasing_neurons; accuracyResponsesCOAcs12_increasing_neurons; accuracyResponsesCOAcs12_increasing_neurons];
aPcx = [accuracyResponsesPCcs11_increasing_neurons; accuracyResponsesPCcs12_increasing_neurons; accuracyResponsesPCcs13_increasing_neurons];
figure
plot(10:10:150, mean(aCoa), 'o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(10:10:150, mean(aPcx), 'o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(10:10:150, mean(aCoa),...
    std(aCoa)./sqrt(length(aCoa)), 'r', 'linewidth', 2); %
hold on
errbar(10:10:150, mean(aPcx),...
    std(aPcx)./sqrt(length(aPcx)), 'k', 'linewidth', 2);
title('odor concentration')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
xlabel('number of neurons')
ylabel('accuracy %')

%%
[accuracyResponses2Coa15,accuracyResponses2Coa15Shuffled]= l_svmClassify(coa15.esp, 1:15,1);
[accuracyResponses2Pcx15,accuracyResponses2Pcx15Shuffled] = l_svmClassify(pcx15.esp, 1:15,1);
%%
figure
shadedErrorBar(2:size(accuracyResponses2Coa15,2)+1, mean(accuracyResponses2Coa15,1), std(accuracyResponses2Coa15,1)/sqrt(size(accuracyResponses2Coa15,2)-1), 'r');
hold on
shadedErrorBar(2:size(accuracyResponses2Pcx15,2)+1, mean(accuracyResponses2Pcx15,1), std(accuracyResponses2Pcx15,1)/sqrt(size(accuracyResponses2Pcx15,2)-1), 'k');
hold on
plot(2:size(accuracyResponses2Pcx15Shuffled1,2)+1, mean(accuracyResponses2Pcx15Shuffled1,1),':k', 'color', pcxC)
hold on
plot(2:size(accuracyResponses2Coa15Shuffled1,2)+1, mean(accuracyResponses2Coa15Shuffled1,1),':r', 'color', coaC)
xlabel('number of neurons')
ylabel('accuracy %')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
