tuningCurvesPC15 =  makeTuningCurves(pcx15.esp, 1:15);
tuningCurvesCOA15 =  makeTuningCurves(coa15.esp, 1:15);

tuningCurvesPCaa =  makeTuningCurves(pcxAA.esp, 1:10);
tuningCurvesCOAaa =  makeTuningCurves(coaAA.esp, 1:10);

%%
figure;
A = [];
A = 1-pdist(tuningCurvesPC15);
A = squareform(A);
clims = [-1 1];
imagesc(A, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

figure;
B = [];
B = 1-pdist(tuningCurvesCOA15);
B = squareform(B);
imagesc(B, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

figure;
C = [];
C = 1-pdist(tuningCurvesPCaa);
C = squareform(C);
imagesc(C, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

figure;
D = [];
D = 1-pdist(tuningCurvesCOAaa);
D = squareform(D);
imagesc(D, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

%%
tuningCurvesPC15_ = [];
tuningCurvesPC15_ = [tuningCurvesPC15 Aclust(:,1)];
tuningCurvesPC15_ = sortrows(tuningCurvesPC15_, size(tuningCurvesPC15_,2));
tuningCurvesPC15_(:,size(tuningCurvesPC15_,2)) = [];
figure;
B = [];
B = 1-pdist(tuningCurvesPC15_);
B = squareform(B);
imagesc(B, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

tuningCurvesCOA15_ = [];
tuningCurvesCOA15_ = [tuningCurvesCOA15 Bclust(:,1)];
tuningCurvesCOA15_ = sortrows(tuningCurvesCOA15_, size(tuningCurvesCOA15_,2));
tuningCurvesCOA15_(:,size(tuningCurvesCOA15_,2)) = [];
figure;
B = [];
B = 1-pdist(tuningCurvesCOA15_);
B = squareform(B);
imagesc(B, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

tuningCurvesPCaa_ = [];
tuningCurvesPCaa_ = [tuningCurvesPCaa Cclust(:,1)];
tuningCurvesPCaa_ = sortrows(tuningCurvesPCaa_, size(tuningCurvesPCaa_,2));
tuningCurvesPCaa_(:,size(tuningCurvesPCaa_,2)) = [];
figure;
B = [];
B = 1-pdist(tuningCurvesPCaa_);
B = squareform(B);
imagesc(B, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

tuningCurvesCOAaa_ = [];
tuningCurvesCOAaa_ = [tuningCurvesCOAaa Dclust(:,1)];
tuningCurvesCOAaa_ = sortrows(tuningCurvesCOAaa_, size(tuningCurvesCOAaa_,2));
tuningCurvesCOAaa_(:,size(tuningCurvesCOAaa_,2)) = [];
figure;
B = [];
B = 1-pdist(tuningCurvesCOAaa_);
B = squareform(B);
imagesc(B, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
%%
A = [];
A = 1-pdist(tuningCurvesPC15);
B = [];
B = 1-pdist(tuningCurvesCOA15);
C = [];
C = 1-pdist(tuningCurvesPCaa);
D = [];
D = 1-pdist(tuningCurvesCOAaa);


figure;
plot([2 6], [mean(B(:)) mean(D(:))], 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([3 7], [mean(A(:)) mean(C(:))], 'ko', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2 6], [mean(B(:)) mean(D(:))], [std(B(:))./sqrt(length(B(:))) std(D(:))./sqrt(length(D(:)))], 'r', 'linewidth', 2); %
hold on
errbar([3 7], [mean(A(:)) mean(C(:))], [std(A(:))./sqrt(length(A(:))) std(C(:))./sqrt(length(C(:)))], 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 13])
%ylim([50 100]);
%line([0 9], [100/8 100/8], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
odorsRearranged = 1:10;
[scoresCoaAA, scoresMeanCoaAA, explainedMeanCoaAA, explaineStdCoaAA] = findCodingSpace(coaAA.esp, odorsRearranged);
[scoresPcxAA, scoresMeanPcxAA, explainedMeanPcxAA, explaineStdPcxAA] = findCodingSpace(pcxAA.esp, odorsRearranged);

figure
colorClass = [118,42,131;...
    27,120,55]./255;
symbolOdor = {'o', 's', 'p', 'd', 'h'};
k = 0;
for idxCat = 1:2
    C = colorClass(idxCat,:);
    for idxOdor = 1:5
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
title('plCOA')


figure
colorClass = [118,42,131;...
    27,120,55]./255;
symbolOdor = {'o', 's', 'p', 'd', 'h'};
k = 0;
for idxCat = 1:2
    C = colorClass(idxCat,:);
    for idxOdor = 1:5
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
title('PCX');

figure;
shadedErrorBar(1:size(explainedMeanCoaAA,1), explainedMeanCoaAA', explaineStdCoaAA', 'r');
hold on
shadedErrorBar(1:size(explainedMeanPcxAA,1), explainedMeanPcxAA', explaineStdPcxAA', 'k');
title('innate')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
odorsRearranged = 1:15;
[scoresCoa, scoresMeanCoa, explainedMeanCoa, explaineStdCoa] = findCodingSpace(coa15.esp, odorsRearranged);
[scoresPcx, scoresMeanPcx, explainedMeanPcx, explaineStdPcx] = findCodingSpace(pcx15.esp, odorsRearranged);

figure
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
title('plCOA');



figure
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
title('PCX');
figure;
shadedErrorBar(1:size(explainedMeanCoa,1), explainedMeanCoa', explaineStdCoa', 'r');
hold on
shadedErrorBar(1:size(explainedMeanPcx,1), explainedMeanPcx', explaineStdPcx', 'k');
title('15 odors')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
[distOdorsCoa, distOdorsDecorrCoa] = findOdorDistances(coa15.esp, odorsRearranged);
[distOdorsPcx, distOdorsDecorrPcx] = findOdorDistances(pcx15.esp, odorsRearranged);
figure
[xHistCoa15, yHistCoa15, handles] = distributionPlot(distOdorsCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15, yHistPcx15, handles] = distributionPlot(distOdorsPcx(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistCoa15d, yHistCoa15d, handles] = distributionPlot(distOdorsDecorrCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15d, yHistPcx15d, handles] = distributionPlot(distOdorsDecorrPcx(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
figure
plot(yHistCoa15, xHistCoa15, 'linewidth', 2,'color', coaC)
hold on
plot(yHistPcx15, xHistPcx15, 'linewidth', 2,'color', pcxC)
hold on
plot(yHistCoa15d, xHistCoa15d, ':', 'linewidth', 2,'color', coaC)
hold on
plot(yHistPcx15d, xHistPcx15d, ':', 'linewidth', 2,'color', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
title('15 odors')






[distOdorsCoaAA, distOdorsDecorrCoaAA] = findOdorDistances(coaAA.esp, odorsRearranged);
[distOdorsPcxAA, distOdorsDecorrPcxAA] = findOdorDistances(pcxAA.esp, odorsRearranged);
figure
[xHistCoaAA, yHistCoaAA, handles] = distributionPlot(distOdorsCoaAA(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcxAA, yHistPcxAA, handles] = distributionPlot(distOdorsPcxAA(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistCoaAAd, yHistCoaAAd, handles] = distributionPlot(distOdorsDecorrCoaAA(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcxAAd, yHistPcxAAd, handles] = distributionPlot(distOdorsDecorrPcxAA(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');

figure
plot(yHistCoaAA, xHistCoaAA, 'linewidth', 2,'color', coaC)
hold on
plot(yHistPcxAA, xHistPcxAA, 'linewidth', 2,'color', pcxC)
hold on
plot(yHistCoaAAd, xHistCoaAAd, ':', 'linewidth', 2,'color', coaC)
hold on
plot(yHistPcxAAd, xHistPcxAAd, ':', 'linewidth', 2,'color', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
title('valence')

%%
odorsRearranged = 1:15;
[noiseCorrW1000msCoa15, noiseCorrB1000msCoa15] = findNoiseCorrelation(coa15.esp, odorsRearranged);
[noiseCorrW1000msPcx15, noiseCorrB1000msPcx15] = findNoiseCorrelation(pcx15.esp, odorsRearranged);
odorsRearranged = 1:10;
[noiseCorrW1000msCoaAA, noiseCorrB1000msCoaAA] = findNoiseCorrelation(coaAA.esp, odorsRearranged);
[noiseCorrW1000msPcxAA, noiseCorrB1000msPcxAA] = findNoiseCorrelation(pcxAA.esp, odorsRearranged);

B = [noiseCorrW1000msCoa15, noiseCorrB1000msCoa15]; 
A = [noiseCorrW1000msPcx15, noiseCorrB1000msPcx15];
D = [noiseCorrW1000msCoaAA, noiseCorrB1000msCoaAA];
C = [noiseCorrW1000msPcxAA, noiseCorrB1000msPcxAA];

figure;
plot([2 6], [mean(B(:)) mean(D(:))], 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([3 7], [mean(A(:)) mean(C(:))], 'ko', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2 6], [mean(B(:)) mean(D(:))], [std(B(:))./sqrt(length(B(:))) std(D(:))./sqrt(length(D(:)))], 'r', 'linewidth', 2); %
hold on
errbar([3 7], [mean(A(:)) mean(C(:))], [std(A(:))./sqrt(length(A(:))) std(C(:))./sqrt(length(C(:)))], 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 13])
%ylim([50 100]);
%line([0 9], [100/8 100/8], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)