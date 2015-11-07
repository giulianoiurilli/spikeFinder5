startingFolder = pwd;
%%
odorsRearranged = 1:15; %15 odors
%odorsRearranged = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
%odorsRearranged = [1,2,3,4,5,6,7]; %7 odors low
%odorsRearranged = [12 13 14 15 1]; %3 odors pen
%odorsRearranged = [2 3 4 5 6]; %3 odors iaa
%odorsRearranged = [7 8 9 10 11]; %3 odors etg
%odorsRearranged = [1 6 11]; %3 odors high
%odorsRearranged = [14 4 9]; %3 odors medium
%odorsRearranged = [12 2 7]; %3 odors low
%odorsRearranged  = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
%odorsRearranged = [1 2 3 4 5 6 7 8 9 10]; %aveatt 
%odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
%odorsRearranged = [1 13 14 15]; %mixTMT


odors = length(odorsRearranged);

%%
responsiveUnit = 1;
modifiedList = [1 2 3 4 6 8];
for idxExp = 1 : length(List) - 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            reliabilityExc = zeros(1,odors);
            reliabilityInh = zeros(1,odors);
            for idxOdor = 1:15
                %                 responsivenessExc(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 responsivenessInh(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == -1;
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                %                 reliabilityExc(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                %                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc + responsivenessInh) > 0
                responsiveUnit = responsiveUnit + 1;
            end
        end
    end
end


%%
baselineAll = zeros(responsiveUnit, 9*2, odors);
responseAll = zeros(responsiveUnit, 9*2, odors);


%%
windowLength = 250;
times = [50 150];
boxWidth = 100;
Tstart = times - floor(boxWidth/2) + 1;
Tend = times + ceil(boxWidth/2) + 1;

idxCell = 1;
for idxExp = 1 : length(List) - 1
    cartella = List{idxExp};
    cd(cartella)
    disp(cartella)
    load('breathing.mat', 'sniffs');
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)

            % select responsive cells
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            for idxOdor = 1:odors
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
            end
            
            if sum(responsivenessExc + responsivenessInh) > 0
                firingRestBinAllTrial(idxCell).spikes = zeros(n_trials, 9*2, odors);
                firingOdorBinAllTrial(idxCell).spikes = zeros(n_trials, 9*2, odors);
                for idxOdor = 1:odors
                    A = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
                    firingRestBinTrial = zeros(n_trials,2,9);
                    firingOdorBinTrial = zeros(n_trials,2,9);
                    for idxTrial = 1:n_trials
                        snif = [];
                        idxSniffsRest = [];
                        idxSniffsOdor = [];
                        snif = sniffs(idxOdor).trial(idxTrial).sniffPower(:,1)';
                        onset = find(snif > 0, 1);
                        idxSniffsRest = floor(15000 + floor(snif(onset - 9 : onset - 1)* 1000));
                        idxSniffsOdor = floor(floor(snif(onset : onset + 8) * 1000) + 15000);
                        for idxSnif = 1:9

                            firingRest = A(idxTrial, idxSniffsRest(idxSnif) + 1 : idxSniffsRest(idxSnif) + windowLength);
                            csum = cumsum(single(firingRest(Tstart(1):Tend(end)+1)));
                            count = csum(Tend - Tstart(1)+1) - csum(:,Tstart - Tstart(1)+1);
                            firingRestBinTrial(idxTrial,:,idxSnif) = count;

                            firingOdor = A(idxTrial, idxSniffsOdor(idxSnif) + 1 : idxSniffsOdor(idxSnif) + windowLength);
                            csum = cumsum(single(firingOdor(Tstart(1):Tend(end)+1)));
                            count = csum(:,Tend - Tstart(1)+1) - csum(:,Tstart - Tstart(1)+1);
                            firingOdorBinTrial(idxTrial,:,idxSnif) = count;

                        end
%                         firingRestBinMean = squeeze(mean(firingRestBinTrial,1));
%                         firingOdorBinMean = squeeze(mean(firingOdorBinTrial,1));
                        
                    end
                    firingRestBinMean = squeeze(mean(firingRestBinTrial,1));
                    firingOdorBinMean = squeeze(mean(firingOdorBinTrial,1));
                    baselineAll(idxCell,:,idxOdor) = firingRestBinMean(:);
                    responseAll(idxCell,:,idxOdor) = firingOdorBinMean(:);
                    
                    firingRestBinAllTrial(idxCell).spikes(:,:,idxOdor) = reshape(firingRestBinTrial, n_trials, 2*9);
                    firingOdorBinAllTrial(idxCell).spikes(:,:,idxOdor) = reshape(firingOdorBinTrial, n_trials, 2*9);
                end
                idxCell = idxCell + 1;
            end
        end
    end
    clear sniffs
end
                
%%
odorDistMedian = zeros(1,9*2*2);
odorDistPctile75 = zeros(1,9*2*2);
odorDistPctile25 = zeros(1,9*2*2);
for idxBin = 1:(9*2)
    A = squeeze(baselineAll(:,idxBin,:));
    A = A';
    odorDist = pdist(A, 'cosine');
    odorDistMedian(idxBin) = median(odorDist);
    odorDistPctile75(idxBin) = prctile(odorDist,75);
    odorDistPctile25(idxBin) = prctile(odorDist,25);
end
for idxBin = 1:(9*2)
    A = squeeze(responseAll(:,idxBin,:));
    A = A';
    odorDist = pdist(A);
    odorDistMedian(idxBin + 9*2) = median(odorDist);
    odorDistPctile75(idxBin + 9*2) = prctile(odorDist,75);
    odorDistPctile25(idxBin + 9*2) = prctile(odorDist,25);
end
%%
n_rep = 200;
odorDistMedianSim = zeros(n_rep,9*2*2);
odorDistPctile75Sim = zeros(n_rep,9*2*2);
odorDistPctile25Sim = zeros(n_rep,9*2*2);
for rep = 1:n_rep
    for idxBin = 1:(9*2)
        A = squeeze(baselineAll(:,idxBin,:));
        A = A';
        appA = A;
        for idxCell = 1:size(appA,2)
            idx = randperm(odors);
            appA(:,idxCell) = appA(idx, idxCell);
        end
        odorDistSim = pdist(appA, 'cosine');
        odorDistMedianSim(rep, idxBin) = median(odorDistSim);
        odorDistPctile75Sim(rep, idxBin) = prctile(odorDistSim,75);
        odorDistPctile25Sim(rep, idxBin) = prctile(odorDistSim,25);
    end
        for idxBin = 1:(9*2)
        A = squeeze(baselineAll(:,idxBin,:));
        A = A';
        appA = A;
        for idxCell = 1:size(appA,2)
            idx = randperm(odors);
            appA(:,idxCell) = appA(idx, idxCell);
        end
        odorDistSim = pdist(appA);
        odorDistMedianSim(rep, idxBin + 9*2) = median(odorDistSim);
        odorDistPctile75Sim(rep, idxBin + 9*2) = prctile(odorDistSim,75);
        odorDistPctile25Sim(rep, idxBin + 9*2) = prctile(odorDistSim,25);
    end
end
%%
timeS = -9*2:9*2 - 1;
figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[121 60 1235 738]);
hold on
plot(timeS, odorDistMedian, 'r', 'linewidth', 2)
plot(timeS, odorDistPctile75, ':', 'color', 'r', 'linewidth', 1); 
plot(timeS, odorDistPctile25, ':', 'color', 'r', 'linewidth', 1); 
plot(timeS, mean(odorDistMedianSim), 'color', [0.7 0.7 0.7], 'linewidth', 2)
hold off
axis tight
xlabel('time-sniff bins')
ylabel('inter-odor distance (spike count/100 ms)')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

%%
A = [];
varExp = zeros(3,9*2*2);

for idxBin = 1:(9*2)
    A = squeeze(baselineAll(:,idxBin,:));
    A = A';
    [coeff, score, latent, tsquared, explained, mu] = pca(zscore(A));
    varExp(:,idxBin) = explained(1:3);
end
for idxBin = 1:(9*2)
    A = squeeze(responseAll(:,idxBin,:));
    A = A';
    [coeff, score, latent, tsquared, explained, mu] = pca(zscore(A));
    varExp(:,idxBin+ 9*2) = explained(1:3);
end 


%%
n_rep = 200;
varExpSim = zeros(3,9*2*2, n_rep);
for rep = 1:n_rep
    for idxBin = 1:(9*2)
        A = squeeze(baselineAll(:,idxBin,:));
        A = A';
        appA = A;
        for idxCell = 1:size(appA,2)
            idx = randperm(odors);
            appA(:,idxCell) = appA(idx, idxCell);
        end
        [coeff, score, latent, tsquared, explained, mu] = pca(zscore(appA));
        varExpSim(:,idxBin, rep) = explained(1:3);
    end
        for idxBin = 1:(9*2)
        A = squeeze(baselineAll(:,idxBin,:));
        A = A';
        appA = A;
        for idxCell = 1:size(appA,2)
            idx = randperm(odors);
            appA(:,idxCell) = appA(idx, idxCell);
        end
        [coeff, score, latent, tsquared, explained, mu] = pca(zscore(appA));
        varExpSim(:,idxBin + 9*2, rep) = explained(1:3);
    end
end

%%
app = [];
app = squeeze(sum(varExpSim(:,19:end,:),1));
app = app';
app75 = prctile(app,75);
app25 = prctile(app,25);

timeS = 1:9*2;
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[121 60 1235 738]);
hold on
plot(timeS, sum(varExp(1:3,19:end)), 'k', 'linewidth', 2)
plot(timeS, app75, 'color', [0.7 0.7 0.7], 'linewidth', 1)
plot(timeS, app25, 'color', [0.7 0.7 0.7], 'linewidth', 1)
hold off
axis tight
xlabel('time-sniff bins')
ylabel('total variance explained by the first 3 PCs')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');



%%
%   firingRestBinAllTrial = zeros(responsiveUnit, n_trials, 2, 9);
%   firingOdorBinAllTrial = zeros(responsiveUnit, n_trials, 2, 9);

bin = [];
for idxBin = 1:(9*2)
    for idxCell = 1:length(firingRestBinAllTrial)
        app = [];
        bin(idxBin).data(idxCell,:,:) = squeeze(firingRestBinAllTrial(idxCell).spikes(:,idxBin,:));
    end
end

for idxBin = 1:(9*2)
    for idxCell = 1:length(firingRestBinAllTrial)
        app = [];
        bin(idxBin + 9*2).data(idxCell,:,:) = squeeze(firingOdorBinAllTrial(idxCell).spikes(:,idxBin,:));
    end
end



%%
repetitions = 200;
allBinAccuracy = [];
for idxBin = 1:(9*2)
    binAccuracy = zeros(1,4);
    dataAll = [];
    dataAll = bin(idxBin).data;
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

    trainingN = floor(0.9*(trials * stimuli));
    
    
    
    % run svm
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    binAccuracy(1) = mean_acc_svm;
    binAccuracy(2) = std_acc_svm;
    binAccuracy(3) = prctile25;
    binAccuracy(4) = prctile75;
    allBinAccuracy{idxBin} = binAccuracy;
end
%%
for idxBin = 1:(9*2)
    binAccuracy = zeros(1,4);
    dataAll = [];
    dataAll = bin(idxBin + 9*2).data;
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

    trainingN = floor(0.9*(trials * stimuli));
    data = dataAll;
    
    
    % run svm
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_1leaveout(dataAll, trainingN, labels, repetitions);
    binAccuracy(1) = mean_acc_svm;
    binAccuracy(2) = std_acc_svm;
    binAccuracy(3) = prctile25;
    binAccuracy(4) = prctile75;
    allBinAccuracy{idxBin + 9*2} = binAccuracy;
end

%%
for idxBin = 1:length(allBinAccuracy)
    meanAccuracy(idxBin) = allBinAccuracy{idxBin}(1);
    accuracy25(idxBin) = allBinAccuracy{idxBin}(3);
    accuracy75(idxBin) = allBinAccuracy{idxBin}(4);
end

timeS = -9*2:9*2 - 1;
figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[121 60 1235 738]);
hold on
plot(timeS, meanAccuracy, 'r', 'linewidth', 2)
plot(timeS, accuracy25, ':', 'color', 'r', 'linewidth', 1); 
plot(timeS, accuracy75, ':', 'color', 'r', 'linewidth', 1); 
hold off
axis tight
xlabel('time-sniff bins')
ylabel('classification accuracy')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');         
            
            
            
            
            
            
 



                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                