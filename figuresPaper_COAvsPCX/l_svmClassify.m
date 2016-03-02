%function [accuracyResponses, accuracyBaseline, accuracyShuffled, accuracyDecorrTuning, accuracyDecorrNoise, conMatResponses] = l_svmClassify(esp, odors)
%function [accuracyResponses, accuracyBaseline, accuracyShuffled, conMatResponses] = l_svmClassify(esp, odors)
%function [accuracyResponses, accuracyBaseline, accuracyShuffled] = l_svmClassify(esp, odors)
function [accuracyResponses] = l_svmClassify(esp, odors, option)

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

%% SVM classification and confusion matrices

%On responses
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

switch option
    case 1
        for odor = 1:size(dataAll,3) - 1
            labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
        end
    case 2
        for odor = 1:size(dataAll,3) - 1
            if odor < 4
                labels  = [labels, app_labels];
            else
                labels  = [labels, app_labels + ones(1,size(dataAll,2))];
            end
        end
    case 3
        for odor = 1:size(dataAll,3) - 1
            if odor < 2
                labels  = [labels, app_labels];
            else
                labels  = [labels, app_labels + ones(1,size(dataAll,2))];
            end
        end
    case 4
        for odor = 1:size(dataAll,3) - 1
            if odor < 3
                labels  = [labels, app_labels];
            else
                labels  = [labels, app_labels + ones(1,size(dataAll,2))];
            end
        end
    case 5
        for odor = 1:size(dataAll,3) - 1
            if odor < 5
                labels  = [labels, app_labels];
            else
                if odor < 10
                    labels  = [labels, app_labels + ones(1,size(dataAll,2))];
                else
                    labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
                end
            end   
        end
end

labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 1000;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
accuracyResponses = acc_svm;
conMatResponses = conMat;

% %%
% %On baselines
% dataAll = baselineCell1All;
% neurons = size(dataAll,1);
% trials = size(dataAll,2);
% stimuli = size(dataAll,3);
% dataAll = reshape(dataAll, neurons, trials .* stimuli);
% dataAll = dataAll';
% dataAll = zscore(dataAll);
% dataAll = dataAll';
% dataAll(isinf(dataAll)) = 0;
% dataAll(isnan(dataAll)) = 0;
% dataAll = reshape(dataAll, neurons, trials, stimuli);
% dataAll = double(dataAll);
% labels      = ones(1,size(dataAll,2));
% app_labels  = labels;
% 
% %                                                                                     for odor = 1:size(dataAll,3) - 1
% %                                                                                         if odor < 5
% %                                                                                         labels  = [labels, app_labels];
% %                                                                                         else
% %                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
% %                                                                                         end
% %                                                                                     end
% %                                                                                     for odor = 1:size(dataAll,3) - 1
% %                                                                                         if odor < 2
% %                                                                                         labels  = [labels, app_labels];
% %                                                                                         else
% %                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
% %                                                                                         end
% %                                                                                     end
% 
% for odor = 1:size(dataAll,3) - 1
%     labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
% end
% labels      = labels';
% trainingN = floor(0.9*(trials * stimuli));
% repetitions = 1000;
% [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
% accuracyBaseline = acc_svm;
% 
% 
% %%
% %Shuffle order neurons across trials
% accuracyShuffled = [];
% for idxShuffle = 1:50
%     dataAll = responseCell1All;
%     neurons = size(dataAll,1);
%     trials = size(dataAll,2);
%     stimuli = size(dataAll,3);
%     
%     for idxTrial = 1:trials
%         for idxStim = 1:stimuli;
%             idx = randperm(neurons);
%             dataAll(:,idxTrial, idxStim) = dataAll(idx,idxTrial, idxStim);
%         end
%     end
%     
%     dataAll = reshape(dataAll, neurons, trials .* stimuli);
%     dataAll = dataAll';
%     dataAll = zscore(dataAll);
%     dataAll = dataAll';
%     dataAll(isinf(dataAll)) = 0;
%     dataAll(isnan(dataAll)) = 0;
%     dataAll = reshape(dataAll, neurons, trials, stimuli);
%     dataAll = double(dataAll);
%     labels      = ones(1,size(dataAll,2));
%     app_labels  = labels;
%     
% %                                                                                         for odor = 1:size(dataAll,3) - 1
% %                                                                                             if odor < 5
% %                                                                                             labels  = [labels, app_labels];
% %                                                                                             else
% %                                                                                                 labels  = [labels, app_labels + ones(1,size(dataAll,2))];
% %                                                                                             end
% %                                                                                         end
% %                                                                             for odor = 1:size(dataAll,3) - 1
% %                                                                                 if odor < 2
% %                                                                                     labels  = [labels, app_labels];
% %                                                                                 else
% %                                                                                     labels  = [labels, app_labels + ones(1,size(dataAll,2))];
% %                                                                                 end
% %                                                                             end
%     
%     for odor = 1:size(dataAll,3) - 1
%         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%     end
%     labels      = labels';
%     
%     trainingN = floor(0.9*(trials * stimuli));
%     repetitions = 100;
%     [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
%     accuracyShuffled =  [accuracyShuffled acc_svm ];
% end
% accuracyShuffled = mean(accuracyShuffled);
% 
%%
% %Remove signal and noise correlation
% accuracyDecorrTuning = [];
% for idxShuffle = 1:50
%     dataAll = responseCell1All;
%     neurons = size(dataAll,1);
%     trials = size(dataAll,2);
%     stimuli = size(dataAll,3);
%     
%     for idxNeuron = 1:neurons
%         idx = randperm(stimuli);
%         dataAll(idxNeuron,:, :) = dataAll(idxNeuron,:, idx);
%     end
%     
%     dataAll = reshape(dataAll, neurons, trials .* stimuli);
%     dataAll = dataAll';
%     dataAll = zscore(dataAll);
%     dataAll = dataAll';
%     dataAll(isinf(dataAll)) = 0;
%     dataAll(isnan(dataAll)) = 0;
%     dataAll = reshape(dataAll, neurons, trials, stimuli);
%     dataAll = double(dataAll);
%     labels      = ones(1,size(dataAll,2));
%     app_labels  = labels;
%     
%     %                                                                                     for odor = 1:size(dataAll,3) - 1
%     %                                                                                         if odor < 5
%     %                                                                                         labels  = [labels, app_labels];
%     %                                                                                         else
%     %                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
%     %                                                                                         end
%     %                                                                                     end
%                                                                                     for odor = 1:size(dataAll,3) - 1
%                                                                                         if odor < 2
%                                                                                         labels  = [labels, app_labels];
%                                                                                         else
%                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
%                                                                                         end
%                                                                                     end
%     
%     for odor = 1:size(dataAll,3) - 1
%         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%     end
%     labels      = labels';
%     
%     trainingN = floor(0.9*(trials * stimuli));
%     repetitions = 100;
%     [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
%     accuracyDecorrTuning =  [acc_svm accuracyDecorrTuning];
% end
% accuracyDecorrTuning = mean(accuracyDecorrTuning,2);
% 
% 
%%
%Remove noise correlation
% accuracyDecorrNoise = [];
% for idxShuffle = 1:50
%     dataAll = responseCell1All;
%     neurons = size(dataAll,1);
%     trials = size(dataAll,2);
%     stimuli = size(dataAll,3);
%     
%     for idxNeuron = 1:neurons
%         idx = randperm(trials);
%         dataAll(idxNeuron,:, :) = dataAll(idxNeuron,idx, :);
%     end
%     
%     dataAll = reshape(dataAll, neurons, trials .* stimuli);
%     dataAll = dataAll';
%     dataAll = zscore(dataAll);
%     dataAll = dataAll';
%     dataAll(isinf(dataAll)) = 0;
%     dataAll(isnan(dataAll)) = 0;
%     dataAll = reshape(dataAll, neurons, trials, stimuli);
%     dataAll = double(dataAll);
%     labels      = ones(1,size(dataAll,2));
%     app_labels  = labels;
%     
%     %                                                                                     for odor = 1:size(dataAll,3) - 1
%     %                                                                                         if odor < 5
%     %                                                                                         labels  = [labels, app_labels];
%     %                                                                                         else
%     %                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
%     %                                                                                         end
%     %                                                                                     end
%                                                                                     for odor = 1:size(dataAll,3) - 1
%                                                                                         if odor < 2
%                                                                                         labels  = [labels, app_labels];
%                                                                                         else
%                                                                                             labels  = [labels, app_labels + ones(1,size(dataAll,2))];
%                                                                                         end
%                                                                                     end
%     
% %     for odor = 1:size(dataAll,3) - 1
% %         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
% %     end
%     labels      = labels';
%     
%     trainingN = floor(0.9*(trials * stimuli));
%     repetitions = 1000;
%     [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
%     accuracyDecorrNoise =  [acc_svm accuracyDecorrNoise];
% end
% accuracyDecorrNoise = mean(accuracyDecorrNoise,2);
