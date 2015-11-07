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

%% Find reponsive units
responsiveUnit = 0;
responsiveUnitInh = 0;
responsiveUnitExc = 0;
modifiedList = [1 2 3 4 6 8];
for idxExp = 9%: length(List) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            responsivenessExcMs = zeros(1,odors);
            for idxOdor = 1:odors
                %                 responsivenessExc(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 responsivenessInh(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == -1;
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                responsivenessExcMs(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 reliabilityExc(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                %                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc + responsivenessInh + responsivenessExcMs) > 0
                responsiveUnit = responsiveUnit + 1;
            end
            if sum(responsivenessExc + responsivenessExcMs) > 0
                responsiveUnitExc = responsiveUnitExc + 1;
            end
            if sum(responsivenessInh) > 0
                responsiveUnitInh = responsiveUnitInh + 1;
            end
        end
    end
end

%%
baselineAllMean = zeros(responsiveUnit, 9*2, odors);
responseAllMean = zeros(responsiveUnit, 9*2, odors);
baselineAllVar = zeros(responsiveUnit, 9*2, odors);
responseAllVar= zeros(responsiveUnit, 9*2, odors);
baselineExcMean = zeros(responsiveUnitExc, 9*2, odors);
responseExcMean = zeros(responsiveUnitExc, 9*2, odors);
baselineExcVar = zeros(responsiveUnitExc, 9*2, odors);
responseExcVar = zeros(responsiveUnitExc, 9*2, odors);
baselineInhMean = zeros(responsiveUnitInh, 9*2, odors);
responseInhMean = zeros(responsiveUnitInh, 9*2, odors);
baselineInhVar = zeros(responsiveUnitInh, 9*2, odors);
responseInhVar = zeros(responsiveUnitInh, 9*2, odors);

%%
windowLength = 250;
times = [50 150];
boxWidth = 100;
Tstart = times - floor(boxWidth/2) + 1;
Tend = times + ceil(boxWidth/2) + 1;

idxCellAll = 0;
idxCellExc = 0;
idxCellInh = 0;
for idxExp = 9 %: length(List) %- 1
    cartella = List{idxExp};
    cd(cartella)
    disp(cartella)
    load('breathing.mat', 'sniffs');
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            responsivenessExcMs = zeros(1,odors);
            for idxOdor = 1:odors
                %                 responsivenessExc(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 responsivenessInh(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == -1;
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                responsivenessExcMs(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 reliabilityExc(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                %                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc + responsivenessInh + responsivenessExcMs) > 0 || sum(responsivenessExc + responsivenessExcMs) > 0 || sum(responsivenessInh) > 0
                idxCellAll = idxCellAll + 1;
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
                    end
                    firingRestBinMean = squeeze(mean(firingRestBinTrial,1));
                    firingOdorBinMean = squeeze(mean(firingOdorBinTrial,1));
                    firingRestBinVar = squeeze(var(firingRestBinTrial,1));
                    firingOdorBinVar = squeeze(var(firingOdorBinTrial,1));
                    
                    baselineAllMean(idxCellAll,:,idxOdor) = firingRestBinMean(:);
                    responseAllMean(idxCellAll,:,idxOdor) = firingOdorBinMean(:);
                    baselineAllVar(idxCellAll,:,idxOdor) = firingRestBinVar(:);
                    responseAllVar(idxCellAll,:,idxOdor) = firingOdorBinVar(:);
                end
            end
            if sum(responsivenessExc + responsivenessExcMs) > 0
                idxCellExc = idxCellExc + 1;
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
                    end
                    firingRestBinMean = squeeze(mean(firingRestBinTrial,1));
                    firingOdorBinMean = squeeze(mean(firingOdorBinTrial,1));
                    firingRestBinVar = squeeze(var(firingRestBinTrial,1));
                    firingOdorBinVar = squeeze(var(firingOdorBinTrial,1));
                    baselineExcMean(idxCellExc,:,idxOdor) = firingRestBinMean(:);
                    responseExcMean(idxCellExc,:,idxOdor) = firingOdorBinMean(:);
                    baselineExcVar(idxCellExc,:,idxOdor) = firingRestBinVar(:);
                    responseExcVar(idxCellExc,:,idxOdor) = firingOdorBinVar(:);
                end
            end
            if sum(responsivenessInh) > 0
                idxCellInh = idxCellInh + 1;
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
                    end
                    firingRestBinMean = squeeze(mean(firingRestBinTrial,1));
                    firingOdorBinMean = squeeze(mean(firingOdorBinTrial,1));
                    firingRestBinVar = squeeze(var(firingRestBinTrial,1));
                    firingOdorBinVar = squeeze(var(firingOdorBinTrial,1));
                    baselineInhMean(idxCellInh,:,idxOdor) = firingRestBinMean(:);
                    responseInhMean(idxCellInh,:,idxOdor) = firingOdorBinMean(:);
                    baselineInhVar(idxCellInh,:,idxOdor) = firingRestBinVar(:);
                    responseInhVar(idxCellInh,:,idxOdor) = firingOdorBinVar(:);
                end
            end
        end
    end
end

%%
%odorsRearranged = [12 13 14 15 1]; %3 odors pen
%odorsRearranged = [2 3 4 5 6]; %3 odors iaa
%odorsRearranged = [7 8 9 10 11]; %3 odors etg
odorsRearranged = 1:15;
figure
taxis = -18:18;
taxis(1) = [];
% colo = [103,169,207;...
%     54,144,192;...
%     2,129,138; ...
%     1,108,89; ...
%     1,70,54];
colo = [255,247,236;...
    253,212,158;...
    252,141,89; ...
    215,48,31; ...
    127,0,0];
idxO = 0;
for idxOdor = odorsRearranged
    idxO = idxO + 1;
    bslAllM = mean(squeeze(baselineAllMean(:,:,idxOdor)), 1);
    rspAllM = mean(squeeze(responseAllMean(:,:,idxOdor)), 1);
    bslAllV = mean(squeeze(baselineAllVar(:,:,idxOdor)), 1);
    rspAllV = mean(squeeze(responseAllVar(:,:,idxOdor)), 1);
    bslExcM = mean(squeeze(baselineExcMean(:,:,idxOdor)), 1);
    rspExcM = mean(squeeze(responseExcMean(:,:,idxOdor)), 1);
    bslExcV = mean(squeeze(baselineExcVar(:,:,idxOdor)), 1);
    rspExcV = mean(squeeze(responseExcVar(:,:,idxOdor)), 1);
    bslInhM = mean(squeeze(baselineInhMean(:,:,idxOdor)), 1);
    rspInhM = mean(squeeze(responseInhMean(:,:,idxOdor)), 1);
    bslInhV = mean(squeeze(baselineInhVar(:,:,idxOdor)), 1);
    rspInhV = mean(squeeze(responseInhVar(:,:,idxOdor)), 1);
    hold on
    %plot(taxis, [bslAllM rspAllM], 'color', [colo(idxO, :)]/255, 'linewidth' , 2)
    plot(taxis, [bslAllM rspAllM], 'linewidth' , 2)
end
hold off
figure;
idxO = 0;
for idxOdor = odorsRearranged
    idxO = idxO + 1;
    bslAllM = mean(squeeze(baselineAllMean(:,:,idxOdor)), 1);
    rspAllM = mean(squeeze(responseAllMean(:,:,idxOdor)), 1);
    bslAllV = mean(squeeze(baselineAllVar(:,:,idxOdor)), 1);
    rspAllV = mean(squeeze(responseAllVar(:,:,idxOdor)), 1);
    bslExcM = mean(squeeze(baselineExcMean(:,:,idxOdor)), 1);
    rspExcM = mean(squeeze(responseExcMean(:,:,idxOdor)), 1);
    bslExcV = mean(squeeze(baselineExcVar(:,:,idxOdor)), 1);
    rspExcV = mean(squeeze(responseExcVar(:,:,idxOdor)), 1);
    bslInhM = mean(squeeze(baselineInhMean(:,:,idxOdor)), 1);
    rspInhM = mean(squeeze(responseInhMean(:,:,idxOdor)), 1);
    bslInhV = mean(squeeze(baselineInhVar(:,:,idxOdor)), 1);
    rspInhV = mean(squeeze(responseInhVar(:,:,idxOdor)), 1);
    hold on
    %plot(taxis, [bslExcM rspExcM], 'color', [colo(idxO, :)]/255, 'linewidth' , 2)
    plot(taxis, [bslExcM rspExcM],'linewidth' , 2)
end
hold off
figure;
idxO =  0;
for idxOdor = odorsRearranged
    idxO = idxO + 1;
    bslAllM = mean(squeeze(baselineAllMean(:,:,idxOdor)), 1);
    rspAllM = mean(squeeze(responseAllMean(:,:,idxOdor)), 1);
    bslAllV = mean(squeeze(baselineAllVar(:,:,idxOdor)), 1);
    rspAllV = mean(squeeze(responseAllVar(:,:,idxOdor)), 1);
    bslExcM = mean(squeeze(baselineExcMean(:,:,idxOdor)), 1);
    rspExcM = mean(squeeze(responseExcMean(:,:,idxOdor)), 1);
    bslExcV = mean(squeeze(baselineExcVar(:,:,idxOdor)), 1);
    rspExcV = mean(squeeze(responseExcVar(:,:,idxOdor)), 1);
    bslInhM = mean(squeeze(baselineInhMean(:,:,idxOdor)), 1);
    rspInhM = mean(squeeze(responseInhMean(:,:,idxOdor)), 1);
    bslInhV = mean(squeeze(baselineInhVar(:,:,idxOdor)), 1);
    rspInhV = mean(squeeze(responseInhVar(:,:,idxOdor)), 1);
    hold on
    %plot(taxis, [bslInhM rspInhM], 'color', [colo(idxO, :)]/255, 'linewidth' , 2)
    plot(taxis, [bslInhM rspInhM], 'linewidth' , 2)
end
hold off
    
            


