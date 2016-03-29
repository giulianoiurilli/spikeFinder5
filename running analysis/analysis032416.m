odors = 1:15;
labelC = [82,82,82] ./ 255;
[corrCoa300_15, corrCoa1000_15, corrCoaBsl_15] = trialCorrelationsShank(coa15.esp, odors);
[corrCoa300_AA, corrCoa1000_AA, corrCoaBsl_AA] = trialCorrelationsShank(coaAA.esp, odors);

[corrPcx300_15, corrPcx1000_15, corrPcxBsl_15] = trialCorrelationsShank(pcx15.esp, odors);
[corrPcx300_AA, corrPcx1000_AA, corrPcxBsl_AA] = trialCorrelationsShank(pcxAA.esp, odors);

%%
corrCoa300_1 = [corrCoa300_15{1} corrCoa300_AA{1}];
corrCoa300_2 = [corrCoa300_15{2} corrCoa300_AA{2}];
corrCoa300_3 = [corrCoa300_15{3} corrCoa300_AA{3}];
corrCoa300_4 = [corrCoa300_15{4} corrCoa300_AA{4}];
corrCoa300_1_Mean = nanmean(corrCoa300_1);
corrCoa300_1_Sem = nanstd(corrCoa300_1) ./ sqrt(length(corrCoa300_1));
corrCoa300_2_Mean = nanmean(corrCoa300_2);
corrCoa300_2_Sem = nanstd(corrCoa300_2) ./ sqrt(length(corrCoa300_2));
corrCoa300_3_Mean = nanmean(corrCoa300_3);
corrCoa300_3_Sem = nanstd(corrCoa300_3) ./ sqrt(length(corrCoa300_3));
corrCoa300_4_Mean = nanmean(corrCoa300_4);
corrCoa300_4_Sem = nanstd(corrCoa300_4) ./ sqrt(length(corrCoa300_4));

corrCoa1000_1 = [corrCoa1000_15{1} corrCoa1000_AA{1}];
corrCoa1000_2 = [corrCoa1000_15{2} corrCoa1000_AA{2}];
corrCoa1000_3 = [corrCoa1000_15{3} corrCoa1000_AA{3}];
corrCoa1000_4 = [corrCoa1000_15{4} corrCoa1000_AA{4}];
corrCoa1000_1_Mean = nanmean(corrCoa1000_1);
corrCoa1000_1_Sem = nanstd(corrCoa1000_1) ./ sqrt(length(corrCoa1000_1));
corrCoa1000_2_Mean = nanmean(corrCoa1000_2);
corrCoa1000_2_Sem = nanstd(corrCoa1000_2) ./ sqrt(length(corrCoa1000_2));
corrCoa1000_3_Mean = nanmean(corrCoa1000_3);
corrCoa1000_3_Sem = nanstd(corrCoa1000_3) ./ sqrt(length(corrCoa1000_3));
corrCoa1000_4_Mean = nanmean(corrCoa1000_4);
corrCoa1000_4_Sem = nanstd(corrCoa1000_4) ./ sqrt(length(corrCoa1000_4));

corrCoaBsl_1 = [corrCoaBsl_15{1} corrCoaBsl_AA{1}];
corrCoaBsl_2 = [corrCoaBsl_15{2} corrCoaBsl_AA{2}];
corrCoaBsl_3 = [corrCoaBsl_15{3} corrCoaBsl_AA{3}];
corrCoaBsl_4 = [corrCoaBsl_15{4} corrCoaBsl_AA{4}];
corrCoaBsl_1_Mean = nanmean(corrCoaBsl_1);
corrCoaBsl_1_Sem = nanstd(corrCoaBsl_1) ./ sqrt(length(corrCoaBsl_1));
corrCoaBsl_2_Mean = nanmean(corrCoaBsl_2);
corrCoaBsl_2_Sem = nanstd(corrCoaBsl_2) ./ sqrt(length(corrCoaBsl_2));
corrCoaBsl_3_Mean = nanmean(corrCoaBsl_3);
corrCoaBsl_3_Sem = nanstd(corrCoaBsl_3) ./ sqrt(length(corrCoaBsl_3));
corrCoaBsl_4_Mean = nanmean(corrCoaBsl_4);
corrCoaBsl_4_Sem = nanstd(corrCoaBsl_4) ./ sqrt(length(corrCoaBsl_4));



corrPcx300_1 = [corrPcx300_15{1} corrPcx300_AA{1}];
corrPcx300_2 = [corrPcx300_15{2} corrPcx300_AA{2}];
corrPcx300_3 = [corrPcx300_15{3} corrPcx300_AA{3}];
corrPcx300_4 = [corrPcx300_15{4} corrPcx300_AA{4}];
corrPcx300_1_Mean = nanmean(corrPcx300_1);
corrPcx300_1_Sem = nanstd(corrPcx300_1) ./ sqrt(length(corrPcx300_1));
corrPcx300_2_Mean = nanmean(corrPcx300_2);
corrPcx300_2_Sem = nanstd(corrPcx300_2) ./ sqrt(length(corrPcx300_2));
corrPcx300_3_Mean = nanmean(corrPcx300_3);
corrPcx300_3_Sem = nanstd(corrPcx300_3) ./ sqrt(length(corrPcx300_3));
corrPcx300_4_Mean = nanmean(corrPcx300_4);
corrPcx300_4_Sem = nanstd(corrPcx300_4) ./ sqrt(length(corrPcx300_4));

corrPcx1000_1 = [corrPcx1000_15{1} corrPcx1000_AA{1}];
corrPcx1000_2 = [corrPcx1000_15{2} corrPcx1000_AA{2}];
corrPcx1000_3 = [corrPcx1000_15{3} corrPcx1000_AA{3}];
corrPcx1000_4 = [corrPcx1000_15{4} corrPcx1000_AA{4}];
corrPcx1000_1_Mean = nanmean(corrPcx1000_1);
corrPcx1000_1_Sem = nanstd(corrPcx1000_1) ./ sqrt(length(corrPcx1000_1));
corrPcx1000_2_Mean = nanmean(corrPcx1000_2);
corrPcx1000_2_Sem = nanstd(corrPcx1000_2) ./ sqrt(length(corrPcx1000_2));
corrPcx1000_3_Mean = nanmean(corrPcx1000_3);
corrPcx1000_3_Sem = nanstd(corrPcx1000_3) ./ sqrt(length(corrPcx1000_3));
corrPcx1000_4_Mean = nanmean(corrPcx1000_4);
corrPcx1000_4_Sem = nanstd(corrPcx1000_4) ./ sqrt(length(corrPcx1000_4));

corrPcxBsl_1 = [corrPcxBsl_15{1} corrPcxBsl_AA{1}];
corrPcxBsl_2 = [corrPcxBsl_15{2} corrPcxBsl_AA{2}];
corrPcxBsl_3 = [corrPcxBsl_15{3} corrPcxBsl_AA{3}];
corrPcxBsl_4 = [corrPcxBsl_15{4} corrPcxBsl_AA{4}];
corrPcxBsl_1_Mean = nanmean(corrPcxBsl_1);
corrPcxBsl_1_Sem = nanstd(corrPcxBsl_1) ./ sqrt(length(corrPcxBsl_1));
corrPcxBsl_2_Mean = nanmean(corrPcxBsl_2);
corrPcxBsl_2_Sem = nanstd(corrPcxBsl_2) ./ sqrt(length(corrPcxBsl_2));
corrPcxBsl_3_Mean = nanmean(corrPcxBsl_3);
corrPcxBsl_3_Sem = nanstd(corrPcxBsl_3) ./ sqrt(length(corrPcxBsl_3));
corrPcxBsl_4_Mean = nanmean(corrPcxBsl_4);
corrPcxBsl_4_Sem = nanstd(corrPcxBsl_4) ./ sqrt(length(corrPcxBsl_4));


figure
plot([1 5 9 13], [corrCoa300_1_Mean corrCoa300_2_Mean corrCoa300_3_Mean corrCoa300_4_Mean], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 6 10 14], [corrPcx300_1_Mean corrPcx300_2_Mean corrPcx300_3_Mean corrPcx300_4_Mean], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 5 9 13], [corrCoa300_1_Mean corrCoa300_2_Mean corrCoa300_3_Mean corrCoa300_4_Mean], [corrCoa300_1_Sem corrCoa300_2_Sem corrCoa300_3_Sem corrCoa300_4_Sem], 'r', 'linewidth', 2);
hold on
errbar([2 6 10 14], [corrPcx300_1_Mean corrPcx300_2_Mean corrPcx300_3_Mean corrPcx300_4_Mean], [corrPcx300_1_Sem corrPcx300_2_Sem corrPcx300_3_Sem corrPcx300_4_Sem], 'k', 'linewidth', 2);
xlim([0 15])
ylim([0 0.085])
set(gca, 'XColor', 'w', 'box','off')
ylabel('Correlation - 300 ms')

figure
plot([1 5 9 13], [corrCoa1000_1_Mean corrCoa1000_2_Mean corrCoa1000_3_Mean corrCoa1000_4_Mean], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 6 10 14], [corrPcx1000_1_Mean corrPcx1000_2_Mean corrPcx1000_3_Mean corrPcx1000_4_Mean], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 5 9 13], [corrCoa1000_1_Mean corrCoa1000_2_Mean corrCoa1000_3_Mean corrCoa1000_4_Mean], [corrCoa1000_1_Sem corrCoa1000_2_Sem corrCoa1000_3_Sem corrCoa1000_4_Sem], 'r', 'linewidth', 2);
hold on
errbar([2 6 10 14], [corrPcx1000_1_Mean corrPcx1000_2_Mean corrPcx1000_3_Mean corrPcx1000_4_Mean], [corrPcx1000_1_Sem corrPcx1000_2_Sem corrPcx1000_3_Sem corrPcx1000_4_Sem], 'k', 'linewidth', 2);
xlim([0 15])
ylim([0 0.085])
set(gca, 'XColor', 'w', 'box','off')
ylabel('Correlation - 1000 ms')

figure
plot([1 5 9 13], [corrCoaBsl_1_Mean corrCoaBsl_2_Mean corrCoaBsl_3_Mean corrCoaBsl_4_Mean], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 6 10 14], [corrPcxBsl_1_Mean corrPcxBsl_2_Mean corrPcxBsl_3_Mean corrPcxBsl_4_Mean], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 5 9 13], [corrCoaBsl_1_Mean corrCoaBsl_2_Mean corrCoaBsl_3_Mean corrCoaBsl_4_Mean], [corrCoaBsl_1_Sem corrCoaBsl_2_Sem corrCoaBsl_3_Sem corrCoaBsl_4_Sem], 'r', 'linewidth', 2);
hold on
errbar([2 6 10 14], [corrPcxBsl_1_Mean corrPcxBsl_2_Mean corrPcxBsl_3_Mean corrPcxBsl_4_Mean], [corrPcxBsl_1_Sem corrPcxBsl_2_Sem corrPcxBsl_3_Sem corrPcxBsl_4_Sem], 'k', 'linewidth', 2);
xlim([0 15])
ylim([0 0.085])
set(gca, 'XColor', 'w', 'box','off')
ylabel('Correlation - Bsl ms')


%%
% corrCoa300_1 = [corrCoa300_15{1} corrCoa300_AA{1}];
% corrCoa300_2 = [corrCoa300_15{2} corrCoa300_AA{2}];
% corrCoa300_3 = [corrCoa300_15{3} corrCoa300_AA{3}];
% corrCoa300_4 = [corrCoa300_15{4} corrCoa300_AA{4}];

corrCoa300 = [corrCoa300_1 corrCoa300_2 corrCoa300_3 corrCoa300_4];
shankPos = ones(size(corrCoa300));
shankPos(size(corrCoa300_1,2)+1:size(corrCoa300_1,2)+size(corrCoa300_2,2)) = 2;
shankPos(size(corrCoa300_1,2)+size(corrCoa300_2,2)+1:size(corrCoa300_1,2)+size(corrCoa300_2,2)+size(corrCoa300_3,3)) = 3;
shankPos(size(corrCoa300_1,2)+size(corrCoa300_2,2)+size(corrCoa300_3,3)+1:end) = 4;

% corrCoa1000_1 = [corrCoa1000_15{1} corrCoa1000_AA{1}];
% corrCoa1000_2 = [corrCoa1000_15{2} corrCoa1000_AA{2}];
% corrCoa1000_3 = [corrCoa1000_15{3} corrCoa1000_AA{3}];
% corrCoa1000_4 = [corrCoa1000_15{4} corrCoa1000_AA{4}];

corrCoa1000 = [corrCoa1000_1 corrCoa1000_2 corrCoa1000_3 corrCoa1000_4];
shankPos = ones(size(corrCoa1000));
shankPos(size(corrCoa1000_1,2)+1:size(corrCoa1000_1,2)+size(corrCoa1000_2,2)) = 2;
shankPos(size(corrCoa1000_1,2)+size(corrCoa1000_2,2)+1:size(corrCoa1000_1,2)+size(corrCoa1000_2,2)+size(corrCoa1000_3,3)) = 3;
shankPos(size(corrCoa1000_1,2)+size(corrCoa1000_2,2)+size(corrCoa1000_3,3)+1:end) = 4;


%%

corr300 = [corrCoa300_1'; corrCoa300_2'; corrCoa300_3'; corrCoa300_4';corrPcx300_1'; corrPcx300_2'; corrPcx300_3'; corrPcx300_4']; 
%corr300 = fisherZTransform(corr300);
g1Coa = ones(size(corrCoa300_1,2) + size(corrCoa300_2,2) + size(corrCoa300_3,2) + size(corrCoa300_4,2), 1);
g1Pcx = 2 * ones(size(corrPcx300_1,2) + size(corrPcx300_2,2) + size(corrPcx300_3,2) + size(corrPcx300_4,2), 1);
g1 = [g1Coa; g1Pcx];
g2Coa1 = zeros(size(corrCoa300_1,2), 1);
g2Coa2 = ones(size(corrCoa300_2,2), 1);
g2Coa3 = 2 * ones(size(corrCoa300_3,2), 1);
g2Coa4 = 3 * ones(size(corrCoa300_4,2), 1);
g2Pcx1 = zeros(size(corrPcx300_1,2), 1);
g2Pcx2 = ones * ones(size(corrPcx300_2,2), 1);
g2Pcx3 = 2 * ones(size(corrPcx300_3,2), 1);
g2Pcx4 = 3 * ones(size(corrPcx300_4,2), 1);
g2 = [g2Coa1; g2Coa2; g2Coa3; g2Coa4; g2Pcx1; g2Pcx2; g2Pcx3; g2Pcx4];
displacement = zeros(size(g2,1),1);
displacement(g1 == 1) = 0.1;
[h, atab, ctab, stats] = aoctool(g2, corr300, g1);
%multcompare(stats, 0.05, 'on', '', 's')
colorCoa = repmat([254,153,41]./255, size(g1Coa,1), 1);
colorPcx = repmat([82,82,82]./255, size(g1Pcx,1), 1);
color = [colorCoa; colorPcx];
x = -0.2:0.1:3.2;
xMargin = 0.05 * range(x);
yMargin = 0.05 * range(corr300);
leftX = min(g2 + displacement) - 0.05;
rightX = max(g2 + displacement);
bottomY = min(corr300);
topY = max(corr300);
blankFigure([leftX-xMargin rightX+xMargin bottomY-yMargin topY+yMargin]);
scatter(g2 + displacement, corr300, 12, color, 'filled')
y1 = 0.056785 - 0.0086365*x;
y2 = 0.039303 - 0.0098201*x;
plot(x,y1, '-', 'linewidth', 2, 'color', [254,153,41]./255);
plot(x,y2, '-', 'linewidth', 2, 'color', [82,82,82]./255);
clear axY
start = round(bottomY-yMargin, 1);
fin = round(topY+yMargin, 1);
axY.lineThickness = 2;
axY.axisLabel = 'Trial-to-trial pairwise stimulus correlation';
axY.axisOrientation = 'v';
axY.tickLocations = [round(bottomY,2) 0 round(topY,2)];
axY.tickLabels = {num2str(round(bottomY,2)) '0' num2str(round(topY,2))};
axY.axisOffset = leftX - xMargin;
axY.fontSize = 12; 
axY.extraLength = 0;
%axY.tickLength = 0.05;
axY.invert = 0;
axY.color = labelC; 
AxisMMC(start, fin, axY);
clear axX
start = round(leftX-xMargin, 1);
fin = round(rightX+xMargin, 1);
axX.lineThickness = 2;
axX.axisLabel = 'inter-neuron distance';
axX.axisOrientation = 'h';
axX.tickLocations = [0 1 2 3];
axX.tickLabels = {'0', '200 �m', '400 �m', '600 �m'};
axX.axisOffset = bottomY - yMargin;
axX.fontSize = 12; 
axX.extraLength = 0;
%axY.tickLength = 0.05;
axX.invert = 0;
axX.color = labelC; 
AxisMMC(start, fin, axX);
title('first sniff')
hold off



%%
corr1000 = [corrCoa1000_1'; corrCoa1000_2'; corrCoa1000_3'; corrCoa1000_4';corrPcx1000_1'; corrPcx1000_2'; corrPcx1000_3'; corrPcx1000_4']; 
%corr1000 = fisherZTransform(corr1000);
g1Coa = ones(size(corrCoa1000_1,2) + size(corrCoa1000_2,2) + size(corrCoa1000_3,2) + size(corrCoa1000_4,2), 1);
g1Pcx = 2 * ones(size(corrPcx1000_1,2) + size(corrPcx1000_2,2) + size(corrPcx1000_3,2) + size(corrPcx1000_4,2), 1);
g1 = [g1Coa; g1Pcx];
g2Coa1 = zeros(size(corrCoa1000_1,2), 1);
g2Coa2 = ones(size(corrCoa1000_2,2), 1);
g2Coa3 = 2 * ones(size(corrCoa1000_3,2), 1);
g2Coa4 = 3 * ones(size(corrCoa1000_4,2), 1);
g2Pcx1 = zeros(size(corrPcx1000_1,2), 1);
g2Pcx2 = ones * ones(size(corrPcx1000_2,2), 1);
g2Pcx3 = 2 * ones(size(corrPcx1000_3,2), 1);
g2Pcx4 = 3 * ones(size(corrPcx1000_4,2), 1);
g2 = [g2Coa1; g2Coa2; g2Coa3; g2Coa4; g2Pcx1; g2Pcx2; g2Pcx3; g2Pcx4];
displacement = zeros(size(g2,1),1);
displacement(g1 == 1) = 0.1;
[h, atab, ctab, stats] = aoctool(g2, corr1000, g1);
%multcompare(stats, 0.05, 'on', '', 's')
colorCoa = repmat([254,153,41]./255, size(g1Coa,1), 1);
colorPcx = repmat([82,82,82]./255, size(g1Pcx,1), 1);
color = [colorCoa; colorPcx];
x = -0.2:0.1:3.2;
xMargin = 0.05 * range(x);
yMargin = 0.05 * range(corr1000);
leftX = min(g2 + displacement) - 0.1;
rightX = max(g2 + displacement);
bottomY = min(corr1000);
topY = max(corr1000);
blankFigure([leftX-xMargin rightX+xMargin bottomY-yMargin topY+yMargin]);
scatter(g2 + displacement, corr1000, 12, color, 'filled')
y1 = 0.056785 - 0.0086365*x;
y2 = 0.039303 - 0.0098201*x;
plot(x,y1, '-', 'linewidth', 2, 'color', [254,153,41]./255);
plot(x,y2, '-', 'linewidth', 2, 'color', [82,82,82]./255);
clear axY
start = round(bottomY-yMargin, 1);
fin = round(topY+yMargin, 1);
axY.lineThickness = 2;
axY.axisLabel = 'Trial-to-trial pairwise stimulus correlation';
axY.axisOrientation = 'v';
axY.tickLocations = [round(bottomY,2) 0 round(topY,2)];
axY.tickLabels = {num2str(round(bottomY,2)) '0' num2str(round(topY,2))};
axY.axisOffset = leftX - xMargin;
axY.fontSize = 12; 
axY.extraLength = 0;
axY.invert = 0;
axY.color = labelC; 
AxisMMC(start, fin, axY);
clear axX
start = round(leftX-xMargin, 1);
fin = round(rightX+xMargin, 1);
axX.lineThickness = 2;
axX.axisLabel = 'inter-neuron distance';
axX.axisOrientation = 'h';
axX.tickLocations = [0 1 2 3];
axX.tickLabels = {'0', '200 �m', '400 �m', '600 �m'};
axX.axisOffset = bottomY - yMargin;
axX.fontSize = 12; 
axX.extraLength = 0;
%axY.tickLength = 0.05;
axX.invert = 0;
axX.color = labelC; 
AxisMMC(start, fin, axX);
title('first second')
hold off


%%
[lsCoa15, pcCoa15] = lsVsPc(coa15.esp);
[lsCoaAA, pcCoaAA] = lsVsPc(coaAA.esp);
[lsPcx15, pcPcx15] = lsVsPc(pcx15.esp);
[lsPcxAA, pcPcxAA] = lsVsPc(pcxAA.esp);

lsCoa = [lsCoa15; lsCoaAA];
pcCoa = [pcCoa15; pcCoaAA];
lsPcx = [lsPcx15; lsPcxAA];
pcPcx = [pcPcx15; pcPcxAA];


color = [254,153,41]./255;
xMargin = 0.05 * range(pcCoa);
yMargin = 0.05 * range(lsCoa);
leftX = min(pcCoa);
rightX = max(pcCoa);
bottomY = 0;
topY = 1;
blankFigure([leftX-xMargin rightX+xMargin bottomY-yMargin topY+yMargin]);
scatter(pcCoa, lsCoa, 8, color, 'filled')
clear axY
start = floor(bottomY-yMargin);
fin = ceil(topY+yMargin);
axY.lineThickness = 2;
axY.axisLabel = 'odor selectivity (lifetime sparseness)';
axY.axisOrientation = 'v';
axY.tickLocations = [0 1];
axY.tickLabels = {'0' '1'};
axY.axisOffset = leftX - xMargin;
axY.fontSize = 12; 
axY.extraLength = 0;
axY.invert = 0;
axY.color = labelC; 
AxisMMC(start, fin, axY);
clear axX
start = floor(leftX-xMargin);
fin = ceil(rightX+xMargin);
axX.lineThickness = 2;
axX.axisLabel = 'population coupling';
axX.axisOrientation = 'h';
axX.tickLocations = [leftX rightX];
axX.tickLabels = {num2str(round(leftX,1)), num2str(round(rightX,1))};
axX.axisOffset = bottomY - yMargin;
axX.fontSize = 12; 
axX.extraLength = 0;
%axY.tickLength = 0.05;
axX.invert = 0;
axX.color = labelC; 
AxisMMC(start, fin, axX);
title('first second')

color = [82,82,82]./255;
xMargin = 0.05 * range(pcCoa);
yMargin = 0.05 * range(lsCoa);
leftX = min(pcCoa);
rightX = max(pcCoa);
bottomY = 0;
topY = 1;
blankFigure([leftX-xMargin rightX+xMargin bottomY-yMargin topY+yMargin]);
scatter(pcPcx, lsPcx, 8, color, 'filled')
clear axY
start = floor(bottomY-yMargin);
fin = ceil(topY+yMargin);
axY.lineThickness = 2;
axY.axisLabel = 'odor selectivity (lifetime sparseness)';
axY.axisOrientation = 'v';
axY.tickLocations = [0 1];
axY.tickLabels = {'0' '1'};
axY.axisOffset = leftX - xMargin;
axY.fontSize = 12; 
axY.extraLength = 0;
axY.invert = 0;
axY.color = labelC; 
AxisMMC(start, fin, axY);
clear axX
start = floor(leftX-xMargin);
fin = ceil(rightX+xMargin);
axX.lineThickness = 2;
axX.axisLabel = 'population coupling';
axX.axisOrientation = 'h';
axX.tickLocations = [leftX rightX];
axX.tickLabels = {num2str(round(leftX,1)), num2str(round(rightX,1))};
axX.axisOffset = bottomY - yMargin;
axX.fontSize = 12; 
axX.extraLength = 0;
%axY.tickLength = 0.05;
axX.invert = 0;
axX.color = labelC; 
AxisMMC(start, fin, axX);
title('first second')

lm = fitlm(pcPcx, lsPcx)
lm1 = fitlm(pcCoa, lsCoa)

%%
[D300Coa, D1000Coa] = signalCorrelationAcrossMice(coa15.esp, odors);
[D300Pcx, D1000Pcx] = signalCorrelationAcrossMice(pcx15.esp, odors);

coa1000SC = [];
pcx1000SC = [];
coa300SC = [];
pcx300SC = [];
for idxShank = 1:4
    coa1000C(idxShank) = nanmean(D1000Coa{1,idxShank});
    pcx1000C(idxShank) = nanmean(D1000Pcx{1,idxShank});
    coa1000SC = [coa1000SC; D1000Coa{1,idxShank}];
    pcx1000SC = [pcx1000SC; D1000Pcx{1,idxShank}];
    coa300C(idxShank) = nanmean(D300Coa{1,idxShank});
    pcx300C(idxShank) = nanmean(D300Pcx{1,idxShank});
    coa300SC = [coa300SC; D300Coa{1,idxShank}];
    pcx300SC = [pcx300SC; D300Pcx{1,idxShank}];
    coaN(idxShank) = numel(D300Coa{1,idxShank});
    pcxN(idxShank) = numel(D300Pcx{1,idxShank});
end

y = [coa300SC; pcx300SC]; 
g1 = [zeros(sum(coaN),1); ones(sum(pcxN),1)];
g2 = [zeros(coaN(1),1); ones(coaN(2),1); 2*ones(coaN(3),1); 3*ones(coaN(4),1); zeros(pcxN(1),1); ones(pcxN(2),1); 2*ones(pcxN(3),1); 3*ones(pcxN(4),1)];
[p, tbl, stats, terms] = anovan( y, {g1, g2})
multcompare(stats, 'Dimension', [1 2])
[h, p] = ttest2(pcx300SC, coa300SC)

y = [coa1000SC; pcx1000SC]; 
g1 = [zeros(sum(coaN),1); ones(sum(pcxN),1)];
g2 = [zeros(coaN(1),1); ones(coaN(2),1); 2*ones(coaN(3),1); 3*ones(coaN(4),1); zeros(pcxN(1),1); ones(pcxN(2),1); 2*ones(pcxN(3),1); 3*ones(pcxN(4),1)];
[p, tbl, stats, terms] = anovan( y, {g1, g2})
multcompare(stats, 'Dimension', [1 2])
[h, p] = ttest2(coa1000SC, pcx1000SC)




xMargin = 0.05 * range([0.5 3.5]);
yMargin = 0.05 * range(coa300SC);
leftX = 0.5;
rightX = 3.5;
bottomY = -1;
topY = 1;
blankFigure([leftX-xMargin rightX+xMargin bottomY-yMargin topY+yMargin]);
dataToPlot = {pcx300SC,coa300SC};
catIdx = [ones(length(pcx300SC),1); zeros(length(coa300SC),1)];
colori = {coaC, pcxC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
clear axY
start = floor(bottomY-yMargin);
fin = ceil(topY+yMargin);
axY.lineThickness = 2;
axY.axisLabel = ' Spearman correlation - first sniff';
axY.axisOrientation = 'v';
axY.tickLocations = [-1 0 1];
axY.tickLabels = {'-1' '0' '1'};
axY.axisOffset = leftX - xMargin;
axY.fontSize = 12; 
axY.extraLength = 0;
axY.invert = 0;
axY.color = labelC; 
AxisMMC(start, fin, axY);


xMargin = 0.05 * range([0.5 3.5]);
yMargin = 0.05 * range(coa300SC);
leftX = 0.5;
rightX = 3.5;
bottomY = -1;
topY = 1;
blankFigure([leftX-xMargin rightX+xMargin bottomY-yMargin topY+yMargin]);
dataToPlot = {pcx1000SC,coa1000SC};
catIdx = [ones(length(pcx1000SC),1); zeros(length(coa1000SC),1)];
colori = {coaC, pcxC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0)
clear axY
start = floor(bottomY-yMargin);
fin = ceil(topY+yMargin);
axY.lineThickness = 2;
axY.axisLabel = ' Spearman correlation - first second';
axY.axisOrientation = 'v';
axY.tickLocations = [-1 0 1];
axY.tickLabels = {'-1' '0' '1'};
axY.axisOffset = leftX - xMargin;
axY.fontSize = 12; 
axY.extraLength = 0;
axY.invert = 0;
axY.color = labelC; 
AxisMMC(start, fin, axY);



