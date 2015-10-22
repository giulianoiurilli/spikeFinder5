%% discard units that never fire above 0.5 Hz
totUnits = 0;
goodUnits = 0;
for idxExperiment = 1 : length(exp)
    for idxShank = 1:4
        for idxUnit = 1:length( exp(idxExperiment).shankNowarp(idxShank).cell)
            totUnits = totUnits + 1;
            goodUnits = goodUnits + exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit;
        end
    end
end

%% as before, but for respiration cycles
%odorsRearranged = 1:15; %15 odors
%odorsRearranged = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
%odorsRearranged = [1,2,3,4,5,6,7]; %7 odors low
%odorsRearranged = [12 13 14 15 1]; %3 odors pen
%odorsRearranged = [2 3 4 5 6]; %3 odors iaa
%odorsRearranged = [7 8 9 10 11]; %3 odors etg
%odorsRearranged = [1 6 11]; %3 odors high
%odorsRearranged = [14 4 9]; %3 odors medium
odorsRearranged = [12 2 7]; %3 odors low
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
%odorsRearranged = [1 2 3 4 5 6 7 8 9 10]; %aveatt 
%odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
%odorsRearranged = [1 13 14 15]; %mixTMT


odors = length(odorsRearranged);
allBinAccuracyWarp = [];
from = 360 * 10;
to = 360*20;
responseWindowSize = to - from;
%%
spikeCountPopBin = [];
for idxBin = 1:10
    idxCell = 0;
    spikeCountPopBin{idxBin} = zeros(goodUnits, n_trials, odors);
    for idxExperiment = 1 : length(exp)
        for idxShank = 1:4
            for idxUnit = 1:length( exp(idxExperiment).shankWarp(idxShank).cell)
                if exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1
                    idxCell = idxCell + 1;
                    idxO = 1;
                    for idxOdor = odorsRearranged%1:odors
                        A = exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(:, from:to  );
                        spikeCounts = sum(A(:,1:idxBin*360),2);
                        %spikeCountPopBin{idxBin}(idxCell,:,idxOdor) =  spikeCounts';
                        spikeCountPopBin{idxBin}(idxCell,:,idxO) =  spikeCounts';
                        idxO = idxO+1;
                        clear A;
                        clear spikeCounts;
                    end
                end
            end
        end
    end
end

%%

binAccuracyWarp = zeros(idxBin,4);

for idxBin = 1:10
    app = [];
    app = spikeCountPopBin{idxBin};
    dataAll = app;
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    % rescale to [0 1];
    dataAll = (dataAll - repmat(min(dataAll,[],1),size(dataAll,1),1))*spdiags(1./(max(dataAll,[],1)-min(dataAll,[],1))',0,size(dataAll,2),size(dataAll,2));
    dataAll = dataAll';
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    % Make labels
    labels      = ones(1,size(dataAll,2));
    app_labels  = labels;
    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    labels      = labels';
    % set the number of repetitions for the bootstrap and the number of
    % training and test trials for the cross-validation
    repetitions = 100;
    trainingN = floor(0.9*(trials * stimuli));
    data = dataAll;
    
    
    % run svm
    [mean_acc_svm, std_acc_svm, acc_svm, prctile5, prctile95] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    binAccuracyWarp(idxBin,1) = mean_acc_svm;
    binAccuracyWarp(idxBin,2) = std_acc_svm;
    binAccuracyWarp(idxBin,3) = prctile5;
    binAccuracyWarp(idxBin,4) = prctile95;
    
end


%%
figure

for idxBin = 1:10
    barre(idxBin) =  binAccuracyWarp(idxBin,1);
end
bar(barre)
axis tight
xlabel('bin width (cycles)')
ylabel('accuracy %')
savefig('decodingBinWidthLow.fig')


    



















