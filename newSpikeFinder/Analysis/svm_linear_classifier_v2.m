function [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, CM, w, MI] = svm_linear_classifier_v2(data, trainingN, labels, repN, option)

%% version2 allows unbalanced classes
%%

acc_svm = zeros(repN, 1);
n_trials = size(data,2);
stimuli = size(data,3);
classes = numel(unique(labels));
data        = reshape(data, size(data,1), size(data,2) .* size(data,3));
data        = data';
numInst     = size(data,1);
numTrain    = trainingN;
prediction = zeros(classes, repN);
actual = zeros(classes, repN);

w = nan(size(data,2), repN);

dataApp = [data labels];
dataApp = sortrows(dataApp,size(dataApp,2));

classNames = unique(labels);
for idxClass = 1:classes
    numerosityClass(idxClass) = numel(find(labels==classNames(idxClass)));
end
minNTrials = min(numerosityClass);

jumpTrials = 0:minNTrials:minNTrials*classes-1;

% Cross-validated classification
for rep = 1:repN %randomly split trials in training and test sets
    
    balancedData = [];
    last = 0;
    for idxClass = 1:classes
        app = [];
        app = dataApp(last + 1 : last + numerosityClass(idxClass), :);
        last  = last + numerosityClass(idxClass);
        idx_app = randperm(numerosityClass(idxClass));
        idx_app = idx_app';
        idx = idx_app(1:minNTrials);
        balancedData = [balancedData; app(idx,:)];
    end
    labels = balancedData(:,size(balancedData,2));
    balancedData(:,size(balancedData,2)) = [];
    
    app = size(balancedData,1)/classes;
    idx = randi([1 app-1], [classes 1]) + jumpTrials';
    app_testData = balancedData(idx,:);
    app_trainData = balancedData;
    app_trainData(idx,:) = [];
    testLabel = labels(idx);
    trainLabel = labels;
    trainLabel(idx) = [];
    j  = 0;
    
    %%
    if strcmp(option.units, 'all')
        for units = size(balancedData,2)
            j                       = j + 1;
            idxUnits                = randsample(size(balancedData,2), units);
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            %w(:,rep) = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'incrementing_by_one')
        for units = 1:size(balancedData,2)
            j                       = j + 1;
            idxUnits                = randsample(size(balancedData,2), units);
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'incrementing_by_10')
        for units = 1:10:size(balancedData,2)
            j                       = j + 1;
            idxUnits                = randsample(size(balancedData,2), units);%1:units;%
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'user_defined_number')
        for units = option.this_number_of_units
            j                       = j + 1;
            idxUnits                = randsample(size(balancedData,2), units);%1:units;%
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
        for units = 1:size(balancedData,2)
            j                       = j + 1;
            idxUnits                = 1:units;%
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w = model_svm.SVs' * model_svm.sv_coef;
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
    end
    %%
    if strcmp(option.units, 'remove')
        %         for units = 1:size(balancedData,2)
        for units = 1:90
            j                       = j + 1;
            %             idxUnits                = units:size(balancedData,2);%
            idxUnits                = units:90;
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            w = model_svm.SVs' * model_svm.sv_coef;
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
appCM = CM;
%compute mutual information from confusion matrix
appCM = appCM';
prob_predicted_actual = appCM./sum(sum(appCM));
prob_predicted = sum(appCM')./sum(sum(appCM));
prob_actual = sum(appCM)./sum(sum(appCM));
MI_pieces_each_pred_actual = prob_predicted_actual .* log2(prob_predicted_actual .* 1./(prob_predicted' * prob_actual));
MI_pieces_each_pred_actual(find(isnan(MI_pieces_each_pred_actual))) = 0;
MI = sum(sum(MI_pieces_each_pred_actual));
                
CM = CM ./ repmat(sum(CM,2), 1, size(CM,2));
mean_acc_svm = mean(acc_svm);
std_acc_svm = std(acc_svm);
prctile25 = prctile(acc_svm,5);
prctile75 = prctile(acc_svm,95);