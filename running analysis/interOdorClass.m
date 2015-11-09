
stringa{1} = 'responses_3low.mat';
stringa{2} = 'responses_3mediumlow.mat';
stringa{3} = 'responses_3medium.mat';
stringa{4} = 'responses_3mediumhigh.mat';
stringa{5} = 'responses_3high.mat';

% stringa{1} = 'baselines_3low.mat';
% stringa{2} = 'baselines_3mediumlow.mat';
% stringa{3} = 'baselines_3medium.mat';
% stringa{4} = 'baselines_3mediumhigh.mat';
% stringa{5} = 'baselines_3high.mat';
%%
repetitions = 200;
accuracy4 = zeros(3,5);
accuracyShuffled4 = zeros(3,5);
accuracy300 = zeros(3,5);
accuracyShuffled300 = zeros(3,5);
for idxConc = 1:5
    repetitions = 200;
    load(stringa{idxConc});
    
    %real data
    dataAll = [];
    dataAll = responses4AllTrials;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = sqrt(dataAll);
    dataAll = dataAll';
    dataAll(isinf(dataAll)) = 0;
    dataAll(isnan(dataAll)) = 0;
    dataAll = dataAll';
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    labels      = ones(1,size(dataAll,2));
    app_labels  = labels;
    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    labels      = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    accuracy4(1:3,idxConc) = [mean_acc_svm; prctile25; prctile75];
    
    %shuffled data
    accuracyS = zeros(200,3);
    for idxShuffle = 1:200
        repetitionsS = 10;
        dataAll = [];
        dataAll = responses4AllTrials;
        neurons = size(dataAll,1);
        trials = size(dataAll,2);
        stimuli = size(dataAll,3);
        dataAll = reshape(dataAll, neurons, trials .* stimuli);
        dataAll = sqrt(dataAll);
        dataAll = dataAll';
        dataAll(isinf(dataAll)) = 0;
        dataAll(isnan(dataAll)) = 0;
        dataAll = dataAll';
        dataAll = reshape(dataAll, neurons, trials, stimuli);
        labels      = ones(1,size(dataAll,2));
        app_labels  = labels;
        for odor = 1:size(dataAll,3) - 1
            labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
        end
        labels      = labels';
        idx = randperm(length(labels));
        labels = labels(idx);
        trainingN = floor(0.9*(trials * stimuli));
        [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitionsS);
        accuracyS(idxShuffle, 1:3) = [mean_acc_svm prctile25 prctile75];
    end
    accuracyShuffled4(1:3,idxConc) = mean(accuracyS)';
    
        %real data
    dataAll = [];
    dataAll = responses300AllTrials;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = sqrt(dataAll);
    dataAll = dataAll';
    dataAll(isinf(dataAll)) = 0;
    dataAll(isnan(dataAll)) = 0;
    dataAll = dataAll';
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    labels      = ones(1,size(dataAll,2));
    app_labels  = labels;
    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    labels      = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    accuracy300(1:3,idxConc) = [mean_acc_svm; prctile25; prctile75];
    
    %shuffled data
    accuracyS = zeros(200,3);
    for idxShuffle = 1:200
        repetitionsS = 10;
        dataAll = [];
        dataAll = responses300AllTrials;
        neurons = size(dataAll,1);
        trials = size(dataAll,2);
        stimuli = size(dataAll,3);
        dataAll = reshape(dataAll, neurons, trials .* stimuli);
        dataAll = sqrt(dataAll);
        dataAll = dataAll';
        dataAll(isinf(dataAll)) = 0;
        dataAll(isnan(dataAll)) = 0;
        dataAll = dataAll';
        dataAll = reshape(dataAll, neurons, trials, stimuli);
        labels      = ones(1,size(dataAll,2));
        app_labels  = labels;
        for odor = 1:size(dataAll,3) - 1
            labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
        end
        labels      = labels';
        idx = randperm(length(labels));
        labels = labels(idx);
        trainingN = floor(0.9*(trials * stimuli));
        [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitionsS);
        accuracyS(idxShuffle, 1:3) = [mean_acc_svm prctile25 prctile75];
    end
    accuracyShuffled300(1:3,idxConc) = mean(accuracyS)';
end
    
%%
save('interOdorClass.mat', 'accuracy4', 'accuracyShuffled4', 'accuracy300', 'accuracyShuffled300')



