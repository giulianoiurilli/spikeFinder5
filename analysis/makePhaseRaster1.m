%close all
%clear all

load('breathing.mat', 'breath', 'sec_on_rsp');
load('units.mat');
load('parameters.mat');
preInhalations = 10;
edgesSpikeMatrixRad = 0:2*pi/360:(preInhalations+postInhalations)*2*pi;
n_trials = 10;
for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        sua = shank(idxShank).spiketimesUnit{idxUnit};
        for idxOdor = 1:odors   
            psthBreathingBins = zeros(n_trials, 2 * (preInhalations + postInhalations));
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad = zeros(n_trials,length(edgesSpikeMatrixRad));
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad = zeros(n_trials,length(edgesSpikeMatrixRad));
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz = zeros(n_trials,length(edgesSpikeMatrixRad));
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad(:,end) = [];
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(:,end) = [];
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth = [];
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl = [];            
            for idxTrial = 1:n_trials
                respiro = breath(idxTrial,:,idxOdor);
                startOdor = sec_on_rsp(idxTrial, idxOdor);
                [alpha, spikesBinnedByInhExh, piLength] = transformSpikeTimesToSpikePhases(respiro, pre, post, fs, sua, startOdor, preInhalations, postInhalations);
                if ~isempty(spikesBinnedByInhExh)
                    psthBreathingBins(idxTrial,:) = spikesBinnedByInhExh;
                end
                alpha_trial{idxTrial} = alpha;
                shankWarp(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial{idxTrial} = alpha_trial{idxTrial};
                alpha = round(alpha, 2);
                shiftedAlpha = alpha + round(preInhalations * 2*pi, 2);
                indexes = histc(shiftedAlpha, edgesSpikeMatrixRad);
                indexes(indexes > 0) = 1;
                shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad(idxTrial,:) = indexes;
                shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad(idxTrial,:) = spikeDensityRad(shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad(idxTrial,:), sigmaDeg);
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
                shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(idxTrial,:) = shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRad(idxTrial,:) ./ piLength;
            end
            psthBreathingBins(1,:) = [];
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth = psthBreathingBins;
            psthBreathingBins = mean(psthBreathingBins);
            meanBsl = zeros(1, 2 * preInhalations);
            meanBsl(1:2:2*preInhalations-1) = mean(psthBreathingBins(1 : 2 : 2 * preInhalations - 1));
            meanBsl(2:2:2*preInhalations) = mean(psthBreathingBins(2 : 2 : 2 * preInhalations));
            repeatfor = floor(postInhalations / preInhalations);
            andadd = mod(2 * postInhalations, 2 * preInhalations);
            meanBsl = repmat(meanBsl, 1, 1 + repeatfor);
            meanBsl = [meanBsl meanBsl(1:andadd)];
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl = meanBsl;
            clear alpha_trial
        end
        clear sua
    end
end

save('unitsWarp.mat', 'shankWarp')

                