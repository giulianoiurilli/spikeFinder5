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
        folderPath = fullfile(nameExperiment, folderShank);
        cd(folderPath)
        filename = [folderShank '.kwik'];
        % collect spikes and their time samples (these are samples not ms);
        % units(:,1) = time samples;
        % unitsInTime(:2) = cluster id
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
        
        % SUAs
        idxSUAClusters = find(unitsID(:,2) == 2);
        SUAClusters = unitsID(idxSUAClusters,1);
        for idxCluster = 1:numel(SUAClusters);
            idxSpikesInGoodCluster = find(units(:,2) == SUAClusters(idxCluster));
            shank(idxShank).SUA.spiketimesUnit_Samples{idxCluster} = units(idxSpikesInGoodCluster,1);
            shank(idxShank).SUA.spiketimesUnit{idxCluster} = round((double(units(idxSpikesInGoodCluster,1))./20000), 3);
            datFilename = [folderShank '.dat'];
            [meanWF, allWF] = readWaveformsFromDat(datFilename, 8, shank(idxShank).SUA.spiketimesUnit_Samples{idxCluster},...
                [-20 20], []);
            meanWF = meanWF';
            shank(idxShank).SUA.meanWaveform{idxCluster} = meanWF(:);
            shank(idxShank).SUA.spikeSNR{idxCluster} = findSpikeSNR(allWF, meanWF', 8);
            shank(idxShank).SUA.clusterID{idxCluster} = SUAClusters(idxCluster); 
            shank(idxShank).SUA.sourceFolder{idxCluster} = fullfile(folderPath, 'units.mat');
        end
        % MUAs
        idxMUAClusters = find(unitsID(:,2) == 1);
        MUAClusters = unitsID(idxMUAClusters,1);
        for idxCluster = 1:numel(MUAClusters);
            idxSpikesInGoodCluster = find(units(:,2) == MUAClusters(idxCluster));
            shank(idxShank).MUA.spiketimesUnit{idxCluster} = round((double(units(idxSpikesInGoodCluster,1))./20000), 3);
            shank(idxShank).MUA.clusterID{idxCluster} = MUAClusters(idxCluster);
            shank(idxShank).MUA.sourceFolder{idxCluster} = fullfile(folderPath, 'units.mat');
        end
    end
    cd(nameExperiment);
    save('units.mat', 'shank')
    
    makeParams
    findValveOnsets(0.5, samplingFrequency, triggerToOnsetDelay)
    findSniffOnsets(samplingFrequency)
    makeSpikeMatrix
end
