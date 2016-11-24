[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaCS2.esp, 1:15, 0);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxCS2.esp, 1:15, 0);

fractionExcitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxExc.idxO1,2));
fractionExcitedNeuronsMeanCoa = nanmean(fractionExcitedNeuronsCoa);
fractionExcitedNeuronsSemCoa = nanstd(fractionExcitedNeuronsCoa)./sqrt(size(fractionExcitedNeuronsCoa,1)-1);

fractionInhibitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanCoa = nanmean(fractionInhibitedNeuronsCoa);
fractionInhibitedNeuronsSemCoa = nanstd(fractionInhibitedNeuronsCoa)./sqrt(size(fractionInhibitedNeuronsCoa,1)-1);

fractionExcitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxExc.idxO1,2));
fractionExcitedNeuronsMeanPcx = nanmean(fractionExcitedNeuronsPcx);
fractionExcitedNeuronsSemPcx = nanstd(fractionExcitedNeuronsPcx)./sqrt(size(fractionExcitedNeuronsPcx,1)-1);

fractionInhibitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanPcx = nanmean(fractionInhibitedNeuronsPcx);
fractionInhibitedNeuronsSemPcx = nanstd(fractionInhibitedNeuronsPcx)./sqrt(size(fractionInhibitedNeuronsPcx,1)-1);

fractionExcitedNeuronsCoa = fliplr(fractionExcitedNeuronsCoa);
fractionExcitedNeuronsMeanCoa = fliplr(fractionExcitedNeuronsMeanCoa);
fractionExcitedNeuronsSemCoa = fliplr(fractionExcitedNeuronsSemCoa);

fractionInhibitedNeuronsCoa = fliplr(fractionInhibitedNeuronsCoa);
fractionInhibitedNeuronsMeanCoa = fliplr(fractionInhibitedNeuronsMeanCoa);
fractionInhibitedNeuronsSemCoa = fliplr(fractionInhibitedNeuronsSemCoa);

fractionExcitedNeuronsPcx = fliplr(fractionExcitedNeuronsPcx);
fractionExcitedNeuronsMeanPcx = fliplr(fractionExcitedNeuronsMeanPcx);
fractionExcitedNeuronsSemPcx = fliplr(fractionExcitedNeuronsSemPcx);

fractionInhibitedNeuronsPcx = fliplr(fractionInhibitedNeuronsPcx);
fractionInhibitedNeuronsMeanPcx = fliplr(fractionInhibitedNeuronsMeanPcx);
fractionInhibitedNeuronsSemPcx = fliplr(fractionInhibitedNeuronsSemPcx);
%%
for idx = 1:3
    figure
    set(gcf,'Position',[440 548 560 250]);
    plot(1:5, fractionExcitedNeuronsMeanCoa(1+5*(idx-1):5+5*(idx-1)), '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
    hold on
    plot(1.1:5.1, fractionExcitedNeuronsMeanPcx(1+5*(idx-1):5+5*(idx-1)), '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
    hold on
    errbar(1:5, fractionExcitedNeuronsMeanCoa(1+5*(idx-1):5+5*(idx-1)), fractionExcitedNeuronsSemCoa(1+5*(idx-1):5+5*(idx-1)), 'color', coaC, 'linewidth', 2); %
    hold on
    errbar(1.1:5.1, fractionExcitedNeuronsMeanPcx(1+5*(idx-1):5+5*(idx-1)), fractionExcitedNeuronsSemPcx(1+5*(idx-1):5+5*(idx-1)), 'color', pcxC, 'linewidth', 2);
    %title('odor concentration')
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
    xlim([0.8 5.6]);
    ylim([-0.02 0.3]);
end
%%
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua_old(coaCS.esp, 1:15);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua_old(pcxCS.esp, 1:15);

fractionExcitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxExc.idxO1,2));
fractionExcitedNeuronsMeanCoa = nanmean(fractionExcitedNeuronsCoa);
fractionExcitedNeuronsSemCoa = nanstd(fractionExcitedNeuronsCoa)./sqrt(size(fractionExcitedNeuronsCoa,1)-1);

fractionInhibitedNeuronsCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa',1,size(totalResponsiveNeuronPerOdorCoa.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanCoa = nanmean(fractionInhibitedNeuronsCoa);
fractionInhibitedNeuronsSemCoa = nanstd(fractionInhibitedNeuronsCoa)./sqrt(size(fractionInhibitedNeuronsCoa,1)-1);

fractionExcitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxExc.idxO1,2));
fractionExcitedNeuronsMeanPcx = nanmean(fractionExcitedNeuronsPcx);
fractionExcitedNeuronsSemPcx = nanstd(fractionExcitedNeuronsPcx)./sqrt(size(fractionExcitedNeuronsPcx,1)-1);

fractionInhibitedNeuronsPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx',1,size(totalResponsiveNeuronPerOdorPcx.idxInh.idxO1,2));
fractionInhibitedNeuronsMeanPcx = nanmean(fractionInhibitedNeuronsPcx);
fractionInhibitedNeuronsSemPcx = nanstd(fractionInhibitedNeuronsPcx)./sqrt(size(fractionInhibitedNeuronsPcx,1)-1);

fractionExcitedNeuronsCoa = fliplr(fractionExcitedNeuronsCoa);
fractionExcitedNeuronsMeanCoa = fliplr(fractionExcitedNeuronsMeanCoa);
fractionExcitedNeuronsSemCoa = fliplr(fractionExcitedNeuronsSemCoa);

fractionInhibitedNeuronsCoa = fliplr(fractionInhibitedNeuronsCoa);
fractionInhibitedNeuronsMeanCoa = fliplr(fractionInhibitedNeuronsMeanCoa);
fractionInhibitedNeuronsSemCoa = fliplr(fractionInhibitedNeuronsSemCoa);

fractionExcitedNeuronsPcx = fliplr(fractionExcitedNeuronsPcx);
fractionExcitedNeuronsMeanPcx = fliplr(fractionExcitedNeuronsMeanPcx);
fractionExcitedNeuronsSemPcx = fliplr(fractionExcitedNeuronsSemPcx);

fractionInhibitedNeuronsPcx = fliplr(fractionInhibitedNeuronsPcx);
fractionInhibitedNeuronsMeanPcx = fliplr(fractionInhibitedNeuronsMeanPcx);
fractionInhibitedNeuronsSemPcx = fliplr(fractionInhibitedNeuronsSemPcx);
%%
for idx = 1:3
    figure
    set(gcf,'Position',[440 548 560 250]);
    plot(1:5, fractionExcitedNeuronsMeanCoa(1+5*(idx-1):5+5*(idx-1)), '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
    hold on
    plot(1.1:5.1, fractionExcitedNeuronsMeanPcx(1+5*(idx-1):5+5*(idx-1)), '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
    hold on
    errbar(1:5, fractionExcitedNeuronsMeanCoa(1+5*(idx-1):5+5*(idx-1)), fractionExcitedNeuronsSemCoa(1+5*(idx-1):5+5*(idx-1)), 'color', coaC, 'linewidth', 2); %
    hold on
    errbar(1.1:5.1, fractionExcitedNeuronsMeanPcx(1+5*(idx-1):5+5*(idx-1)), fractionExcitedNeuronsSemPcx(1+5*(idx-1):5+5*(idx-1)), 'color', pcxC, 'linewidth', 2);
    %title('odor concentration')
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
    xlim([0.8 5.6]);
    ylim([-0.02 0.3]);
end
%%
[tuningCurvesCoa, tuningCurvesAuRocCoa, tuningCurvesSigCoa, auROCSigCoa] = findTuningCurves(coaCS2.esp, 1:15, 0);
[tuningCurvesPcx, tuningCurvesAuRocPcx, tuningCurvesSigPcx, auROCSigPcx] = findTuningCurves(pcxCS2.esp, 1:15, 0);

tuningCurvesAuRocCoa = fliplr(tuningCurvesAuRocCoa);
tuningCurvesAuRocPcx = fliplr(tuningCurvesAuRocPcx);

x = 1:5;
for idx = 1:3
    X = tuningCurvesAuRocCoa(:,1+5*(idx-1):5+5*(idx-1));
    cc = [];
    for idxCell = 1:size(X,1)
        a = polyfit(x,X(idxCell,:),1);
        cc(idxCell) = a(1);
    end
    X = [X cc'];
    X = sortrows(X,6);
    X(:,6) = [];
    Y = tuningCurvesAuRocPcx(:,1+5*(idx-1):5+5*(idx-1));
    cc = [];
    for idxCell = 1:size(Y,1)
        a = polyfit(x,Y(idxCell,:),1);
        cc(idxCell) = a(1);
    end
    Y = [Y cc'];
    Y = sortrows(Y,6);
    Y(:,6) = [];
    figure
    set(gcf,'Position',[440 378 274 420]);
    clims = [0 1];
    imagesc(flipud(X), clims); colormap(brewermap([],'*RdBu')); axis tight
    set(gca,'XColor','w')
    set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'XTickLabel',[])
    set(gca,'YTick',[])
    set(gca,'YTickLabel',[])
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
    figure
    set(gcf,'Position',[440 378 274 420]);
    clims = [0 1];
    imagesc(flipud(Y), clims); colormap(brewermap([],'*RdBu')); axis tight
    set(gca,'XColor','w')
    set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'XTickLabel',[])
    set(gca,'YTick',[])
    set(gca,'YTickLabel',[])
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
end


%%
[tuningCurvesCoa, tuningCurvesAuRocCoa, tuningCurvesSigCoa, auROCSigCoa] = findTuningCurves_old(coaCS.esp, 1:15, 0);
[tuningCurvesPcx, tuningCurvesAuRocPcx, tuningCurvesSigPcx, auROCSigPcx] = findTuningCurves_old(pcxCS.esp, 1:15, 0);

tuningCurvesAuRocCoa = fliplr(tuningCurvesAuRocCoa);
tuningCurvesAuRocPcx = fliplr(tuningCurvesAuRocPcx);

x = 1:5;
for idx = 1:3
    X = [];
    X = tuningCurvesAuRocCoa(:,1+5*(idx-1):5+5*(idx-1));
    cc = [];
    for idxCell = 1:size(X,1)
        a = polyfit(x,X(idxCell,:),1);
        cc(idxCell) = a(1);
    end
    X = [X cc'];
    X = sortrows(X,6);
    X(:,6) = [];
    Y = [];
    Y = tuningCurvesAuRocPcx(:,1+5*(idx-1):5+5*(idx-1));
    cc = [];
    for idxCell = 1:size(Y,1)
        a = polyfit(x,Y(idxCell,:),1);
        cc(idxCell) = a(1);
    end
    Y = [Y cc'];
    Y = sortrows(Y,6);
    Y(:,6) = [];
    figure
    set(gcf,'Position',[440 378 274 420]);
    clims = [0 1];
    imagesc(flipud(X), clims); colormap(brewermap([],'*RdBu')); axis tight
    set(gca,'XColor','w')
    set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'XTickLabel',[])
    set(gca,'YTick',[])
    set(gca,'YTickLabel',[])
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
    figure
    set(gcf,'Position',[440 378 274 420]);
    clims = [0 1];
    imagesc(flipud(Y), clims); colormap(brewermap([],'*RdBu')); axis tight
    set(gca,'XColor','w')
    set(gca,'YColor','w')
    set(gca,'XTick',[])
    set(gca,'XTickLabel',[])
    set(gca,'YTick',[])
    set(gca,'YTickLabel',[])
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
end


%%
[VariantCoa, InvariantCoa, nonmonotonicCoa, nonmonotonicSemCoa, monotonicDCoa, monotonicDSemCoa, monotonicICoa, monotonicISemCoa, cellLogInvCoa, nCellsCoa] = findConcInvarianceAndMonotonicity_new(coaCS2.esp);
[VariantPcx, InvariantPcx, nonmonotonicPcx, nonmonotonicSemPcx, monotonicDPcx, monotonicDSemPcx, monotonicIPcx, monotonicISemPcx, cellLogInvPcx, nCellsPcx] = findConcInvarianceAndMonotonicity_new(pcxCS2.esp);
%%
for idxOdor = 1:3
xMean = [VariantCoa(idxOdor) VariantPcx(idxOdor); InvariantCoa(idxOdor) InvariantPcx(idxOdor)];
semCoa = sqrt(xMean(1,1) * xMean(2,1) / (nCellsCoa-1));
semPcx = sqrt(xMean(1,2) * xMean(2,2) / (nCellsPcx-1));
xSem = [semCoa, semPcx; semCoa, semPcx];
figure
b = barwitherr(xSem, xMean);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
end



for idxOdor = 1:3
    xMean = [nonmonotonicCoa(idxOdor) nonmonotonicPcx(idxOdor); monotonicDCoa(idxOdor) monotonicDPcx(idxOdor); monotonicICoa(idxOdor) monotonicIPcx(idxOdor)];
    xSem = [nonmonotonicSemCoa(idxOdor) nonmonotonicSemPcx(idxOdor); monotonicDSemCoa(idxOdor) monotonicDSemPcx(idxOdor); monotonicISemCoa(idxOdor) monotonicISemPcx(idxOdor)];
    figure
    b = barwitherr(xSem, xMean);
    b(1).EdgeColor = coaC;
    b(1).FaceColor = coaC;
    b(2).EdgeColor = pcxC;
    b(2).FaceColor = pcxC;
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
end
%%
[VariantCoa, InvariantCoa, nonmonotonicCoa, nonmonotonicSemCoa, monotonicDCoa, monotonicDSemCoa, monotonicICoa, monotonicISemCoa,  nCellsCoa] = findConcInvarianceAndMonotonicity_old(coaCS.esp);
[VariantPcx, InvariantPcx, nonmonotonicPcx, nonmonotonicSemPcx, monotonicDPcx, monotonicDSemPcx, monotonicIPcx, monotonicISemPcx,  nCellsPcx] = findConcInvarianceAndMonotonicity_old(pcxCS.esp);
%%
for idxOdor = 1:3
xMean = [VariantCoa(idxOdor) VariantPcx(idxOdor); InvariantCoa(idxOdor) InvariantPcx(idxOdor)];
semCoa = sqrt(xMean(1,1) * xMean(2,1) / (nCellsCoa-1));
semPcx = sqrt(xMean(1,2) * xMean(2,2) / (nCellsPcx-1));
xSem = [semCoa, semPcx; semCoa, semPcx];
figure
b = barwitherr(xSem, xMean);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
end



for idxOdor = 1:3
    xMean = [nonmonotonicCoa(idxOdor) nonmonotonicPcx(idxOdor); monotonicDCoa(idxOdor) monotonicDPcx(idxOdor); monotonicICoa(idxOdor) monotonicIPcx(idxOdor)];
    xSem = [nonmonotonicSemCoa(idxOdor) nonmonotonicSemPcx(idxOdor); monotonicDSemCoa(idxOdor) monotonicDSemPcx(idxOdor); monotonicISemCoa(idxOdor) monotonicISemPcx(idxOdor)];
    figure
    b = barwitherr(xSem, xMean);
    b(1).EdgeColor = coaC;
    b(1).FaceColor = coaC;
    b(2).EdgeColor = pcxC;
    b(2).FaceColor = pcxC;
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
end


%%
odors = 1:15;
[concCoa, totalResponsiveSUACoa] = findOdorDiscriminative_new(coaCS2.esp, odors, 0);
[concPcx, totalResponsiveSUAPcx] = findOdorDiscriminative_new(pcxCS2.esp, odors, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
concCoaP = concCoa ./ totalResponsiveSUACoa;
concPcxP = concPcx ./ totalResponsiveSUAPcx;
p_1 = ones(1,5);
p_1Coa = p_1 - concCoaP;
p_1Pcx = p_1 - concPcxP;

for idxConc = 1:5
    semCoa(idxConc) = sqrt(concCoaP(idxConc) * p_1Coa(idxConc) ./  (totalResponsiveSUACoa-1));
    semPcx(idxConc) = sqrt(concPcxP(idxConc) * p_1Pcx(idxConc) ./  (totalResponsiveSUAPcx-1));
end

meanX = [concCoaP', concPcxP'];
semX = [semCoa' semPcx'];

b = barwitherr(semX, meanX);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
%%
odors = 1:15;
[concCoa, totalResponsiveSUACoa] = findOdorDiscriminative_new2(coaCS.esp, odors);
[concPcx, totalResponsiveSUAPcx] = findOdorDiscriminative_new2(pcxCS.esp, odors);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
concCoaP = concCoa ./ totalResponsiveSUACoa;
concPcxP = concPcx ./ totalResponsiveSUAPcx;
p_1 = ones(1,5);
p_1Coa = p_1 - concCoaP;
p_1Pcx = p_1 - concPcxP;

for idxConc = 1:5
    semCoa(idxConc) = sqrt(concCoaP(idxConc) * p_1Coa(idxConc) ./  (totalResponsiveSUACoa-1));
    semPcx(idxConc) = sqrt(concPcxP(idxConc) * p_1Pcx(idxConc) ./  (totalResponsiveSUAPcx-1));
end

meanX = [concCoaP', concPcxP'];
semX = [semCoa' semPcx'];

b = barwitherr(semX, meanX);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)

%%
odorsRearranged = 1:15;
[scoresCoa, scoresMeanCoa, explainedMeanCoa, explaineStdCoa] = findCodingSpace_new(coaCS2.esp, odorsRearranged);


figure
colorClass1 = flipud([254,240,217;...
253,204,138;...
252,141,89;...
227,74,51;...
179,0,0]./255);

colorClass2 = flipud([239,243,255;...
189,215,231;...
107,174,214;...
49,130,189;...
8,81,156]./255);

colorClass3 = flipud([237,248,233;...
186,228,179;... 
116,196,118;...
49,163,84;...
0,109,44]./255);

colorClass = cat(3,colorClass1, colorClass2, colorClass3);


k = 0;
for idxOdor = 1:3
    C = squeeze(colorClass(:,:,idxOdor));
    for idxConc = 1:5
        scatter3(scoresCoa(1 + k*5:5 + k*5, 1), scoresCoa(1 + k*5:5 + k*5, 2), scoresCoa(1 + k*5:5 + k*5, 3), 100, C(idxConc,:), 'o', 'filled');
        k = k + 1;
        hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('plCOA');
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%
odorsRearranged = 1:15;
[scoresPcx, scoresMeanPcx, explainedMeanPcx, explaineStdPcx] = findCodingSpace_new(pcxCS2.esp, odorsRearranged);
figure
colorClass1 = flipud([254,240,217;...
253,204,138;...
252,141,89;...
227,74,51;...
179,0,0]./255);

colorClass2 = flipud([239,243,255;...
189,215,231;...
107,174,214;...
49,130,189;...
8,81,156]./255);

colorClass3 = flipud([237,248,233;...
186,228,179;...
116,196,118;...
49,163,84;...
0,109,44]./255);
symbolOdor = {'o', 's', 'p'};
k = 0;
colorClass = cat(3,colorClass1, colorClass2, colorClass3);
for idxOdor = 1:3
    C = squeeze(colorClass(:,:,idxOdor));
    for idxConc = 1:5
        scatter3(scoresPcx(1 + k*5:5 + k*5, 1), scoresPcx(1 + k*5:5 + k*5, 2), scoresPcx(1 + k*5:5 + k*5, 3), 100, C(idxConc,:), 'o', 'filled');
        k = k + 1;
        hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('PCX');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
%%
odorsRearranged = 1:15;
[scoresCoa, scoresMeanCoa, explainedMeanCoa, explaineStdCoa] = findCodingSpace(coaCS.esp, odorsRearranged);


figure
colorClass1 = flipud([254,240,217;...
253,204,138;...
252,141,89;...
227,74,51;...
179,0,0]./255);

colorClass2 = flipud([239,243,255;...
189,215,231;...
107,174,214;...
49,130,189;...
8,81,156]./255);

colorClass3 = flipud([237,248,233;...
186,228,179;... 
116,196,118;...
49,163,84;...
0,109,44]./255);

colorClass = cat(3,colorClass1, colorClass2, colorClass3);


k = 0;
for idxOdor = 1:3
    C = squeeze(colorClass(:,:,idxOdor));
    for idxConc = 1:5
        scatter3(scoresCoa(1 + k*5:5 + k*5, 1), scoresCoa(1 + k*5:5 + k*5, 2), scoresCoa(1 + k*5:5 + k*5, 3), 100, C(idxConc,:), 'o', 'filled');
        k = k + 1;
        hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('plCOA');
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%
odorsRearranged = 1:15;
[scoresPcx, scoresMeanPcx, explainedMeanPcx, explaineStdPcx] = findCodingSpace(pcxCS.esp, odorsRearranged);
figure
colorClass1 = flipud([254,240,217;...
253,204,138;...
252,141,89;...
227,74,51;...
179,0,0]./255);

colorClass2 = flipud([239,243,255;...
189,215,231;...
107,174,214;...
49,130,189;...
8,81,156]./255);

colorClass3 = flipud([237,248,233;...
186,228,179;...
116,196,118;...
49,163,84;...
0,109,44]./255);
symbolOdor = {'o', 's', 'p'};
k = 0;
colorClass = cat(3,colorClass1, colorClass2, colorClass3);
for idxOdor = 1:3
    C = squeeze(colorClass(:,:,idxOdor));
    for idxConc = 1:5
        scatter3(scoresPcx(1 + k*5:5 + k*5, 1), scoresPcx(1 + k*5:5 + k*5, 2), scoresPcx(1 + k*5:5 + k*5, 3), 100, C(idxConc,:), 'o', 'filled');
        k = k + 1;
        hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('PCX');
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%
odorsRearranged = 1:15;
[ACoa, aCoa, bCoa, cCoa, dCoa, eCoa, f1Coa, f2Coa, f3Coa, g1Coa, g2Coa, g3Coa, h1Coa, h2Coa, h3Coa, i1Coa, i2Coa, i3Coa, l1Coa, l2Coa, l3Coa] =...
    findCorrelationsConc_new(coaCS2.esp, odorsRearranged);

odorsRearranged = 1:15;
[APcx, aPcx, bPcx, cPcx, dPcx, ePcx, f1Pcx, f2Pcx, f3Pcx, g1Pcx, g2Pcx, g3Pcx, h1Pcx, h2Pcx, h3Pcx, i1Pcx, i2Pcx, i3Pcx, l1Pcx, l2Pcx, l3Pcx] =...
    findCorrelationsConc_new(pcxCS2.esp, odorsRearranged);

AcoaMean = fliplr(mean(aCoa));
AcoaSEM = fliplr(std(aCoa)/sqrt(2));

ApcxMean = fliplr(mean(aPcx));
ApcxSEM = fliplr(std(aPcx)/sqrt(2));

%%
figure
plot(1:4, AcoaMean, '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(1.1:4.1, ApcxMean, '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(1:4, AcoaMean, AcoaSEM, 'r', 'linewidth', 2); %
hold on
errbar(1.1:4.1, ApcxMean, ApcxSEM, 'k', 'linewidth', 2);
%title('odor concentration')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
xlim([0.8 4.6]);
ylim([-1 1]);
ylabel('pairwise correlation')

%%

fmeanCoa = mean([f1Coa, f2Coa, f3Coa]);
fsemCoa = std([f1Coa, f2Coa, f3Coa])/sqrt(2);

gmeanCoa = mean([g1Coa, g2Coa, g3Coa]);
gsemCoa = std([g1Coa, g2Coa, g3Coa])/sqrt(2);

hmeanCoa = mean([h1Coa, h2Coa, h3Coa]);
hsemCoa = std([h1Coa, h2Coa, h3Coa])/sqrt(2);

imeanCoa = mean([i1Coa, i2Coa, i3Coa]);
isemCoa = std([i1Coa, i2Coa, i3Coa])/sqrt(2);

lmeanCoa = mean([l1Coa, l2Coa, l3Coa]);
lsemCoa = std([l1Coa, l2Coa, l3Coa])/sqrt(2);

meanICoa = [fmeanCoa gmeanCoa hmeanCoa imeanCoa lmeanCoa];
semICoa = [fsemCoa gsemCoa hsemCoa isemCoa lsemCoa];

fmeanPcx = mean([f1Pcx, f2Pcx, f3Pcx]);
fsemPcx = std([f1Pcx, f2Pcx, f3Pcx])/sqrt(2);

gmeanPcx = mean([g1Pcx, g2Pcx, g3Pcx]);
gsemPcx = std([g1Pcx, g2Pcx, g3Pcx])/sqrt(2);

hmeanPcx = mean([h1Pcx, h2Pcx, h3Pcx]);
hsemPcx = std([h1Pcx, h2Pcx, h3Pcx])/sqrt(2);

imeanPcx = mean([i1Pcx, i2Pcx, i3Pcx]);
isemPcx = std([i1Pcx, i2Pcx, i3Pcx])/sqrt(2);

lmeanPcx = mean([l1Pcx, l2Pcx, l3Pcx]);
lsemPcx = std([l1Pcx, l2Pcx, l3Pcx])/sqrt(2);

meanIPcx = [fmeanPcx gmeanPcx hmeanPcx imeanPcx lmeanPcx];
semIPcx = [fsemPcx gsemPcx hsemPcx isemPcx lsemPcx];

figure
plot(1:5, fliplr(meanICoa), '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(1.1:5.1, fliplr(meanIPcx), '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(1:5, fliplr(meanICoa), fliplr(semICoa), 'r', 'linewidth', 2); %
hold on
errbar(1.1:5.1, fliplr(meanIPcx), fliplr(semIPcx), 'k', 'linewidth', 2);
%title('odor concentration')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
xlim([0.8 5.6]);
ylim([-1 1]);
%%
odorsRearranged = 1:15;
[ACoa, aCoa, bCoa, cCoa, dCoa, eCoa, f1Coa, f2Coa, f3Coa, g1Coa, g2Coa, g3Coa, h1Coa, h2Coa, h3Coa, i1Coa, i2Coa, i3Coa, l1Coa, l2Coa, l3Coa] =...
    findCorrelationsConc(coaCS.esp, odorsRearranged);

odorsRearranged = 1:15;
[APcx, aPcx, bPcx, cPcx, dPcx, ePcx, f1Pcx, f2Pcx, f3Pcx, g1Pcx, g2Pcx, g3Pcx, h1Pcx, h2Pcx, h3Pcx, i1Pcx, i2Pcx, i3Pcx, l1Pcx, l2Pcx, l3Pcx] =...
    findCorrelationsConc(pcxCS.esp, odorsRearranged);

AcoaMean = fliplr(mean(aCoa));
AcoaSEM = fliplr(std(aCoa)/sqrt(2));

ApcxMean = fliplr(mean(aPcx));
ApcxSEM = fliplr(std(aPcx)/sqrt(2));

%%
figure
plot(1:4, AcoaMean, '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(1.1:4.1, ApcxMean, '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(1:4, AcoaMean, AcoaSEM, 'r', 'linewidth', 2); %
hold on
errbar(1.1:4.1, ApcxMean, ApcxSEM, 'k', 'linewidth', 2);
%title('odor concentration')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
xlim([0.8 4.6]);
ylim([-1 1]);
ylabel('pairwise correlation')

%%

fmeanCoa = mean([f1Coa, f2Coa, f3Coa]);
fsemCoa = std([f1Coa, f2Coa, f3Coa])/sqrt(2);

gmeanCoa = mean([g1Coa, g2Coa, g3Coa]);
gsemCoa = std([g1Coa, g2Coa, g3Coa])/sqrt(2);

hmeanCoa = mean([h1Coa, h2Coa, h3Coa]);
hsemCoa = std([h1Coa, h2Coa, h3Coa])/sqrt(2);

imeanCoa = mean([i1Coa, i2Coa, i3Coa]);
isemCoa = std([i1Coa, i2Coa, i3Coa])/sqrt(2);

lmeanCoa = mean([l1Coa, l2Coa, l3Coa]);
lsemCoa = std([l1Coa, l2Coa, l3Coa])/sqrt(2);

meanICoa = [fmeanCoa gmeanCoa hmeanCoa imeanCoa lmeanCoa];
semICoa = [fsemCoa gsemCoa hsemCoa isemCoa lsemCoa];

fmeanPcx = mean([f1Pcx, f2Pcx, f3Pcx]);
fsemPcx = std([f1Pcx, f2Pcx, f3Pcx])/sqrt(2);

gmeanPcx = mean([g1Pcx, g2Pcx, g3Pcx]);
gsemPcx = std([g1Pcx, g2Pcx, g3Pcx])/sqrt(2);

hmeanPcx = mean([h1Pcx, h2Pcx, h3Pcx]);
hsemPcx = std([h1Pcx, h2Pcx, h3Pcx])/sqrt(2);

imeanPcx = mean([i1Pcx, i2Pcx, i3Pcx]);
isemPcx = std([i1Pcx, i2Pcx, i3Pcx])/sqrt(2);

lmeanPcx = mean([l1Pcx, l2Pcx, l3Pcx]);
lsemPcx = std([l1Pcx, l2Pcx, l3Pcx])/sqrt(2);

meanIPcx = [fmeanPcx gmeanPcx hmeanPcx imeanPcx lmeanPcx];
semIPcx = [fsemPcx gsemPcx hsemPcx isemPcx lsemPcx];

figure
plot(1:5, fliplr(meanICoa), '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(1.1:5.1, fliplr(meanIPcx), '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(1:5, fliplr(meanICoa), fliplr(semICoa), 'r', 'linewidth', 2); %
hold on
errbar(1.1:5.1, fliplr(meanIPcx), fliplr(semIPcx), 'k', 'linewidth', 2);
%title('odor concentration')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
xlim([0.8 5.6]);
ylim([-1 1]);













