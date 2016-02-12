% pcx1 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_1.mat');
% pcx2 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_2.mat');
% pcxR = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/responses.mat');
% pcxRH = load('/Volumes/Tetrodes Backup1/january2/pcx/15/responsesH.mat');
% pcxRL = load('/Volumes/Tetrodes Backup1/january2/pcx/15/responsesL.mat');
% pcx2HL = load('/Volumes/Tetrodes Backup1/january2/pcx/15/pcx_15_2_2.mat');
% pcxRH8 = load('/Volumes/Tetrodes Backup1/january2/pcx/15/responsesH8.mat');
% 
% coa1 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_1.mat');
% coa2 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_2.mat');
% coaR = load('/Volumes/Tetrodes Backup1/january2/coa/aa/responses.mat');
% coaRH = load('/Volumes/Tetrodes Backup1/january2/coa/15/responsesH.mat');
% coaRL = load('/Volumes/Tetrodes Backup1/january2/coa/15/responsesL.mat');
% coa2HL = load('/Volumes/Tetrodes Backup1/january2/coa/15/coa_15_2_2.mat');
% coaRH8 = load('/Volumes/Tetrodes Backup1/january2/coa/15/responsesH8.mat');

odorsRearranged = 1:15;

%% Set figure size/position
figure
set(gcf,'Name', 'Figure 2: Tuning', 'NumberTitle', 'off');
set(gcf,'Position',[120 270 1540 650]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%% Set panels
p = panel();
p.pack('h', {40 60});
p(1).pack('v', {6 47 47});
p(1,2).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(1,3).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(2).pack('v', {1/2 1/2});
p(2,1).pack('h', {50 50});
p(2,2).pack('h', {1/2 1/2});


% p.select('all');
% p.identify()

%% A, B - Tuning curves (auROC)
%tuningCurves15Coa = makeTuningCurves(coa2.esp, odorsRearranged);
%tuningCurves15Pcx = makeTuningCurves(pcx2.esp, odorsRearranged);

p(1,1).select();
set(gca,'XColor','w', 'YColor','w')
clims = [0 1];
p(1,2,1).select()
imagesc(tuningCurves15Coa(:,1:3), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
p(1,2,2).select()
imagesc(tuningCurves15Coa(:,4:6), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(1,2,3).select()
imagesc(tuningCurves15Coa(:,7:9), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(1,2,4).select()
imagesc(tuningCurves15Coa(:,10:12), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(1,2,5).select()
imagesc(tuningCurves15Coa(:,13:15), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
% l1 = p(1,2).ylabel({'Cortical Amygdala', 'Neurons'});
% set(l1, 'Color', 'r');

p(1,3,1).select()
imagesc(tuningCurves15Pcx(:,1:3), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XColor','w')
p(1,3,2).select()
imagesc(tuningCurves15Pcx(:,4:6), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(1,3,3).select()
imagesc(tuningCurves15Pcx(:,7:9), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(1,3,4).select()
imagesc(tuningCurves15Pcx(:,10:12), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p(1,3,5).select()
imagesc(tuningCurves15Pcx(:,13:15), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'YColor','w')
set(gca,'XColor','w')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
% l2 = p(1,3).ylabel({'Piriform Cortex', 'Neurons'});
% set(l2, 'Color', 'k');

%% C - Odors activated
pcxHlist = [14 6 4 12 13 3 11];% pcxH
coaHlist = [14 2 15 4 10 11 8];% coaH
pcxLlist = [1 2 5 10 15 7 8];% pcxL
coaLlist = [6 1 3 13 12 7 5];% coaL
% [actOdorPcx, auROCsortPcx] = proportionActivatingOdors(pcx2.esp, odorsRearranged);
% [actOdorCoa, auROCsortCoa] = proportionActivatingOdors(coa2.esp, odorsRearranged);
% [actOdorPcxH, auROCsortPcxH] = proportionActivatingOdors(pcx2HL.esp, pcxHlist);
% [actOdorCoaH, auROCsortCoaH] = proportionActivatingOdors(coa2HL.esp, coaHlist);
% [actOdorPcxL, auROCsortPcxL] = proportionActivatingOdors(pcx2HL.esp, pcxLlist);
% [actOdorCoaL, auROCsortCoaL] = proportionActivatingOdors(coa2HL.esp, coaLlist);


longList = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15'};
shortList = {'0', '1', '2', '3', '4', '5', '6', '7'};
longTicks = 0.15:15.15;
shortTicks = 0.15:7.15;

N = histcounts(actOdorPcx,0:16); 
PPcx = N./ sum(N);
SEMPPcx = sqrt((PPcx .* (1 - PPcx)) ./ sum(N));
N = histcounts(actOdorCoa,0:16); 
PCoa = N./ sum(N);
SEMPCoa = sqrt((PCoa .* (1 - PCoa)) ./ sum(N));
N = histcounts(actOdorPcxH,0:8); 
PPcxH = N./ sum(N);
SEMPPcxH = sqrt((PPcxH .* (1 - PPcxH)) ./ sum(N));
N = histcounts(actOdorCoaH,0:8); 
PCoaH = N./ sum(N);
SEMPCoaH = sqrt((PCoaH .* (1 - PCoaH)) ./ sum(N));
N = histcounts(actOdorPcxL,0:8); 
PPcxL = N./ sum(N);
SEMPPcxL = sqrt((PPcxL .* (1 - PPcxL)) ./ sum(N));
N = histcounts(actOdorCoaL,0:8); 
PCoaL = N./ sum(N);
SEMPCoaL = sqrt((PCoaL .* (1 - PCoaL)) ./ sum(N));


p(2, 1, 1).select();
errorbar(0:15, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-1 16.3]);
ylim([-0.03 0.6])
set(gca,'box','off')
set(gca, 'XTick' , longTicks);
set(gca, 'XTickLabel', longList);
p(2, 1, 1).xlabel({'Odors activated'});
p(2, 1, 1).ylabel({'Proportion of neurons'});


% p0coa = length(actOdorCoa(actOdorCoa==0))./length(actOdorCoa);
% sem0coa = sqrt((p0coa*(1-p0coa))./length(actOdorCoa));
% p0pcx = length(actOdorPcx(actOdorPcx==0))./length(actOdorPcx);
% sem0pcx = sqrt((p0pcx*(1-p0pcx))./length(actOdorPcx));
% 
% p0coaL = length(actOdorCoaL(actOdorCoaL==0))./length(actOdorCoaL);
% sem0coaL = sqrt((p0coaL*(1-p0coaL))./length(actOdorCoaL));
% p0pcxL = length(actOdorPcxL(actOdorPcxL==0))./length(actOdorPcxL);
% sem0pcxL = sqrt((p0pcxL*(1-p0pcxL))./length(actOdorPcxL));
% 
% p0coaH = length(actOdorCoaH(actOdorCoaH==0))./length(actOdorCoaH);
% sem0coaH = sqrt((p0coaH*(1-p0coaH))./length(actOdorCoaH));
% p0pcxH = length(actOdorPcxH(actOdorPcxH==0))./length(actOdorPcxH);
% sem0pcxH = sqrt((p0pcxH*(1-p0pcxH))./length(actOdorPcxH));
% 
% pMeanCoa = [p0coa 0; p0coaL 0; p0coaH 0];
% pMeanPcx = [0 p0pcx; 0 p0pcxL; 0 p0pcxH];
% pSemCoa = [sem0coa 0; sem0coaL 0; sem0coaH 0];
% pSemPcx = [0 sem0pcx; 0 sem0pcxL; 0 sem0pcxH];
% 
% figure;
% b1 = barwitherr(pSemCoa, pMeanCoa, [], '.r');
% b1(1).FaceColor = 'r'; 
% b1(1).EdgeColor = 'r';
% hold on
% b2 = barwitherr(pSemPcx, pMeanPcx, [], '.k');
% b2(1).FaceColor = 'k'; 
% b2(1).EdgeColor = 'k';
% %xlim([0 3])
% set(gca,'XColor','w', 'box','off')

%% D - auROC sorted selectivity

coaMean = mean(auROCsortCoa); 
coaSem = std(auROCsortCoa)./ sqrt(length(auROCsortCoa));
pcxMean = mean(auROCsortPcx); 
pcxSem = std(auROCsortPcx)./ sqrt(length(auROCsortPcx));

t = 1:length(coaMean); 
p(2,1,2).select();
hl(1) = PlotMeanWithFilledSemBand(t, pcxMean, pcxSem, pcxSem, 'k', 2, 'k', 0.2);
hold on; 
hl(2) = PlotMeanWithFilledSemBand(t, coaMean, coaSem, coaSem, 'r', 2, 'r', 0.2);
xlim([0 16]);
ylim([0.25 1]);
plotTicks = [1 15];
plotLabels = {'min', 'max'}; 
set(gca, 'XTick' , plotTicks);
set(gca, 'XTickLabel', plotLabels);
%set(gca,'XColor','w')
p(2,1,2).xlabel('odor response');
p(2,1,2).ylabel('Fraction of maximum response');

%% E - Lifetime Sparseness
ls = [coaR.ls1sTot pcxR.ls1sTot];
groupingV = ones(1,length(ls(:)));
groupingV(length(coaR.ls1sTot + 1) : end) = 2;

p(2, 2, 1).select();
b1 = boxplot(ls, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([0 1]);
set(gca, 'YColor', 'w', 'box','off')
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
p(2, 2, 1).xlabel({'Lifetime sparseness'});

% ls = [coaRH.ls1sTot pcxRH.ls1sTot];
% groupingV = ones(1,length(ls(:)));
% groupingV(length(coaRH.ls1sTot + 1) : end) = 2;
% 
% p(2, 2, 2, 1).select();
% b1 = boxplot(ls, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
% xlim([0 1]);
% set(gca, 'YColor', 'w', 'box','off')
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% p(2, 2, 2, 1).title({'1:100'})
% 
% ls = [coaRL.ls1sTot pcxRL.ls1sTot];
% groupingV = ones(1,length(ls(:)));
% groupingV(length(coaRL.ls1sTot + 1) : end) = 2;
% 
% p(2, 2, 2, 2).select();
% b1 = boxplot(ls, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
% xlim([0 1]);
% set(gca, 'YColor', 'w', 'box','off')
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% p(2, 2, 2, 2).title({'1:10000'})
% p(2, 2, 2).xlabel({'Lifetime sparseness'});
%% F - Information
info1 = [info1Coa info1Pcx];
groupingV = ones(1,length(info1(:)));
groupingV(length(info1Coa + 1) : end) = 2;

p(2, 2, 2).select();
b1 = boxplot(info1, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([-0.005 0.15]);
set(gca, 'YColor', 'w', 'box','off')
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
p(2, 2, 2).xlabel({'Information (bit/spike)'});

% info1 = [info1CoaH info1PcxH];
% groupingV = ones(1,length(info1(:)));
% groupingV(length(info1CoaH + 1) : end) = 2;
% 
% p(2, 3, 2, 1).select();
% b1 = boxplot(info1, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
% xlim([-0.005 0.15]);
% set(gca, 'YColor', 'w','box','off')
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% p(2, 3, 2, 1).title({'1:100'})
% 
% info1 = [info1CoaL info1PcxL];
% groupingV = ones(1,length(info1(:)));
% groupingV(length(info1CoaL + 1) : end) = 2;
% 
% p(2, 3, 2, 2).select();
% b1 = boxplot(info1, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
% xlim([-0.005 0.15]);
% set(gca, 'YColor', 'w', 'box','off')
% h = findobj(gca,'Tag','Box');
% colorToUse = {'k', 'r'};
% for j=1:length(h)
%     patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
% end
% p(2, 3, 2, 2).title({'1:10000'})
% p(2, 3, 2).xlabel({'Information (bit/spike)'});
%% show panels
p.select('all');
p.de.margin = 2;
p(1).marginright = 30;
p(1,2).marginbottom = 10;
p(2,1,1).marginright = 15;
p(2,2,1).marginright = 15;
p(2,1).marginbottom = 35;
p.margin = [30 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';










