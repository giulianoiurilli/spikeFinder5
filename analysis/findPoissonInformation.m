%%
fileToSave = 'pcx_AAmix_2_2.mat';
load('parameters.mat')
odorsRearranged = 1:15; 
% odorsRearranged = [1 7 3 15]; %coa
% odorsRearranged = [7 6 10 9]; %pcx
% odorsRearranged = [8 11 12 5 2 14 4 10]; %coa AA
% odorsRearranged = [2 12 13 1 8 3 15 5]; %pcx AA
% odorsRearranged = [7 6 13 15 3 9]; %coa Mix
%odorsRearranged = [4 6 7 9 10 11]; %pcx Mix
%odorsRearranged = [4 5 13 15 1 14 8 3 7 12 11 10 6 9 2]; %coa CS
%odorsRearranged = [14 13 12 15 1 5 3 4 2 6 8 7 9 10 11]; %pcx CS
%odorsRearranged = [6 8 5 11 12 3 2 10 14 4 7 13 15 9 1]; %coa AAmix
%odorsRearranged = [4 2 13 12 1 11 3 5 8 15 6 7 9 10 14]; %pcx AAmix
odors = length(odorsRearranged);

%%
startingFolder = pwd;
for idxExp =  1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            A300ms = zeros(n_trials, odors);
            A1s = zeros(n_trials, odors);
            idxO = 0;
            for idxOdor = 1:odors
                idxO = idxO + 1;
                A300ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse300ms' - esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl300ms';
                A1s(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse1000ms' - esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
                Auroc300ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROC300ms;
                Auroc1s(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROC1000ms;
            end
%             esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms = poissonInformation(A300ms);
%             esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s = poissonInformation(A1s);
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms = lifetime_sparseness(A300ms);
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s = lifetime_sparseness(A1s);
%             esp(idxExp).shankNowarp(idxShank).cell(idxUnit).lsAuroc300ms = lifetime_sparsenessAUROC(Auroc300ms);
%             esp(idxExp).shankNowarp(idxShank).cell(idxUnit).lsAuroc1s = lifetime_sparsenessAUROC(Auroc1s);
%             esp(idxExp).shankNowarp(idxShank).cell(idxUnit).nbs300ms = naiveBayesSelectivity(A300ms);
%             esp(idxExp).shankNowarp(idxShank).cell(idxUnit).nbs1s = naiveBayesSelectivity(A1s);
        end
    end
end
cd(startingFolder)
clearvars -except List esp fileToSave
save(fileToSave, 'esp', '-append')

