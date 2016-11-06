folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');
%%
meanSpeed = nan(15,200,length(folderlist));
for idxExp = 1 : length(folderlist)
    folderExp = folderlist(idxExp).name;
    disp(folderExp)
    cd(fullfile(folderExp, 'ephys'))
% cd(folderExp)
% cd ..
% cd('ephys')
    load('speed.mat')
    
    for idxOdor = 1:15
        meanSpeed(idxOdor,:,idxExp) = nanmean(squeeze(speedSweeps(:,:,idxOdor)));
    end
end
figure
for idxOdor = 1:15
    subplot(3,5,idxOdor)
    for idxExp = 1:length(folderlist)
    plot(nanmean(meanSpeed(idxOdor,:,:),3),'r')
%     hold on
%     plot(meanSpeed(idxOdor,:,idxExp), 'k')    
    end
    ylim([0 3])
end

    