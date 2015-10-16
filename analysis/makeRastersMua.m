load('breathing.mat', 'breath', 'sec_on_rsp');
load('parameters.mat');
edgesSpikeMatrix= -pre:1/1000:post;
edgesSpikeMatrix(end) = [];
for idxShank = 1:4
    shankToLoad = sprintf('tetrode%d_spikesK.mat', idxShank);
    load(shankToLoad);
    mua = spikes.spiketimes;
    for idxOdor = 1:odors 
        shankMua(idxShank).odor(idxOdor).spikeMatrixMua = zeros(n_trials,length(edgesSpikeMatrix));
        for idxTrial = 1:10
                startOdor = sec_on_rsp(idxTrial, idxOdor);
                mua_trial{idxTrial} = mua(find((mua > startOdor - pre) & (mua < startOdor + post))) - startOdor;
                shankMua(idxShank).odor(idxOdor).spikeTimesTrial{idxTrial} = mua_trial{idxTrial};
                indexes = round((mua_trial{idxTrial} + pre)*1000);
                indexes(indexes==0) = 1;
                shankMua(idxShank).odor(idxOdor).spikeMatrixMua(idxTrial,indexes) = 1; %consider the idea of sparsifying here
                shankMua(idxShank).odor(idxOdor).sdf_trialMua(idxTrial,:) =...
                spikeDensity(shankMua(idxShank).odor(idxOdor).spikeMatrixMua(idxTrial,:),0.01);
        end
    end
end

save('mua.mat', 'shankMua', '-v7.3')