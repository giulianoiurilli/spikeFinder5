[ACoa, aCoa, bCoa, cCoa, dCoa, eCoa, f1Coa, f2Coa, f3Coa, g1Coa, g2Coa, g3Coa, h1Coa, h2Coa, h3Coa, i1Coa, i2Coa, i3Coa, l1Coa, l2Coa, l3Coa] =...
    findCorrelationsConc(coaCS.esp, 1:15);
[APcx, aPcx, bPcx, cPcx, dPcx, ePcx, f1Pcx, f2Pcx, f3Pcx, g1Pcx, g2Pcx, g3Pcx, h1Pcx, h2Pcx, h3Pcx, i1Pcx, i2Pcx, i3Pcx, l1Pcx, l2Pcx, l3Pcx] =...
    findCorrelationsConc(pcxCS.esp, 1:15);

AcoaMean = mean(aCoa);
AcoaSEM = std(aCoa)/sqrt(2);

ApcxMean = mean(aPcx);
ApcxSEM = std(aPcx)/sqrt(2);

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
ylim([0 1]);
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
plot(1:5, meanICoa, '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(1.1:5.1, meanIPcx, '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(1:5, meanICoa, semICoa, 'r', 'linewidth', 2); %
hold on
errbar(1.1:5.1, meanIPcx, semIPcx, 'k', 'linewidth', 2);
%title('odor concentration')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
xlim([0.8 5.6]);
ylim([0 1]);



%%
A = [];
A = [aCoa(:); aPcx(:)];
g1 = repmat([1:3]', 4*2, 1);
g2 = [1 1 1 2 2 2 3 3 3 4 4 4 1 1 1 2 2 2 3 3 3 4 4 4]';
g3 = [repmat(1,12,1) ; repmat(2, 12, 1)];
p = anovan(A, {g1, g2, g3});

idx = triu(true(5,5),1);
bCoa1 = squeeze(bCoa(:,:,1));
bCoa2 = squeeze(bCoa(:,:,2));
bCoa3 = squeeze(bCoa(:,:,3));
xCoa = [bCoa1(idx); bCoa2(idx); bCoa3(idx)];
yCoa = [cCoa(:); dCoa(:); eCoa(:)];

bPcx1 = squeeze(bPcx(:,:,1));
bPcx2 = squeeze(bPcx(:,:,2));
bPcx3 = squeeze(bPcx(:,:,3));
xPcx = [bPcx1(idx); bPcx2(idx); bPcx3(idx)];
yPcx = [cPcx(:); dPcx(:); ePcx(:)];

figure
[xHistCoa15, yHistCoa15, handles] = distributionPlot(xCoa,'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15, yHistPcx15, handles] = distributionPlot(xPcx,'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistCoa15d, yHistCoa15d, handles] = distributionPlot(yCoa,'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
[xHistPcx15d, yHistPcx15d, handles] = distributionPlot(yPcx,'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped');
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
%%
z = [];
b = [];
z = [mean(yCoa); mean(yPcx)];
z1 = [std(yCoa)/sqrt(numel(yCoa)-1); std(yPcx)/sqrt(numel(yPcx)-1)];
figure
b = bar(z);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
ylim([0.2 0.9])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

%%

%%

[pop_sparseness1000Coa15] = findPopulationSparseness(coa15.esp, 1:15);
[pop_sparseness1000Pcx15] = findPopulationSparseness(pcx15.esp, 1:15);

figure
b1 = bar(mean(pop_sparseness1000Coa15));
b1.EdgeColor = coaC;
b1.FaceColor = coaC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
figure
b2 = bar(mean(pop_sparseness1000Pcx15));
b2.EdgeColor = pcxC;
b2.FaceColor = pcxC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
[pop_sparseness1000CoaAA] = findPopulationSparseness(coaAA.esp, 1:10);
[pop_sparseness1000PcxAA] = findPopulationSparseness(pcxAA.esp, 1:10);

figure
b1 = bar(mean(pop_sparseness1000CoaAA));
b1.EdgeColor = coaC;
b1.FaceColor = coaC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
figure
b2 = bar(mean(pop_sparseness1000PcxAA));
b2.EdgeColor = pcxC;
b2.FaceColor = pcxC;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
