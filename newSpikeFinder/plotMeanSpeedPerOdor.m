%%folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');
%%
for idxExp = 1: length(esp)
folderlist(idxExp).name = esp(idxExp).filename;
end

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
        meanSpeedE(idxOdor,:,idxExp) = nanmean(squeeze(speedSweeps(1:5,:,idxOdor)));
        meanSpeedL(idxOdor,:,idxExp) = nanmean(squeeze(speedSweeps(6:10,:,idxOdor)));
    end
end

%%
figure
timeline  = linspace(-2,8,200);
for idxOdor = 1:15
    subplot(3,5,idxOdor)
    for idxExp = 1:length(folderlist)
    plot(timeline,nanmean(meanSpeedE(idxOdor,:,:),3),'r', 'linewidth', 2)
    hold on
    plot(timeline,nanmean(meanSpeedL(idxOdor,:,:),3), 'linewidth', 2) 
    end
    ylim([0 3])
    xlim([-2 8])
    ylabel('cm/sec')
    xlabel('s')
end

% set(gcf,'Position',[-1763 166 1222 641]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');

    