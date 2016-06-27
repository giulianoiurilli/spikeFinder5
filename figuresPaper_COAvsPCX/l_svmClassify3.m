function [accuracyResponses] = l_svmClassify3(esp, odors)


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
                info(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I1s;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                    esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
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

%% SVM classification and confusion matrices

%On responses
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
app = [dataAll, info'];
app = sortrows(app);
app = flipud(app);
dataAll = app(:,1:end-1);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;


for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end


labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 1000;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_3leaveout(dataAll, trainingN, labels, repetitions);
accuracyResponses = acc_svm;


