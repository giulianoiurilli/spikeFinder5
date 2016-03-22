%%
fileToSave = 'pcx_CS_2_1.mat';
load('parameters.mat');
startingFolder = pwd;
%odorsRearranged = 1:15;
% odorsRearranged = [1 7 3 15]; %coa
% odorsRearranged = [7 6 10 9]; %pcx
% odorsRearranged = [8 11 12 5 2 14 4 10]; %coa AA
% odorsRearranged = [2 12 13 1 8 3 15 5]; %pcx AA
% odorsRearranged = [7 6 13 15 3 9]; %coa Mix
%odorsRearranged = [4 6 7 9 10 11]; %pcx Mix
%odorsRearranged = [4 5 13 15 1 14 8 3 7 12 11 10 6 9 2]; %coa CS
odorsRearranged = [14 13 12 15 1 5 3 4 2 6 8 7 9 10 11]; %pcx CS
%odorsRearranged = [6 8 5 11 12 3 2 10 14 4 7 13 15 9 1]; %coa AAmix
%odorsRearranged = [4 2 13 12 1 11 3 5 8 15 6 7 9 10 14]; %pcx AAmix



odors = length(odorsRearranged);
%%
for idxExp = 1 : length(List)
    cartella = List{idxExp};
    cd(cartella)
    load('unitsNowarp.mat', 'shankNowarp');
    response_window = 1; 
    for idxShank = 1:4
        for idxUnit = 1:length(shankNowarp(idxShank).cell)
            idxO = 0;
            R = zeros(n_trials, odors);
            B = zeros(n_trials, odors);
            X = zeros(n_trials, odors);
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                spike_matrix_app = single(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp);
                espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrix = logical(spike_matrix_app); 
            end
        end
    end
end
%%
cd(startingFolder)
clearvars -except List espe fileToSave 
save(fileToSave, 'espe', '-v7.3')
           
                
                
                
                
                
                
                
                
                
                
                