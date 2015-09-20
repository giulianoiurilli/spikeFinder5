function [mean_acc_svm, std_acc_svm, acc_svm] = odor_c_svm(data, trainingN, labels, repN, clas, tofolder)


data_master = data;


for ii = 1:size(data,1)
    data = data_master;
    data(ii,:,:) = [];
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
        for units = size(data,2)
            idxUnits                = randsample(size(data,2), units);
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            j                       = j + 1;
        end
    end
    
    mean_acc_svm(1,ii) = mean(acc_svm);
    std_acc_svm(1:ii) = std(acc_svm);
    
end

data = [];
data = data_master;
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
    for units = size(data,2)
        idxUnits                = randsample(size(data,2), units);
        trainData               = app_trainData(:,idxUnits);
        testData                = app_testData(:,idxUnits);
        model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
        [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
        acc_svm1(rep,j)          = accuracy(1);
        j                       = j + 1;
    end
end

mean_acc_svm_1 = mean(acc_svm1);
std_acc_svm_1 = std(acc_svm1);









mean_acc_svm = mean_acc_svm - mean_acc_svm_1;



h = figure;
x = 1 : length(mean_acc_svm);
shadedErrorBar(x, mean_acc_svm, std_acc_svm, 'g');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');



