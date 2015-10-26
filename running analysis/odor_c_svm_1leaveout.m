function [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(data, trainingN, labels, repN)


n_trials = size(data,2);
classes = size(data,3);
jumpTrials = 0:n_trials:(classes-1)*n_trials;
data        = reshape(data, size(data,1), size(data,2) .* size(data,3));
data        = data';
numInst     = size(data,1);
numTrain    = trainingN; 
numTest     = numInst - numTrain;
numLabels   = max(labels);




% Cross-validated classification
for rep = 1:repN
    % Split training/testing
    %idx                         = randperm(numInst);
    idx = randi([1 n_trials], [classes 1]) + jumpTrials';
    %app_trainData               = data(idx(1:numTrain),:);
    app_testData = data(idx,:);
    %app_testData                = data(idx(numTrain+1:end),:);
    app_trainData = data;
    app_trainData(idx,:) = [];
    %trainLabel                  = labels(idx(1:numTrain));
    testLabel = labels(idx);
    %testLabel                   = labels(idx(numTrain+1:end));
    trainLabel = labels;
    trainLabel(idx) = [];
    j                           = 1;
    %for cValue = [0.01 0.05 0.1 0.5]  
        %params = sprintf('-t 0 -c %d -q', cValue)
    for units = size(data,2) %2:size(data,2)
        idxUnits                = randsample(size(data,2), units);%1:units;%
        trainData               = app_trainData(:,idxUnits);
        testData                = app_testData(:,idxUnits);
        model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 0.1 -q');
        %model_svm               = svmtrain(trainLabel, trainData, params);
        [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
        acc_svm(rep)          = accuracy(1);  
        j                       = j + 1;
    end
    %end
end

mean_acc_svm = mean(acc_svm);
std_acc_svm = std(acc_svm);
prctile25 = prctile(acc_svm, 25);
prctile75 = prctile(acc_svm, 75);



