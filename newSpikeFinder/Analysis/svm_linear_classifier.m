function [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, CM, w] = svm_linear_classifier(data, trainingN, labels, repN, option)

acc_svm = zeros(repN, 1);
n_trials = size(data,2);
stimuli = size(data,3);
classes = numel(unique(labels));
jumpTrials = 0:n_trials*stimuli/classes:n_trials*stimuli-1;
data        = reshape(data, size(data,1), size(data,2) .* size(data,3));
data        = data';
numInst     = size(data,1);
numTrain    = trainingN;
prediction = zeros(classes, repN);
actual = zeros(classes, repN);

w = nan(size(data,2), repN);


% Cross-validated classification
for rep = 1:repN %randomly split trials in training and test sets
    
    app = size(data,1)/classes;
    idx = randi([1 app-1], [classes 1]) + jumpTrials';
    app_testData = data(idx,:);
    app_trainData = data;
    app_trainData(idx,:) = [];
    testLabel = labels(idx);
    trainLabel = labels;
    trainLabel(idx) = [];
    j  = 0;
    
    %%
    if strcmp(option.units, 'all')
        for units = size(data,2)
            j                       = j + 1;
            idxUnits                = randsample(size(data,2), units);
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w(:,rep) = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'incrementing_by_one')
        for units = 1:size(data,2)
            j                       = j + 1;
            idxUnits                = randsample(size(data,2), units);
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w(:,rep) = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'incrementing_by_10')
        for units = 1:10:size(data,2)
            j                       = j + 1;
            idxUnits                = randsample(size(data,2), units);%1:units;%
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w(:,rep) = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'user_defined_number')
        for units = option.units.this_number_of_units
            j                       = j + 1;
            idxUnits                = randsample(size(data,2), units);%1:units;%
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w(:,rep) = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'sorted')
        for units = 1:size(data,2)
            j                       = j + 1;
            idxUnits                = 1:units;%
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w(:,rep) = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'remove')
        for units = 1:size(data,2)
            j                       = j + 1;
            idxUnits                = units:size(data,2);%
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w(:,rep) = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
end

prediction = prediction(:);
actual = actual(:);
CM = confusionmat(actual, prediction);
CM = CM ./ repmat(sum(CM,2), 1, size(CM,2));
mean_acc_svm = mean(acc_svm);
std_acc_svm = std(acc_svm);
prctile25 = prctile(acc_svm,5);
prctile75 = prctile(acc_svm,95);