function [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, CM] = odor_c_svm_1leaveout(data, trainingN, labels, repN)




% nClassifiers = nchoosek(size(dataTot,3),2);
% v = 1:size(dataTot,3);
% C = nchoosek(v,2);
% 
% 
% mean_acc_svm = zeros(nClassifiers,size(dataTot,1)-1);
% std_acc_svm = zeros(nClassifiers,size(dataTot,1)-1);
% prctile25 = zeros(nClassifiers,size(dataTot,1)-1);
% prctile75 = zeros(nClassifiers,size(dataTot,1)-1);
% labels = [];
% labels = ones(size(dataTot,2),1);
% labels = [labels;labels+labels];
% for idxClass = 1:nClassifiers
%     data = zeros(size(dataTot,1), size(dataTot,2),2);
%     stimuliToClass = C(idxClass,:);
%     data(:,:,1) =  dataTot(:,:,stimuliToClass(1));
%     data(:,:,2) =  dataTot(:,:,stimuliToClass(2));
%     
    
    %acc_svm = zeros(repN, size(data,1)-1);
    acc_svm = zeros(repN, 1);
    n_trials = size(data,2);
    odors = size(data,3);
    classes = numel(unique(labels)); 
    jumpTrials = 0:n_trials*odors/classes-1:classes*n_trials-1;
    %jumpTrials = 0:n_trials:(odors-1)*n_trials;
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
        %idx                         = randperm(numInst);
        app = size(data,1)/classes;
        idx = randi([1 app-1], [classes 1]) + jumpTrials';
        %idx = randi([1 n_trials], [odors 1]) + jumpTrials';
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
        j                           = 0;
        %for cValue = [0.01 0.05 0.1 0.5]
        %params = sprintf('-t 0 -c %d -q', cValue)
        for units = 100%2:size(data,2) %size(data,2) %
            j                       = j + 1;
            idxUnits                = randsample(size(data,2), units);%1:units;%
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            model_svm               = svmtrain(trainLabel, trainData, '-t 0 -c 10 -q');
            %model_svm               = svmtrain(trainLabel, trainData, params);
            [predict_label, accuracy, dec_values] = svmpredict(testLabel, testData, model_svm);
            acc_svm(rep,j)          = accuracy(1);
            prediction(:,rep) = predict_label;
            actual(:,rep) = testLabel;
        end
        %end
    end
    
    prediction = prediction(:);
    actual = actual(:);
    CM = confusionmat(actual, prediction);
    CM = CM ./ repmat(sum(CM,2), 1, size(CM,2));
    mean_acc_svm = mean(acc_svm);
    std_acc_svm = std(acc_svm);
    prctile25 = prctile(acc_svm,5);
    prctile75 = prctile(acc_svm,95);
% end



