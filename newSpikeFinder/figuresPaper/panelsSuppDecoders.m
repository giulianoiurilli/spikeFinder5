esp = coa15.esp;
nOdors = 15;
folder = fullfile(pwd, 'binnedSUA15monoCoa');
prefix_name = 'coa15_nonlinearSVM';
option.classifierType = 4;
option.shuffle = 0;
option.lratio = 1;
option.splits = 9;
option.onlyexc = 0;
option.single_cell = 0;

[meanAccuracy_Coa15_nonlinear_svm, stdevAccuracy_Coa15_nonlinear_svm, meanInfo_Coa15_nonlinear_svm, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat_Coa15_nonlinear_svm] =...
 findClassificationAccuracy_2(esp, nOdors, folder, prefix_name, option);

%%
esp = pcx15.esp;
nOdors = 15;
folder = fullfile(pwd, 'binnedSUA15monoPcx');
prefix_name = 'pcx15_nonlinearSVM';
option.classifierType = 4;
option.shuffle = 0;
option.splits = 9;
option.onlyexc = 0;
option.single_cell = 0;

[meanAccuracy_Pcx15_nonlinear_svm, stdevAccuracy_Pcx15_nonlinear_svm, meanInfo_Pcx15_nonlinear_svm, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat_Pcx15_nonlinear_svm] =...
 findClassificationAccuracy_2(esp, nOdors, folder, prefix_name, option);

%%
esp = coa15.esp;
nOdors = 15;
folder = fullfile(pwd, 'binnedSUA15monoCoa');
prefix_name = 'coa15_corr';
option.classifierType = 2;
option.shuffle = 0;
option.splits = 9;
option.onlyexc = 0;
option.single_cell = 0;

[meanAccuracy_Coa15_corr, stdevAccuracy_Coa15_corr, meanInfo_Coa15_corr, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat_Coa15_corr] =...
 findClassificationAccuracy_2(esp, nOdors, folder, prefix_name, option);

%%
esp = pcx15.esp;
nOdors = 15;
folder = fullfile(pwd, 'binnedSUA15monoPcx');
prefix_name = 'pcx15_corr';
option.classifierType = 2;
option.shuffle = 0;
option.splits = 9;
option.onlyexc = 0;
option.single_cell = 0;

[meanAccuracy_Pcx15_corr, stdevAccuracy_Pcx15_corr, meanInfo_Pcx15_corr, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat_Pcx15_corr] =...
 findClassificationAccuracy_2(esp, nOdors, folder, prefix_name, option);

%%
esp = coaNM.esp;
nOdors = 13;
folder = fullfile(pwd, 'binnedSUANMCoa');
prefix_name = 'coaNM_nonlinearSVM';
option.classifierType = 4;
option.shuffle = 0;
option.splits = 9;
option.onlyexc = 0;
option.single_cell = 0;

[meanAccuracy_CoaNM_nonlinear_svm, stdevAccuracy_CoaNM_nonlinear_svm, meanInfo_CoaNM_nonlinear_svm, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat_CoaNM_nonlinear_svm] =...
 findClassificationAccuracy_2(esp, nOdors, folder, prefix_name, option);

%%
esp = pcxNM.esp;
nOdors = 13;
folder = fullfile(pwd, 'binnedSUANMPcx');
prefix_name = 'pcxNM_nonlinearSVM';
option.classifierType = 4;
option.shuffle = 0;
option.splits = 9;
option.onlyexc = 0;
option.single_cell = 0;

[meanAccuracy_PcxNM_nonlinear_svm, stdevAccuracy_PcxNM_nonlinear_svm, meanInfo_PcxNM_nonlinear_svm, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat_PcxNM_nonlinear_svm] =...
 findClassificationAccuracy_2(esp, nOdors, folder, prefix_name, option);

%%
esp = coaNM.esp;
nOdors = 13;
folder = fullfile(pwd, 'binnedSUANMCoa');
prefix_name = 'coaNM_corr';
option.classifierType = 2;
option.shuffle = 0;
option.splits = 9;
option.onlyexc = 0;
option.single_cell = 0;

[meanAccuracy_CoaNM_corr, stdevAccuracy_CoaNM_corr, meanInfo_CoaNM_corr, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat_CoaNM_corr] =...
 findClassificationAccuracy_2(esp, nOdors, folder, prefix_name, option);

%%
esp = pcxNM.esp;
nOdors = 13;
folder = fullfile(pwd, 'binnedSUANMPcx');
prefix_name = 'pcxNM_corr';
option.classifierType = 2;
option.shuffle = 0;
option.splits = 9;
option.onlyexc = 0;
option.single_cell = 0;

[meanAccuracy_PcxNM_corr, stdevAccuracy_PcxNM_corr, meanInfo_PcxNM_corr, stdevInfo, auROCsClasses_mean, auROCsClasses_sem, confMat_PcxNM_corr] =...
 findClassificationAccuracy_2(esp, nOdors, folder, prefix_name, option);


%%
%% figure
figure
plot(meanAccuracy_Pcx15_nonlinear_svm*100, 'color', pcxC, 'linewidth', 2);
hold on
plot(meanAccuracy_Coa15_nonlinear_svm*100, 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
title('15 mono - non linear SVM')

figure
plot(meanAccuracy_PcxNM_nonlinear_svm*100, 'color', pcxC, 'linewidth', 2);
hold on
plot(meanAccuracy_CoaNM_nonlinear_svm*100, 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
title('NM - non linear SVM')

figure
plot(meanAccuracy_Pcx15_corr*100, 'color', pcxC, 'linewidth', 2);
hold on
plot(meanAccuracy_Coa15_corr*100, 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
title('15 mono - LSMR')

figure
plot(meanAccuracy_PcxNM_corr*100, 'color', pcxC, 'linewidth', 2);
hold on
plot(meanAccuracy_CoaNM_corr*100, 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
title('NM - LSMR')
%%
option = [];
option.units = 'incrementing_by_one';
option.repetitions =500;
option.abs = 0;
[performanceCoa15_simLabeledLine, confusionMatrixCoa15_simLabeledLine] = perform_linear_svm_decoding(coa15.esp, 1:15, option);
[performancePcx15_simLabeledLine, confusionMatrixPcx15_simLabeledLine] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);

option = [];
option.units = 'incrementing_by_one';
option.repetitions =500;
option.abs = 0;
[performanceCoaNM_simLabeledLine, confusionMatrixCoaNM_simLabeledLine] = perform_linear_svm_decoding(coaNM.esp, 1:13, option);
[performancePcxNM_simLabeledLine, confusionMatrixPcxNM_simLabeledLine] = perform_linear_svm_decoding(pcxNM.esp, 1:13, option);
%%
option = [];
option.units = 'incrementing_by_one';
option.repetitions =500;
option.abs = 0;
[performanceCoa15_onlyExc, confusionMatrixCoa15_onlyExc] = perform_linear_svm_decoding(coa15.esp, 1:15, option);
[performancePcx15_onlyExc, confusionMatrixPcx15_onlyExc] = perform_linear_svm_decoding(pcx15.esp, 1:15, option);

option = [];
option.units = 'incrementing_by_one';
option.repetitions =500;
option.abs = 0;
[performanceCoaNM_onlyExc, confusionMatrixCoaNM_onlyExc] = perform_linear_svm_decoding(coaNM.esp, 1:13, option);
[performancePcxNM_onlyExc, confusionMatrixPcxNM_onlyExc] = perform_linear_svm_decoding(pcxNM.esp, 1:13, option);
%%
figure
plot(mean(performancePcx15_simLabeledLine), '--', 'color', pcxC, 'linewidth', 2);
hold on
plot(mean(performanceCoa15_simLabeledLine),'--', 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
title('15 mono - LSMR')

hold on
plot(mean(performancePcx15_onlyExc), 'color', pcxC, 'linewidth', 2);
hold on
plot(mean(performanceCoa15_onlyExc), 'color', coaC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
title('NM - LSMR')

%%
figure
plot(mean(performancePcx15), 'color', pcxC, 'linewidth', 1);
hold on
plot(mean(performancePcx15NoSignalCorr),'color', [8,81,156]./255, 'linewidth', 1);
hold on
plot(mean(performancePcx15shuffledNoNoiseCorr),'color', [107,174,214]./255, 'linewidth', 1);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')


figure
plot(mean(performanceCoa15),'color', coaC, 'linewidth', 1);
hold on
plot(mean(performanceCoa15NoSignalCorr), 'color', [165,15,21]./255, 'linewidth', 1);
hold on
plot(mean(performanceCoa15NoNoiseCorr), 'color', [251,106,74]./255, 'linewidth', 1);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 100])
ylabel('Accuracy %')
