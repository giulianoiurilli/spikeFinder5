%function [accuracyResponses, accuracyBaseline, accuracyShuffled, accuracyDecorrTuning, accuracyDecorrNoise, conMatResponses] = l_svmClassify(esp, odors)
%function [accuracyResponses, accuracyBaseline, accuracyShuffled, conMatResponses] = l_svmClassify(esp, odors)
%function [accuracyResponses, accuracyBaseline, accuracyShuffled] = l_svmClassify(esp, odors)
%function [accuracyResponses] = l_svmClassify(esp, odors, option)
function [accuracyResponses, accuracyDecorrNoise, conMatResponses] = l_svmClassify_new(esp, odors, option)

% esp = coaAA.esp;
% odors = 1:10;
% option = 2;


odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.1
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
%                         resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell1 = idxCell1 + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;    
                            responseCell1All(idxCell1,:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                            baselineCell1All(idxCell1,:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;

                        end
                    end
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
                    if odor < 6
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
            case 6
                for odor = 1:size(dataAll,3) - 1
                    if odor >0 & odor < 3
                        labels  = [labels, app_labels];
                    end
                    if odor > 2 & odor< 6
                        labels  = [labels, app_labels + ones(1,size(dataAll,2))];
                    end
                    if odor > 5 & odor< 9
                        labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
                    end
                    if odor > 8 & odor< 12
                        labels  = [labels, app_labels + 3*ones(1,size(dataAll,2))];
                    end
                    if odor > 11
                        labels  = [labels, app_labels + 4*ones(1,size(dataAll,2))];
                    end
                end
            case 7
                for odor = 1:size(dataAll,3) - 1
                    if odor < 4
                        labels  = [labels, app_labels];
                    else
                        labels  = [labels, app_labels + ones(1,size(dataAll,2))];
                    end
                end
        end
 %%       
        labels      = labels';
        trainingN = floor(0.9*(trials * stimuli));
        repetitions = 100;
        [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
        accuracyResponses = acc_svm;
        conMatResponses = conMat;
        
        %%
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
        %Shuffle order neurons across trials
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
        %% Remove noise correlation
        % accuracyDecorrNoise = [];
        % for idxShuffle = 1:10
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
        %     switch option
        %         case 1
        %             for odor = 1:size(dataAll,3) - 1
        %                 labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
        %             end
        %         case 2
        %             for odor = 1:size(dataAll,3) - 1
        %                 if odor < 6
        %                     labels  = [labels, app_labels];
        %                 else
        %                     labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        %                 end
        %             end
        %         case 3
        %             for odor = 1:size(dataAll,3) - 1
        %                 if odor < 2
        %                     labels  = [labels, app_labels];
        %                 else
        %                     labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        %                 end
        %             end
        %         case 4
        %             for odor = 1:size(dataAll,3) - 1
        %                 if odor < 3
        %                     labels  = [labels, app_labels];
        %                 else
        %                     labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        %                 end
        %             end
        %         case 5
        %             for odor = 1:size(dataAll,3) - 1
        %                 if odor < 5
        %                     labels  = [labels, app_labels];
        %                 else
        %                     if odor < 10
        %                         labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        %                     else
        %                         labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
        %                     end
        %                 end
        %             end
        %         case 6
        %             for odor = 1:size(dataAll,3) - 1
        %                 if odor < 4
        %                     labels  = [labels, app_labels];
        %                 else
        %                     labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        %                 end
        %             end
        %     end
        %     labels      = labels';
        %
        %     trainingN = floor(0.9*(trials * stimuli));
        %     repetitions = 100;
        %     [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
        %     accuracyDecorrNoise =  [acc_svm; accuracyDecorrNoise];
        % end
        %accuracyDecorrNoise = mean(accuracyDecorrNoise);
