function [accuracyNBMean, accuracyNBStd] = naiveBayes_Classify(esp, odors)

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

%% Naive Bayes

dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';

labels      = ones(1,trials);
app_labels  = labels;
for odor = 1:stimuli - 1
    labels  = [labels, app_labels + odor .* ones(1,trials)];
end
labels      = labels';


nRep = 5000;
accuracyNB = zeros(1, nRep);
for idxRep = 1:nRep
    cp = cvpartition(labels, 'Kfold', 10);
    for units = 100%2:size(data,2) %size(data,2) %
        idxUnits                = randsample(size(dataAll,2), units);%1:units;%
        data                    = dataAll(:,idxUnits);
        nbG                    = fitcnb(data, labels, 'DistributionNames', 'normal');
        nbGCV                  = crossval(nbG,  'CVPartition', cp);
        accuracyNB(idxRep)      = (1 - kfoldLoss(nbGCV)) * 100;
    end
end

accuracyNBMean = nanmean(accuracyNB);
accuracyNBStd = nanstd(accuracyNB);
            







