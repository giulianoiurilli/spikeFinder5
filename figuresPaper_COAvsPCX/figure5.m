%% Load data

% pcx2HL = load('/Volumes/Tetrodes Backup1/january2/pcx/15/pcx_15_2_2.mat');
% pcxRH8 = load('/Volumes/Tetrodes Backup1/january2/pcx/15/responsesH8.mat');
% 
% coa2HL = load('/Volumes/Tetrodes Backup1/january2/coa/15/coa_15_2_2.mat');
% coaRH8 = load('/Volumes/Tetrodes Backup1/january2/coa/15/responsesH8.mat');


%% Set figure size/position
figure
set(gcf,'Name', 'Figure 4: Population encoding of odors', 'NumberTitle', 'off');
set(gcf,'Position',[230 110 790 870]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%% Set panels
p = panel();
p.pack('v', {28 28 24 20});
p(1).pack('h', {50 50});
p(1,1).pack('h', {50 50});
p(1,2).pack('h', {50 50});
p(2).pack('h', {1/3 1/3 1/3});
p(3).pack('h', {1/2 1/2});
p(3,1).pack('h', {1/2 1/2});
p(3,2).pack('h', {1/2 1/2});
p(4).pack('h', {1/2 1/2});

% p.select('all');
% p.identify()


%% A, B - Tuning curves
% odorsRearranged = [8 11 12 5 2 14 4 10];
% tuningCurvesAACoa = makeTuningCurves(coa2HL.esp, odorsRearranged);
% odorsRearranged = [3 8 10 1 13 11 9 14];
% tuningCurvesAAPcx = makeTuningCurves(pcx2HL.esp, odorsRearranged);
clims = [0 1];

p(1,1,1).select()
imagesc(tuningCurvesAACoa(:,1:4), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
p(1,1,2).select()
imagesc(tuningCurvesAACoa(:,5:8), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(1,1).title({'plcOA'})

p(1,2,1).select()
imagesc(tuningCurvesAAPcx(:,1:4), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
p(1,2,2).select()
imagesc(tuningCurvesAAPcx(:,5:8), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(1,2).title({'PCX'})


%% C,D - Coding spaces
% odorsRearranged = [8 11 12 5 2 14 4 10];
% [scoresCoaAA, scoresMeanCoaAA] = findCodingSpace(coa2HL.esp, odorsRearranged);
% odorsRearranged = [3 8 10 1 13 11 9 14];
% [scoresPcxAA, scoresMeanPcxAA] = findCodingSpace(pcx2HL.esp, odorsRearranged);

p(2,1).select()
colorClass = [118,42,131;...
    27,120,55]./255;
symbolOdor = {'o', 's', 'p', 'd'};
k = 0;
for idxCat = 1:2
    C = colorClass(idxCat,:);
    for idxOdor = 1:4
        mT = symbolOdor{idxOdor};
        scatter3(scoresCoaAA(1 + k*5:5 + k*5, 1), scoresCoaAA(1 + k*5:5 + k*5, 2), scoresCoaAA(1 + k*5:5 + k*5, 3), 100, C, mT, 'filled');
        k = k + 1;
        hold on
    end
end
xlim([-5 10])
ylim([-5 5])
zlim([-2 4])
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');

p(2,2).select()
colorClass = [118,42,131;...
    27,120,55]./255;
symbolOdor = {'o', 's', 'p', 'd'};
k = 0;
for idxCat = 1:2
    C = colorClass(idxCat,:);
    for idxOdor = 1:4
        mT = symbolOdor{idxOdor};
        scatter3(scoresPcxAA(1 + k*5:5 + k*5, 1), scoresPcxAA(1 + k*5:5 + k*5, 2), scoresPcxAA(1 + k*5:5 + k*5, 3),100, C, mT, 'filled');
        k = k + 1;
        hold on
    end
end
xlim([-5 10])
ylim([-5 5])
zlim([-2 4])
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');

%% E - Optimal number of clusters
clustersN = [1:8, 10 15 20 25 30 35];
% odorsRearranged = [8 11 12 5 2 14 4 10];
% [EmeanCoaAA, EstdCoaAA, EmeanShuffledCoaAA, EsemShuffledCoaAA, EmeanDecorrCoaAA, EsemDecorrCoaAA] = findBestNumberOfClusters(coa2HL.esp, odorsRearranged, clustersN);
% odorsRearranged = [3 8 10 1 13 11 9 14];
% [EmeanPcxAA, EstdPcxAA, EmeanShuffledPcxAA, EsemShuffledPcxAA, EmeanDecorrPcxAA, EsemDecorrPcxAA] = findBestNumberOfClusters(pcx2HL.esp, odorsRearranged, clustersN);

p(2,3).select()
x = 1:8;
%optClusters = [EmeanCoa; EmeanPcx];
%imagesc(optClusters); axis xy; %colormap('hot');
% yTicks  = 1:2; yLabels = {'plCOA', 'PCX'};
xTicks  = [2 4 6 8] ; xLabels = {'2', '4', '6', '8'};
plot(x, EmeanCoaAA, 'ro-', 'linewidth', 2, 'markerSize', 5, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'r')
hold on
errbar(x, EmeanCoaAA, EstdCoaAA, 'r', 'linewidth', 2);
hold on
plot(x, EmeanPcxAA, 'ko-', 'linewidth', 2, 'markerSize', 5, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
hold on
errbar(x, EmeanPcxAA, EstdPcxAA, 'k', 'linewidth', 2);
set(gca,'box','off')
set(gca, 'XTick' , xTicks);
set(gca, 'XTickLabel', xLabels);
xlabel('Optimal number of clusters')
ylabel('Gap value')

%% F - Linear classification
% odorsRearranged = [8 11 12 5 2 14 4 10];
% [accuracyResponsesCoaAA, accuracyBaselineCoaAA, accuracyShuffledCoaAA, accuracyDecorrTuningCoaAA, accuracyDecorrNoiseCoaAA, conMatResponsesCoaAA] = l_svmClassify(coa2HL.esp, odorsRearranged);
% odorsRearranged = [3 8 10 1 13 11 9 14];
% [accuracyResponsesPcxAA, accuracyBaselinePcxAA, accuracyShuffledPcxAA, accuracyDecorrTuningPcxAA, accuracyDecorrNoisePcxAA, conMatResponsesPcxAA] = l_svmClassify(pcx2HL.esp, odorsRearranged);


p(3,1,1).select()
plot(2, mean(accuracyResponsesCoaAA(:)), 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot(3, mean(accuracyResponsesPcxAA(:)), 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar(2, mean(accuracyResponsesCoaAA(:)), std(accuracyResponsesCoaAA(:)), 'r', 'linewidth', 2); %./sqrt(length(accuracyResponsesCoaAA(:)))
hold on
errbar(3, mean(accuracyResponsesPcxAA(:)), std(accuracyResponsesPcxAA(:)), 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 5])
ylim([0 100]);
set(gca, 'XColor', 'w', 'box','off')
% X = [accuracyResponsesCoaAA(:) accuracyResponsesPcxAA(:)];
% boxplot(X, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5);
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% ylim([0 100]);
% set(gca, 'XColor', 'w', 'box','off')

%% G - Linear classification: avv vs app
% odorsRearranged = [8 11 12 5 2 14 4 10];
% [accuracyResponsesCoaAAaa] = l_svmClassify(coa2HL.esp, odorsRearranged);
% odorsRearranged = [3 8 10 1 13 11 9 14];
% [accuracyResponsesPcxAAaa] = l_svmClassify(pcx2HL.esp, odorsRearranged);

p(3,1,2).select()
plot(2, mean(accuracyResponsesCoaAAaa(:)), 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot(3, mean(accuracyResponsesPcxAAaa(:)), 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar(2, mean(accuracyResponsesCoaAAaa(:)), std(accuracyResponsesCoaAAaa(:)), 'r', 'linewidth', 2); %./sqrt(length(accuracyResponsesCoaAA(:)))
hold on
errbar(3, mean(accuracyResponsesPcxAAaa(:)), std(accuracyResponsesPcxAAaa(:)), 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 5])
ylim([0 100]);
set(gca, 'XColor', 'w', 'box','off')
% X = [accuracyResponsesCoaAAaa(:) accuracyResponsesPcxAAaa(:)];
% boxplot(X, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5);
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end

%% G - Confusion matrices
clims = [0 1];
p(3,2,1).select()
imagesc(conMatResponsesCoaAA, clims); colormap(brewermap([],'*RdBu'));
axis xy, axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(3,2,2).select()
imagesc(conMatResponsesPcxAA, clims); colormap(brewermap([],'*RdBu'));
axis xy, axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

%% H - Population sparseness


labels = {'PB', 'ger', 'btd', '2-PEth', 'IPA', '2-PT', 'MMB', 'TMT'};

odorsRearranged = [8 11 12 5 2 14 4 10];
psCoa = findPopulationSparseness(coa2HL.esp, odorsRearranged);
odorsRearranged = [3 8 10 1 13 11 9 14];
psPcx = findPopulationSparseness(pcx2HL.esp, odorsRearranged);

colorClass = [118,42,131;...
    27,120,55]./255;

p(4,1).select()
h1 = area(1:4, psCoa(1:4));
h1.EdgeColor = colorClass(1,:);
h1.FaceColor = colorClass(1,:);
hold on
h2 = area(4:7, psCoa(5:8));
h2.EdgeColor = colorClass(2,:);
h2.FaceColor = colorClass(2,:);
ylim([0.5 0.7])
set(gca, 'XColor', 'w', 'box','off')

p(4,2).select()
h1 = area(1:4, psPcx(1:4));
h1.EdgeColor = colorClass(1,:);
h1.FaceColor = colorClass(1,:);
hold on
h2 = area(4:7, psPcx(5:8));
h2.EdgeColor = colorClass(2,:);
h2.FaceColor = colorClass(2,:);
ylim([0.5 0.7])
set(gca, 'XColor', 'w', 'box','off')


%%
p.select('all');