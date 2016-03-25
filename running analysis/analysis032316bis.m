odors = 1:15;
selectivityCoa15 = selectivityIndexes(coa15.esp, odors);
selectivityCoaAA = selectivityIndexes(coaAA.esp, odors);
selectivityPcx15 = selectivityIndexes(pcx15.esp, odors);
selectivityPcxAA = selectivityIndexes(pcxAA.esp, odors);

%%
DeltaRspCOA = [selectivityCoa15.info300;selectivityCoaAA.info300];
DeltaRspPCX = [selectivityPcx15.info300;selectivityPcxAA.info300];


xMargin = 0.05 * range([DeltaRspCOA(:); DeltaRspPCX(:)]);
bottomMargin = 0;
topMargin = 0.001;
leftX = min([DeltaRspCOA(:); DeltaRspPCX(:)]);
rightX = max([DeltaRspCOA(:); DeltaRspPCX(:)]);
blankFigure([leftX-xMargin rightX+xMargin 0-bottomMargin 0.2+topMargin]);

distributionPlot(DeltaRspCOA(:),'histOri','right','color',coaC,'widthDiv',[2 2],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(DeltaRspPCX(:),'histOri','left','color',pcxC,'widthDiv',[2 1],'showMM',0, 'globalNorm', 1, 'xyOri', 'flipped')
% hold on
% coaRsp = DeltaRspCOA;
% coaRsp(logSignificantCoa == 0) = [];
% pcxRsp = DeltaRspPCX;
% pcxRsp(logSignificantPcx == 0) = [];
% dataToPlot = {pcxRsp,coaRsp};
% catIdx = [ones(length(pcxRsp),1); zeros(length(coaRsp),1)];
% colori = {coaC, pcxC};
% plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
alpha(0.5)

clear axP
start = floor(leftX-xMargin);
fin = ceil(rightX+xMargin);
axP.lineThickness = 2;
axP.axisLabel = 'spike count change';
axP.axisOrientation = 'h';
axP.tickLocations = [floor(leftX) 0 ceil(rightX)];
axP.tickLabels = {num2str(floor(leftX)), num2str(0), num2str(ceil(rightX))};
axP.axisOffset = 0.4;
axP.fontSize = 12; 
axP.color = labelC; 
AxisMMC(start, fin, axP);
%%
N = histcounts([selectivityPcx15.numberExcNeurons1000; selectivityPcxAA.numberExcNeurons1000],0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts([selectivityCoa15.numberExcNeurons1000; selectivityCoaAA.numberExcNeurons1000],0:16); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));
figure
errorbar(0:15, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-1 16.3]);
ylim([-0.03 0.8])
set(gca,'box','off')
