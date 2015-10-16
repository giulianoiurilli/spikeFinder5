%close all
%clear all
%delete('unitsNowarp.mat')

load('breathing.mat', 'breath', 'sec_on_rsp');
load('units.mat');
load('parameters.mat');
%delete('unitsNowarp.mat')

edgesSpikeMatrixNoWarp = -pre:1/1000:post;
edgesSpikeMatrixNoWarp(end) = [];

for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        sua = shank(idxShank).spiketimesUnit{idxUnit};
        sua=sua';
        for idxOdor = 1:odors   
            psthBreathingBins = zeros(n_trials, 2 * (preInhalations + postInhalations));
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp = zeros(n_trials,length(edgesSpikeMatrixNoWarp));
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp = zeros(n_trials,length(edgesSpikeMatrixNoWarp));
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:,end) = [];
            for idxTrial = 1:10
                startOdor = sec_on_rsp(idxTrial, idxOdor);
                sua_trial{idxTrial} = sua(find((sua > startOdor - pre) & (sua < startOdor + post))) - startOdor;
                shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeTimesTrial{idxTrial} = sua_trial{idxTrial};
                indexes = round((sua_trial{idxTrial} + pre)*1000);
                indexes(indexes==0) = 1;
                shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(idxTrial,indexes) = 1; %consider the idea of sparsifying here
                shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(idxTrial,:) =...
                spikeDensity(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(idxTrial,:),0.01);
            end
        end
    end
end

%save('units.mat', 'shank', '-append', '-v7.3')
save('unitsNowarp.mat', 'shankNowarp', '-v7.3')
                