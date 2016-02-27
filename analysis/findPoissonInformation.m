%%
fileToSave = 'coa_mix_2_2.mat';
load('parameters.mat')
% odorsRearranged = 1:15; 
  odorsRearranged = [1 7 3 15]; %coa
% odorsRearranged = [7 6 10 9]; %pcx
% odorsRearranged = [8 11 12 5 2 14 4 10]; %coa
% odorsRearranged = [2 12 13 1 8 3 15 5]; %pcx
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
                A300ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse300ms';
                A1s(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse1000ms';
            end
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms = poissonInformation(A300ms);
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s = poissonInformation(A1s);
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms = lifetime_sparseness(A300ms);
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s = lifetime_sparseness(A1s);
%             esp(idxExp).shankNowarp(idxShank).cell(idxUnit).nbs300ms = naiveBayesSelectivity(A300ms);
%             esp(idxExp).shankNowarp(idxShank).cell(idxUnit).nbs1s = naiveBayesSelectivity(A1s);
        end
    end
end
cd(startingFolder)
clearvars -except List esp fileToSave
save(fileToSave, 'esp', '-append')

