%function [accuracyResponses, accuracyBaseline, accuracyShuffled, accuracyDecorrTuning, accuracyDecorrNoise, conMatResponses] = l_svmClassify(esp, odors)
%function [accuracyResponses, accuracyBaseline, accuracyShuffled, conMatResponses] = l_svmClassify(esp, odors)
%function [accuracyResponses, accuracyBaseline, accuracyShuffled] = l_svmClassify(esp, odors)
%function [accuracyResponses] = l_svmClassify(esp, odors, option)
function [accuracyResponses, weights, accuracyDecorrNoise, conMatResponses] = l_svmClassifyValence(esp, odors, sortingIndex, option)

% esp = coa15.esp;
% odors = 1:15;
% option = 1;


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
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                        esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app;
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    baselineCell1All(idxCell1,:,idxO) = app;
                end
            end
        end
    end
end

%% SVM classification and confusion matrices

if option ==1
    %On responses
    dataAll = responseCell1All;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
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
        if odor < 6
            labels  = [labels, app_labels];
        else
            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        end
    end
    
    
    
    labels      = labels';
    trainingN = floor(0.9*(trials * stimuli));
    repetitions = 100;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat, w] = odor_c_svm_1leaveoutValence(dataAll, trainingN, labels, repetitions, 1);
    accuracyResponses = acc_svm;
    conMatResponses = conMat;
    weights = w;
    
else
    %On responses
    dataAll = responseCell1All;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    
    
    dataAll = [dataAll sortingIndex];
    dataAll = sortrows(dataAll, size(dataAll,2));
    dataAll = flipud(dataAll);
    dataAll(:,end) = [];
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
        if odor < 6
            labels  = [labels, app_labels];
        else
            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        end
    end
    
    
    
    labels      = labels';
    trainingN = floor(0.9*(trials * stimuli));
    repetitions = 100;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat, w] = odor_c_svm_1leaveoutValence(dataAll, trainingN, labels, repetitions, 2);
    accuracyResponses = acc_svm;
    conMatResponses = conMat;
    weights = nan;
end

