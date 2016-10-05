% collect spikes and their time samples (these are samples not ms);
% units(:,1) = time samples;
% unitsInTime(:2) = cluster id
filename = 'ephysData.kwik';
units(:,1) = hdf5read(filename, '/channel_groups/0/spikes/time_samples');
units(:,2) = hdf5read(filename, '/channel_groups/0/spikes/clusters/main');

% tell for each cluster if it is noise (0), MUA (1), SUA (2) or unsorted
% (3)
% unitsID(:,1) = cluster id;
% unitsID(:,2) = class
clusters = unique(units(:,2));
unitsID = nan(numel(clusters), 2);
for i = 1:numel(clusters)
    unitsID(i,1) = clusters(i);
    clusterGroup = sprintf('/channel_groups/0/clusters/main/%d/cluster_group', clusters(i));
    unitsID(i,2) = hdf5read(filename, clusterGroup);
end


% find best channel for each spike (not cluster)
% units(:,1) = time samples;
% units(:2) = cluster id
% units(:,3) = best channel;
filename2 = 'ephysData.kwx'; 
featureMasks = hdf5read(filename2, '/channel_groups/0/features_masks');
features = squeeze(featureMasks(1,:,:));
masks = squeeze(featureMasks(1,1:3:end,:));


ycoords = 0:31;
ycoords = ycoords';
for idxSpike = 1:size(masks,2)
    singleSpikeFeature = features(1:3:end,idxSpike); 
    %singleSpikeFeature = masks(:,idxSpike);
    units(idxSpike,3) = ycoords(find(singleSpikeFeature==max(singleSpikeFeature),1));
    %units(idxSpike,3) = round(sum(ycoords.*singleSpikeFeature)/sum(singleSpikeFeature));
end


% assign clusters to best channel

% good SUAs
goodSUAs = [];
idxGoodClusters = find(unitsID(:,2) == 2);
goodClusters = unitsID(idxGoodClusters,1);
for idxCluster = 1:numel(goodClusters);
    idxSpikesInGoodCluster = find(units(:,2) == goodClusters(idxCluster));
    ChannelsOfSpikesInGoodCluster = units(idxSpikesInGoodCluster,3);
    bestChannel = mode(ChannelsOfSpikesInGoodCluster);
    goodSUAs = [goodSUAs; units(idxSpikesInGoodCluster,1:2), repmat(bestChannel, numel(ChannelsOfSpikesInGoodCluster), 1)];
end

% MUAs
MUAs = [];
idxMuaClusters = find(unitsID(:,2) == 1);
muaClusters = unitsID(idxMuaClusters,1);
for idxCluster = 1:numel(muaClusters);
    idxSpikesInMuaCluster = find(units(:,1) == muaClusters(idxCluster));
    ChannelsOfSpikesInMuaCluster = units(idxSpikesInMuaCluster,3);
    bestChannel = mode(ChannelsOfSpikesInMuaCluster);
    MUAs = [MUAs; units(idxSpikesInMuaCluster,1:2), repmat(bestChannel, numel(ChannelsOfSpikesInMuaCluster), 1)];
end
