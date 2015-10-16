function [mean_acc_svm, std_acc_svm, acc_svm] = odor_c_svm(data, trainingN, labels, repN)



data        = reshape(data, size(data,1), size(data,2) .* size(data,3));
data        = data';
numInst     = size(data,1);
numTrain    = trainingN; 
numTest     = numInst - numTrain;
numLabels   = max(labels);



% Cross-validated classification
for rep = 1:repN
    % Split training/testing
    idx                         = randperm(numInst);
    app_trainData               = data(idx(1:numTrain),:);
    app_testData                = data(idx(numTrain+1:end),:);
    trainLabel                  = labels(idx(1:numTrain));
    testLabel                   = labels(idx(numTrain+1:end));
    j                           = 1;
    for units = 2:size(data,2)
        idxUnits                = randsample(size(data,2), units);%1:units;%
        trainData               = app_trainData(:,idxUnits);
        testData                = app_testData(:,idxUnits);
        model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
        [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
        acc_svm(rep,j)          = accuracy(1);  
        j                       = j + 1;
    end
end

mean_acc_svm = mean(acc_svm);
std_acc_svm = std(acc_svm);



