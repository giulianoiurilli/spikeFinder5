%%folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');
esp = pcxCS2.esp;
for idxExp = 1: length(esp)
folderlist(idxExp).name = esp(idxExp).filename;
end

% %%
% meanSpeed = nan(15,200,length(folderlist));
% for idxExp = 1 : length(folderlist)
%     folderExp = folderlist(idxExp).name;
%     disp(folderExp)
%     cd(fullfile(folderExp, 'ephys'))
% % cd(folderExp)
% % cd ..
% % cd('ephys')
%     load('speed.mat')
%     
%     for idxOdor = 1:15
%         meanSpeedE(idxOdor,:,idxExp) = nanmean(squeeze(speedSweeps(1:5,:,idxOdor)));
%         meanSpeedL(idxOdor,:,idxExp) = nanmean(squeeze(speedSweeps(6:10,:,idxOdor)));
%     end
% end
% %%
% 
% 
% %%
% app1 = mean(mean(meanSpeedE,3));
% app2 = mean(mean(meanSpeedL,3));
% app3 = mean([app1; app2]);
% figure
% timeline  = linspace(-2,8,200);
%     plot(timeline,smooth(app1, 20,'loess'),'color', [0,136,55]./255, 'linewidth', 1)
%     hold on
%     plot(timeline,smooth(app2, 20,'loess'), 'color', [123,50,148]./255, 'linewidth', 1) 
%     hold on
%     plot(timeline,smooth(app3, 20,'loess'), 'color', 'k', 'linewidth', 1) 
% 
%     ylim([0 2])
%     xlim([-2 8])
%     ylabel('cm/sec')
%     xlabel('s')
% 
% 
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% %%
% figure
% timeline  = linspace(-2,8,200);
% for idxOdor = 1:15
%     subplot(3,5,idxOdor)
%     for idxExp = 1:length(folderlist)
%     plot(timeline,smooth(nanmean(meanSpeedE(idxOdor,:,:),3), 20,'loess'),'color', [0,136,55]./255, 'linewidth', 1)
%     hold on
%     plot(timeline,smooth(nanmean(meanSpeedL(idxOdor,:,:),3), 20,'loess'), 'color', [123,50,148]./255, 'linewidth', 1) 
%     end
%     ylim([0 4])
%     xlim([-2 8])
%     ylabel('cm/sec')
%     xlabel('s')
% end
% 
% % set(gcf,'Position',[-1763 166 1222 641]);
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% 
%  %%
%   
%  colorClass1 = flipud([254,240,217;...
% 253,204,138;...
% 252,141,89;...
% 227,74,51;...
% 179,0,0]./255);
% colorClass2 = flipud([239,243,255;...
% 189,215,231;...
% 107,174,214;...
% 49,130,189;...
% 8,81,156]./255);
% 
% colorClass3 = flipud([237,248,233;...
% 186,228,179;... 
% 116,196,118;...
% 49,163,84;...
% 0,109,44]./255);
% 
% %%
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% roseHSpeed1 = mean(meanSpeedE(1,:,:),3);
% roseHSpeed2 = mean(meanSpeedL(1,:,:),3);
% roseHSpeed = mean([roseHSpeed1; roseHSpeed2]);
% roseMSpeed1 = mean(meanSpeedE(3,:,:),3);
% roseMSpeed2 = mean(meanSpeedL(3,:,:),3);
% roseMSpeed = mean([roseMSpeed1; roseMSpeed2]);
% roseLSpeed1 = mean(meanSpeedE(5,:,:),3);
% roseLSpeed2 = mean(meanSpeedL(5,:,:),3);
% roseLSpeed = mean([roseLSpeed1; roseLSpeed2]);
% plot(timeline,smooth(roseHSpeed, 20,'loess'),'color', [179,0,0]./255, 'linewidth', 2)
% hold on
% plot(timeline,smooth(roseMSpeed, 20,'loess'), 'color', [227,74,51]./255, 'linewidth', 2)
% hold on
% plot(timeline,smooth(roseLSpeed, 20,'loess'), 'color', [252,141,89]./255, 'linewidth', 2)
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
% %%
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% TMTHSpeed1 = mean(meanSpeedE(6,:,:),3);
% TMTHSpeed2 = mean(meanSpeedL(6,:,:),3);
% TMTHSpeed = mean([TMTHSpeed1; TMTHSpeed2]);
% TMTMSpeed1 = mean(meanSpeedE(8,:,:),3);
% TMTMSpeed2 = mean(meanSpeedL(8,:,:),3);
% TMTMSpeed = mean([TMTMSpeed1; TMTMSpeed2]);
% TMTLSpeed1 = mean(meanSpeedE(10,:,:),3);
% TMTLSpeed2 = mean(meanSpeedL(10,:,:),3);
% TMTLSpeed = mean([TMTLSpeed1; TMTLSpeed2]);
% plot(timeline,smooth(TMTHSpeed, 20,'loess'),'color', [8,81,156]./255, 'linewidth', 2)
% hold on
% plot(timeline,smooth(TMTMSpeed, 20,'loess'), 'color', [49,130,189]./255, 'linewidth', 2)
% hold on
% plot(timeline,smooth(TMTLSpeed, 20,'loess'), 'color', [107,174,214]./255, 'linewidth', 2)
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
% 
% %%
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% iaaHSpeed1 = mean(meanSpeedE(11,:,:),3);
% iaaHSpeed2 = mean(meanSpeedL(11,:,:),3);
% iaaHSpeed = mean([iaaHSpeed1; iaaHSpeed2]);
% iaaMSpeed1 = mean(meanSpeedE(13,:,:),3);
% iaaMSpeed2 = mean(meanSpeedL(13,:,:),3);
% iaaMSpeed = mean([iaaMSpeed1; iaaMSpeed2]);
% iaaLSpeed1 = mean(meanSpeedE(15,:,:),3);
% iaaLSpeed2 = mean(meanSpeedL(15,:,:),3);
% iaaLSpeed = mean([iaaLSpeed1; iaaLSpeed2]);
% plot(timeline,smooth(iaaHSpeed, 20,'loess'),'color', [0,109,44]./255, 'linewidth', 2)
% hold on
% plot(timeline,smooth(iaaMSpeed, 20,'loess'), 'color', [49,163,84]./255, 'linewidth', 2)
% hold on
% plot(timeline,smooth(iaaLSpeed, 20,'loess'), 'color', [116,196,118]./255, 'linewidth', 2)
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
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
        meanSpeedAll(idxOdor,:,idxExp) = nanmean(squeeze(speedSweeps(1:10,:,idxOdor)));
    end
end
%%
%%
figure

for idxOdor = 1:15
    subplot(3,5,idxOdor)
    for idxExp = 1:length(folderlist)
    plot(smooth(nanmean(meanSpeedAll(idxOdor,:,:),3), 20,'loess'),'color', [0,136,55]./255, 'linewidth', 1)
    end
    ylim([0 4])

    ylabel('cm/sec')
    xlabel('s')
end

% set(gcf,'Position',[-1763 166 1222 641]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
%%
avgBslSpeed = nan(length(folderlist), 15);
avgRspSpeed = nan(length(folderlist), 15);
for idxExp = 1:length(folderlist)
    for idxOdor = 1:15
        avgBslSpeed(idxExp,idxOdor) = nanmean(meanSpeedAll(idxOdor,1:30, idxExp));
        avgRspSpeed(idxExp,idxOdor) = nanmean(meanSpeedAll(idxOdor,50:150, idxExp));
    end
end
deltaSpeed2 = avgRspSpeed - avgBslSpeed;
%% for NM (pcx and coa together)
Z = [deltaSpeed1(:,1:13); deltaSpeed2(:,1:13)]; %odor to use
idx = [1 3 4 8 10 11 12 14 16:19];%experiments to use
z = Z(idx,:);
[p,~,stats] = kruskalwallis(z)
figure
[c,~,~,gnames] = multcompare(stats)


figure
barwitherr(std(z)./sqrt(size(z,1)), mean(z), 'EdgeColor', [37 37 37]./255, 'FaceColor', [37 37 37]./255)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)

%% for CS2 (only pcx)
Z = deltaSpeed2(:,[1 5 6 10 11 15]); %conc to use
z = Z([1:8 10 11],:); %experiments to use
[p,~,stats] = kruskalwallis(z)
figure
[c,~,~,gnames] = multcompare(stats)
figure
barwitherr(std(z)./sqrt(size(z,1)), mean(z), 'EdgeColor', [37 37 37]./255, 'FaceColor', [37 37 37]./255)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)

%%
figure
app = deltaSpeed(:,1:13);
app = app(:);
sameNM = app(:);
g = [zeros(size(deltaSpeed,1),1); ones(size(deltaSpeed,1),1); 2*ones(size(deltaSpeed,1),1); 3*ones(size(deltaSpeed,1),1); 4*ones(size(deltaSpeed,1),1);...
    5*ones(size(deltaSpeed,1),1); 6*ones(size(deltaSpeed,1),1); 7*ones(size(deltaSpeed,1),1); 8*ones(size(deltaSpeed,1),1); 9*ones(size(deltaSpeed,1),1);...
    10*ones(size(deltaSpeed,1),1); 11*ones(size(deltaSpeed,1),1); 12*ones(size(deltaSpeed,1),1)];
boxplot(sameNM, g, 'color', 'r', 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-0.2 3])
ylabel('Speed Increase (cm/sec)')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
