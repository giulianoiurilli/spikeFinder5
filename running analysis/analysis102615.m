%% number of spikes distribution
modifiedList = [1 2 3 4 6 8];
n_cellOdorPairs = 0;
for idxExp = modifiedList%1 : length(List) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            for idxOdor = 1:15
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
            end
            n_cellOdorPairs =  n_cellOdorPairs + sum(responsivenessExc + responsivenessInh);
        end
    end
end
%%

windowLength = 250;
times = [50 150];
boxWidth = 100;
Tstart = times - floor(boxWidth/2) + 1;
Tend = times + ceil(boxWidth/2) + 1;


baselineAllSpikeDist = zeros(n_cellOdorPairs, 9*2);
responseAllSpikeDist = zeros(n_cellOdorPairs, 9*2);
idxCellOdorPair = 1;
modifiedList = [1 2 3 4 6 8];
for idxExp = modifiedList%1 : length(List) %- 1
    cartella = List{idxExp};
    cd(cartella)
    disp(cartella)
    load('breathing.mat', 'sniffs');
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            for idxOdor = 1:15
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
            end
            totResponsivenes = responsivenessExc + responsivenessInh;
            if sum(totResponsivenes) > 0
                odorsToUse = find(totResponsivenes == 1);
                for idxOdor = odorsToUse
                    A = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
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
                    end
                    firingRestBinMean = squeeze(mean(firingRestBinTrial,1));
                    firingOdorBinMean = squeeze(mean(firingOdorBinTrial,1));
                    baselineAllSpikeDist(idxCellOdorPair,:) = firingRestBinMean(:);
                    responseAllSpikeDist(idxCellOdorPair,:) = firingOdorBinMean(:);
                    idxCellOdorPair = idxCellOdorPair + 1;
                end
            end
        end
    end
end

%%
figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[701 160 430 698]);
suptitle('spike counts distributions')
edges = 0:0.1:2;
for idxBin = 1 : 9*2
    x = histcounts(baselineAllSpikeDist(:,idxBin),edges, 'normalization', 'probability');
    subplot(36,1,idxBin)
    area(x, 'FaceColor', 'k')
    %set(gca, ylim([0 1]))
    axis tight
    axis off
end
for idxBin = 1 : 9*2
    x = histcounts(responseAllSpikeDist(:,idxBin),edges, 'normalization', 'probability');
    subplot(36,1,idxBin + 9*2)
    area(x, 'FaceColor', 'r')
    %set(gca, ylim([0 1]))
    axis tight
    axis off
end