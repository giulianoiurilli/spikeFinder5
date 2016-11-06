idxCell = 0;
corrSpeedSpikes = [];
logCell = [];

folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');
%%
for idxExp = 1 : length(folderlist)
    folderExp = folderlist(idxExp).name;
    disp(folderExp)
    cd(fullfile(folderExp, 'ephys'))
    load('speed.mat')
    load('units.mat')
    for idxShank = 1:4
        if ~isnan(shank(idxShank).SUA.clusterID{1})
            for idxUnit = 1:length(shank(idxShank).SUA.clusterID)
                idxCell = idxCell + 1;
                
                allSpikes = nan(15*10, 100);
                allSpeeds = nan(15*10, 100);
                idx = 0;
                for idxOdor = 1:15
                        spikesVect = shank(idxShank).SUA.spike_matrix{idxUnit}(:,:,idxOdor);
                        [slidingPSTHmn, slidingPSTHsd, slidingPSTHFF, slidingPSTHCV, slidingPSTH] = slidePSTH(spikesVect, 100, 25);
                        X(idxCell,:,idxOdor) = slidingPSTHmn;
                end
            end
        end
    end
end
figure
for idxOdor = 1:15
        subplot(3,5,idxOdor)
        plot(mean(X(:,:,idxOdor)))
end
        
        



