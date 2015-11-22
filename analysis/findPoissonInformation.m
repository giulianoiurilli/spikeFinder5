%%
%odorsRearranged = 1:15; %15 odors
%odorsRearranged = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
%odorsRearranged = [1,2,3,4,5,6,7]; %7 odors low
%odorsRearranged = [12 13 14 15 1]; %3 odors pen
%odorsRearranged = [2 3 4 5 6]; %3 odors iaa
%odorsRearranged = [7 8 9 10 11]; %3 odors etg
%odorsRearranged = [1 6 11]; %3 odors high
%odorsRearranged = [15 5 10]; %3 odors medium-high
%odorsRearranged = [14 4 9]; %3 odors medium
%odorsRearranged = [13 3 8]; %3 odors medium-low
%odorsRearranged = [12 2 7]; %3 odors low
%odorsRearranged  = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
odorsRearranged = [1 2 3 4 5  6 7 8 9 10]; %aveatt
%odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
%odorsRearranged = [1 13 14 15]; %mixTMT


odors = length(odorsRearranged);
%%
tic
startingFolder = pwd;
%for idxExp = 1 : length(List)
for idxExp =  1:length(exp) 
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
%             A300ms = zeros(n_trials, odors + 1);
%             A1s = zeros(n_trials, odors + 1);
            A300ms = zeros(n_trials, odors);
            A1s = zeros(n_trials, odors);
            for idxOdor = 1:odors
                A300ms(:, idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                A1s(:, idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
            end
%             A300ms(:, idxOdor+1) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms';
%             A1s(:, idxOdor+1) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms = poissonInformation(A300ms);
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s = poissonInformation(A1s);
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms = lifetime_sparseness(A300ms);
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s = lifetime_sparseness(A1s);
        end
    end
end
toc
tic
cd(startingFolder)
clearvars -except List exp
save('aPCx_aveatt_Area.mat', 'exp', '-append')
toc