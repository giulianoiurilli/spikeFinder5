function performances = naiveBayes_1leaveout(data, trainingN, labels, repN)
 
 
acc_svm = zeros(repN, 1);
neurons = size(data,1);
n_trials = size(data,2);
odors = size(data,3);
classes = numel(unique(labels)); 
jumpTrials = 0:n_trials*odors/classes-1:classes*n_trials-1;
data        = reshape(data, neurons, n_trials .* odors);
data        = data';
numInst     = size(data,1);
numTrain    = trainingN;
numTest     = numInst - numTrain;
numLabels   = max(labels);

 
 
 
correct  = nan * ones(1, classes);
performances  = nan * ones(1, repN);
% Cross-validated classification
for rep = 1:repN
    % Split training/testing
    app = size(data,1)/classes;
    idx = randi([1 app-1], [classes 1]) + jumpTrials';
    app_testData = data(idx,:);
    trainData = data;
    trainData(idx,:) = [];
    testLabel = labels(idx);
    trainLabel = labels;
    trainLabel(idx) = [];
    trainData = trainData';
    app_testData = app_testData';
    trainData = reshape(trainData, neurons, n_trials*odors/classes - 1, classes);
    app_lambda = squeeze(mean(trainData, 2));
    idxUnit = randsample(size(data,2), 100);
    lambda = app_lambda(idxUnit,:);
    testData = app_testData(idxUnit,:);
    for idxTest = 1:size(testData,2)
        lik1 = bsxfun(@power, lambda, testData(:,idxTest));
        lik2 = lik1.* exp(-lambda);
        lik3 = bsxfun(@rdivide, lik2, factorial(testData(:,idxTest)));
        lik3(lik3<0.01) = 0.01;
        likPop = prod(lik3);
        [~, indMax] = max(likPop);
        correct(idxTest) = indMax == testLabel(idxTest);
    end
    performances(rep) = sum(correct) ./ length(correct);
end