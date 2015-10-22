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
%odorsRearranged = [12 2 7]; %3 odors low
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
odorsRearranged = [1 2 3 4 5 6 7 8 9 10]; %aveatt 
%odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
%odorsRearranged = [1 13 14 15]; %mixTMT


odors = length(odorsRearranged);
allBinAccuracyWarp = [];
from = 360 * 7;
to = 360*20;
responseWindowSize = to - from;
%%
halfBinSize = 180:180:180*10;
%halfBinSize(end) = [];
for idxBinSize = 1:length(halfBinSize);
    timestep = 360;
    timeBinEdges = [];
    timeBinEdges = halfBinSize(idxBinSize)+1:timestep:responseWindowSize-halfBinSize(idxBinSize);
    for idxBin = 1:length(timeBinEdges)
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
                            spikeCounts = sum(A(:,timeBinEdges(idxBin)-halfBinSize(idxBinSize):timeBinEdges(idxBin)+halfBinSize(idxBinSize)),2);
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
    
    % timecourse of the linear classification in the first 300 ms
    binAccuracyWarp = zeros(length(timeBinEdges),4);
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
        binAccuracyWarp(idxBin,1) = mean_acc_svm;
        binAccuracyWarp(:,2) = std_acc_svm;
        binAccuracyWarp(:,3) = prctile5;
        binAccuracyWarp(:,4) = prctile95;
    end
    allBinAccuracyWarp{idxBinSize} = binAccuracyWarp;
end
allBinAccuracyByCyclesMixTmt = allBinAccuracyWarp;
%%
rows = length(timeBinEdges);
columns = length(halfBinSize);
accuracyMatrixCycle = ones(rows,columns) * (100/odors);
for i = 1:size(halfBinSize,2)
    accuracyMatrixCycle(floor(size(allBinAccuracyWarp{1},1) - size(allBinAccuracyWarp{i},1) + 1):...
        floor(size(allBinAccuracyWarp{1},1) - size(allBinAccuracyWarp{i},1))+floor(size(allBinAccuracyWarp{i},1)),i) = ...
        allBinAccuracyWarp{i}(:,1);
end

figure;
imagesc(accuracyMatrixCycle'), axis xy, axis square, colorbar
xlabel('respiration cycles - odor onset: 4th cycle')
ylabel('bin width (cycles)')
savefig('decodingByCyclesMixTmt.fig')

%%
save('plCoA_aveAtt_Area.mat', 'allBinAccuracyByCyclesMixTmt','halfBinSize', 'timestep', '-append')

%%
fromRad = 360 * 7;
toRad = 360*20;
responseWindowSizeRad = toRad - fromRad;
edgesRad = 1:10:responseWindowSizeRad;
edgesRad = 1:10:responseWindowSizeRad;
edgesSniff = 1:360:responseWindowSizeRad;
angleStamps = 1:responseWindowSizeRad; angleStamps = repmat(angleStamps, n_trials,1);
from = 14500;
to = 18000;
responseWindowSize = to-from;
edgesMs = 1:5:responseWindowSize;
timeStamps = 1:responseWindowSize; timeStamps = repmat(timeStamps, n_trials,1);


psthMeanMs = zeros(goodUnits, length(edgesMs), length(odorsRearranged));
psthVarMs = zeros(goodUnits, length(edgesMs), length(odorsRearranged));
psthFanoMs = zeros(goodUnits, length(edgesMs), length(odorsRearranged));

psthMeanRad = zeros(goodUnits, length(edgesRad), length(odorsRearranged));
psthVarRad = zeros(goodUnits, length(edgesRad), length(odorsRearranged));
psthFanoRad = zeros(goodUnits, length(edgesRad), length(odorsRearranged));

psthMeanSniff = zeros(goodUnits, length(edgesSniff), length(odorsRearranged));
psthVarSniff  = zeros(goodUnits, length(edgesSniff), length(odorsRearranged));
psthFanoSniff = zeros(goodUnits, length(edgesSniff), length(odorsRearranged));



idxO = 0;
idxCell = 0;
for idxOdor=odorsRearranged
    idxO = idxO + 1;
    for idxExp = 1:length(exp)
        for idxShank = 1:4;
            for idxUnit = 1:length( exp(idxExperiment).shankWarp(idxShank).cell)
                if exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1
                    idxCell = idxCell + 1;
                    app = [];
                    appHist = [];
                    appHistMean = [];
                    appHistVar = [];
                    appHistFano = [];
                    app = exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(:, from:to);
                    app = app .* timeStamps;
                    appHist = histc(app, edgesMs,2);
                    appHistMean = mean(appHist);
                    appHistVar = var(appHist);
                    appHistFano = appHistVar ./ appHistMean;
                    psthMeanMs(idxCell,:, idxO) = appHistMean;
                    psthVarMs(idxCell,:, idxO) = appHistVar;
                    psthFanoMs(idxCell,:, idxO) = appHistVar;
                    
                    app = [];
                    appHist = [];
                    appHistMean = [];
                    appHistVar = [];
                    appHistFano = [];
                    app = exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp(:, fromRad:toRad);
                    app = app .* angleStamps;
                    appHist = histc(app, edgesRad,2);
                    appHistMean = mean(appHist);
                    appHistVar = var(appHist);
                    appHistFano = appHistVar ./ appHistMean;
                    psthMeanRad(idxCell,:, idxO) = appHistMean;
                    psthVarRad(idxCell,:, idxO) = appHistVar;
                    psthFanoRad(idxCell,:, idxO) = appHistVar;
                                       
                    appHist = [];
                    appHistMean = [];
                    appHistVar = [];
                    appHistFano = [];
                    appHist = histc(app, edgesSniff,2);
                    appHistMean = mean(appHist);
                    appHistVar = var(appHist);
                    appHistFano = appHistVar ./ appHistMean;
                    psthMeanSniff(idxCell,:, idxO) = appHistMean;
                    psthVarSniff(idxCell,:, idxO) = appHistVar;
                    psthFanoSniff(idxCell,:, idxO) = appHistVar;
                    
                end
            end
        end
    end
end

                    

                    
                    
                    
                    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    