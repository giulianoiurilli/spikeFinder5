odors = 1:15;
selectivityCoa15 = selectivityIndexes(coa15.esp, odors);
selectivityCoaAA = selectivityIndexes(coaAA.esp, odors);
selectivityPcx15 = selectivityIndexes(pcx15.esp, odors);
selectivityPcxAA = selectivityIndexes(pcxAA.esp, odors);

%%
ls300Coa = [selectivityCoa15.ls300;selectivityCoaAA.ls300];
ls300Pcx = [selectivityPcx15.ls300;selectivityPcxAA.ls300];
info300Coa = [selectivityCoa15.info300;selectivityCoaAA.info300];
info300Pcx = [selectivityPcx15.info300;selectivityPcxAA.info300];
R300Coa  = [selectivityCoa15.LI300';selectivityCoaAA.LI300'];
R300Pcx  = [selectivityPcx15.LI300';selectivityPcxAA.LI300'];

cellLogCoa300 = zeros(size(selectivityCoa15.cellLog300,1) + size(selectivityCoaAA.cellLog300,1),4);
cellLogCoa300(1:size(selectivityCoa15.cellLog300,1),:) = 1;
cellLogCoa300(size(selectivityCoa15.cellLog300,1)+1 : end,:) = 1;
cellLogCoa300(:,2:4) = [selectivityCoa15.cellLog300;selectivityCoaAA.cellLog300];

cellLogPcx300 = nan(size(selectivityPcx15.cellLog300,1) + size(selectivityPcxAA.cellLog300,1),4);
cellLogPcx300(1:size(selectivityPcxAA.cellLog300,1),:) = 1;
cellLogPcx300(:,2:4) = [selectivityPcx15.cellLog300;selectivityPcxAA.cellLog300];



xMargin = 0.05 * range([ls300Coa(:); ls300Pcx(:)]);
bottomMargin = 0;
topMargin = 0.001;
leftX = min([ls300Coa(:); ls300Pcx(:)]);
rightX = max([ls300Coa(:); ls300Pcx(:)]);
blankFigure([leftX-xMargin rightX+xMargin 0-bottomMargin 0.2+topMargin]);
distributionPlot(ls300Coa(:),'histOri','right','color',coaC,'widthDiv',[2 2],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(ls300Pcx(:),'histOri','left','color',pcxC,'widthDiv',[2 1],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
clear axP
start = floor(leftX-xMargin);
fin = ceil(rightX+xMargin);
axP.lineThickness = 2;
axP.axisLabel = 'Lifetime Sparseness - first sniff';
axP.axisOrientation = 'h';
axP.tickLocations = [floor(leftX) 0 ceil(rightX)];
axP.tickLabels = {num2str(floor(leftX)), num2str(0), num2str(ceil(rightX))};
axP.axisOffset = 0.4;
axP.fontSize = 12; 
axP.color = labelC; 
AxisMMC(start, fin, axP);

figure
plot(R300Coa, ls300Coa, 'ok', 'markersize', 8)
axis square

figure
plot(R300Coa, info300Coa, 'ok', 'markersize', 8)
axis square

figure
plot(ls300Coa, info300Coa, 'ok', 'markersize', 8)
axis square

%%
ls1000Coa = [selectivityCoa15.ls1000;selectivityCoaAA.ls1000];
ls1000Pcx = [selectivityPcx15.ls1000;selectivityPcxAA.ls1000];
info1000Coa = [selectivityCoa15.info1000;selectivityCoaAA.info1000];
info1000Pcx = [selectivityPcx15.info1000;selectivityPcxAA.info1000];
R1000Coa  = [selectivityCoa15.LI1000';selectivityCoaAA.LI1000'];
R1000Pcx  = [selectivityPcx15.LI1000';selectivityPcxAA.LI1000'];

cellLogCoa1000 = zeros(size(selectivityCoa15.cellLog1000,1) + size(selectivityCoaAA.cellLog1000,1),4);
cellLogCoa1000(1:size(selectivityCoa15.cellLog1000,1),:) = 1;
cellLogCoa1000(size(selectivityCoa15.cellLog1000,1)+1 : end,:) = 2;
cellLogCoa1000(:,2:4) = [selectivityCoa15.cellLog1000;selectivityCoaAA.cellLog1000];

cellLogPcx1000 = nan(size(selectivityPcx15.cellLog1000,1) + size(selectivityPcxAA.cellLog1000,1),4);
cellLogPcx1000(1:size(selectivityPcxAA.cellLog1000,1),:) = 1;
cellLogPcx1000(:,2:4) = [selectivityPcx15.cellLog1000;selectivityPcxAA.cellLog1000];

ls1000Coa(R1000Coa == 0) = [];
info1000Coa(R1000Coa == 0) = [];
cellLogCoa1000(R1000Coa == 0,:) = [];
R1000Coa(R1000Coa == 0) = [];



xMargin = 0.05 * range([ls1000Coa(:); ls1000Pcx(:)]);
bottomMargin = 0;
topMargin = 0.001;
leftX = min([ls1000Coa(:); ls1000Pcx(:)]);
rightX = max([ls1000Coa(:); ls1000Pcx(:)]);
blankFigure([leftX-xMargin rightX+xMargin 0-bottomMargin 0.2+topMargin]);
distributionPlot(ls1000Coa(:),'histOri','right','color',coaC,'widthDiv',[2 2],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(ls1000Pcx(:),'histOri','left','color',pcxC,'widthDiv',[2 1],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
clear axP
start = floor(leftX-xMargin);
fin = ceil(rightX+xMargin);
axP.lineThickness = 2;
axP.axisLabel = 'Lifetime Sparseness - first second';
axP.axisOrientation = 'h';
axP.tickLocations = [floor(leftX) 0 ceil(rightX)];
axP.tickLabels = {num2str(floor(leftX)), num2str(0), num2str(ceil(rightX))};
axP.axisOffset = 0.4;
axP.fontSize = 12; 
axP.color = labelC; 
AxisMMC(start, fin, axP);

%%
xMargin = 0.05*range(R1000Coa);
yMargin = 0.05*range(R1000Coa);
bottomMargin = 0.05*range(ls1000Coa);
topMargin = 0.05*range(ls1000Coa);
leftX = min(R1000Coa);
rightX = max(R1000Coa);
bottomY = 0;
topY = 1;
blankFigure([leftX-10*yMargin rightX+10*xMargin bottomY-10*bottomMargin topY+10*topMargin]);
%hold on
plot(R1000Coa, ls1000Coa, 'ok', 'markersize', 8, 'markerfacecolor', [115,115,115]./255, 'markeredgecolor', [115,115,115]./255)
plot(R1000Coa(129), ls1000Coa(129), 'ok', 'markersize', 10, 'markerfacecolor', [215,48,39]./255, 'markeredgecolor', [215,48,39]./255)
plot(R1000Coa(116), ls1000Coa(116), 'ok', 'markersize', 10, 'markerfacecolor', [26,152,80]./255, 'markeredgecolor', [26,152,80]./255)
clear axX
start = leftX-xMargin;
fin = rightX+xMargin;
axX.lineThickness = 2;
axX.axisLabel = 'Number of activating odors';
axX.axisOrientation = 'h';
axX.tickLocations = [floor(leftX) ceil(rightX)];
axX.tickLabels = {num2str(floor(leftX)) num2str(ceil(rightX))};
axX.axisOffset = bottomY-bottomMargin;
axX.fontSize = 14; 
axX.color = labelC; 
AxisMMC(start, fin, axX);
clear axY
start = bottomY-0.01;
fin = topY+0.01;
axY.lineThickness = 2;
axY.axisLabel = 'Lifetime Sparseness';
axY.axisOrientation = 'v';
axY.tickLocations = [floor(bottomY) ceil(topY)];
axY.tickLabels = {num2str(floor(bottomY)) num2str(ceil(topY))};
axY.axisOffset = floor(leftX-xMargin);
axY.fontSize = 14; 
axY.color = labelC; 
AxisMMC(start, fin, axY);


xMargin = 0.05*range(R1000Coa);
yMargin = 0.05*range(R1000Coa);
bottomMargin = 0.05*range(info1000Coa);
topMargin = 0.05*range(info1000Coa);
leftX = min(R1000Coa);
rightX = max(R1000Coa);
bottomY = min(info1000Coa);
topY = max(info1000Coa);
blankFigure([leftX-10*yMargin rightX+10*xMargin bottomY-10*bottomMargin topY+10*topMargin]);
hold on
plot(R1000Coa, info1000Coa, 'ok', 'markersize', 8, 'markerfacecolor', [115,115,115]./255, 'markeredgecolor', [115,115,115]./255)
plot(R1000Coa(129), info1000Coa(129), 'ok', 'markersize', 10, 'markerfacecolor', [215,48,39]./255, 'markeredgecolor', [215,48,39]./255)
plot(R1000Coa(116), info1000Coa(116), 'ok', 'markersize', 10, 'markerfacecolor', [26,152,80]./255, 'markeredgecolor', [26,152,80]./255)
clear axX
start = leftX-xMargin;
fin = rightX+xMargin;
axX.lineThickness = 2;
axX.axisLabel = 'Number of activating odors';
axX.axisOrientation = 'h';
axX.tickLocations = [floor(leftX) ceil(rightX)];
axX.tickLabels = {num2str(floor(leftX)) num2str(ceil(rightX))};
axX.axisOffset = bottomY-bottomMargin;
axX.fontSize = 14; 
axX.color = labelC; 
AxisMMC(start, fin, axX);
clear axY
start = bottomY-0.01;
fin = topY+0.01;
axY.lineThickness = 2;
axY.axisLabel = 'Odor Predictability (bits)';
axY.axisOrientation = 'v';
axY.tickLocations = [floor(bottomY) ceil(topY)];
axY.tickLabels = {num2str(floor(bottomY)) num2str(ceil(topY))};
axY.axisOffset = leftX-xMargin;
axY.fontSize = 14; 
axY.color = labelC; 
AxisMMC(start, fin, axY);

xMargin = 0.05*range(ls1000Coa);
yMargin = 0.05*range(ls1000Coa);
bottomMargin = 0.05*range(info1000Coa);
topMargin = 0.05*range(info1000Coa);
leftX = floor(min(ls1000Coa));
rightX = ceil(max(ls1000Coa));
bottomY = min(info1000Coa);
topY = max(info1000Coa);
blankFigure([leftX-10*yMargin rightX+10*xMargin bottomY-10*bottomMargin topY+10*topMargin]);
hold on
plot(ls1000Coa, info1000Coa, 'ok', 'markersize', 8, 'markerfacecolor', [115,115,115]./255, 'markeredgecolor', [115,115,115]./255)
plot(ls1000Coa(129), info1000Coa(129), 'ok', 'markersize', 10, 'markerfacecolor', [215,48,39]./255, 'markeredgecolor', [215,48,39]./255)
plot(ls1000Coa(116), info1000Coa(116), 'ok', 'markersize', 10, 'markerfacecolor', [26,152,80]./255, 'markeredgecolor', [26,152,80]./255)
clear axX
start = leftX-xMargin;
fin = rightX+xMargin;
axX.lineThickness = 2;
axX.axisLabel = 'Lifetime Sparseness';
axX.axisOrientation = 'h';
axX.tickLocations = [floor(leftX) ceil(rightX)];
axX.tickLabels = {num2str(floor(leftX)) num2str(ceil(rightX))};
axX.axisOffset = bottomY-bottomMargin;
axX.fontSize = 14; 
axX.color = labelC; 
AxisMMC(start, fin, axX);
clear axY
start = bottomY-0.01;
fin = topY+0.01;
axY.lineThickness = 2;
axY.axisLabel = 'Odor Predictability (bits)';
axY.axisOrientation = 'v';
axY.tickLocations = [floor(bottomY) ceil(topY)];
axY.tickLabels = {num2str(floor(bottomY)) num2str(ceil(topY))};
axY.axisOffset = leftX-xMargin;
axY.fontSize = 14; 
axY.color = labelC; 
AxisMMC(start, fin, axY);
%%
N = histcounts([selectivityPcx15.numberExcNeurons300; selectivityPcxAA.numberExcNeurons300],0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts([selectivityCoa15.numberExcNeurons300; selectivityCoaAA.numberExcNeurons300],0:16); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));


xMargin = 0.05*range(0:15);
yMargin = 0.05*range(PPcx);
bottomMargin = 0.05*range(PPcx);
topMargin = 0.05*range(PPcx);
leftX = 0;
rightX = 15;
bottomY = 0;
topY = 0.6;
blankFigure([leftX-50*yMargin rightX+10*xMargin bottomY-10*bottomMargin topY+10*topMargin]);
errorbar(0:15, PCoa, SEMPCoa, 'o', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8, 'color', coaC)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'o', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8, 'color', pcxC)
% xlim([-1 16.3]);
% ylim([-0.03 0.8])
% set(gca,'box','off')
clear axX
start = leftX-xMargin;
fin = rightX+xMargin;
axX.lineThickness = 2;
axX.axisLabel = 'Number Of Excitatory Odors - first sniff';
axX.axisOrientation = 'h';
axX.tickLocations = [floor(leftX) ceil(rightX)];
axX.tickLabels = {num2str(floor(leftX)) num2str(ceil(rightX))};
axX.axisOffset = bottomY-bottomMargin;
axX.fontSize = 14; 
axX.color = labelC; 
AxisMMC(start, fin, axX);
clear axY
start = bottomY-0.01;
fin = topY+0.01;
axY.lineThickness = 2;
axY.axisLabel = 'Proportion Of Neurons';
axY.axisOrientation = 'v';
axY.tickLocations = [bottomY topY];
axY.tickLabels = {num2str(bottomY) num2str(topY)};
axY.axisOffset = leftX-1;
axY.fontSize = 14; 
axY.color = labelC; 
AxisMMC(start, fin, axY);
%%
N = histcounts([selectivityPcx15.numberExcNeurons1000; selectivityPcxAA.numberExcNeurons1000],0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts([selectivityCoa15.numberExcNeurons1000; selectivityCoaAA.numberExcNeurons1000],0:16); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));


xMargin = 0.05*range(0:15);
yMargin = 0.05*range(PPcx);
bottomMargin = 0.05*range(PPcx);
topMargin = 0.05*range(PPcx);
leftX = 0;
rightX = 15;
bottomY = 0;
topY = 0.6;
blankFigure([leftX-50*yMargin rightX+10*xMargin bottomY-10*bottomMargin topY+10*topMargin]);
errorbar(0:15, PCoa, SEMPCoa, 'o', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8, 'color', coaC)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'o', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8, 'color', pcxC)
% xlim([-1 16.3]);
% ylim([-0.03 0.8])
% set(gca,'box','off')
clear axX
start = leftX-xMargin;
fin = rightX+xMargin;
axX.lineThickness = 2;
axX.axisLabel = 'Number Of Excitatory Odors - first second';
axX.axisOrientation = 'h';
axX.tickLocations = [floor(leftX) ceil(rightX)];
axX.tickLabels = {num2str(floor(leftX)) num2str(ceil(rightX))};
axX.axisOffset = bottomY-bottomMargin;
axX.fontSize = 14; 
axX.color = labelC; 
AxisMMC(start, fin, axX);
clear axY
start = bottomY-0.01;
fin = topY+0.01;
axY.lineThickness = 2;
axY.axisLabel = 'Proportion Of Neurons';
axY.axisOrientation = 'v';
axY.tickLocations = [bottomY topY];
axY.tickLabels = {num2str(bottomY) num2str(topY)};
axY.axisOffset = leftX-1;
axY.fontSize = 14; 
axY.color = labelC; 
AxisMMC(start, fin, axY);

%%
N = histcounts([selectivityPcx15.numberExcNeurons300; selectivityPcxAA.numberExcNeurons300],0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts([selectivityCoa15.numberExcNeurons300; selectivityCoaAA.numberExcNeurons300],0:16); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));


xMargin = 0.05*range(0:15);
yMargin = 0.05*range(PPcx);
bottomMargin = 0.05*range(PPcx);
topMargin = 0.05*range(PPcx);
leftX = 0;
rightX = 15;
bottomY = 0;
topY = 0.8;
blankFigure([leftX-50*yMargin rightX+10*xMargin bottomY-10*bottomMargin topY+10*topMargin]);
errorbar(0:15, PCoa, SEMPCoa, 'o', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8, 'color', coaC)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'o', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8, 'color', pcxC)
% xlim([-1 16.3]);
% ylim([-0.03 0.8])
% set(gca,'box','off')
clear axX
start = leftX-xMargin;
fin = rightX+xMargin;
axX.lineThickness = 2;
axX.axisLabel = 'Number Of Inhibitory Odors - first sniff';
axX.axisOrientation = 'h';
axX.tickLocations = [floor(leftX) ceil(rightX)];
axX.tickLabels = {num2str(floor(leftX)) num2str(ceil(rightX))};
axX.axisOffset = bottomY-bottomMargin;
axX.fontSize = 14; 
axX.color = labelC; 
AxisMMC(start, fin, axX);
clear axY
start = bottomY-0.01;
fin = topY+0.01;
axY.lineThickness = 2;
axY.axisLabel = 'Proportion Of Neurons';
axY.axisOrientation = 'v';
axY.tickLocations = [bottomY topY];
axY.tickLabels = {num2str(bottomY) num2str(topY)};
axY.axisOffset = leftX-1;
axY.fontSize = 14; 
axY.color = labelC; 
AxisMMC(start, fin, axY);


%%
N = histcounts([selectivityPcx15.numberInhNeurons1000; selectivityPcxAA.numberInhNeurons1000],0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts([selectivityCoa15.numberInhNeurons1000; selectivityCoaAA.numberInhNeurons1000],0:16); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));


xMargin = 0.05*range(0:15);
yMargin = 0.05*range(PPcx);
bottomMargin = 0.05*range(PPcx);
topMargin = 0.05*range(PPcx);
leftX = 0;
rightX = 15;
bottomY = 0;
topY = 0.9;
blankFigure([leftX-50*yMargin rightX+10*xMargin bottomY-10*bottomMargin topY+10*topMargin]);
errorbar(0:15, PCoa, SEMPCoa, 'o', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8, 'color', coaC)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'o', 'LineWidth', 1, 'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 8, 'color', pcxC)
% xlim([-1 16.3]);
% ylim([-0.03 0.8])
% set(gca,'box','off')
clear axX
start = leftX-xMargin;
fin = rightX+xMargin;
axX.lineThickness = 2;
axX.axisLabel = 'Number Of Inhibitory Odors - first second';
axX.axisOrientation = 'h';
axX.tickLocations = [floor(leftX) ceil(rightX)];
axX.tickLabels = {num2str(floor(leftX)) num2str(ceil(rightX))};
axX.axisOffset = bottomY-bottomMargin;
axX.fontSize = 14; 
axX.color = labelC; 
AxisMMC(start, fin, axX);
clear axY
start = bottomY-0.01;
fin = topY+0.01;
axY.lineThickness = 2;
axY.axisLabel = 'Proportion Of Neurons';
axY.axisOrientation = 'v';
axY.tickLocations = [bottomY topY];
axY.tickLabels = {num2str(bottomY) num2str(topY)};
axY.axisOffset = leftX-1;
axY.fontSize = 14; 
axY.color = labelC; 
AxisMMC(start, fin, axY);


%%
ls300 = [ls300Coa' ls300Pcx'];
groupingVls300 = ones(1,length(ls300(:)));
groupingVls300(length(ls300Coa + 1) : end) = 2;

ls1000 = [ls1000Coa' ls1000Pcx'];
groupingVls1000 = ones(1,length(ls1000(:)));
groupingVls1000(length(ls1000Coa + 1) : end) = 2;

info300 = [info300Coa' info300Pcx'];
groupingVinfo300 = ones(1,length(info300(:)));
groupingVinfo300(length(info300Coa + 1) : end) = 2;

info1000 = [info1000Coa' info1000Pcx'];
groupingVinfo1000 = ones(1,length(info1000(:)));
groupingVinfo1000(length(info1000Coa + 1) : end) = 2;

figure
subplot(2,2,1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b1 = boxplot(ls300, groupingVls300, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', [coaC; pcxC], 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([0 1]);
set(gca, 'YColor', 'w', 'box','off')
h = findobj(gca,'Tag','Box');
colorToUse = [pcxC; coaC];
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse(j,:),'FaceAlpha',.7);
end
xlabel('Lifetime Sparseness - first sniff')

subplot(2,2,2)
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b1 = boxplot(ls1000, groupingVls1000, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', [coaC; pcxC], 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([0 1]);
set(gca, 'YColor', 'w', 'box','off')
h = findobj(gca,'Tag','Box');
colorToUse = [pcxC; coaC];
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse(j,:),'FaceAlpha',.7);
end
xlabel('Lifetime Sparseness - first second')
set(gca, 'TickDir', 'out')

subplot(2,2,3)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b1 = boxplot(info300, groupingVinfo300, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', [coaC; pcxC], 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([0 4]);
set(gca, 'YColor', 'w', 'box','off')
h = findobj(gca,'Tag','Box');
colorToUse = [pcxC; coaC];
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse(j,:),'FaceAlpha',.7);
end
xlabel('Odor Predictability (bits) - first sniff')

subplot(2,2,4)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
b1 = boxplot(info1000, groupingVinfo1000, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', [coaC; pcxC], 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([0 4]);
set(gca, 'YColor', 'w', 'box','off')
h = findobj(gca,'Tag','Box');
colorToUse = [pcxC; coaC];
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse(j,:),'FaceAlpha',.7);
end
xlabel('Odor Predictability (bits) - first second')
set(gca, 'TickDir', 'out')

%%
R1000Coa  = [selectivityCoa15.LI1000';selectivityCoaAA.LI1000'];
R1000Pcx  = [selectivityPcx15.LI1000';selectivityPcxAA.LI1000'];
info1000CoaG = [selectivityCoa15.info1000Gradient;selectivityCoaAA.info1000Gradient];
info1000PcxG = [selectivityPcx15.info1000Gradient;selectivityPcxAA.info1000Gradient];
ls1000CoaG = [selectivityCoa15.ls1000Gradient;selectivityCoaAA.ls1000Gradient];
ls1000PcxG = [selectivityPcx15.ls1000Gradient;selectivityPcxAA.ls1000Gradient];

ls1000CoaG(R1000Coa == 0) = [];
info1000CoaG(R1000Coa == 0) = [];
ls1000PcxG(R1000Pcx == 0) = [];
info1000PcxG(R1000Pcx == 0) = [];

figure
hold on
plot(nanmean(ls1000CoaG))
plot(nanmean(ls1000PcxG))


figure
hold on
plot(nanmean(info1000CoaG))
plot(nanmean(info1000PcxG))
