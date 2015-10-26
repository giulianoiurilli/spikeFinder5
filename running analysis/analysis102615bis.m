%% Find reponsive units
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
                end
                idxCell = idxCell + 1;
            end
        end
    end
    clear sniffs
end
%% Subtract baselines
app1 = [];
app2 = [];
meanBaselineAll1 = [];
meanBaselineAll2 = [];
app1 = reshape(baselineAll(:,1:2:size(baselineAll,2)-1,:), size(baselineAll,1), (size(baselineAll,2) ./2) *size(baselineAll,3));
app2 = reshape(baselineAll(:,2:2:size(baselineAll,2),:), size(baselineAll,1), (size(baselineAll,2) ./2) *size(baselineAll,3));
meanBaselineAll1 = mean(app1,2);
meanBaselineAll2 = mean(app2,2);
meanBaselineAll1 = repmat(meanBaselineAll1,1,(size(baselineAll,2) ./2) *size(baselineAll,3));
meanBaselineAll1 = reshape(meanBaselineAll1, size(baselineAll,1), (size(baselineAll,2) ./2) ,size(baselineAll,3));
meanBaselineAll2 = repmat(meanBaselineAll2,1,(size(baselineAll,2) ./2) *size(baselineAll,3));
meanBaselineAll2 = reshape(meanBaselineAll2, size(baselineAll,1), (size(baselineAll,2) ./2) ,size(baselineAll,3));
baselineAll(:,1:2:size(baselineAll,2)-1,:) = baselineAll(:,1:2:size(baselineAll,2)-1,:) - meanBaselineAll1;
baselineAll(:,2:2:size(baselineAll,2),:) = baselineAll(:,2:2:size(baselineAll,2),:) - meanBaselineAll2;
responseAll(:,1:2:size(responseAll,2)-1,:) = responseAll(:,1:2:size(responseAll,2)-1,:) - meanBaselineAll1;
responseAll(:,2:2:size(responseAll,2),:) = responseAll(:,2:2:size(responseAll,2),:) - meanBaselineAll2;

%% compute lifetime and population sparseness
for idxBin = 1:9*2
    X = squeeze(baselineAll(:,idxBin,:));
    ps(idxBin,:) = population_sparseness(X, size(X,1), size(X,2));
    ls(idxBin,:) = lifetime_sparseness(X, size(X,1), size(X,2));
end
for idxBin = 1:9*2
    X = squeeze(responseAll(:,idxBin,:));
    ps(idxBin + 9*2,:) = population_sparseness(X, size(X,1), size(X,2));
    ls(idxBin + 9*2,:) = lifetime_sparseness(X, size(X,1), size(X,2));
end
%% plot
figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[701 110 430 748]);
suptitle('lifetime sparseness')
edges = 0:0.1:1;
for idxBin = 1 : 9*2*2
    x = histcounts(ls(idxBin,:),edges, 'normalization', 'probability');
    subplot(36,1,idxBin)
    if idxBin < 9*2+1
        area(x, 'FaceColor', 'k')
    else
        area(x, 'FaceColor', 'r')
    end
    %set(gca, ylim([0 1]))
    axis tight
    axis off
end
%%
figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[701 110 430 748]);
suptitle('population sparseness')
edges = 0.2:0.1:1;
for idxBin = 1 : 9*2*2
    x = histcounts(ps(idxBin,:),edges, 'normalization', 'probability');
    subplot(36,1,idxBin)
    if idxBin < 9*2+1
        area(x, 'FaceColor', 'k')
    else
        area(x, 'FaceColor', 'r')
    end
    %set(gca, ylim([0 1]))
    axis tight
    axis off
end
