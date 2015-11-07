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
            %if sum(responsivenessExc + responsivenessInh) > 0
                responsiveUnit = responsiveUnit + 1;
            %end
        end
    end
end


%% Build avearge and single trials PETH for each responding neuron. Bin size = 100ms. Timepoints evaluated: first and second 100 ms of a sniff. 9 sniffs pre-odor and 9 sniffs post-odor.
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
            
            %if sum(responsivenessExc + responsivenessInh) > 0
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
            %end
        end
    end
    clear sniffs
end


C = zeros(1,length(firingRestBinAllTrial));
for idxUnit = 1:length(firingRestBinAllTrial)
A = [];
B = zeros(1,idxOdor);
for idxOdor = 1:15
    A = squeeze(firingRestBinAllTrial(idxUnit).spikes(:,1:16,idxOdor));
    B(idxOdor) = mean(sum(A));
end
C(idxUnit) = mean(B)*1000/1600;
end
C(C == 0) = 0;
figure;
histogram(C, 100)
median(C)
    
    
    
    
    
    
    
    
    
    
    
    
    
    