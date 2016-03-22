%%
fileToSave = 'coa_AAmix_2_2.mat';
load('parameters.mat');
startingFolder = pwd;
odorsRearranged = 1:15; 
% odorsRearranged = [1 7 3 15]; %coa
% odorsRearranged = [7 6 10 9]; %pcx
% odorsRearranged = [8 11 12 5 2 14 4 10]; %coa
% odorsRearranged = [2 12 13 1 8 3 15 5]; %pcx
%odorsRearranged = [7 6 13 15 3 9]; %coa
%odorsRearranged = [4 6 7 9 10 11]; %pcx
%odorsRearranged = [4 5 13 15 1 14 8 3 7 12 11 10 6 9 2]; %coa
%odorsRearranged = [14 13 12 15 1 5 3 4 2 6 8 7 9 10 11]; %pcx

odors = length(odorsRearranged);

%%

for idxExp = 1 : length(List)
    cartella = List{idxExp};
    cd(cartella)
    load('unitsNowarp.mat', 'shankNowarp');
    idxCell = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell = idxCell + 1;
            end
        end
    end
    sdf_response = nan * ones(idxCell, odors * (floor(pre*1000 + 3 * 1000) - floor(pre*1000 - 1000) + 1) * n_trials);
    sdf_response_diff = nan * ones(idxCell, odors * (floor(pre*1000 + 3 * 1000) - floor(pre*1000 - 1000) + 1) * n_trials);
    cellLog = nan * ones(idxCell, 3);
    idxCell = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 
                idxCell = idxCell + 1;
                idxO = 0;
                response = nan * ones(odors, (floor(pre*1000 + 3 * 1000) - floor(pre*1000 - 1000) + 1) * n_trials);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor(pre*1000 - 1000) : floor(pre*1000 + 3 * 1000));
                    response(idxO,:) = reshape(app,1, size(app,1) * size(app,2));
                end
                sdf_response(idxCell,:) = reshape(response, 1, size(response,1) * size(response,2));
                sdf_response_mean = mean(sdf_response(idxCell,:));
                sdf_response_diff(idxCell,:) = sdf_response(idxCell,:) - sdf_response_mean;
                cellLog(idxCell,:) = [idxExp, idxShank, idxUnit];
            end
        end
    end
    idxCell = [];
    for idxCell = 1:size(sdf_response,1)
        firingSum = [];
        firingSum = sum(sdf_response(idxCell,:));
        app = [];
        app = sdf_response_diff;
        app(idxCell,:) = [];
        populationSum = sum(app);
        integralInTime = sum(sdf_response_diff(idxCell,:) .* populationSum);
        i1 = cellLog(idxCell,1); i2 = cellLog(idxCell,2); i3 = cellLog(idxCell,3);
        esp(i1).shankNowarp(i2).cell(i3).couplingFactor = integralInTime ./ firingSum;
    end
end

cd(startingFolder)
clearvars -except esp fileToSave List
save(fileToSave, 'esp', '-append')
