[responseCell1AllCoa15, fR, fRmean, fRsem]  = findResponsiveNeuronsPerTrial(coa15.esp, 1:15);
[responseCell1AllPcx15, fR, fRmean, fRsem]  = findResponsiveNeuronsPerTrial(pcx15.esp, 1:15);
[responseCell1AllCoaAA, fR, fRmean, fRsem]  = findResponsiveNeuronsPerTrial(coaAA.esp, 1:10);
[responseCell1AllPcxAA, fR, fRmean, fRsem]  = findResponsiveNeuronsPerTrial(pcxAA.esp, 1:10);
%%

for idxO = 1:15
    app = [];
    app = squeeze(responseCell1AllCoa15(:,:,idxO));
    meanCoa15(idxO) = mean(sum(app)/size(app,1));
    semCoa15(idxO) = std(sum(app)/size(app,1))./sqrt(9);
    app = [];
    app = squeeze(responseCell1AllPcx15(:,:,idxO));
    meanPcx15(idxO) = mean(sum(app)/size(app,1));
    semPcx15(idxO) = std(sum(app)/size(app,1))./sqrt(9);
end

for idxO = 1:10
    app = [];
    app = squeeze(responseCell1AllCoaAA(:,:,idxO));
    meanCoaAA(idxO) = mean(sum(app)/size(app,1));
    semCoaAA(idxO) = std(sum(app)/size(app,1))./sqrt(9);
    app = [];
    app = squeeze(responseCell1AllPcxAA(:,:,idxO));
    meanPcxAA(idxO) = mean(sum(app)/size(app,1));
    semPcxAA(idxO) = std(sum(app)/size(app,1))./sqrt(9);
end
%%
figure
b1 = bar(meanCoa15);
b1.EdgeColor = coaC;
b1.FaceColor = coaC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
figure
b2 = bar(meanPcx15);
b2.EdgeColor = pcxC;
b2.FaceColor = pcxC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
figure
b1 = bar(meanCoaAA);
b1.EdgeColor = coaC;
b1.FaceColor = coaC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
figure
b2 = bar(meanPcxAA);
b2.EdgeColor = pcxC;
b2.FaceColor = pcxC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%
figure
h1 = errorbar(meanCoa15, semCoa15, 'o');
h1.MarkerSize = 5;
h1.MarkerEdgeColor = coaC;
h1.MarkerFaceColor = coaC;
hold on
h2 = errorbar(meanPcx15, semPcx15, 'o');
h2.MarkerSize = 5;
h2.MarkerEdgeColor = coaC;
h2.MarkerFaceColor = coaC;
figure
h3 = errorbar(meanCoaAA, semCoaAA, 'o');
h3.MarkerSize = 5;
h3.MarkerEdgeColor = coaC;
h3.MarkerFaceColor = coaC;
hold on
h4 = errorbar(meanPcxAA, semPcxAA, 'o');
h4.MarkerSize = 5;
h4.MarkerEdgeColor = pcxC;
h4.MarkerFaceColor = pcxC;

