infor = [];
c = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                infor = [infor coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s];
                idxO = 0;
                c = c+1;
                for idxOdor = 1:15
                    idxO = idxO + 1;
                    app = [];
                    app = double(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                        coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1All(c,:,idxO) = app2;
                    aurocs(c,idxO) = coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
end

[sortedI,sortingIndices] = sort(infor,'descend');
maxValueIndices = sortingIndices(1);
best15_aurocs_coa = aurocs(maxValueIndices,:);
clims = [0 1];
figure; subplot(1,2,1); imagesc(best15_aurocs_coa, clims);


%% Best Neuron
dataAll = [];
dataAll = responseCell1All(maxValueIndices,:,:);
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
labela = labels';
trainingN = floor(0.9*(trials * stimuli));
[mean_acc_svm_best, std_acc_svm_best, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 100);

%% Remove best neurons
mean_acc_svm_1 = nan(1,100);
std_acc_svm_1 = nan(1,100);
for idxNeuron = 1:100
    X = [];
    X = responseCell1All;
    X(sortingIndices(1:idxNeuron),:,:) = [];
    dataAll = [];
    dataAll = X;
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
    labela = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 100);
    mean_acc_svm_1(idxNeuron) = mean_acc_svm(1);
    std_acc_svm_1(idxNeuron) = std_acc_svm(1);
end

%%

    dataAllapp = [];
    dataAllapp = responseCell1All(maxValueIndices,:,:);
    [x,y] = max(best15_aurocs_coa);
dataAll = zeros(15,5,15);
for idxOdor = 1:15
    dataAll(idxOdor,:,idxOdor) = dataAllapp(y(idxOdor),:,idxOdor);
end
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
    labela = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 100);
%%
meanAcc = [];

    dataAll = [];
    dataAll = responseCell1All(maxValueIndices,:,:);
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
    labela = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 100);



figure
plot(mean_acc_svm)
%%
infor = [];
c = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                infor = [infor pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s];
                idxO = 0;
                c = c+1;
                for idxOdor = 1:15
                    idxO = idxO + 1;
                    app = [];
                    app = double(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                        pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1All(c,:,idxO) = app2;
                    aurocs(c,idxO) = pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
end

[sortedI,sortingIndices] = sort(infor,'descend');
maxValueIndices = sortingIndices(1);
best15_aurocs_pcx = aurocs(maxValueIndices,:);

    
%%
meanAcc = [];

    dataAll = [];
    dataAll = responseCell1All(maxValueIndices,:,:);
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
    labela = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, best15_acc_svm_pcx, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 100);



figure
plot(mean_acc_svm)


%%



%%
dataAll = zeros(15,5,15);
for idxOdor = 1:15
    dataAll(idxOdor,:,idxOdor) = 10*ones(1,5);
end

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
    labela = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, best15_acc_svm_labeledLines, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 100);