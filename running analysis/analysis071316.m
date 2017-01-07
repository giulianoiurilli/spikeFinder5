[accuracyResponses2Coa15,accuracyResponses2Coa15Decorrelated, ConMatCoa15]= l_svmClassify_new(coa15.esp, 1:15,1);
[accuracyResponses2Pcx15,accuracyResponses2Pcx15Decorrelated, ConMatPcx15] = l_svmClassify(pcx15.esp, 1:15,1);

[accuracyResponses2CoaAA,accuracyResponses2CoaAADecorrelated, ConMatCoaAA]= l_svmClassify(coaAA.esp, 1:10,1);
[accuracyResponses2PcxAA,accuracyResponses2PcxAADecorrelated, ConMatPcxAA] = l_svmClassify(pcxAA.esp, 1:10,1);


%%
[accuracyResponses2Coa15AllTrials]= l_svmClassifyAllTrials(coa15.esp, 1:15,1);
[accuracyResponses2Pcx15AllTrials] = l_svmClassifyAllTrials(pcx15.esp, 1:15,1);

[accuracyResponses2Coa15AllTrials15]= l_svmClassifyAllTrials(coa15.esp, 1:15,6);
[accuracyResponses2Pcx15AllTrials15] = l_svmClassifyAllTrials(pcx15.esp, 1:15,6);

[accuracyResponses2Coa15AllTrialsAA]= l_svmClassifyAllTrials(coaAA.esp, 1:10,2);
[accuracyResponses2Pcx15AllTrialsAA] = l_svmClassifyAllTrials(pcxAA.esp, 1:10,2);

[accuracyResponsesTogether] = l_svmClassifyTogether(coa15.esp,pcx15.esp, 1:15,1);
[accuracyResponsesTogether15] = l_svmClassifyTogether(coa15.esp,pcx15.esp, 1:15,6);
[accuracyResponsesTogetherAA] = l_svmClassifyTogether(coaAA.esp,pcxAA.esp, 1:10,2);

%%
accuracyResponsesPC_increasing_neurons_sorted = l_svmClassify3(pcx15.esp, 1:15);
accuracyResponsesCOA_increasing_neurons_sorted = l_svmClassify3(coa15.esp, 1:15);

%%
figure
shadedErrorBar(2:size(accuracyResponsesTogether,2)+1, mean(accuracyResponsesTogether,1), std(accuracyResponsesTogether,1)/sqrt(size(accuracyResponsesTogether,2)-1), 'y');
hold on
shadedErrorBar(2:size(accuracyResponses2Coa15,2)+1, mean(accuracyResponses2Coa15,1), std(accuracyResponses2Coa15,1)/sqrt(size(accuracyResponses2Coa15,2)-1), 'r');
hold on
shadedErrorBar(2:size(accuracyResponses2Pcx15,2)+1, mean(accuracyResponses2Pcx15,1), std(accuracyResponses2Pcx15,1)/sqrt(size(accuracyResponses2Pcx15,2)-1), 'k');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100])

%%
figure
subplot(1,2,1)
imagesc(ConMatCoa15)
title('plCoA')
axis square
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
subplot(1,2,2)
imagesc(ConMatPcx15)
title('PCx')
axis square
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)


%%
figure
shadedErrorBar(2:size(accuracyResponses2Pcx15,2)+1, mean(accuracyResponses2Pcx15,1), std(accuracyResponses2Pcx15,1)/sqrt(size(accuracyResponses2Pcx15,2)-1), 'k');
hold on
shadedErrorBar(2:size(accuracyResponses2Coa15,2)+1, mean(accuracyResponses2Coa15,1), std(accuracyResponses2Coa15,1)/sqrt(size(accuracyResponses2Coa15,2)-1), 'r');
hold on
figure
shadedErrorBar(2:size(accuracyResponsesPC_increasing_neurons_sorted,2)+1, mean(accuracyResponsesPC_increasing_neurons_sorted,1), std(accuracyResponsesPC_increasing_neurons_sorted,1)/sqrt(size(accuracyResponsesPC_increasing_neurons_sorted,2)-1), ':k');
hold on
shadedErrorBar(2:size(accuracyResponsesCOA_increasing_neurons_sorted,2)+1, mean(accuracyResponsesCOA_increasing_neurons_sorted,1), std(accuracyResponsesCOA_increasing_neurons_sorted,1)/sqrt(size(accuracyResponsesCOA_increasing_neurons_sorted,2)-1), ':r');
title('dotted lines use sparsest neurons first (lifetime sparseness)')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
ylabel('accuracy %')
%%
figure
plot(1.1:15.1, accuracyResponsesPcx15, 'color', pcxC);
hold on
plot(1:15, accuracyResponsesCoa15, 'color', coaC);
hold on
errorbar(1:15, accuracyResponsesCoa15, accuracyResponsesSemCoa15, 'o', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 2, 'color', coaC)
hold on
errorbar(1.1:15.1, accuracyResponsesPcx15, accuracyResponsesSemPcx15, 'o', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 2, 'color', pcxC)
xlabel('Number of excitatory odors')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
ylabel('accuracy %')
%%
figure
shadedErrorBar(1:15, mean(accuracyResponses2Coa15AllTrials,1), std(accuracyResponses2Coa15AllTrials,1)/sqrt(size(accuracyResponses2Coa15AllTrials,2)-1), 'r');
hold on
shadedErrorBar(1:15, mean(accuracyResponses2Pcx15AllTrials,1), std(accuracyResponses2Pcx15AllTrials,1)/sqrt(size(accuracyResponses2Pcx15AllTrials,2)-1), 'k');
title('without trial averaging')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
ylabel('accuracy %')
%%
figure
shadedErrorBar(2:size(accuracyResponses2Pcx15,2)+1, mean(accuracyResponses2Pcx15,1), std(accuracyResponses2Pcx15,1)/sqrt(size(accuracyResponses2Pcx15,2)-1), 'k');
hold on
shadedErrorBar(2:size(accuracyResponses2Coa15,2)+1, mean(accuracyResponses2Coa15,1), std(accuracyResponses2Coa15,1)/sqrt(size(accuracyResponses2Coa15,2)-1), 'r');
hold on
shadedErrorBar(2:size(accuracyResponses2Pcx15Decorrelated,2)+1, mean(accuracyResponses2Pcx15Decorrelated,1), std(accuracyResponses2Pcx15Decorrelated,1)/sqrt(size(accuracyResponses2Pcx15Decorrelated,2)-1), ':k');
hold on
shadedErrorBar(2:size(accuracyResponses2Coa15Decorrelated,2)+1, mean(accuracyResponses2Coa15Decorrelated,1), std(accuracyResponses2Coa15Decorrelated,1)/sqrt(size(accuracyResponses2Coa15Decorrelated,2)-1), ':r');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)