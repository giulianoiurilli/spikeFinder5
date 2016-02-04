function [scores, scoresMean] = findCodingSpace(esp, odors)

odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = [];
                    app = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms; %- ...
                    %esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    baselineCell1All(idxCell1,:,idxO) = app2;
                end
            end
        end
    end
end


%% Odor distances - Single trials (averages of 2 presentations) - PCA
% responseCell1All(145:149,:,:) = [];
nRep = 1000;
dataAll = [];
trials = size(responseCell1All,2);
stimuli = size(responseCell1All,3);
scores = zeros(trials .* stimuli, 3, nRep);
for idxRep = 1:nRep
    idxCell = randsample(size(responseCell1All,1), 100);
    dataAll = responseCell1All(idxCell,:);
    neurons = size(dataAll,1);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    dataAll= zscore(dataAll);
    [coeff, score, latent, tsuared, explained, mu] = pca(dataAll);
    scores(:,:,idxRep) = score(:,1:3);
end

scores = squeeze(mean(scores,3));
scoresMean = zeros(stimuli,3);
for idxScore = 1:3
app = [];
app = reshape(scores(:, idxScore), trials, stimuli);
app = mean(app);
scoresMean(:, idxScore) = app'; 
end

% figure;
% colorClass = [228,26,28;...
%     55,126,184;...
%     77,175,74;...
%     152,78,163;...
%     255,127,0]./255;
% symbolOdor = {'o', 's', 'p'};
% k = 0;
% for idxCat = 1:5
%     C = colorClass(idxCat,:);
%     for idxOdor = 1:3
%         mT = symbolOdor{idxOdor};
%         scatter(scores(1 + k*5:5 + k*5, 1), scores(1 + k*5:5 + k*5, 2), 100, C, mT, 'filled');
%         k = k + 1;
%         hold on
% %         scatter3(scoresMean(k, 1), scoresMean(k, 2), scoresMean(k, 3), 100, C, 'd','filled');
% %         hold on
%     end
% end