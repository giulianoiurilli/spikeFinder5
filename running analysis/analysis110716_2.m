esp = pcx15.esp;

infor = [];
c = 0;
for idxExp = 1 : length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                infor = [infor esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s];
                idxO = 0;
                c = c+1;
                for idxOdor = 1:15
                    idxO = idxO + 1;
                    app = [];
                    app = double(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1All(c,:,idxO) = app2;
                    aurocs(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
end

[sortedI,sortingIndices] = sort(infor,'descend');
maxValueIndices = sortingIndices(1);
% best15_aurocs_coa = aurocs(maxValueIndices,:);
clims = [0 1];
% figure; subplot(1,2,1); imagesc(best15_aurocs_coa, clims);


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
[mean_acc_svm_bestPcx, std_acc_svm_bestPcx, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 100);

%% Remove best neurons
mean_acc_svm_1 = nan(1,150);
std_acc_svm_1 = nan(1,150);
for idxNeuron = 1:150
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
    mean_acc_svm_1Pcx(idxNeuron) = mean_acc_svm(1);
    std_acc_svm_1Pcx(idxNeuron) = std_acc_svm(1);
end

%% Remove random neurons
randomIndices = randperm(numel(infor));
mean_acc_svm_2Pcx = nan(1,150);
std_acc_svm_2Pcx = nan(1,150);
for idxNeuron = 1:150
    X = [];
    X = responseCell1All;
    X(randomIndices(1:idxNeuron),:,:) = [];
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
    mean_acc_svm_2Pcx(idxNeuron) = mean_acc_svm(1);
    std_acc_svm_2Pcx(idxNeuron) = std_acc_svm(1);
end

%%
esp = coa15.esp;

infor = [];
c = 0;
for idxExp = 1 : length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                infor = [infor esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s];
                idxO = 0;
                c = c+1;
                for idxOdor = 1:15
                    idxO = idxO + 1;
                    app = [];
                    app = double(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1All(c,:,idxO) = app2;
                    aurocs(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
end

[sortedI,sortingIndices] = sort(infor,'descend');
maxValueIndices = sortingIndices(1);
% best15_aurocs_coa = aurocs(maxValueIndices,:);
clims = [0 1];
% figure; subplot(1,2,1); imagesc(best15_aurocs_coa, clims);


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
[mean_acc_svm_bestCoa, std_acc_svm_bestCoa, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 100);

%% Remove best neurons
mean_acc_svm_1 = nan(1,150);
std_acc_svm_1 = nan(1,150);
for idxNeuron = 1:150
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
    mean_acc_svm_1Coa(idxNeuron) = mean_acc_svm(1);
    std_acc_svm_1Coa(idxNeuron) = std_acc_svm(1);
end

%% Remove random neurons
randomIndices = randperm(numel(infor));
mean_acc_svm_2Coa = nan(1,150);
std_acc_svm_2Coa = nan(1,150);
for idxNeuron = 1:150
    X = [];
    X = responseCell1All;
    X(randomIndices(1:idxNeuron),:,:) = [];
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
    mean_acc_svm_2Coa(idxNeuron) = mean_acc_svm(1);
    std_acc_svm_2Coa(idxNeuron) = std_acc_svm(1);
end
%%
figure
shadedErrorBar(1:150, mean_acc_svm_1Coa, std_acc_svm_1Coa /sqrt(100-1), '-r');
hold on
shadedErrorBar(1:150, mean_acc_svm_1Pcx, std_acc_svm_1Pcx /sqrt(100-1), '-k');
hold on
shadedErrorBar(1:150, mean_acc_svm_2Coa, std_acc_svm_2Coa /sqrt(100-1), ':r');
hold on
shadedErrorBar(1:150, mean_acc_svm_2Pcx, std_acc_svm_2Pcx /sqrt(100-1), ':k');
hold on
shadedErrorBar(1:150, repmat(mean_acc_svm_bestCoa, 1,150), repmat((std_acc_svm_bestCoa /sqrt(100-1)), 1, 150), ':r');
hold on
shadedErrorBar(1:150, repmat(mean_acc_svm_bestPcx, 1,150), repmat((std_acc_svm_bestPcx /sqrt(100-1)), 1, 150), ':k');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
ylabel('accuracy %')



