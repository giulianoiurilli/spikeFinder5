%%
odorsRearranged = 1:15; %15 odors
%odorsRearranged = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
%odorsRearranged = [1,2,3,4,5,6,7]; %7 odors low
%odorsRearranged = [12 13 14 15 1]; %3 odors pen
%odorsRearranged = [2 3 4 5 6]; %3 odors iaa
%odorsRearranged = [7 8 9 10 11]; %3 odors etg
%odorsRearranged = [1 6 11]; %3 odors high
%odorsRearranged = [15 5 10]; %3 odors medium-high
%odorsRearranged = [14 4 9]; %3 odors medium
%odorsRearranged = [13 3 8]; %3 odors medium-low
%odorsRearranged = [12 2 7]; %3 odors low
%odorsRearranged  = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
%odorsRearranged = [1 2 3 4  6 7 8 9]; %aveatt
%odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
%odorsRearranged = [1 13 14 15]; %mixTMT


odors = length(odorsRearranged);
%%
responsiveUnit4cycles = 0;

cells = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            cells = cells + 1;
            responsivenessExc4cycles = zeros(1,odors);
            responsivenessInh4cycles = zeros(1,odors);
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                responsivenessExc4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
            end
            if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0 && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                responsiveUnit4cycles = responsiveUnit4cycles + 1;
            end
        end
    end
end    


%%

xTime = 200:200:3000;
baselineAcc = zeros(length(xTime), responsiveUnit4cycles - 1);
for idxTime = 1:length(xTime)
    baselineResponses = zeros(responsiveUnit4cycles, n_trials, odors);
    idxCell = 0;
    for idxExp = 1: length(exp) %- 1
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
                responsivenessExc4cycles = zeros(1,odors);
                responsivenessInh4cycles = zeros(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                    responsivenessInh4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                end
                if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0 && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                    idxCell = idxCell + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        baselineResponses(idxCell, :, idxO) = sum(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(:,11000:11000 + xTime(idxTime)),2)';
                    end
                end
            end
        end
    end
    dataAll = [];
    dataAll = baselineResponses(:,:,5:8);
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
    repetitions = 100;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    baselineAcc(idxTime,:) = mean_acc_svm; 
end

%%
responseAcc = zeros(length(xTime), responsiveUnit4cycles - 1);
for idxTime = 1:length(xTime)
    odorResponses = zeros(responsiveUnit4cycles, n_trials, odors);
    idxCell = 0;
    for idxExp = 1: length(exp) %- 1
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
                responsivenessExc4cycles = zeros(1,odors);
                responsivenessInh4cycles = zeros(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                    responsivenessInh4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                end
                if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0 && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                    idxCell = idxCell + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        odorResponses(idxCell, :, idxO) = sum(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(:,15000:15000 + xTime(idxTime)),2)';
                    end
                end
            end
        end
    end
    dataAll = [];
    dataAll = odorResponses(:,:,5:8);
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
    repetitions = 100;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    responseAcc(idxTime,:) = mean_acc_svm; 
end

