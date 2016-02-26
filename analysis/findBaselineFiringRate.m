fileToSave = 'coa_15_2_2.mat';
load('parameters.mat')
startingFolder = pwd;
%%
odorsRearranged = 1:15;
odors = length(odorsRearranged);
%%
cells = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 
                cells = cells + 1;
            end
        end
    end
end

%%
baselineFiring = nan*ones(cells,1);
idxCell = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 
                idxCell = idxCell + 1;
                appResponse = nan * ones(1, odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    appResponse(idxO) = median(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl2000ms) ./ 2;
                end
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).baselineFiringRate = mean(appResponse);
            end
        end
    end
end


cd(startingFolder)
clearvars -except esp  fileToSave
save(fileToSave, 'esp', '-append')