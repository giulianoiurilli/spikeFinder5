%% Load data

coa = load('coa_AA_2_2.mat');
pcx = load('pcx_AA_2_2.mat');


%% Set figure size/position
figure
set(gcf,'Name', 'Figure 5: Population encoding of innately relevant odors', 'NumberTitle', 'off');
set(gcf,'Position',[230 110 790 870]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%% Set panels
p = panel();
p.pack('v', {28 28 24 20});
p(1).pack('h', {45 45 10});
p(1,1).pack('h', {50 50});
p(1,2).pack('h', {50 50});
p(2).pack('h', {1/3 1/3 1/3});
p(3).pack('h', {47.5 47.5 5});
p(3,1).pack('h', {1/2 1/2});
p(3,2).pack('h', {1/2 1/2});
p(4).pack('h', {1/2 1/2});

% p.select('all');
% p.identify()


%% A, B - Tuning curves
odorsRearranged = [13 7 3 9 1 15];
odorsRearranged = [15 3 1 13 7 6];
odorsRearranged = [1 7 3 15];
%tuningCurvesAACoa = makeTuningCurves(coa.esp, odorsRearranged);
odorsRearranged = [6 14 10 9 7 11];
odorsRearranged = [7 6 10 9];
%tuningCurvesAAPcx = makeTuningCurves(pcx.esp, odorsRearranged);
clims = [0 1];

p(1,1,1).select()
imagesc(tuningCurvesAACoa(:,1:2), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
p(1,1,2).select()
imagesc(tuningCurvesAACoa(:,3:4), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
t1 = p(1,1).title({'plCOA'});
set(t1, 'Color', 'r');

p(1,2,1).select()
imagesc(tuningCurvesAAPcx(:,1:2), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
p(1,2,2).select()
imagesc(tuningCurvesAAPcx(:,3:4), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
t2 = p(1,2).title({'PCX'});
set(t2, 'Color', 'k');

% p(1).ylabel({'Neurons'})


%% C,D - Coding spaces
odorsRearranged = [13 7 3 9 1 15];
odorsRearranged = [15 3 1 13 7 6];
odorsRearranged = [1 7 3 15];
[scoresCoaAA, scoresMeanCoaAA] = findCodingSpace(coa.esp, odorsRearranged);
odorsRearranged = [6 14 10 9 7 11];
odorsRearranged = [7 6 10 9];
[scoresPcxAA, scoresMeanPcxAA] = findCodingSpace(pcx.esp, odorsRearranged);

p(2,1).select()
colorClass = [118,42,131;...
    27,120,55]./255;
symbolOdor = {'o', 's'};
k = 0;
for idxCat = 1:2
    C = colorClass(idxCat,:);
    for idxOdor = 1:2
        mT = symbolOdor{idxOdor};
        scatter3(scoresCoaAA(1 + k*3:3 + k*3, 1), scoresCoaAA(1 + k*3:3 + k*3, 2), scoresCoaAA(1 + k*3:3 + k*3, 3), 100, C, mT, 'filled');
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
t3 = p(2,1).title({'plCOA'});
set(t3, 'Color', 'r');

p(2,2).select()
colorClass = [118,42,131;...
    27,120,55]./255;
symbolOdor = {'o', 's', 'p'};
k = 0;
for idxCat = 1:2
    C = colorClass(idxCat,:);
    for idxOdor = 1:2
        mT = symbolOdor{idxOdor};
        scatter3(scoresPcxAA(1 + k*3:3 + k*3, 1), scoresPcxAA(1 + k*3:3 + k*3, 2), scoresPcxAA(1 + k*3:3 + k*3, 3),100, C, mT, 'filled');
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
t4 = p(2,2).title({'PCX'});
set(t4, 'Color', 'k');

%%
p(1,3).select();
set(gca, 'XTick' , []);
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'XColor','w')
%% E - Optimal number of clusters
% clustersN = [1:8, 10 15 20 25 30 35];
odorsRearranged = [13 7 3 9 1 15];
odorsRearranged = [15 3 1 13 7 6];
odorsRearranged = [1 7 3 15];
% [EmeanCoaAA, EstdCoaAA, EmeanShuffledCoaAA, EsemShuffledCoaAA, EmeanDecorrCoaAA, EsemDecorrCoaAA] = findBestNumberOfClusters(coa2HL.esp, odorsRearranged, clustersN);
odorsRearranged = [6 14 10 9 7 11];
odorsRearranged = [7 6 10 9];
% [EmeanPcxAA, EstdPcxAA, EmeanShuffledPcxAA, EsemShuffledPcxAA, EmeanDecorrPcxAA, EsemDecorrPcxAA] = findBestNumberOfClusters(pcx2HL.esp, odorsRearranged, clustersN);

p(2,3).select()
x = 1:14;
%optClusters = [EmeanCoa; EmeanPcx];
%imagesc(optClusters); axis xy; %colormap('hot');
% yTicks  = 1:2; yLabels = {'plCOA', 'PCX'};
xTicks  = [2 4 6 8 10 12 14] ; xLabels = {'2', '4', '6', '8', '15', '25', '35'};
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
xlabel('Number of clusters')
ylabel('Gap value')
ylim([-0.45 0])

%% F - Linear classification
odorsRearranged = [13 7 3 9 1 15];
odorsRearranged = [15 3 1 13 7 6];
odorsRearranged = [1 7 3 15];
[accuracyResponsesCoaAA, accuracyBaselineCoaAA, accuracyShuffledCoaAA, conMatResponsesCoaAA] = l_svmClassify(coa.esp, odorsRearranged);
odorsRearranged = [6 14 10 9 7 11];
odorsRearranged = [7 6 10 9];
[accuracyResponsesPcxAA, accuracyBaselinePcxAA, accuracyShuffledPcxAA, conMatResponsesPcxAA] = l_svmClassify(pcx.esp, odorsRearranged);


p(3,1,1).select()
plot([2 6], [mean(accuracyShuffledCoaAA(:)) mean(accuracyResponsesCoaAA(:))], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([3 7], [mean(accuracyShuffledPcxAA(:)) mean(accuracyResponsesPcxAA(:))], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([2 6], [mean(accuracyShuffledCoaAA(:)) mean(accuracyResponsesCoaAA(:))], [std(accuracyShuffledCoaAA)./sqrt(length(accuracyResponsesCoaAA(:))) std(accuracyResponsesCoaAA(:))./sqrt(length(accuracyResponsesCoaAA(:)))], 'r', 'linewidth', 2); %
hold on
errbar([3 7], [mean(accuracyShuffledPcxAA(:)) mean(accuracyResponsesPcxAA(:))], [std(accuracyShuffledPcxAA)./sqrt(length(accuracyResponsesCoaAA(:))) std(accuracyResponsesPcxAA(:))./sqrt(length(accuracyResponsesPcxAA(:)))], 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 9])
ylim([0 100]);
line([0 9], [100/4 100/4], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')
p(3,1,1).ylabel({'Correct classification (%)'})
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
odorsRearranged = [13 7 3 9 1 15];
odorsRearranged = [15 3 1 13 7 6];
odorsRearranged = [1 7 3 15];
[accuracyResponsesCoaAAaa, accuracyBaselineCoaAAaa, accuracyShuffledCoaAA] = l_svmClassify(coa.esp, odorsRearranged);
odorsRearranged = [6 14 10 9 7 11];
odorsRearranged = [7 6 10 9];
[accuracyResponsesPcxAAaa, accuracyBaselinePcxAAaa, accuracyShuffledPcxAA] = l_svmClassify(pcx.esp, odorsRearranged);

p(3,1,2).select()
plot([2 6], [mean(accuracyShuffledCoaAA(:)) mean(accuracyResponsesCoaAAaa(:))], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([3 7], [mean(accuracyShuffledPcxAA(:)) mean(accuracyResponsesPcxAAaa(:))], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([2 6], [mean(accuracyShuffledCoaAA(:)) mean(accuracyResponsesCoaAAaa(:))], [std(accuracyShuffledCoaAA(:))./sqrt(length(accuracyResponsesCoaAAaa(:))) std(accuracyResponsesCoaAAaa(:))./sqrt(length(accuracyResponsesCoaAAaa(:)))], 'r', 'linewidth', 2); 
hold on
errbar([3 7], [mean(accuracyShuffledPcxAA(:)) mean(accuracyResponsesPcxAAaa(:))], [std(accuracyShuffledPcxAA(:))./sqrt(length(accuracyResponsesPcxAAaa(:))) std(accuracyResponsesPcxAAaa(:))./sqrt(length(accuracyResponsesPcxAAaa(:)))], 'k', 'linewidth', 2); 
xlim([0 9])
ylim([30 100]);
line([0 9], [50 50], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')
p(3,1,2).ylabel({'Correct classification (%)'})
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
t5 = p(3,2,1).title({'plCOA'});
set(t5, 'Color', 'r');
p(3,2,2).select()
imagesc(conMatResponsesPcxAA, clims); colormap(brewermap([],'*RdBu'));
axis xy, axis square
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
t6 = p(3,2,2).title({'PCX'});
set(t6, 'Color', 'k');

%%
p(3,3).select();
set(gca, 'XTick' , []);
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'XColor','w')

%% H - Population sparseness


labels = {'PB', 'ger', 'btd', '2-PEth', 'IPA', '2-PT', 'MMB', 'TMT'};

odorsRearranged = [13 7 3 9 1 15];
odorsRearranged = [15 3 1 13 7 6];
odorsRearranged = [1 7 3 15];
psCoa = findPopulationSparseness(coa.esp, odorsRearranged);
odorsRearranged = [6 14 10 9 7 11];
odorsRearranged = [7 6 10 9];
psPcx = findPopulationSparseness(pcx.esp, odorsRearranged);


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
set(gca, 'YColor', 'w', 'box','off')
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

% p(4).ylabel({'Population sparseness'});

%%
p.select('all');
p.de.margin = 2;
p(1).marginbottom = 40;
p(1,1).marginright = 20;
p(2).marginbottom = 40;
p(3).marginbottom = 30;
p(2,1).marginright = 20;
p(2,2).marginright = 30;
p(3,1).marginright = 30;
p(3,1,1).marginright = 20;
p(3,1).marginright = 20;
p.margin = [20 15 10 10];
p.fontsize = 12;
p.fontname = 'Avenir';


%%
p.select('all');