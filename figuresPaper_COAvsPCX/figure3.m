%% Load data
% pcx1 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_1.mat');
% pcx2 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_2.mat');
pcxR = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/responses.mat');
% 
% coa1 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_1.mat');
% coa2 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_2.mat');
coaR = load('/Volumes/Tetrodes Backup1/january2/coa/aa/responses.mat');

odorsRearranged = 1:15;

%% Set figure size/position
figure
set(gcf,'Name', 'Figure 3: Signal and noise correlation', 'NumberTitle', 'off');
set(gcf,'Position',[670 480 450 520]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%% Set panels
p = panel();
p.pack('v', {60 40});
p(1).pack('h', {50 50});


% p.select('all');
% p.identify()


% %% A - Signal correlation - Whithin and between shanks
% 
% coaScT = [coaR.sigCorrW1000ms];
% pcxScT = [pcxR.sigCorrW1000ms];
% allScT = [coaScT pcxScT];
% groupingV = ones(1,length(allScT(:)));
% groupingV(length(coaScT + 1) : end) = 2;
% 
% p(1,1,1).select()
% boxplot(allScT, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5, 'datalim', [-0.2 0.4]);
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% %xlim([-0.005 0.15]);
% set(gca, 'XColor', 'w', 'box','off')
% p(2,1,1).title({'Signal correlation', 'Nearby neurons'});
% 
% coaScT = [coaR.sigCorrB1000ms];
% pcxScT = [pcxR.sigCorrB1000ms];
% allScT = [coaScT pcxScT];
% groupingV = ones(1,length(allScT(:)));
% groupingV(length(coaScT + 1) : end) = 2;
% 
% p(1,1,2).select()
% boxplot(allScT, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5, 'datalim', [-0.2 0.4]);
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% %xlim([-0.005 0.15]);
% set(gca, 'XColor', 'w', 'box','off')
% set(gca, 'YTickLabel', []);
% set(gca,'YTick',[])
% set(gca, 'YColor', 'w')
% p(2,1,2).title({'Signal correlation', 'Far-apart neurons'});
% %% B - Noise correlation - Whithin and between shanks
% 
% coaNcT = [coaR.noiseCorrW1000ms];
% pcxNcT = [pcxR.noiseCorrW1000ms];
% allNcT = [coaNcT pcxNcT];
% groupingV = ones(1,length(allNcT(:)));
% groupingV(length(coaNcT + 1) : end) = 2;
% 
% p(1,2,1).select()
% b1 = boxplot(allNcT, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5, 'datalim', [-0.2 0.4]);
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% %xlim([-0.005 0.15]);
% set(gca, 'XColor', 'w', 'box','off')
% p(1,2,1).title({'Noise correlation', 'Nearby neurons'});
% 
% coaNcT = [coaR.noiseCorrB1000ms];
% pcxNcT = [pcxR.noiseCorrB1000ms];
% allNcT = [coaNcT pcxNcT];
% groupingV = ones(1,length(allNcT(:)));
% groupingV(length(coaNcT + 1) : end) = 2;
% 
% p(1,2,2).select()
% b1 = boxplot(allNcT, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5, 'datalim', [-0.2 0.4]);
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% %xlim([-0.005 0.15]);
% set(gca, 'XColor', 'w', 'box','off')
% set(gca, 'YColor', 'w')
% set(gca, 'YTickLabel', []);
% set(gca,'YTick',[])
% p(2,2,2).title({'Noise correlation', 'Far-apart neurons'});
%% A - Signal correlation - Whithin and between shanks

coaScWMean = nanmean(coaR.sigCorrW1000ms);
pcxScWMean = nanmean(pcxR.sigCorrW1000ms);
coaScWSem = nanstd(coaR.sigCorrW1000ms)./sqrt(length(coaR.sigCorrW1000ms));
pcxScWSem = nanstd(pcxR.sigCorrW1000ms)./sqrt(length(pcxR.sigCorrW1000ms));

coaNcWMean = nanmean(coaR.noiseCorrW1000ms);
pcxNcWMean = nanmean(pcxR.noiseCorrW1000ms);
coaNcWSem = nanstd(coaR.noiseCorrW1000ms)./sqrt(length(coaR.noiseCorrW1000ms));
pcxNcWSem = nanstd(pcxR.noiseCorrW1000ms)./sqrt(length(pcxR.noiseCorrW1000ms));

coaScBMean = nanmean(coaR.sigCorrB1000ms);
pcxScBMean = nanmean(pcxR.sigCorrB1000ms);
coaScBSem = nanstd(coaR.sigCorrB1000ms)./sqrt(length(coaR.sigCorrB1000ms));
pcxScBSem = nanstd(pcxR.sigCorrB1000ms)./sqrt(length(pcxR.sigCorrB1000ms));

coaNcBMean = nanmean(coaR.noiseCorrB1000ms);
pcxNcBMean = nanmean(pcxR.noiseCorrB1000ms);
coaNcBSem = nanstd(coaR.noiseCorrB1000ms)./sqrt(length(coaR.noiseCorrB1000ms));
pcxNcBSem = nanstd(pcxR.noiseCorrB1000ms)./sqrt(length(pcxR.noiseCorrB1000ms));


p(1,1).select()
plot([1 5], [coaScWMean coaScBMean], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 6], [pcxScWMean pcxScBMean], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 5], [coaScWMean coaScBMean], [coaScWSem coaScBSem], 'r', 'linewidth', 2);
hold on
errbar([2 6], [pcxScWMean pcxScBMean], [pcxScWSem pcxScBSem], 'k', 'linewidth', 2);
xlim([0 7])
ylim([0.02 0.09])
set(gca, 'XColor', 'w', 'box','off')
ylabel('Signal correlation')


%% B - Noise correlation - Whithin and between shanks
p(1,2).select()
plot([1 5], [coaNcWMean coaNcBMean], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 6], [pcxNcWMean pcxNcBMean], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 5], [coaNcWMean coaNcBMean], [coaNcWSem coaNcBSem], 'r', 'linewidth', 2);
hold on
errbar([2 6], [pcxNcWMean pcxNcBMean], [pcxNcWSem pcxNcBSem], 'k', 'linewidth', 2);
xlim([0 7])
ylim([0.02 0.09])
set(gca, 'XColor', 'w', 'box','off')
ylabel('Noise correlation')



%% C - Correlation between signal and noise correlation

coaScT = [coaR.sigCorrW1000ms coaR.sigCorrB1000ms];
pcxScT = [pcxR.sigCorrW1000ms pcxR.sigCorrB1000ms];
coaNcT = [coaR.noiseCorrW1000ms coaR.noiseCorrB1000ms];
pcxNcT = [pcxR.noiseCorrW1000ms pcxR.noiseCorrB1000ms];
grayShade = 0.7;
msize = 7;
p(2).select()
plot(coaScT, coaNcT, 'r.', 'markersize', msize, 'color', grayShade * [1 0 0]);
coaFit = polyfit(coaScT,coaNcT,1); 
hold on
p1 = plot(xlim, polyval(coaFit, xlim));
p1.LineWidth = 2;
p1.Color = 'r';

hold on
plot(pcxScT, pcxNcT, 'k.', 'markersize', msize, 'color', grayShade * [1 1 1]);
pcxFit = polyfit(pcxScT,pcxNcT,1); 
p2 = plot(xlim, polyval(pcxFit,xlim));
p2.LineWidth = 2;
p2.Color = 'k';

p(2).xlabel('Signal correlation');
p(2).ylabel('Noise correlation');



%% show panels
p.select('all');
p.de.margin = 2;
p(1).marginbottom = 40;
p(1,1).marginright = 30;
p.margin = [20 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';