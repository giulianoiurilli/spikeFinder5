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


%% make matrices of avg spike counts in the first 300 ms and of trajectories (20 ms binning) in the same response window of 300 ms. Note that the response time
% window starts 50 ms after the first inhalation onset
idxCell = 0;
idxCellTraj = 1;
from = 15050;
to = 15350;
responseWindowSize = to - from;
binSize = 20;
timeBinEdges = 1:binSize:responseWindowSize;
spikeCountPop = zeros(goodUnits, n_trials, odors);
spikeTrajPop = zeros(goodUnits*length(timeBinEdges), n_trials, odors);
for idxExperiment = 1 : length(exp)
    for idxShank = 1:4
        for idxUnit = 1:length( exp(idxExperiment).shankNowarp(idxShank).cell)
            if exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1
                idxCell = idxCell + 1;
                for idxOdor = 1:odors
                    A = exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(:, from:to);
                    spikeCounts = sum(A,2);
                    spikeCountPop(idxCell,:,idxOdor) =  spikeCounts';
                    clear A;
                    clear spikeCounts;
                    A = exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, from:to);
                    idxTimeBin = 1;
                    for idxBin = 1:length(timeBinEdges)
                        binnedA(:,idxBin) = mean(A(:,timeBinEdges(idxBin):timeBinEdges(idxBin)+binSize), 2);
                    end
                    spikeTrajPop(idxCellTraj:idxCellTraj+length(timeBinEdges)-1, :, idxOdor) = binnedA'; 
                    
                    clear A;
                    clear binnedA;
                end
                idxCellTraj = idxCellTraj + length(timeBinEdges);
            end
        end
    end
end



%% linear classification using the total spike counts in the first 300 ms
% prepare data for spike counts over the first 300 ms
dataAll = spikeCountPop;
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
repetitions = 500;
trainingN = floor(0.9*(trials * stimuli));
data = dataAll;


% run svm
[mean_acc_svm, std_acc_svm, acc_svm, prctile5, prctile95] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);

firstSniffSpikeCountAccuracy(1) = mean_acc_svm;
firstSniffSpikeCountAccuracy(2) = std_acc_svm;
firstSniffSpikeCountAccuracy(3) = prctile5;
firstSniffSpikeCountAccuracy(4) = prctile95;
firstSniffSpikeCountAccuracyAll = acc_svm;
    
% h = figure;
% %x = 2 : length(mean_acc_svm) + 1;
% x = 1:2;
% shadedErrorBar(x, mean_acc_svm, std_acc_svm./sqrt(repetitions), 'r');
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
% set(h,'color','white', 'PaperPositionMode', 'auto');

%% linear classification of the trajectories in the first 300 ms
% prepare data for trajectories
dataAll = spikeTrajPop;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
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

neuralTrajectoriesAccuracy(1) = mean_acc_svm;
neuralTrajectoriesAccuracy(2) = std_acc_svm;
neuralTrajectoriesAccuracy(3) = prctile5;
neuralTrajectoriesAccuracy(4) = prctile95;
neuralTrajectoriesAccuracyAll = acc_svm;

%% make matrices of avg spike counts in overlapping 50 ms bins (every 5 ms) over the first 500 ms. Note that the response time
% window starts 50 ms after the first inhalation onset
allBinAccuracy = [];
from = 14500;
to = 19000;
responseWindowSize = to - from;
halfBinSize = 10:10:floor(responseWindowSize/2);
halfBinSize(end) = [];
for idxBinSize = 1:length(halfBinSize);
    timestep = 5;
    timeBinEdges = [];
    timeBinEdges = halfBinSize(idxBinSize)+1:timestep:responseWindowSize-halfBinSize(idxBinSize);
    for idxBin = 1:length(timeBinEdges)
        idxCell = 0;
        spikeCountPopBin{idxBin} = zeros(goodUnits, n_trials, odors);
        for idxExperiment = 1 : length(exp)
            for idxShank = 1:4
                for idxUnit = 1:length( exp(idxExperiment).shankNowarp(idxShank).cell)
                    if exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1
                        idxCell = idxCell + 1;
                        for idxOdor = 1:odors
                            A = exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(:, from:to+100);
                            spikeCounts = sum(A(:,timeBinEdges(idxBin)-halfBinSize(idxBinSize):timeBinEdges(idxBin)+halfBinSize(idxBinSize)),2);
                            spikeCountPopBin{idxBin}(idxCell,:,idxOdor) =  spikeCounts';
                            clear A;
                            clear spikeCounts;
                        end
                    end
                end
            end
        end
    end
    
    % timecourse of the linear classification in the first 300 ms
    binAccuracy = zeros(length(timeBinEdges),4);
    for idxBin = 1:length(timeBinEdges)
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
        binAccuracy(idxBin,1) = mean_acc_svm;
        binAccuracy(:,2) = std_acc_svm;
        binAccuracy(:,3) = prctile5;
        binAccuracy(:,4) = prctile95;
    end
    allBinAccuracy{idxBinSize} = binAccuracy;
end

%%
rows = length(timeBinEdges{1});
columns = length(halBinSize);
accuracyMatrix = ones(rows,columns) * (100/odors);
for i = 1:size(halfBinSize,2)
    accuracyMatrix(floor(size(allBinAccuracy{1},1) - size(allBinAccuracy{i},1) + 1):...
        floor(size(allBinAccuracy{1},1) - size(allBinAccuracy{i},1))+floor(size(allBinAccuracy{i},1)),i) = ...
        allBinAccuracy{i}(:,1);
end

figure;
imagesc(accuracyMatrix), axis xy, axis square






