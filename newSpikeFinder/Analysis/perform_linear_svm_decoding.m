function [performance, confusionMatrix, weigths, mi] = perform_linear_svm_decoding(esp, odors, option)


% option.abs:           scalar, 1: include neurons that have at least one
%                                  excitatory or one inhibitory response
%                               0: include neurons that have at least one
%                                  excitatory response
%
% option.window:        scalar, 300 or 1000 ms window
%
% option.L_ratio:       scalar indicating the minimum L_Ratio for including
%                       that unit
%
% option.repetitions:   scalar specifying number of repetitions for
%                       cross-validation
%
% option.baseline:      0: only baseline window; 1: only response window
%
% option.grouping:      array
%
% option.units:         string: 'all', 'incrementing_by_one',
%                       'incrementing_by_10', 'user_defined_number', 'sorted', 'remove'
% option.this_number_of_units:    scalar, only used if "user_defined_number' is selected
%
% option.sorting_vector:          1xm array specifyng the sorting
%                                           order of units, only used if 'sorted' or 'remove' are selected
% option.single_unit:              scalar indicating a unique unit
%
% option.shuffle:       scalar: 0: no reshuffling; 1: shuffle odor labels
%                       across trials
% option.number_of_shuffles:    scalar
%
% option.decorrelation:   string: 'none', 'signal', 'noise'
%
% option.decorrelation.number_of_shuffles:    scalar;
%
% option.trajectory:



%%
if ~isfield(option, 'repetitions')
    option.repetitions = 100;
end

if ~isfield(option, 'baseline')
    option.baseline = 0;
end

if ~isfield(option, 'units')
    option.units = 'all';
end

if ~isfield(option, 'shuffle')
    option.shuffle = 0;
end
if option.shuffle == 1 && ~isfield(option, 'number_of_shuffles')
    option.number_of_shuffles = 100;
end

if ~isfield(option, 'decorrelation' )
    option.decorrelation = 'none';
end
if ~strcmp(option.decorrelation, 'none') && ~isfield(option, 'number_of_decorrelations')
    option.number_of_decorrelations = 100;
end

if ~isfield(option, 'grouping')
    option.grouping = 1:numel(odors);
end

weigths = nan;
%%
dataAll = createResponseMatrix(esp, odors, option);


if isfield(option, 'single_unit')
    single_unit_index = option.single_unit;
    app = dataAll;
    dataAll = [];
    dataAll = app(single_unit_index,:,:);
    option.units = 'all';
end

%%
if option.shuffle == 0
    if strcmp(option.decorrelation, 'none')  == 1
        neurons = size(dataAll,1);
        trials = size(dataAll,2);
        stimuli = size(dataAll,3);
        dataAll = reshape(dataAll, neurons, trials .* stimuli);
        if strcmp(option.units, 'sorted') || strcmp(option.units, 'remove')
            dataAll = [dataAll option.sorting_vector(:)];
            dataAll = sortrows(dataAll, size(dataAll,2));
            dataAll(:,size(dataAll,2)) = [];
            dataAll = flipud(dataAll);
        end
        dataAll = dataAll';
        dataAll = zscore(dataAll);
        dataAll = dataAll';
        dataAll(isinf(dataAll)) = 0;
        dataAll(isnan(dataAll)) = 0;
        dataAll = reshape(dataAll, neurons, trials, stimuli);
        dataAll = double(dataAll);
        trainingN = floor(0.9*(trials * stimuli));
        repetitions = option.repetitions;
        labels = create_labels(trials,stimuli, option);
        [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat, weigths, mi] = svm_linear_classifier_v2(dataAll, trainingN, labels, repetitions, option);
        performance = acc_svm;
        confusionMatrix = conMat;
    end
    if strcmp(option.decorrelation, 'signal')  == 1
        accuracyDecorrTuning = [];
        for idxShuffle = 1:option.number_of_decorrelations
            dataAllRe = dataAll;
            neurons = size(dataAllRe,1);
            trials = size(dataAllRe,2);
            stimuli = size(dataAllRe,3);
            for idxNeuron = 1:neurons
                idx = randperm(stimuli);
                dataAllRe(idxNeuron,:, :) = dataAllRe(idxNeuron,:, idx);
            end
            dataAllRe = reshape(dataAllRe, neurons, trials .* stimuli);
            dataAllRe = dataAllRe';
            dataAllRe = zscore(dataAllRe);
            dataAllRe = dataAllRe';
            dataAllRe(isinf(dataAllRe)) = 0;
            dataAllRe(isnan(dataAllRe)) = 0;
            dataAllRe = reshape(dataAllRe, neurons, trials, stimuli);
            dataAllRe = double(dataAllRe);
            trainingN = floor(0.9*(trials * stimuli));
            repetitions = option.repetitions;
            labels = create_labels(trials,stimuli, option);
            [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat, weigths] = svm_linear_classifier_v2(dataAllRe, trainingN, labels, repetitions, option);
            accuracyDecorrTuning =  [accuracyDecorrTuning; acc_svm];
        end
        performance = accuracyDecorrTuning;
        confusionMatrix = nan(stimuli);
    end
    if strcmp(option.decorrelation, 'noise')  == 1
        accuracyDecorrTuning = [];
        for idxShuffle = 1:option.number_of_decorrelations
            dataAllRe = dataAll;
            neurons = size(dataAllRe,1);
            trials = size(dataAllRe,2);
            stimuli = size(dataAllRe,3);
            for idxNeuron = 1:neurons
                idx = randperm(trials);
                dataAllRe(idxNeuron,:, :) = dataAllRe(idxNeuron,idx, :);
            end
            dataAllRe = reshape(dataAllRe, neurons, trials .* stimuli);
            dataAllRe = dataAllRe';
            dataAllRe = zscore(dataAllRe);
            dataAllRe = dataAllRe';
            dataAllRe(isinf(dataAllRe)) = 0;
            dataAllRe(isnan(dataAllRe)) = 0;
            dataAllRe = reshape(dataAllRe, neurons, trials, stimuli);
            dataAllRe = double(dataAllRe);
            trainingN = floor(0.9*(trials * stimuli));
            repetitions = option.repetitions;
            labels = create_labels(trials,stimuli, option);
            [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat, weigths] = svm_linear_classifier_v2(dataAllRe, trainingN, labels, repetitions, option);
            accuracyDecorrTuning =  [accuracyDecorrTuning; acc_svm];
        end
        performance = accuracyDecorrTuning;
        confusionMatrix = nan(stimuli);
    end
end

%%
if option.shuffle == 1
    %Shuffle order neurons across trials
    accuracyShuffled = [];
    for idxShuffle = 1:option.number_of_shuffles
        dataAllRe = dataAll;
        neurons = size(dataAllRe,1);
        trials = size(dataAllRe,2);
        stimuli = size(dataAllRe,3);
        
        for idxTrial = 1:trials
            for idxStim = 1:stimuli;
                idx = randperm(neurons);
                dataAllRe(:,idxTrial, idxStim) = dataAllRe(idx,idxTrial, idxStim);
            end
        end
        dataAllRe = reshape(dataAllRe, neurons, trials .* stimuli);
        dataAllRe = dataAllRe';
        dataAllRe = zscore(dataAllRe);
        dataAllRe = dataAllRe';
        dataAllRe(isinf(dataAllRe)) = 0;
        dataAllRe(isnan(dataAllRe)) = 0;
        dataAllRe = reshape(dataAllRe, neurons, trials, stimuli);
        dataAllRe = double(dataAllRe);
        trainingN = floor(0.9*(trials * stimuli));
        repetitions = option.repetitions;
        labels = create_labels(trials,stimuli, option);
        [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat, weigths] = svm_linear_classifier_v2(dataAllRe, trainingN, labels, repetitions, option);
        accuracyShuffled =  [accuracyShuffled; acc_svm ];
        confusionMatrix = nan(stimuli);
    end
    performance = accuracyShuffled;
end