close all
colors = [228,26,28;...
55,126,184;...
77,175,74;...
152,78,163] ./ 255;
time = -4:1/1000:6;
time(1:2) = [];
for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).SUA.sdf_trial)
        figure
        set(gcf,'Position',[87 68 560 728]);
        subplot(6,3,[1 2])
        plot(shank(idxShank).SUA.meanWaveform{idxUnit}, 'color', colors(idxShank,:), 'linewidth', 1)
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca, 'YTickLabel', []);
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        set(gca,'XColor','w')
        maxRsp = 0;
        minRsp = 0;
        for idxOdor = 1:15
            maxRsp = max([maxRsp max(mean(shank(idxShank).SUA.sdf_trial{idxUnit}(:,:,idxOdor)))]);
            minRsp = min([minRsp min(mean(shank(idxShank).SUA.sdf_trial{idxUnit}(:,:,idxOdor)))]);
        end
        for idxOdor = 1:15
            subplot(6,3,3+idxOdor)
            plot(time, mean(shank(idxShank).SUA.sdf_trial{idxUnit}(:,:,idxOdor)), 'color', 'k', 'linewidth', 1)
            ylim([minRsp-0.001 maxRsp+0.001])
            set(gca, 'box', 'off')
        end
    end
end
    