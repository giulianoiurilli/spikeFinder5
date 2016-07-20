[tuningCurvesPC15, tuningCurvesPC15Sig, rhoPcx15,  rhoPcx15Sig] =  makeTuningCurves(pcx15.esp, 1:15);
[tuningCurvesCOA15, tuningCurvesCoa15Sig, rhoCoa15,  rhoCoa15Sig] =  makeTuningCurves(coa15.esp, 1:15);
%%
figure
histogram(rhoPcx15,200)
hold on
histogram(rhoCoa15,200)


%%
tuningCurvesPCaa =  makeTuningCurves(pcxAA.esp, 1:10);
tuningCurvesCOAaa =  makeTuningCurves(coaAA.esp, 1:10);

%%
figure;
A = [];
A = 1-pdist(tuningCurvesPC15, 'correlation');
A = squareform(A);
clims = [-1 1];
imagesc(A, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

figure;
B = [];
B = 1-pdist(tuningCurvesCOA15, 'correlation');
B = squareform(B);
imagesc(B, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

figure;
C = [];
C = 1-pdist(tuningCurvesPCaa, 'correlation');
C = squareform(C);
imagesc(C, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

figure;
D = [];
D = 1-pdist(tuningCurvesCOAaa, 'correlation');
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
A1 = [];
A1 = 1-pdist(tuningCurvesPC15, 'correlation');
B1 = [];
B1 = 1-pdist(tuningCurvesCOA15, 'correlation');
C = [];
C = 1-pdist(tuningCurvesPCaa, 'correlation');
D = [];
D = 1-pdist(tuningCurvesCOAaa, 'correlation');


figure;
plot([2 6], [mean(B1(:)) mean(D(:))], 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([3 7], [mean(A1(:)) mean(C(:))], 'ko', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2 6], [mean(B1(:)) mean(D(:))], [std(B1(:))./sqrt(length(B1(:))) std(D(:))./sqrt(length(D(:)))], 'r', 'linewidth', 2); %
hold on
errbar([3 7], [mean(A1(:)) mean(C(:))], [std(A1(:))./sqrt(length(A1(:))) std(C(:))./sqrt(length(C(:)))], 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 13])
%ylim([50 100]);
%line([0 9], [100/8 100/8], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

figure;
b = bar([mean(B(:)) mean(A(:)); 0 0]);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
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
[distOdorsCoa, distOdorsDecorrCoa, distOdorsBslCoa, DsigCoa, DbsigCoa] = findOdorDistances(coa15.esp, odorsRearranged);
[distOdorsPcx, distOdorsDecorrPcx, distOdorsBslPcx, DsigPcx, DbsigPcx] = findOdorDistances(pcx15.esp, odorsRearranged);
figure
[xHistCoa15, yHistCoa15, handles] = distributionPlot(distOdorsCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15, yHistPcx15, handles] = distributionPlot(distOdorsPcx(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistCoa15d, yHistCoa15d, handles] = distributionPlot(distOdorsDecorrCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15d, yHistPcx15d, handles] = distributionPlot(distOdorsDecorrPcx(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistCoa15Bsl, yHistCoa15Bsl, handles] = distributionPlot(distOdorsBslCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15Bsl, yHistPcx15Bsl, handles] = distributionPlot(distOdorsBslPcx(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistCoa15Sig, yHistCoa15Sig, handles] = distributionPlot(DsigCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15Sig, yHistPcx15Sig, handles] = distributionPlot(DsigPcx(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistCoa15BslSig, yHistCoa15BslSig, handles] = distributionPlot(DbsigCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15BslSig, yHistPcx15BslSig, handles] = distributionPlot(DbsigPcx(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');

mean(distOdorsCoa(:))
mean(distOdorsPcx(:))
[h,p] = ttest2(distOdorsCoa(:), distOdorsPcx(:))

mean(DsigCoa(:))
mean(DsigPcx(:))
[h,p] = ttest2(DsigCoa(:), DsigPcx(:))

mean(distOdorsDecorrCoa(:))
mean(distOdorsDecorrPcx(:))


figure
plot(yHistCoa15, xHistCoa15, ':', 'linewidth', 2,'color', coaC)
hold on
plot(yHistPcx15, xHistPcx15, ':', 'linewidth', 2,'color', pcxC)
% hold on
% plot(yHistCoa15d, xHistCoa15d, ':', 'linewidth', 2,'color', coaC)
% hold on
% plot(yHistPcx15d, xHistPcx15d, ':', 'linewidth', 2,'color', pcxC)
hold on
% plot(yHistCoa15Bsl, xHistCoa15Bsl, ':', 'linewidth', 2,'color', coaC)
% hold on
% plot(yHistPcx15Bsl, xHistPcx15Bsl, ':', 'linewidth', 2,'color', pcxC)
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
% title('15 odors')

% figure
plot(yHistCoa15Sig, xHistCoa15Sig, 'linewidth', 2,'color', coaC)
hold on
plot(yHistPcx15Sig, xHistPcx15Sig, 'linewidth', 2,'color', pcxC)
% hold on
% plot(yHistCoa15d, xHistCoa15d, ':', 'linewidth', 2,'color', coaC)
% hold on
% plot(yHistPcx15d, xHistPcx15d, ':', 'linewidth', 2,'color', pcxC)
% hold on
% plot(yHistCoa15BslSig, xHistCoa15BslSig, ':', 'linewidth', 2,'color', coaC)
% hold on
% plot(yHistPcx15BslSig, xHistPcx15BslSig, ':', 'linewidth', 2,'color', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
title('15 odors')






% figure; histogram(distOdorsCoa, 'normalization', 'probability')
% xlim([-1 1])
% figure; histogram(distOdorsPcx, 'normalization', 'probability')
% xlim([-1 1])
% 
% 
% 
% 
% [distOdorsCoaAA, distOdorsDecorrCoaAA] = findOdorDistances(coaAA.esp, odorsRearranged);
% [distOdorsPcxAA, distOdorsDecorrPcxAA] = findOdorDistances(pcxAA.esp, odorsRearranged);
% figure
% [xHistCoaAA, yHistCoaAA, handles] = distributionPlot(distOdorsCoaAA(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
% [xHistPcxAA, yHistPcxAA, handles] = distributionPlot(distOdorsPcxAA(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
% [xHistCoaAAd, yHistCoaAAd, handles] = distributionPlot(distOdorsDecorrCoaAA(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
% [xHistPcxAAd, yHistPcxAAd, handles] = distributionPlot(distOdorsDecorrPcxAA(:),'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
% 
% figure
% plot(yHistCoaAA, xHistCoaAA, 'linewidth', 2,'color', coaC)
% hold on
% plot(yHistPcxAA, xHistPcxAA, 'linewidth', 2,'color', pcxC)
% hold on
% plot(yHistCoaAAd, xHistCoaAAd, ':', 'linewidth', 2,'color', coaC)
% hold on
% plot(yHistPcxAAd, xHistPcxAAd, ':', 'linewidth', 2,'color', pcxC)
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
% title('valence')



%%
odorsRearranged = 1:15;
[noiseCorrW1000msCoa15, noiseCorrB1000msCoa15, noiseCorrW1000msCoa15Sig, noiseCorrB1000msCoa15Sig] = findNoiseCorrelation(coa15.esp, odorsRearranged);
[noiseCorrW1000msPcx15, noiseCorrB1000msPcx15, noiseCorrW1000msPcx15Sig, noiseCorrB1000msPcx15Sig] = findNoiseCorrelation(pcx15.esp, odorsRearranged);
odorsRearranged = 1:10;
[noiseCorrW1000msCoaAA, noiseCorrB1000msCoaAA] = findNoiseCorrelation(coaAA.esp, odorsRearranged);
[noiseCorrW1000msPcxAA, noiseCorrB1000msPcxAA] = findNoiseCorrelation(pcxAA.esp, odorsRearranged);

B = [noiseCorrW1000msCoa15, noiseCorrB1000msCoa15]; 
A = [noiseCorrW1000msPcx15, noiseCorrB1000msPcx15];
BSig = [noiseCorrW1000msCoa15Sig, noiseCorrB1000msCoa15Sig]; 
ASig = [noiseCorrW1000msPcx15Sig, noiseCorrB1000msPcx15Sig];
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

%%
clims = [-1 1];
odorsRearranged = 1:15;
[sigCorrCoa15, corrMatCoa15, sigCorrCoa15Sig, corrMatCoa15Sig] = findSignalCorrelation(coa15.esp, odorsRearranged);
[sigCorrPcx15, corrMatPcx15, sigCorrPcx15Sig, corrMatPcx15Sig] = findSignalCorrelation(pcx15.esp, odorsRearranged);
figure
imagesc(corrMatCoa15, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
figure
imagesc(corrMatPcx15, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

figure;
plot([2 6], [mean(sigCorrCoa15(:)) mean(B(:))], 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([3 7], [mean(sigCorrPcx15) mean(A(:))], 'ko', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2 6], [mean(sigCorrCoa15(:)) mean(B(:))], [std(sigCorrCoa15(:))./sqrt(length(sigCorrCoa15(:))) std(B(:))./sqrt(length(B(:)))], 'r', 'linewidth', 2); %
hold on
errbar([3 7], [mean(sigCorrPcx15) mean(A(:))], [std(sigCorrPcx15)./sqrt(length(sigCorrPcx15)) std(A(:))./sqrt(length(A(:)))], 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 13])
%ylim([50 100]);
%line([0 9], [100/8 100/8], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
figure;
plot([2 8], [mean(sigCorrCoa15(:)) mean(B(:))], 's', 'markersize', 10, 'markeredgecolor', coaC)
hold on
plot([4 10], [mean(sigCorrPcx15(:)) mean(A(:))], 's', 'markersize', 10, 'markeredgecolor', pcxC)
hold on
errbar([2 8], [mean(sigCorrCoa15(:)) mean(B(:))], [std(sigCorrCoa15(:))./sqrt(length(sigCorrCoa15(:))) std(B(:))./sqrt(length(B(:)))], 'color', coaC, 'linewidth', 1); %
hold on
errbar([4 10], [mean(sigCorrPcx15(:)) mean(A(:))], [std(sigCorrPcx15)./sqrt(length(sigCorrPcx15)) std(A(:))./sqrt(length(A(:)))], 'color', pcxC, 'linewidth', 1); %./sqrt(length(accuracyResponsesPcxAA(:)))


hold on;
plot([2.5 8.5], [mean(sigCorrCoa15Sig(:)) mean(BSig(:))], 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([4.5 10.5], [mean(sigCorrPcx15Sig(:)) mean(ASig(:))], 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2.5 8.5], [mean(sigCorrCoa15Sig(:)) mean(BSig(:))], [std(sigCorrCoa15Sig(:))./sqrt(length(sigCorrCoa15Sig(:))) std(BSig(:))./sqrt(length(BSig(:)))], 'color', coaC, 'linewidth', 1); %
hold on
errbar([4.5 10.5], [mean(sigCorrPcx15Sig(:)) mean(ASig(:))], [std(sigCorrPcx15Sig)./sqrt(length(sigCorrPcx15Sig)) std(ASig(:))./sqrt(length(ASig(:)))], 'color', pcxC, 'linewidth', 1);

xlim([0 13])
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
[h,p] = ttest2(sigCorrCoa15(:), sigCorrPcx15(:))
mean(sigCorrCoa15(:))
mean(sigCorrPcx15(:))

[h,p] = ttest2(sigCorrCoa15Sig(:), sigCorrPcx15Sig(:))
mean(sigCorrCoa15Sig(:))
mean(sigCorrPcx15Sig(:))

[h,p] = ttest2(B(:), A(:))
mean(B(:))
mean(A(:))

[h,p] = ttest2(BSig(:), ASig(:))
mean(BSig(:))
mean(ASig(:))
%%
B1 = rhoCoa15;
A1 = rhoPcx15;
figure;
plot([2 6], [mean(B1(:)) mean(B(:))], 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([3 7], [mean(A1) mean(A(:))], 'ko', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2 6], [mean(B1(:)) mean(B(:))], [std(B1(:))./sqrt(length(B1(:))) std(B(:))./sqrt(length(B(:)))], 'r', 'linewidth', 2); %
hold on
errbar([3 7], [mean(A1) mean(A(:))], [std(A1)./sqrt(length(A1)) std(A(:))./sqrt(length(A(:)))], 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 13])
%ylim([50 100]);
%line([0 9], [100/8 100/8], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)