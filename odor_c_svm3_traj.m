function [mean_acc_svm, std_acc_svm] = odor_c_svm_traj3(data, n_neurons, trainingN, labels, repN, clas, tofolder)



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
    for units = 2:n_neurons
        idxUnits_o                = randsample(n_neurons, units)';
        idxUnits                  = idxUnits_o;
        for u = 1:size(data,2)/n_neurons - 1
            idxUnits                = [idxUnits idxUnits_o + u * n_neurons];
        end
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
x = 2 : size(mean_acc_svm,2) + 1;
h = figure;
shadedErrorBar(x, mean_acc_svm, std_acc_svm, 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('c_svm linear discrimination -%s .eps', clas);
saveas(h,fullfile(tofolder,stringa_fig),'epsc')


