%%
close all

idxExp = 1;
colors = [228,26,28;...
55,126,184;...
77,175,74;...
152,78,163] ./ 255;
time = -4:1/1000:6;
time(1) = [];
sigmaSDF = 0.1;
for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
            figure
            set(gcf,'Position',[-1735 400 1256 555]);
            maxRsp = 0;
            minRsp = 0;
            sdfOdor = [];
            for idxOdor = 1:15
                app = double(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(:,15000-4000:15000+6000));
                sdf = [];
                for idxTrial = 1:10
                    sdf(idxTrial,:) = spikeDensity(app(idxTrial,:), sigmaSDF);
                end
                sdfOdor(idxOdor,:) = mean(sdf);  
                maxRsp = max([maxRsp max(sdfOdor(idxOdor,:))]);
                minRsp = min([minRsp min(sdfOdor(idxOdor,:))]);
            end
            for idxOdor = 1:15
                subplot(3,5,idxOdor)
                plot(time, sdfOdor(idxOdor,:), 'color', 'k', 'linewidth', 1);
                ylim([minRsp-0.001 maxRsp+0.001])
                xlim([-4 6])
                set(gca, 'box', 'off')
                stringa = sprintf('auROC: %0.2f - significant: %d', esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms, esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms);
                title(stringa)
            end
            end
        end
end