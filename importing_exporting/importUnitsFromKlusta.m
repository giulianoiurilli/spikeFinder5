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
                    shank(idxShank).SUA.spiketimesUnit_Samples{idxCluster} = units(idxSpikesInGoodCluster,1);
                    shank(idxShank).SUA.spiketimesUnit{idxCluster} = round((double(units(idxSpikesInGoodCluster,1))./20000), 3);
                    datFilename = [folderShank '.dat'];
                    [meanWF, allWF] = readWaveformsFromDat(datFilename, 8, shank(idxShank).SUA.spiketimesUnit_Samples{idxCluster},...
                        [-20 20], []);
                    meanWF = meanWF';
                    shank(idxShank).SUA.meanWaveform{idxCluster} = meanWF(:);
                    shank(idxShank).SUA.spikeSNR{idxCluster} = findSpikeSNR(allWF, meanWF', 8);
                    %                     FetThisCluster = features(idxSpikesInGoodCluster,:);
                    %                     meanFetThisCluster = mean(FetThisCluster);
                    %                     app = flipud(unique(sort(abs(meanFetThisCluster))));
                    %                     result = app(end-2:end);
                    %                     ind = find(abs(meanFetThisCluster)>=result(1));
                    %                     resultat = flipud(sortrows([meanFetThisCluster(ind) ind],1));
                    %                     resultatBestThree = resultat(end-2:end);
                    %                     Fet = features(:,resultatBestThree); %best three PC
                    %Fet = features(:,1:3:24); %first PCs of all channels
                    Fet = features;
                    [CluSep, m] = Cluster_Quality(Fet, idxSpikesInGoodCluster);
                    shank(idxShank).SUA.isolationDistance{idxCluster} = CluSep.IsolationDist;
                    shank(idxShank).SUA.L_Ratio{idxCluster} = CluSep.Lratio;
                    shank(idxShank).SUA.clusterID{idxCluster} = SUAClusters(idxCluster);
                    shank(idxShank).SUA.sourceFolder{idxCluster} = fullfile(folderPath, 'units.mat');
                end
            else
                shank(idxShank).SUA.spiketimesUnit_Samples{1} = NaN;
                shank(idxShank).SUA.spiketimesUnit{1} = NaN;
                shank(idxShank).SUA.meanWaveform{1} = nan(1,32);
                shank(idxShank).SUA.spikeSNR{1} = NaN;
                shank(idxShank).SUA.clusterID{1} = NaN;
                shank(idxShank).SUA.sourceFolder{1} = fullfile(folderPath, 'units.mat');
            end
            
            % MUAs
            
            idxMUAClusters = find(unitsID(:,2) == 1);
            if numel(idxMUAClusters) > 0
                MUAClusters = unitsID(idxMUAClusters,1);
                for idxCluster = 1:numel(MUAClusters);
                    idxSpikesInGoodCluster = find(units(:,2) == MUAClusters(idxCluster));
                    shank(idxShank).MUA.spiketimesUnit{idxCluster} = round((double(units(idxSpikesInGoodCluster,1))./20000), 3);
                    shank(idxShank).MUA.clusterID{idxCluster} = MUAClusters(idxCluster);
                    shank(idxShank).MUA.sourceFolder{idxCluster} = fullfile(folderPath, 'units.mat');
                end
            else
                shank(idxShank).MUA.spiketimesUnit{1} = NaN;
                shank(idxShank).MUA.clusterID{1} = NaN;
                shank(idxShank).MUA.sourceFolder{1} = fullfile(folderPath, 'units.mat');
            end
        else
            shank(idxShank).SUA.spiketimesUnit_Samples{1} = NaN;
            shank(idxShank).SUA.spiketimesUnit{1} = NaN;
            shank(idxShank).SUA.meanWaveform{1} = nan(1,32);
            shank(idxShank).SUA.spikeSNR{1} = NaN;
            shank(idxShank).SUA.clusterID{1} = NaN;
            shank(idxShank).SUA.sourceFolder{1} = fullfile(folderPath, 'units.mat');
            shank(idxShank).MUA.spiketimesUnit{1} = NaN;
            shank(idxShank).MUA.clusterID{1} = NaN;
            shank(idxShank).MUA.sourceFolder{1} = fullfile(folderPath, 'units.mat');
        end
    end
    cd(fullfile(nameExperiment, 'ephys'));
    save('units.mat', 'shank')
    
    makeParams
    findValveOnsets(0.5, samplingFrequency, triggerToOnsetDelay)
    findSniffOnsets(samplingFrequency)
    makeSpikeMatrix
end
