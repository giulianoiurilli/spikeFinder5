%%
fileToSave = 'pcx_15_2_2.mat';
odorsRearranged = 1:15; 
odors = length(odorsRearranged);
%%
startingFolder = pwd;
for idxExp =  1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            A300ms = zeros(n_trials, odors);
            A1s = zeros(n_trials, odors);
            for idxOdor = 1:odors
                A300ms(:, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                A1s(:, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
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
clearvars -except List esp
save(fileToSave, 'esp', '-append')

