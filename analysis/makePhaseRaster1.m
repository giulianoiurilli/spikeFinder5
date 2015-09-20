%close all
%clear all

load('breathing.mat', 'breath', 'sec_on_rsp');
load('units.mat');
load('parameters.mat');

edgesSpikeMatrixRad = 0:2*pi/360:(preInhalations+postInhalations)*2*pi;

for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        sua = shank(idxShank).spiketimesUnit{idxUnit};
        for idxOdor = 1:odors   
            psthBreathingBins = zeros(n_trials, 2 * (preInhalations + postInhalations));
            shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad = zeros(n_trials,length(edgesSpikeMatrixRad));
            shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad = zeros(n_trials,length(edgesSpikeMatrixRad));
            shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz = zeros(n_trials,length(edgesSpikeMatrixRad));
            shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad(:,end) = [];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(:,end) = [];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth = [];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl = [];            
            for idxTrial = 1:n_trials
                respiro = breath(idxTrial,:,idxOdor);
                startOdor = sec_on_rsp(idxTrial, idxOdor);
                [alpha, spikesBinnedByInhExh, piLength] = transformSpikeTimesToSpikePhases(respiro, pre, post, fs, sua, startOdor, preInhalations, postInhalations);
                if ~isempty(spikesBinnedByInhExh)
                    psthBreathingBins(idxTrial,:) = spikesBinnedByInhExh;
                end
                alpha_trial{idxTrial} = alpha;
                shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial{idxTrial} = alpha_trial{idxTrial};
                alpha = round(alpha, 2);
                shiftedAlpha = alpha + round(preInhalations * 2*pi, 2);
                indexes = histc(shiftedAlpha, edgesSpikeMatrixRad);
                indexes(indexes > 0) = 1;
                shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad(idxTrial,:) = indexes;
                shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad(idxTrial,:) = spikeDensityRad(shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad(idxTrial,:), sigmaDeg);
                piLength = piLength';
                piLength = repmat(piLength, 1, 180);
                piLength = reshape(piLength', [],1);
                piLength = piLength';
                piLength = piLength / 180 * sigmaDeg;
                shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(idxTrial,:) = shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad(idxTrial,:) ./ piLength;
            end
            psthBreathingBins(1,:) = [];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth = psthBreathingBins;
            psthBreathingBins = mean(psthBreathingBins);
            meanBsl = zeros(1, 2 * preInhalations);
            meanBsl(1:2:2*preInhalations-1) = mean(psthBreathingBins(1 : 2 : 2 * preInhalations - 1));
            meanBsl(2:2:2*preInhalations) = mean(psthBreathingBins(2 : 2 : 2 * preInhalations));
            repeatfor = floor(postInhalations / preInhalations);
            andadd = mod(2 * postInhalations, 2 * preInhalations);
            meanBsl = repmat(meanBsl, 1, 1 + repeatfor);
            meanBsl = [meanBsl meanBsl(1:andadd)];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl = meanBsl;
            clear alpha_trial
        end
        clear sua
    end
end

save('units.mat', 'shank', '-append')

                