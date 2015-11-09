    dataAll = [];
    dataAll = responses1AllTrials;
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
    
%     for odor = 1:size(dataAll,3) - 1
%         if odor < 5
%         labels  = [labels, app_labels];
%         else
%             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
%         end
%     end

    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    
    labels      = labels';
    trainingN = floor(0.9*(trials * stimuli));
    repetitions = 200;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    