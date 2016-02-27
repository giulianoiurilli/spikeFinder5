% fileToSave1 = 'coa_AA1_2_1.mat';
% fileToSave2 = 'coa_AA1_2_3.mat';
% load('parameters.mat');
% startingFolder = pwd;
% % odorsRearranged = 1:15;
% % odorsRearranged = [1 7 3 15]; %coa
% % odorsRearranged = [7 6 10 9]; %pcx
% % odorsRearranged = [8 11 12 5 2 14 4 10]; %coa
% % odorsRearranged = [2 12 13 1 8 3 15 5]; %pcx
% odors = length(odorsRearranged);
% 
% for idxExp = 1 : length(List)
%     for idxShank = 1:4
%         for idxUnit = 1:length(espe(idxExp).shankNowarp(idxShank).cell)
%             idxO = 0;
%             for idxOdor = odorsRearranged
%                 idxO = idxO + 1;
%                 espe1(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrix = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
%                 espe1(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).sdf = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf;
%                 esperimento1(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixRad = esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad;
%                 esperimento1(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialRad = esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad;
%                 esperimento1(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialHz = esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz;
%                 esperimento1(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sniffBinnedBsl = esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl;
%                 esperimento1(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).alphaTrial = esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial;
%             end
%         end
%     end
% end
% 
% cd(startingFolder)
% clearvars -except List espe esperimento espe1 esperimento1 fileToSave1 fileToSave2
% save(fileToSave1, 'espe1', '-v7.3')
% save(fileToSave2, 'esperimento1', '-v7.3')
% clearvars -except List espe esperimento 



fileToSave1 = 'pcx_AA_2_1.mat';
fileToSave2 = 'pcx_AA_2_3.mat';
espe = espe1;
esperimento = esperimento1;
clearvars -except espe esperimento fileToSave1 fileToSave2
save(fileToSave1, 'espe', '-v7.3')
save(fileToSave2, 'esperimento', '-v7.3')

                