%%
odorsRearranged = 1:15; 
odors = length(odorsRearranged);
%%
startingFolder = pwd;
for idxExp = 1: length(espe) 
    idxCell = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 
                idxCell = idxCell + 1;
            end
        end
    end
end



%%
sdf_response = nan * ones(idxCell, odors * (floor(pre*1000 + 3 * 1000) - floor(pre*1000 - 1000) + 1));
sdf_response_diff = nan * ones(idxCell, odors * (floor(pre*1000 + 3 * 1000) - floor(pre*1000 - 1000) + 1));
cellLog = nan * ones(idxCell, 3);
for idxExp = 1: length(espe) 
    idxCell = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 
                idxCell = idxCell + 1;
                idxO = 0;
                response = nan * ones(odors, floor(pre*1000 + 3 * 1000) - floor(pre*1000 - 1000) + 1);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor(pre*1000 - 1000) : floor(pre*1000 + 3 * 1000));
                    response(idxO,:) = reshape(app,1, size(app,1) * size(app,2));
                end
                sdf_response(idxCell,:) = reshape(response, 1, size(response,1) * size(response,2));
                sdf_response_mean = mean(sdf_response(idxCell,:));
                sdf_response_diff(idxCell,:) = sdf_response - sdf_response_mean;
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
clearvars -except espe
save('coa_15_2_2.mat', 'esp', '-append')