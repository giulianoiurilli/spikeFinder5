clc
clear

folderList = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');



for idxFolder = 1:length(folderList)
    nameExperiment = folderList(idxFolder).name;
    shank = [];
    for idxShank = 1:4
        units = [];
        unitsID = [];
        folderShank = sprintf('shank%d', idxShank);
        folderPath = fullfile(nameExperiment, 'ephys', folderShank);
        cd(folderPath)
        filename = [folderShank '.kwik'];
        filenameFeat = [folderShank '.kwx'];
        % collect spikes and their time samples (these are samples not ms);
        % units(:,1) = time samples;
        % unitsInTime(:2) = cluster id
        units(:,1) = hdf5read(filename, '/channel_groups/0/spikes/time_samples');
        units(:,2) = hdf5read(filename, '/channel_groups/0/spikes/clusters/main');
        featuresApp = hdf5read(filenameFeat, '/channel_groups/0/features_masks');
        features = squeeze(featuresApp(1,:,:))';
        
        % tell for each cluster if it is noise (0), MUA (1), SUA (2) or unsorted
        % (3)
        % unitsID(:,1) = cluster id;
        % unitsID(:,2) = class
        clusters = unique(units(:,2));
        if numel(clusters) > 0
            unitsID = nan(numel(clusters), 2);
            for i = 1:numel(clusters)
                unitsID(i,1) = clusters(i);
                clusterGroup = sprintf('/channel_groups/0/clusters/main/%d/cluster_group', clusters(i));
                unitsID(i,2) = hdf5read(filename, clusterGroup);
            end
            
            % SUAs
            idxSUAClusters = find(unitsID(:,2) == 2);
            if numel(idxSUAClusters) > 0
                SUAClusters = unitsID(idxSUAClusters,1);
                for idxCluster = 1:numel(SUAClusters);
                    idxSpikesInGoodCluster = find(units(:,2) == SUAClusters(idxCluster));
                    Fet = features;
                    [CluSep, m] = Cluster_Quality(Fet, idxSpikesInGoodCluster);
                    shank(idxShank).SUA.isolationDistance{idxCluster} = CluSep.IsolationDist;
                    shank(idxShank).SUA.L_Ratio{idxCluster} = CluSep.Lratio;
                end
            end
        end
    end
    cd(fullfile(nameExperiment, 'ephys'));
    save('units.mat', 'shank', '-append')
end

