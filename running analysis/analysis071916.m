function accuracy_knnCoa = nkk_Classify(esp, odors);

%%
esp  = pcx15.esp;
odors  =1:15;


odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                    esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    baselineCell1All(idxCell1,:,idxO) = app2;
                end
            end
        end
    end
end

dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;

for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end


labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 1000;

for i = 1:numel(labels)
    Labels{i} = num2str(labels(i));
end
%%
odor_c_svm_1leaveout(data, trainingN, labels, repN)
%%
data = dataAll;
repN = repetitions;


accuracy_knnCoa = zeros(100, 1);
n_trials = size(data,2);
odors = size(data,3);
classes = numel(unique(labels));
jumpTrials = 0:n_trials*odors/classes:n_trials*odors-1;
%jumpTrials = 0:n_trials:(odors-1)*n_trials;
data        = reshape(data, size(data,1), size(data,2) .* size(data,3));
data        = data';
numInst     = size(data,1);
numTrain    = trainingN;
numTest     = numInst - numTrain;
numLabels   = max(labels);
prediction = zeros(classes, repN);
actual = zeros(classes, repN);


accuracy_knnCoa_test = zeros(100,9);
% Cross-validated classification
for n_neighbours = 2:10
    for rep = 1:100
        app = size(data,1)/classes;
        idx = randi([1 app-1], [classes 1]) + jumpTrials';
        app_testData = data(idx,:);
        app_trainData = data;
        app_trainData(idx,:) = [];
        testLabel = Labels(idx);
        trainLabel = Labels;
        trainLabel(idx) = [];
        j                           = 0;
        for units = 150%2:150%10:10:150%2:size(data,2) %150 %size(data,2) %
            j                       = j + 1;
            idxUnits                = randsample(size(data,2), units);%1:units;%
            trainData               = app_trainData(:,idxUnits);
            testData                = app_testData(:,idxUnits);
            Mdl = fitcknn(trainData,trainLabel,'ClassNames',{'1','2','3','4','5','6', '7','8','9','10','11','12','13','14','15'}, 'NumNeighbors',n_neighbours,...
                'Distance','correlation', 'Standardize', 1);
            predict_label = predict(Mdl, testData);
            %accuracy_knn(rep,j)          = sum(strcmp(predict_label', testLabel))./numLabels * 100;
            accuracy_knn_test(rep,n_neighbours)          = sum(strcmp(predict_label', testLabel))./numLabels * 100;
        end
    end
end
%%