nOdors = 15;
name_folder = 'binnedSUA6odorsPcxExc_single_units';
folder = fullfile(pwd, name_folder);
mkdir(folder)
cd(folder)

prepareDataForClassification_single_unit(pcxNM.esp, nOdors, name_folder)
cd(folder)
%%
d = dir;
[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(pcxNM.esp, 1:nOdors);
for idx = 1:totalResponsiveSUA
    s = sprintf('%d',idx);
    stringa = [name_folder s];
    folder = fullfile(pwd, stringa);
    option.classifierType = 3;
    option.shuffle = 0;
    option.splits = 9;
    option.single_cell = 1;
    [meanAccuracyPcxCorr, stdevAccuracyPcxCorr, meanInfoPcxCorr, stdevInfoPcxCorr, auROCsClasses_meanPcxCorr, auROCsClasses_semPcxCorr, confMatPcxCorr] = findClassificationAccuracy(pcxNM.esp, nOdors, folder, option);
    info_single_cell(idx) = meanInfoPcxCorr;
    accuracy_single_cell(idx) = meanAccuracyPcxCorr;
end

%%


