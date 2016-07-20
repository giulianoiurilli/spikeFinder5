odorsx = [1 2 3 4 5 6 7 8 9 10 14 12 13 11 15];
[responsivenessExc300msCoa, responsivenessExc1000msCoa, responsivenessInh300msCoa, responsivenessInh1000msCoa,...
    aurocs1000msCoa, aurocs300msCoa, gVar300Coa, gVar1000Coa, infoOdorIDCoa, infoConcIDCoa, onsetLatCoa, halfWidthCoa, cellLogCoa] = concSeriesAnalysis(coaCS.esp, odorsx);
[responsivenessExc300msPcx, responsivenessExc1000msPcx, responsivenessInh300msPcx, responsivenessInh1000msPcx,...
    aurocs1000msPcx, aurocs300msPcx, gVar300Pcx, gVar1000Pcx, infoOdorIDPcx, infoConcIDPcx, onsetLatPcx, halfWidthPcx, cellLogPcx] = concSeriesAnalysis(pcxCS.esp, odors);


%%
meanAurocCoa300 = mean(aurocs300msCoa);
meanAurocCoa1000 = mean(aurocs1000msCoa);
semAurocCoa300 = std(aurocs300msCoa) ./ sqrt(size(aurocs300msCoa,1));
semAurocCoa1000 = std(aurocs1000msCoa) ./ sqrt(size(aurocs1000msCoa,1));

meanGvarCoa300 = mean(gVar300Coa);
meanGvarCoa1000 = mean(gVar1000Coa);
semGvarCoa300 = std(gVar300Coa) ./ sqrt(size(gVar300Coa,1));
semGvarCoa1000 = std(gVar1000Coa) ./ sqrt(size(gVar1000Coa,1));

meanOnsetLatCoa = nanmean(onsetLatCoa);
meanHalfWidthCoa = nanmean(halfWidthCoa);
semOnsetLatCoa = nanstd(onsetLatCoa) ./ sqrt(size(onsetLatCoa,1));
semWidthCoa = nanstd(halfWidthCoa) ./ sqrt(size(halfWidthCoa,1));

pMeanCoaExc300 = sum(responsivenessExc300msCoa) ./ size(responsivenessExc300msCoa,1);
pMeanCoaExc1000 = sum(responsivenessExc1000msCoa) ./ size(responsivenessExc1000msCoa,1);
pSemCoaExc300  = sqrt((pMeanCoaExc300 .* (1 - pMeanCoaExc300)) ./ size(responsivenessExc300msCoa,1));
pSemCoaExc1000  = sqrt((pMeanCoaExc1000 .* (1 - pMeanCoaExc1000)) ./ size(responsivenessExc1000msCoa,1));

pMeanCoaInh300 = sum(responsivenessInh300msCoa) ./ size(responsivenessInh300msCoa,1);
pMeanCoaInh1000 = sum(responsivenessInh1000msCoa) ./ size(responsivenessInh1000msCoa,1);
pSemCoaInh300  = sqrt((pMeanCoaInh300 .* (1 - pMeanCoaInh300)) ./ size(responsivenessInh300msCoa,1));
pSemCoaInh1000  = sqrt((pMeanCoaInh1000 .* (1 - pMeanCoaInh1000)) ./ size(responsivenessInh1000msCoa,1));

meanAurocPcx300 = mean(aurocs300msPcx);
meanAurocPcx1000 = mean(aurocs1000msPcx);
semAurocPcx300 = std(aurocs300msPcx) ./ sqrt(size(aurocs300msPcx,1));
semAurocPcx1000 = std(aurocs1000msPcx) ./ sqrt(size(aurocs1000msPcx,1));

meanGvarPcx300 = mean(gVar300Pcx);
meanGvarPcx1000 = mean(gVar1000Pcx);
semGvarPcx300 = std(gVar300Pcx) ./ sqrt(size(gVar300Pcx,1));
semGvarPcx1000 = std(gVar1000Pcx) ./ sqrt(size(gVar1000Pcx,1));

meanOnsetLatPcx = nanmean(onsetLatPcx);
meanHalfWidthPcx = nanmean(halfWidthPcx);
semOnsetLatPcx = nanstd(onsetLatPcx) ./ sqrt(size(onsetLatPcx,1));
semWidthPcx = nanstd(halfWidthPcx) ./ sqrt(size(halfWidthPcx,1));

pMeanPcxExc300 = sum(responsivenessExc300msPcx) ./ size(responsivenessExc300msPcx,1);
pMeanPcxExc1000 = sum(responsivenessExc1000msPcx) ./ size(responsivenessExc1000msPcx,1);
pSemPcxExc300  = sqrt((pMeanPcxExc300 .* (1 - pMeanPcxExc300)) ./ size(responsivenessExc300msPcx,1));
pSemPcxExc1000  = sqrt((pMeanPcxExc1000 .* (1 - pMeanPcxExc1000)) ./ size(responsivenessExc1000msPcx,1));

pMeanPcxInh300 = sum(responsivenessInh300msPcx) ./ size(responsivenessInh300msPcx,1);
pMeanPcxInh1000 = sum(responsivenessInh1000msPcx) ./ size(responsivenessInh1000msPcx,1);
pSemPcxInh300  = sqrt((pMeanPcxInh300 .* (1 - pMeanPcxInh300)) ./ size(responsivenessInh300msPcx,1));
pSemPcxInh1000  = sqrt((pMeanPcxInh1000 .* (1 - pMeanPcxInh1000)) ./ size(responsivenessInh1000msPcx,1));


%%
figure
set(gcf,'Name', 'Figure 3: Tuning', 'NumberTitle', 'off');
set(gcf,'Position',[255 68 1359 985]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
p = panel();
p.pack('h', {1/2 1/2});
p(1).pack('h', {1/3, 1/3, 1/3});
p(2).pack('h', {1/3, 1/3, 1/3});
p(1,1).pack('v', {30 70});
p(1,2).pack('v', {30 70});
p(1,3).pack('v', {30 70});
p(2,1).pack('v', {30 70});
p(2,2).pack('v', {30 70});
p(2,3).pack('v', {30 70});
p(1,1,2).pack('v', {25 25 25 25});
p(1,2,2).pack('v', {25 25 25 25});
p(1,3,2).pack('v', {25 25 25 25});
p(2,1,2).pack('v', {25 25 25 25});
p(2,2,2).pack('v', {25 25 25 25});
p(2,3,2).pack('v', {25 25 25 25});

% p.select('all');
% p.identify()

clims = [0 1];
p(1,1,1).select()
imagesc(aurocs1000msCoa(:,1:5), clims); colormap(brewermap([],'*RdBu')); axis tight
colorbar
set(gca,'XColor','w')
ylabel('Neuron ID')
title('Pentanal')
p(1,2,1).select()
imagesc(aurocs1000msCoa(:,6:10), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
set(gca,'YColor','w')
title('Ethyl tiglate')
p(1,3,1).select()
imagesc(aurocs1000msCoa(:,11:15), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
set(gca,'YColor','w')
title('Isoamylacetate')
p(2,1,1).select()
imagesc(aurocs1000msPcx(:,1:5), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
ylabel('Neuron ID')
title('Pentanal')
p(2,2,1).select()
imagesc(aurocs1000msPcx(:,6:10), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
set(gca,'YColor','w')
title('Ethyl tiglate')
p(2,3,1).select()
imagesc(aurocs1000msPcx(:,11:15), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
set(gca,'YColor','w')
title('Isoamylacetate')


p(1,1,2,1).select()
hold on
plot([1 2 3 4 5], pMeanCoaExc300(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaExc300(1:5), pSemCoaExc300(1:5), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], pMeanCoaExc1000(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaExc1000(1:5), pSemCoaExc1000(1:5), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
ylabel('Excited neurons (fraction)')
xlim([0.5 5.5])
ylim([0 0.3])
p(1,1,2,2).select()
hold on
plot([1 2 3 4 5], pMeanCoaInh300(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaInh300(1:5), pSemCoaInh300(1:5), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], pMeanCoaInh1000(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaInh1000(1:5), pSemCoaInh1000(1:5), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
ylabel('Inhibited neurons (fraction)')
xlim([0.5 5.5])
ylim([0 0.1])
p(1,1,2,3).select()
hold on
plot([1 2 3 4 5], meanAurocCoa300(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], meanAurocCoa300(1:5), semAurocCoa300(1:5), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], meanAurocCoa1000(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanAurocCoa1000(1:5), semAurocCoa1000(1:5), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
ylabel('auROC')
xlim([0.5 5.5])
ylim([0.45 0.65])
p(1,1,2,4).select()
hold on
plot([1 2 3 4 5], meanGvarCoa300(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], meanGvarCoa300(1:5), semGvarCoa300(1:5), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], meanGvarCoa1000(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanGvarCoa1000(1:5), semGvarCoa1000(1:5), 'linewidth', 2, 'color', coaC)
set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off')
xlabel('Concentration')
xlim([0.5 5.5])
ylim([0.5 2.5])
ylabel('Mean Response Variance')

p(1,2,2,1).select()
hold on
plot([1 2 3 4 5], pMeanCoaExc300(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaExc300(6:10), pSemCoaExc300(6:10), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], pMeanCoaExc1000(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaExc1000(6:10), pSemCoaExc1000(6:10), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0 0.3])
p(1,2,2,2).select()
hold on
plot([1 2 3 4 5], pMeanCoaInh300(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaInh300(6:10), pSemCoaInh300(1:5), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], pMeanCoaInh1000(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaInh1000(6:10), pSemCoaInh1000(6:10), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0 0.1])
p(1,2,2,3).select()
hold on
plot([1 2 3 4 5], meanAurocCoa300(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], meanAurocCoa300(6:10), semAurocCoa300(6:10), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], meanAurocCoa1000(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanAurocCoa1000(6:10), semAurocCoa1000(6:10), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0.45 0.65])
p(1,2,2,4).select()
hold on
plot([1 2 3 4 5], meanGvarCoa300(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], meanGvarCoa300(6:10), semGvarCoa300(6:10), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], meanGvarCoa1000(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanGvarCoa1000(6:10), semGvarCoa1000(6:10), 'linewidth', 2, 'color', coaC)
set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off')
xlabel('Concentration')
xlim([0.5 5.5])
ylim([0.5 2.5])

p(1,3,2,1).select()
hold on
plot([1 2 3 4 5], pMeanCoaExc300(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaExc300(11:15), pSemCoaExc300(11:15), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], pMeanCoaExc1000(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaExc1000(11:15), pSemCoaExc1000(11:15), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0 0.3])
p(1,3,2,2).select()
hold on
plot([1 2 3 4 5], pMeanCoaInh300(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaInh300(11:15), pSemCoaInh300(11:15), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], pMeanCoaInh1000(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], pMeanCoaInh1000(11:15), pSemCoaInh1000(11:15), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0 0.1])
p(1,3,2,3).select()
hold on
plot([1 2 3 4 5], meanAurocCoa300(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], meanAurocCoa300(11:15), semAurocCoa300(11:15), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], meanAurocCoa1000(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanAurocCoa1000(11:15), semAurocCoa1000(11:15), 'linewidth', 2, 'color', coaC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0.45 0.65])
p(1,3,2,4).select()
hold on
plot([1 2 3 4 5], meanGvarCoa300(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC)
errbar([1 2 3 4 5], meanGvarCoa300(11:15), semGvarCoa300(11:15), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5], meanGvarCoa1000(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanGvarCoa1000(11:15), semGvarCoa1000(11:15), 'linewidth', 2, 'color', coaC)
set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off')
xlabel('Concentration')
xlim([0.5 5.5])
ylim([0.5 2.5])



p(2,1,2,1).select()
hold on
plot([1 2 3 4 5], pMeanPcxExc300(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxExc300(1:5), pSemPcxExc300(1:5), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], pMeanPcxExc1000(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxExc1000(1:5), pSemPcxExc1000(1:5), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
ylim([0 0.3])
xlim([0.5 5.5])
p(2,1,2,2).select()
hold on
plot([1 2 3 4 5], pMeanPcxInh300(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxInh300(1:5), pSemPcxInh300(1:5), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], pMeanPcxInh1000(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxInh1000(1:5), pSemPcxInh1000(1:5), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0 0.1])
p(2,1,2,3).select()
hold on
plot([1 2 3 4 5], meanAurocPcx300(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], meanAurocPcx300(1:5), semAurocPcx300(1:5), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], meanAurocPcx1000(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], meanAurocPcx1000(1:5), semAurocPcx1000(1:5), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0.45 0.65])
p(2,1,2,4).select()
hold on
plot([1 2 3 4 5], meanGvarPcx300(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], meanGvarPcx300(1:5), semGvarPcx300(1:5), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], meanGvarPcx1000(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], meanGvarPcx1000(1:5), semGvarPcx1000(1:5), 'linewidth', 2, 'color', pcxC)
set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off')
xlabel('Concentration')
xlim([0.5 5.5])
ylim([0.5 2.5])


p(2,2,2,1).select()
hold on
plot([1 2 3 4 5], pMeanPcxExc300(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxExc300(6:10), pSemPcxExc300(6:10), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], pMeanPcxExc1000(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxExc1000(6:10), pSemPcxExc1000(6:10), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
ylim([0 0.3])
xlim([0.5 5.5])
p(2,2,2,2).select()
hold on
plot([1 2 3 4 5], pMeanPcxInh300(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxInh300(6:10), pSemPcxInh300(1:5), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], pMeanPcxInh1000(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxInh1000(6:10), pSemPcxInh1000(6:10), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0 0.1])
p(2,2,2,3).select()
hold on
plot([1 2 3 4 5], meanAurocPcx300(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], meanAurocPcx300(6:10), semAurocPcx300(6:10), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], meanAurocPcx1000(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], meanAurocPcx1000(6:10), semAurocPcx1000(6:10), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0.45 0.65])
p(2,2,2,4).select()
hold on
plot([1 2 3 4 5], meanGvarPcx300(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], meanGvarPcx300(6:10), semGvarPcx300(6:10), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], meanGvarPcx1000(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], meanGvarPcx1000(6:10), semGvarPcx1000(6:10), 'linewidth', 2, 'color', pcxC)
set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off')
xlabel('Concentration')
xlim([0.5 5.5])
ylim([0.5 2.5])

p(2,3,2,1).select()
hold on
plot([1 2 3 4 5], pMeanPcxExc300(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxExc300(11:15), pSemPcxExc300(11:15), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], pMeanPcxExc1000(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxExc1000(11:15), pSemPcxExc1000(11:15), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0 0.3])
p(2,3,2,2).select()
hold on
plot([1 2 3 4 5], pMeanPcxInh300(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxInh300(11:15), pSemPcxInh300(11:15), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], pMeanPcxInh1000(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], pMeanPcxInh1000(11:15), pSemPcxInh1000(11:15), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0 0.1])
p(2,3,2,3).select()
hold on
plot([1 2 3 4 5], meanAurocPcx300(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], meanAurocPcx300(11:15), semAurocPcx300(11:15), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], meanAurocPcx1000(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], meanAurocPcx1000(11:15), semAurocPcx1000(11:15), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off')
xlim([0.5 5.5])
ylim([0.45 0.65])
p(2,3,2,4).select()
hold on
plot([1 2 3 4 5], meanGvarPcx300(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
errbar([1 2 3 4 5], meanGvarPcx300(11:15), semGvarPcx300(11:15), 'linewidth', 2, 'color', pcxC)
plot([1 2 3 4 5], meanGvarPcx1000(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5], meanGvarPcx1000(11:15), semGvarPcx1000(11:15), 'linewidth', 2, 'color', pcxC)
set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off')
xlabel('Concentration')
xlim([0.5 5.5])
ylim([0.5 2.5])


p.select('all');
p.de.margin = 2;
p(1).marginright = 50;
p(1,1).marginright = 15;
p(1,2).marginright = 15;
p(2,1).marginright = 15;
p(2,2).marginright = 15;

p(1,1,1).marginbottom = 10;
p(1,2,1).marginbottom = 10;
p(1,3,1).marginbottom = 10;
p(2,1,1).marginbottom = 10;
p(2,2,1).marginbottom = 10;
p(2,3,1).marginbottom = 10;

p(1,1,2,1).marginbottom = 10;
p(1,1,2,2).marginbottom = 10;
p(1,1,2,3).marginbottom = 10;
p(1,1,2,4).marginbottom = 10;

p(1,2,2,1).marginbottom = 10;
p(1,2,2,2).marginbottom = 10;
p(1,2,2,3).marginbottom = 10;
p(1,2,2,4).marginbottom = 10;

p(1,3,2,1).marginbottom = 10;
p(1,3,2,2).marginbottom = 10;
p(1,3,2,3).marginbottom = 10;
p(1,3,2,4).marginbottom = 10;

p(2,1,2,1).marginbottom = 10;
p(2,1,2,2).marginbottom = 10;
p(2,1,2,3).marginbottom = 10;
p(2,1,2,4).marginbottom = 10;

p(2,2,2,1).marginbottom = 10;
p(2,2,2,2).marginbottom = 10;
p(2,2,2,3).marginbottom = 10;
p(2,2,2,4).marginbottom = 10;

p(2,3,2,1).marginbottom = 10;
p(2,3,2,2).marginbottom = 10;
p(2,3,2,3).marginbottom = 10;
p(2,3,2,4).marginbottom = 10;



p.margin = [20 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';



%%
figure
set(gcf,'Name', 'Figure 3: Tuning', 'NumberTitle', 'off');
set(gcf,'Position',[255 68 1359 985]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
p = panel();
p.pack('v', {1/2 1/2});
p(1).pack('h', {1/3 1/3 1/3});
p(2).pack('h', {1/3 1/3 1/3});



meanOnsetLatCoa = nanmean(onsetLatCoa);
meanHalfWidthCoa = nanmean(halfWidthCoa);
semOnsetLatCoa = nanstd(onsetLatCoa) ./ sqrt(size(onsetLatCoa(~isnan(onsetLatCoa)),1));
semWidthCoa = nanstd(halfWidthCoa) ./ sqrt(size(halfWidthCoa(~isnan(halfWidthCoa)),1));
meanOnsetLatPcx = nanmean(onsetLatPcx);
meanHalfWidthPcx = nanmean(halfWidthPcx);
semOnsetLatPcx = nanstd(onsetLatPcx) ./ sqrt(size(onsetLatPcx(~isnan(onsetLatPcx)),1));
semWidthPcx = nanstd(halfWidthPcx) ./ sqrt(size(halfWidthPcx(~isnan(halfWidthPcx)),1));

p(1,1).select()
hold on
plot([1 2 3 4 5], meanOnsetLatCoa(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanOnsetLatCoa(1:5), semOnsetLatCoa(1:5), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5] + 0.2, meanOnsetLatPcx(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5] + 0.2, meanOnsetLatPcx(1:5), semOnsetLatPcx(1:5), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off', 'TickDir', 'out')
xlim([0.5 5.5])
ylabel('Onset Latency (ms)')
title('Pentanal')

p(1,2).select()
hold on
plot([1 2 3 4 5], meanOnsetLatCoa(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanOnsetLatCoa(6:10), semOnsetLatCoa(6:10), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5] + 0.2, meanOnsetLatPcx(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5] + 0.2, meanOnsetLatPcx(6:10), semOnsetLatPcx(6:10), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off', 'TickDir', 'out')
xlim([0.5 5.5])
title('Ethyl tiglate')

p(1,3).select()
hold on
plot([1 2 3 4 5], meanOnsetLatCoa(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanOnsetLatCoa(11:15), semOnsetLatCoa(11:15), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5] + 0.2, meanOnsetLatPcx(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5] + 0.2, meanOnsetLatPcx(11:15), semOnsetLatPcx(11:15), 'linewidth', 2, 'color', pcxC)
set(gca, 'XColor', 'w', 'box','off', 'TickDir', 'out')
xlim([0.5 5.5])
title('Isoamylacetate')

p(2,1).select()
hold on
plot([1 2 3 4 5], meanHalfWidthCoa(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanHalfWidthCoa(1:5), semWidthCoa(1:5), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5] + 0.2, meanHalfWidthPcx(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5] + 0.2, meanHalfWidthPcx(1:5), semWidthPcx(1:5), 'linewidth', 2, 'color', pcxC)
%set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off', 'TickDir', 'out')
set(gca, 'XColor', 'w', 'box','off', 'TickDir', 'out')
xlabel('Concentration')
xlim([0.5 5.5])
ylabel('Half Width (ms)')


p(2,2).select()
hold on
plot([1 2 3 4 5], meanHalfWidthCoa(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanHalfWidthCoa(6:10), semWidthCoa(6:10), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5] + 0.2, meanHalfWidthPcx(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5] + 0.2, meanHalfWidthPcx(6:10), semWidthPcx(6:10), 'linewidth', 2, 'color', pcxC)
%set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off', 'TickDir', 'out')
set(gca, 'XColor', 'w', 'box','off', 'TickDir', 'out')
xlabel('Concentration')
xlim([0.5 5.5])


p(2,3).select()
hold on
plot([1 2 3 4 5], meanHalfWidthCoa(11:15), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
errbar([1 2 3 4 5], meanHalfWidthCoa(11:15), semWidthCoa(11:15), 'linewidth', 2, 'color', coaC)
plot([1 2 3 4 5] + 0.2, meanHalfWidthPcx(11:15), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
errbar([1 2 3 4 5] + 0.2, meanHalfWidthPcx(11:15), semWidthPcx(11:15), 'linewidth', 2, 'color', pcxC)
%set(gca, 'XTickLabel', {'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}'}, 'box','off', 'TickDir', 'out')
set(gca, 'XColor', 'w', 'box','off', 'TickDir', 'out')
xlabel('Concentration')
xlim([0.5 5.5])


p.select('all');
p.de.margin = 2;
p(1).marginbottom = 30;
p(1,1).marginright = 20;
p(1,2).marginright = 20;
p(2,1).marginright = 20;
p(2,2).marginright = 20;
p.margin = [20 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';


%%
figure
set(gcf,'Position',[255 68 1359 985]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
p = panel();
p.pack('v', {1/2 1/2});
p(1).pack('h', {1/5, 1/5, 1/5, 1/5, 1/5});
p(2).pack('h', {1/3, 1/3, 1/3});

conc = {'1:100000', '1:10000', '1:1000', '1:100', '1:10'};
for idxC = 1:5
p(1,idxC).select()
dataToPlot = {infoOdorIDCoa(:,idxC),infoOdorIDPcx(:,idxC)};
catIdx = [ones(length(infoOdorIDCoa(:,idxC)),1); zeros(length(infoOdorIDPcx(:,idxC)),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
set(gca, 'YColor', 'w')
xlabel('Odor ID discriminability (bits)')
xlim([0 8])
title(conc(idxC))
end

od = {'Pentanal', 'Ethyl tiglate', 'Isoamylacetate'};
for idxC = 1:3
p(2,idxC).select()
dataToPlot = {infoConcIDCoa(:,idxC),infoConcIDPcx(:,idxC)};
catIdx = [ones(length(infoConcIDCoa(:,idxC)),1); zeros(length(infoConcIDPcx(:,idxC)),1)];
colori = {pcxC,coaC};
plotSpread(dataToPlot,'categoryIdx',catIdx,'categoryColors', colori, 'showMM', 0, 'xyOri', 'flipped')
set(gca, 'YColor', 'w')
xlabel('Concentration discriminability (bits)')
xlim([0 10])
title(od(idxC))
end

p.select('all');
p.de.margin = 2;
p(1).marginbottom = 80;
p(1,1).marginright = 10;
p(1,2).marginright = 10;
p(1,3).marginright = 10;
p(1,4).marginright = 10;
p(2,1).marginright = 10;
p(2,2).marginright = 10;
    
p.margin = [20 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';