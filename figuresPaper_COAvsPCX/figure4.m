%% Load data
% pcx1 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_1.mat');
% pcx2 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_2.mat');
% pcxR = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/responses.mat');
% 
% coa1 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_1.mat');
% coa2 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_2.mat');
% coaR = load('/Volumes/Tetrodes Backup1/january2/coa/aa/responses.mat');

odorsRearranged = 1:15;

%% Set figure size/position
figure
set(gcf,'Name', 'Figure 4: Population encoding of odors', 'NumberTitle', 'off');
set(gcf,'Position',[380 300 800 700]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%% Set panels
% p = panel();
% p.pack('h', {30 70});
% p(1).pack('v', {50 50});
% p(2).pack('v', {1/3 1/3 1/3});
% p(2,1).pack('h', {1/3 1/3 1/3});
% p(2,2).pack('h', {1/5 1/5 1/5 1/5 1/5});
% p(2,3).pack('h', {1/2 1/2});
% p(2,3,1).pack('h', {1/2 1/2});

% p.select('all');
% p.identify()
p = panel();
p.pack('v', {1/3 1/3 1/3});
p(1).pack('h', {50 50});
p(2).pack('h', {1/3 1/3 1/3});
p(3).pack('h', {50 50});
p(3,1).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(3,2).pack('h', {50 50});

%% A, B - Coding space
% [scoresCoa, scoresMeanCoa] = findCodingSpace(coa2.esp, odorsRearranged);
% [scoresPcx, scoresMeanPcx] = findCodingSpace(pcx2.esp, odorsRearranged);

p(1,1).select()
colorClass = [228,26,28;...
    55,126,184;...
    77,175,74;...
    152,78,163;...
    255,127,0]./255;
symbolOdor = {'o', 's', 'p'};
k = 0;
for idxCat = 1:5
    C = colorClass(idxCat,:);
    for idxOdor = 1:3
        mT = symbolOdor{idxOdor};
        scatter3(scoresCoa(1 + k*5:5 + k*5, 1), scoresCoa(1 + k*5:5 + k*5, 2), scoresCoa(1 + k*5:5 + k*5, 3), 100, C, mT, 'filled');
        k = k + 1;
        hold on
%         scatter3(scoresMeanCoa(k, 1), scoresMeanCoa(k, 2), scoresMeanCoa(k, 3), 100, C, 'd','filled');
%         hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
t1 = p(1,1).title('plCOA coding space');
set(t1, 'Color', 'r');


p(1,2).select()
colorClass = [228,26,28;...
    55,126,184;...
    77,175,74;...
    152,78,163;...
    255,127,0]./255;
symbolOdor = {'o', 's', 'p'};
k = 0;
for idxCat = 1:5
    C = colorClass(idxCat,:);
    for idxOdor = 1:3
        mT = symbolOdor{idxOdor};
        scatter3(scoresPcx(1 + k*5:5 + k*5, 1), scoresPcx(1 + k*5:5 + k*5, 2), scoresPcx(1 + k*5:5 + k*5, 3), 100, C, mT, 'filled');
        k = k + 1;
        hold on
%         scatter3(scoresMeanPcx(k, 1), scoresMeanPcx(k, 2), scoresMeanPcx(k, 3), 100, C, 'd','filled');
%         hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
t2 = p(1,2).title('PCX coding space');
set(t2, 'Color', 'k');
%% C - Optimal number of clusters
clustersN = [1:15, 20 30 40 50 60 70];
[EmeanCoa, EstdCoa, EmeanShuffledCoa, EsemShuffledCoa, EmeanDecorrCoa, EsemDecorrCoa] = findBestNumberOfClusters(coa2.esp, odorsRearranged);
[EmeanPcx, EstdPcx, EmeanShuffledPcx, EsemShuffledPcx, EmeanDecorrPcx, EsemDecorrPcx] = findBestNumberOfClusters(pcx2.esp, odorsRearranged);
p(2,1).select()
x = 1:21;
%optClusters = [EmeanCoa; EmeanPcx];
%imagesc(optClusters); axis xy; %colormap('hot');
% yTicks  = 1:2; yLabels = {'plCOA', 'PCX'};
xTicks  = [1 5 15 21] ; xLabels = {'1', '5', '15', '75'};
plot(x, EmeanCoa, 'ro-', 'linewidth', 2, 'markerSize', 5, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r')
hold on
errbar(x, EmeanCoa, EstdCoa, 'r', 'linewidth', 2);
hold on
plot(x, EmeanPcx, 'ko-', 'linewidth', 2, 'markerSize', 5, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
hold on
errbar(x, EmeanPcx, EstdPcx, 'k', 'linewidth', 2);
set(gca,'box','off')
set(gca, 'XTick' , xTicks);
set(gca, 'XTickLabel', xLabels);
xlabel('Optimal number of clusters')
ylabel('Gap value')
% minGap = min(optClusters(:));
% maxGap = max(optClusters(:))
% minLab = sprintf('%.2f (worst)', maxGap);
% maxLab = sprintf('%.2f (best)', minGap);
% c = colorbar('eastoutside', 'Ticks', [minGap, maxGap], 'TickLabels', {minLab, maxLab});
% c.Label.String = {'Optimal number of clusters', 'Gap value'}; 
% axis tight
%% D - Odor distances
% [distOdorsCoa, distOdorsDecorrCoa] = findOdorDistances(coa2.esp, odorsRearranged);
% [distOdorsPcx, distOdorsDecorrPcx] = findOdorDistances(pcx2.esp, odorsRearranged);
p(2,2).select();
distributionPlot(distOdorsCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(distOdorsPcx(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
ylim([0.5 1.5]);
xlabel('Pairwise distance between odor representations') 
set(gca,'YColor','w','box','off')
alpha(0.5)
% hold on
% distributionPlot(distOdorsDecorrCoa(:),'histOri','right','color','k','widthDiv',[2 2],'globalNorm', 1, 'xyOri', 'flipped')
% distributionPlot(distOdorsDecorrPcx(:),'histOri','left','color','r','widthDiv',[2 1],'globalNorm', 1, 'xyOri', 'flipped')
% alpha(0)

%% E - Correlation of odor distances between areas

p(2,3).select();
plot(distOdorsCoa(:), distOdorsPcx(:), 'k.', 'markersize', 7, 'color', [82 82 82]./255);
hold on
yFit = polyfit(distOdorsCoa(:),distOdorsPcx(:),1); 
p2 = plot(xlim, polyval(yFit,xlim));
p2.LineWidth = 2;
p2.Color = [0,109,44]./255;
xlim([0.8, 1.3])
ylim([0.8, 1.3])
xlabel('Distances in plCOA')
ylabel('Distances in PCX')


%% F - Linear classification
% [accuracyResponsesCoa, accuracyBaselineCoa, accuracyShuffledCoa, accuracyDecorrTuningCoa, accuracyDecorrNoiseCoa, conMatResponsesCoa] = l_svmClassify(coa2.esp, odorsRearranged);
% [accuracyResponsesPcx, accuracyBaselinePcx, accuracyShuffledPcx, accuracyDecorrTuningPcx, accuracyDecorrNoisePcx, conMatResponsesPcx] = l_svmClassify(pcx2.esp, odorsRearranged);

X = [accuracyResponsesCoa(:) accuracyResponsesPcx(:)];
p(3,1,1).select()
boxplot(X, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5);
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
set(gca, 'XColor', 'w', 'box','off')
ylim([0 100]);

X = [accuracyDecorrNoiseCoa(:) accuracyDecorrNoisePcx(:)];
p(3,1,2).select()
boxplot(X, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5);
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
set(gca, 'XColor', 'w', 'box','off')
set(gca, 'YColor', 'w')
ylim([0 100]);

X = [accuracyDecorrTuningCoa(:) accuracyDecorrTuningPcx(:)];
p(3,1,3).select()
boxplot(X, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5);
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
set(gca, 'XColor', 'w', 'box','off')
set(gca, 'YColor', 'w')
ylim([0 100]);

X = [accuracyShuffledCoa(:) accuracyShuffledPcx(:)];
p(3,1,4).select()
boxplot(X, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5);
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
set(gca, 'XColor', 'w', 'box','off')
set(gca, 'YColor', 'w')
ylim([0 100]);

X = [accuracyBaselineCoa(:) accuracyBaselinePcx(:)];
p(3,1,5).select()
boxplot(X, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5);
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
set(gca, 'XColor', 'w', 'box','off')
set(gca, 'YColor', 'w')
ylim([0 100]);

p(3, 1).ylabel('Correct classification (%)');

%% G - Confusion matrices
clims = [0 100];
p(3,2,1).select()
imagesc(conMatResponsesCoa*100, clims); axis square; colormap(brewermap([],'*RdBu'));
set(gca, 'XColor', 'w', 'box','off')
set(gca, 'YColor', 'w')
t3 = p(3,2,1).title('plCOA');
set(t3, 'Color', 'r');

p(3,2,2).select()
imagesc(conMatResponsesPcx*100, clims); axis square; colormap(brewermap([],'*RdBu'));
set(gca, 'XColor', 'w', 'box','off')
set(gca, 'YColor', 'w')
t4 = p(3,2,2).title('PCX');
set(t4, 'Color', 'k');


%%
p.select('all');
p.de.margin = 2;
p(1).marginbottom = 20;
p(1,1).marginright = 20;
p(2).marginbottom = 30;
p(2,1).marginright = 20;
p(2,2).marginright = 30;
p(3,1).marginright = 20;
p(3,1,1).marginright = 5;
p(3,1,2).marginright = 5;
p(3,1,3).marginright = 5;
p(3,1,4).marginright = 5;
p.margin = [20 15 10 10];
p.fontsize = 12;
p.fontname = 'Avenir';
