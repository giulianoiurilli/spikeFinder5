function [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(data, trainingN, labels, repN)


% classification for increasing number of random cells


acc_svm = zeros(repN, size(data,1)-1);
n_trials = size(data,2);
odors = size(data,3);
classes = numel(unique(labels));
jumpTrials = 0:n_trials*odors/classes:n_trials*odors-1;
data        = reshape(data, size(data,1), size(data,2) .* size(data,3));
data        = data';
numInst     = size(data,1);
numTrain    = trainingN;
numTest     = numInst - numTrain;
numLabels   = max(labels);
prediction = zeros(classes, repN);
actual = zeros(classes, repN);




% Cross-validated classification
for rep = 1:repN
    % Split training/testing
    app = size(data,1)/classes;
    idx = randi([1 app-1], [classes 1]) + jumpTrials';
    app_testData = data(idx,:);
    app_trainData = data;
    app_trainData(idx,:) = [];
    testLabel = labels(idx);
    trainLabel = labels;
    trainLabel(idx) = [];
    j                           = 0;
    for units = 10:10:150 %size(data,2) 
        j                       = j + 1;
        idxUnits                = randsample(size(data,2), units);%1:units;%
        trainData               = app_trainData(:,idxUnits);
        testData                = app_testData(:,idxUnits);
        model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
        [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
        acc_svm(rep,j)          = accuracy(1);
    end
end


mean_acc_svm = mean(acc_svm);
std_acc_svm = std(acc_svm);
prctile25 = prctile(acc_svm,5);
prctile75 = prctile(acc_svm,95);




