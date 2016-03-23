fileToSave = 'coa_AAmix_2_2.mat';
load('parameters.mat')
startingFolder = pwd;



%% Valence class
% between class prediction 
cSeries = [1:5; 6:10];
for idxExp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                odor1S = nan*ones(50, 2);
                for idxClass = 1:2
                    idxSeries = cSeries(idxClass,:);
                    A1s = nan*ones(n_trials, 5);
                    j = 0;
                    for idxMix = idxSeries(1):idxSeries(5)
                        j = j+1;
                        A1s(:, j) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxMix).AnalogicResponse1000ms';
                    end
                    odor1S(:,idxClass) = A1s(:);
                end
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1sBetweenValenceClassIdentity = poissonInformation(odor1S);
            end
        end
    end
end

% whithin class prediction
for idxExp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxClass = 1:2
                    idxSeries = cSeries(idxClass,:);
                    A1s = nan*ones(n_trials, 5);
                    j = 0;
                    for idxMix = idxSeries(1):idxSeries(5)
                        j = j+1;
                        A1s(:, j) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxMix).AnalogicResponse1000ms';
                    end
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).class(idxClass).I1sWhithinValenceClassIdentity = poissonInformation(A1s);
                end
            end
        end
    end
end
%% Mixes
% between class prediction 
cSeries = [1 11 12; 6 13 14];
for idxExp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                odor1S = nan*ones(30, 2);
                for idxClass = 1:2
                    idxSeries = cSeries(idxClass,:);
                    A1s = nan*ones(n_trials, 3);
                    j = 0;
                    for idx = 1:3
                        idxMix = idxSeries(idx);
                        j = j+1;
                        A1s(:, j) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxMix).AnalogicResponse1000ms';
                    end
                    odor1S(:,idxClass) = A1s(:);
                end
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1sBetweenMixIdentity = poissonInformation(odor1S);
            end
        end
    end
end

% whithin class prediction
for idxExp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxClass = 1:2
                    idxSeries = cSeries(idxClass,:);
                    A1s = nan*ones(n_trials, 3);
                    j = 0;
                    for idx = 1:3
                        idxMix = idxSeries(idx);
                        j = j+1;
                        A1s(:, j) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxMix).AnalogicResponse1000ms';
                    end
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).class(idxClass).I1sWhithinMixIdentity = poissonInformation(A1s);
                end
            end
        end
    end
end

cd(startingFolder)
clearvars -except List esp fileToSave startingFolder
save(fileToSave, 'esp', '-append')