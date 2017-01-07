odors = 1:15;
%%
[VariantCoa, InvariantCoa, nonmonotonicCoa, nonmonotonicSemCoa, monotonicDCoa, monotonicDSemCoa, monotonicICoa, monotonicISemCoa] = findConcInvarianceAndMonotonicity_new(coaCS2.esp);
[VariantPcx, InvariantPcx, nonmonotonicPcx, nonmonotonicSemPcx, monotonicDPcx, monotonicDSemPcx, monotonicIPcx, monotonicISemPcx] = findConcInvarianceAndMonotonicity_new(pcxCS2.esp);
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
for idxOdor = 1:3
xMean = [VariantCoa(idxOdor) VariantPcx(idxOdor); InvariantCoa(idxOdor) InvariantPcx(idxOdor)];
semCoa = sqrt(xMean(1,1) * xMean(2,1) / (numel(totalResponsiveSUACoa)-1));
semPcx = sqrt(xMean(1,2) * xMean(2,2) / (numel(totalResponsiveSUAPcx)-1));
xSem = [semCoa, semPcx; semCoa, semPcx];
subplot(3,1,idxOdor)
b = barwitherr(xSem, xMean);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
end

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
for idxOdor = 1:3
    xMean = [nonmonotonicCoa(idxOdor) nonmonotonicPcx(idxOdor); monotonicDCoa(idxOdor) monotonicDPcx(idxOdor); monotonicICoa(idxOdor) monotonicIPcx(idxOdor)];
    xSem = [nonmonotonicSemCoa(idxOdor) nonmonotonicSemPcx(idxOdor); monotonicDSemCoa(idxOdor) monotonicDSemPcx(idxOdor); monotonicISemCoa(idxOdor) monotonicISemPcx(idxOdor)];
    subplot(3,1,idxOdor)
    b = barwitherr(xSem, xMean);
    b(1).EdgeColor = coaC;
    b(1).FaceColor = coaC;
    b(2).EdgeColor = pcxC;
    b(2).FaceColor = pcxC;
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
end
%%
[concCoa, totalResponsiveSUACoa] = findOdorDiscriminative_new2(coaCS2.esp, odors);
[concPcx, totalResponsiveSUAPcx] = findOdorDiscriminative_new2(pcxCS2.esp, odors);
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
[ACoa, aCoa, bCoa, cCoa, dCoa, eCoa, f1Coa, f2Coa, f3Coa, g1Coa, g2Coa, g3Coa, h1Coa, h2Coa, h3Coa, i1Coa, i2Coa, i3Coa, l1Coa, l2Coa, l3Coa] =...
    findCorrelationsConc_new(coaCS2.esp, 1:15);
[APcx, aPcx, bPcx, cPcx, dPcx, ePcx, f1Pcx, f2Pcx, f3Pcx, g1Pcx, g2Pcx, g3Pcx, h1Pcx, h2Pcx, h3Pcx, i1Pcx, i2Pcx, i3Pcx, l1Pcx, l2Pcx, l3Pcx] =...
    findCorrelationsConc_new(pcxCS2.esp, 1:15);

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
% xlim([0.8 4.6]);
% ylim([-0.5 0.5]);
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
% xlim([0.8 5.6]);
% ylim([-0.5 0.5]);


