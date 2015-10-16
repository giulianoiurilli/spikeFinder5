bestParam = ['-t 0 -q -c 4'];

% model = ovrtrain(trainLabel, trainData, bestParam);
% [predict_label, accuracy, decis_values] = ovrpredictBot(testLabel, testData, model);
% [decis_value_winner, label_out] = max(decis_values,[],2);
% 
% [confusionMatrix,order] = confusionmat(testLabel,label_out);
% 
% figure; imagesc(confusionMatrix');
% xlabel('actual class label');
% ylabel('predicted class label');
% totalAccuracy = trace(confusionMatrix)/NTest;
% disp(['Total accuracy from the SVM: ',num2str(totalAccuracy*100),'%']);

confMat = [];
grouporder = 1:numLabels;
% Cross-validated classification
for rep = 1:500
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
        NTest = size(testData,1);
        model = ovrtrain(trainLabel, trainData, bestParam);
        [predict_label, accuracy, decis_values] = ovrpredictBot(testLabel, testData, model);
        [decis_value_winner, label_out] = max(decis_values,[],2);
        
        [confusionMatrix,order] = confusionmat(testLabel,label_out, 'order', grouporder);
        if rep ==1
            confMat{j} = [];
        end

        if isempty(confMat{j})
            if size(confusionMatrix,1) == numLabels 
                confMat{j} = confusionMatrix';
            end
        else
            if size(confusionMatrix,1) == numLabels 
                confMat{j} = confMat{j} + confusionMatrix';
            end
        end

        acc_svm(rep,j)          = trace(confusionMatrix')/size(confusionMatrix,1);
        j                       = j + 1;
    end
end


figure; plot(mean(acc_svm));
confusionMatrix = mean(confMat{3},3); 
figure; imagesc(confusionMatrix, [0 430])
xlabel('actual odor'); ylabel('predicted odor');axis square;
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
set(gcf,'Color','w')