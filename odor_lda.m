function [mean_acc_lda, std_acc_lda] = odor_lda(data, trainingN, repN, clas)



data        = reshape(data, size(data,1), size(data,2) .* size(data,3));
data        = data';
numInst     = size(data,1);
numTrain    = trainingN; 
numTest     = numInst - numTrain;

% Make labels
labels      = ones(1,size(data,2));
app_labels  = labels;
for odor = 1:size(data,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(data,2))];
end
labels      = labels';
numLabels   = max(labels);

% Bootstrap and model
for rep = 1:repetitions
    % Split training/testing
    idx                         = randperm(numInst);
    app_trainData               = data(idx(1:numTrain),:);
    app_testData                = data(idx(numTrain+1:end),:);
    trainLabel                  = labels(idx(1:numTrain));
    testLabel                   = labels(idx(numTrain+1:end));
    j                           = 1;
    for units = 2:size(populatioPatternTrials,1)
        idxUnits                = randsample(size(data,1), units);
        trainData               = app_trainData(:,idxUnits);
        testData                = app_testData(:,idxUnits);
        model_lda               = fitcdiscr(trainData, trainLabel);
        predLabel               = predict(model_lda, testData);
        conMat                  = confusionmat(testLabel, predLabel);
        acc_lda(rep, j)         = sum(diag(conMat)) ./ sum(conMat(:)); % Accuracy   
        j                       = j + 1;
    end
end

mean_acc_lda = mean(acc_lda);
std_acc_lda = std(acc_lda);
x = 2 : size(acc_svm,2) + 1;

h = figure;
shadedErrorBar(x, mean_acc_lda, std_acc_lda, 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('lda linear discrimination -%s .eps', clas);
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


