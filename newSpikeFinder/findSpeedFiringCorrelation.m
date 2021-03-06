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
                    for idxTrial = 1:10
                        idx = idx + 1;
                        spikesVect = shank(idxShank).SUA.spike_matrix{idxUnit}(idxTrial,:,idxOdor);
                        [slidingPSTHmn, slidingPSTHsd, slidingPSTHFF, slidingPSTHCV, slidingPSTH] = slidePSTH(spikesVect, 100, 100);
                        app_speed = squeeze(speedSweeps(idxTrial,:,idxOdor));
                        allSpeeds(idx,:) = mean(reshape(app_speed, 2,size(app_speed,2)/2));
                        allSpikes(idx,:) = slidingPSTH;
                    end
                end
                corrSpeedSpikes(idxCell) = corr(allSpeeds(:), allSpikes(:));
                logCell = [logCell; [idxExp, idxShank, idxUnit]];
            end
        end
    end
end

figure
histogram(corrSpeedSpikes,20)

