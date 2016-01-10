odors = 10;
idxCell1000ms = 0;
for idxesp = 1:length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            idxCell1000ms = idxCell1000ms + 1;
            for idxOdor = 1:odors
                responseCell1000ms(idxCell1000ms,:,idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms - ...
                    esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
            end
        end
    end
end

dataAll = [];
%dataAll = responses1AllTrials(:,:,5:8);
%dataAll = responses300AllTrialsPcx;
%dataAll(info1==0, :,:) = [];
%dataAll(:,:,7:15)=[];
dataAll = responseCell1000ms;

                                                                                dataAll(:,:,3:4) = [];


neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);


%sort based on information
%         dataAll = [dataAll info300];
%         dataAll = sortrows(dataAll,size(dataAll,2));
%         dataAll = flipud(dataAll);
%         dataAll(:,size(dataAll,2)) = [];

%dataAll = dataAll';

%dataAll = sqrt(dataAll);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
%     dataAll = dataAll';
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
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
repetitions = 500;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);

save('responses.mat', 'mean_acc_svm', 'std_acc_svm', 'prctile25', 'prctile75', 'acc_svm', '-append');
                                                                                %save('valence.mat', 'mean_acc_svm', 'std_acc_svm', 'prctile25', 'prctile75', 'acc_svm');