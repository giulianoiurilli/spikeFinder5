function accuracyNBMean = naiveBayesClassify(esp, odors)
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

%%
%On responses
dataAll = ceil(responseCell1All);
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
%dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;

%                                                                                     for odor = 1:size(dataAll,3) - 1
%                                                                                         if odor < 4
%                                                                                         labels  = [labels, app_labels];
%                                                                                         else
%                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
%                                                                                         end
%                                                                                     end
                                                                                    for odor = 1:size(dataAll,3) - 1
                                                                                        if odor < 2
                                                                                        labels  = [labels, app_labels];
                                                                                        else
                                                                                            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
                                                                                        end
                                                                                    end

% for odor = 1:size(dataAll,3) - 1
%     labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
% end
labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repN = 1000;
accuracyNBMean = naiveBayes_1leaveout(dataAll, trainingN, labels, repN);
