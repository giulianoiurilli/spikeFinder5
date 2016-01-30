odorsRearranged = 1:15;
odors = length(odorsRearranged);

preInhalations = 10;
postInhalations = 10;
edgesSpikeMatrixRad = 0:2*pi/360:(preInhalations+postInhalations)*2*pi;

startingFolder = pwd;
for idxExp = 1 : length(List)%-1
    cartella = List{idxExp};
    cd(cartella)
    load('units.mat');
    load('breathing.mat', 'breath', 'sec_on_rsp');
    load('parameters.mat');
    response_window = 1;
    for idxShank = 1:4
        for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
            sua = shank(idxShank).spiketimesUnit{idxUnit};
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                psthBreathingBins = zeros(n_trials, 2 * (preInhalations + postInhalations));
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixRad = zeros(n_trials,length(edgesSpikeMatrixRad));
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialRad = zeros(n_trials,length(edgesSpikeMatrixRad));
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialHz = zeros(n_trials,length(edgesSpikeMatrixRad));
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialRad(:,end) = [];
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialHz(:,end) = [];
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sniffBinnedPsth = [];
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sniffBinnedBsl = [];
                for idxTrial = 1:size(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms, 2)
                    respiro = breath(idxTrial,:,idxOdor);
                    startOdor = sec_on_rsp(idxTrial, idxOdor);
                    [alpha, spikesBinnedByInhExh, piLength] = transformSpikeTimesToSpikePhases(respiro, pre, post, fs, sua, startOdor, preInhalations, postInhalations);
                    if ~isempty(spikesBinnedByInhExh)
                        psthBreathingBins(idxTrial,:) = spikesBinnedByInhExh;
                    end
                    alpha_trial{idxTrial} = alpha;
                    esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).alphaTrial{idxTrial} = alpha_trial{idxTrial};
                                    alpha = round(alpha, 2);
                shiftedAlpha = alpha + round(preInhalations * 2*pi, 2);
                indexes = histc(shiftedAlpha, edgesSpikeMatrixRad);
                indexes(indexes > 0) = 1;
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixRad(idxTrial,:) = indexes;
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialRad(idxTrial,:) = spikeDensityRad(esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixRad(idxTrial,:), sigmaDeg);
                %Morphing
                piLength = piLength';
                piLength = repmat(piLength, 1, 180);
                piLength = reshape(piLength', [],1);
                piLength = piLength';
                piLength = piLength / 180 * sigmaDeg; %how many seconds for sigmaDeg(usually 10 deg)
                sv = SplitVec(piLength, 'consecutive','firstval'); 
                sampleAt = piLength(90:180:end); %find nodes to fit with a spline
                sampleAt = [sampleAt(2) sampleAt]; %pad on left
                x1 = -90:180:length(piLength); 
                xx = -90:length(piLength); xx(end) = [];
                piLengthSplined = spline(x1, sampleAt, xx);
                piLength = piLengthSplined(91:end);
                esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialHz(idxTrial,:) = esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sdf_trialRad(idxTrial,:) ./ piLength;
            end
            psthBreathingBins(1,:) = [];
            esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sniffBinnedPsth = psthBreathingBins;
            psthBreathingBins = mean(psthBreathingBins);
            meanBsl = zeros(1, 2 * preInhalations);
            meanBsl(1:2:2*preInhalations-1) = mean(psthBreathingBins(1 : 2 : 2 * preInhalations - 1));
            meanBsl(2:2:2*preInhalations) = mean(psthBreathingBins(2 : 2 : 2 * preInhalations));
            repeatfor = floor(postInhalations / preInhalations);
            andadd = mod(2 * postInhalations, 2 * preInhalations);
            meanBsl = repmat(meanBsl, 1, 1 + repeatfor);
            meanBsl = [meanBsl meanBsl(1:andadd)];
            esperimento(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).sniffBinnedBsl = meanBsl;
            clear alpha_trial
        end
        clear sua
    end
    end
end
cd(startingFolder)
clearvars -except List esp esperimento 

save('coa_AA_2_3.mat', 'esperimento', '-v7.3')            
            
            