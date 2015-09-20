function [mean_acc_svm1, std_acc_svm1, mean_acc_svm2, std_acc_svm2] = odor_c_svm(data, repN, clas, toFolder)


dataTrain(:,:,1) = data(:,:,1);
dataTrain(:,:,2) = data(:,:,5);
dataTrain        = reshape(dataTrain, size(dataTrain,1), size(dataTrain,2) .* size(dataTrain,3));
dataTrain        = dataTrain';

dataTest1(:,:,1) = data(:,:,2);
dataTest1(:,:,2) = data(:,:,6);
dataTest1       = reshape(dataTest1, size(dataTest1,1), size(dataTest1,2) .* size(dataTest1,3));
dataTest1        = dataTest1';

dataTest2(:,:,1) = data(:,:,3);
dataTest2(:,:,2) = data(:,:,4);
dataTest2       = reshape(dataTest2, size(dataTest2,1), size(dataTest2,2) .* size(dataTest2,3));
dataTest2        = dataTest2';



% Make labels
labels      = [ones(1,10) 2*ones(1,10)];
labels      = labels';



% Cross-validated classification
for rep = 1:repN
    j                           = 1;
    for units = 2:size(dataTrain,2)
        idxUnits                = randsample(size(dataTrain,2), units);
        trainData               = dataTrain(:,idxUnits);
        testData1               = dataTest1(:,idxUnits);
        testData2                = dataTest2(:,idxUnits);
        model_svm               = svmtrain(labels, trainData, '-t 0 -c 10 -q');
        [predict_label, accuracy, dec_values] = svmpredict(labels, testData1, model_svm);
        acc_svm1(rep,j)          = accuracy(1);
        [predict_label, accuracy, dec_values] = svmpredict(labels, testData2, model_svm);
        acc_svm2(rep,j)          = accuracy(1);
        j                       = j + 1;
    end
end

mean_acc_svm1 = mean(acc_svm1);
std_acc_svm1 = std(acc_svm1);
mean_acc_svm2 = mean(acc_svm2);
std_acc_svm2 = std(acc_svm2);
x = 2 : size(mean_acc_svm1,2) + 1;

h = figure;
shadedErrorBar(x, mean_acc_svm1, std_acc_svm1, 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('c_svm linear discrimination -%s .eps', clas);
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')
h = figure;
shadedErrorBar(x, mean_acc_svm2, std_acc_svm2, 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
% stringa_fig=sprintf('c_svm linear discrimination -%s .eps', clas);
% saveas(h,fullfile(toFolder,stringa_fig),'epsc')