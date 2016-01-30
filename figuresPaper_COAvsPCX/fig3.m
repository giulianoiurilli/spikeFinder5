% pcx1 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_1.mat');
% pcx2 = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/pcx_AA_2_2.mat');
% pcxR = load('/Volumes/Tetrodes Backup1/january2/pcx/aa/responses.mat');
% pcxRH = load('/Volumes/Tetrodes Backup1/january2/pcx/15/responsesH.mat');
% pcxRL = load('/Volumes/Tetrodes Backup1/january2/pcx/15/responsesL.mat');
% pcx2HL = load('/Volumes/Tetrodes Backup1/january2/pcx/15/pcx_15_2_2.mat');
% 
% coa1 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_1.mat');
% coa2 = load('/Volumes/Tetrodes Backup1/january2/coa/aa/coa_AA_2_2.mat');
% coaR = load('/Volumes/Tetrodes Backup1/january2/coa/aa/responses.mat');
% coaRH = load('/Volumes/Tetrodes Backup1/january2/coa/15/responsesH.mat');
% coaRL = load('/Volumes/Tetrodes Backup1/january2/coa/15/responsesL.mat');
% coa2HL = load('/Volumes/Tetrodes Backup1/january2/coa/15/coa_15_2_2.mat');


%% Set figure size
figure
set(gcf,'Name', 'Figure 3: Tuning', 'NumberTitle', 'off');
set(gcf,'Position',[235 470 1010 590]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%% Set panels
p = panel();
p.pack('h', {40 60});
p(1).pack('v', {6 47 47});
p(1,2).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(1,3).pack('h', {1/5 1/5 1/5 1/5 1/5});
p(2).pack('v', {1/3 1/3 1/3});
p(2,1).pack('h', {70 30});
p(2,2).pack('h', {70 30});
p(2,3).pack('h', {70 30});
p(2,1,2).pack('v', {1/2 1/2});
p(2,2,2).pack('v', {1/2 1/2});
p(2,3,2).pack('v', {1/2 1/2});


% p.select('all');
% p.identify()

%% Tuning curves (auROC)
p(1,1).select();
set(gca,'XColor','w', 'YColor','w')
%makeTuningCurves
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
l1 = p(1,2).ylabel({'Cortical Amygdala', 'Neurons'});
set(l1, 'Color', 'r');

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
l2 = p(1,3).ylabel({'Piriform Cortex', 'Neurons'});
set(l2, 'Color', 'k');


%% Odors activated
proportionActivatingOdors

% templ1 = zeros(16,2); templ2 = zeros(16,2);
% templ1(:,1) = 1; templ2(:,2) = 1;
% templPcxMean = templ2; templPcxSem = templ2;
% templCoaMean = templ1; templCoaSem = templ1;
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
% PPcx = [PPcx' PPcx'];
% SEMPPcx = [SEMPPcx' SEMPPcx'];
% PcxMean = PPcx .*  templPcxMean;
% PcxSem = SEMPPcx .* templPcxSem;
% PCoa = [PCoa' PCoa'];
% SEMPCoa = [SEMPCoa' SEMPCoa'];
% CoaMean = PCoa .*  templCoaMean;
% CoaSem = SEMPCoa .* templCoaSem;

% p(2, 1, 1).select();
% b1 = barwitherr(CoaSem, CoaMean, [], '.r');
% b1(1).FaceColor = 'r'; 
% b1(1).EdgeColor = 'r';
% hold on
% b2 = barwitherr(PcxSem, PcxMean, [], '.k');
% b2(1).FaceColor = 'k'; 
% b2(1).EdgeColor = 'k';
% set(gca,'XColor','w', 'box','off')
% hold on

p(2, 1, 1).select();
errorbar(0:15, PCoa, SEMPCoa, 'or', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:15.3, PPcx, SEMPPcx, 'ok', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-1 16.3]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , longTicks);
set(gca, 'XTickLabel', longList);
p(2, 1, 1).xlabel({'Odors activated'});
p(2, 1, 1).ylabel({'Proportion of neurons'});

p(2, 1, 2, 1).select();
errorbar(0:7, PCoaH, SEMPCoaH, 'sr', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:7.3, PPcxH, SEMPPcxH, 'sk', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-0.5 7.5]);
ylim([-0.03 1])
set(gca,'box','off', 'XColor', 'w')
p(2, 1, 2, 1).title({'1:100'})

p(2, 1, 2, 2).select();
errorbar(0:7, PCoaL, SEMPCoaL, 'dr', 'LineWidth', 1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
hold on
errorbar(0.3:7.3, PPcxL, SEMPPcxL, 'dk', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8)
xlim([-0.5 7.5]);
ylim([-0.03 1])
set(gca,'box','off')
set(gca, 'XTick' , shortTicks);
set(gca, 'XTickLabel', shortList);
p(2, 1, 2, 2).title({'1:10000'})
p(2, 1, 2).xlabel({'Odors activated'});
p(2, 1, 2).ylabel({'Proportion of neurons'});


%% Lifetime Sparseness
ls = [coaR.ls1sTot pcxR.ls1sTot];
groupingV = ones(1,length(ls(:)));
groupingV(length(coaR.ls1sTot + 1) : end) = 2;

p(2, 2, 1).select();
b1 = boxplot(ls, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([0 1]);
set(gca, 'YColor', 'w', 'box','off')
p(2, 2, 1).xlabel({'Lifetime sparseness'});

ls = [coaRH.ls1sTot pcxRH.ls1sTot];
groupingV = ones(1,length(ls(:)));
groupingV(length(coaRH.ls1sTot + 1) : end) = 2;

p(2, 2, 2, 1).select();
b1 = boxplot(ls, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([0 1]);
set(gca, 'YColor', 'w', 'XColor', 'w','box','off')
p(2, 2, 2, 1).title({'1:100'})

ls = [coaRL.ls1sTot pcxRL.ls1sTot];
groupingV = ones(1,length(ls(:)));
groupingV(length(coaRL.ls1sTot + 1) : end) = 2;

p(2, 2, 2, 2).select();
b1 = boxplot(ls, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([0 1]);
set(gca, 'YColor', 'w', 'box','off')
p(2, 2, 2, 2).title({'1:10000'})
p(2, 2, 2).xlabel({'Lifetime sparseness'});

%% Information
inform
info1 = [info1Coa info1Pcx];
groupingV = ones(1,length(info1(:)));
groupingV(length(info1Coa + 1) : end) = 2;

p(2, 3, 1).select();
b1 = boxplot(info1, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([-0.005 0.15]);
set(gca, 'YColor', 'w', 'box','off')
p(2, 3, 1).xlabel({'Information (bit/spike)'});

info1 = [info1CoaH info1PcxH];
groupingV = ones(1,length(info1(:)));
groupingV(length(info1CoaH + 1) : end) = 2;

p(2, 3, 2, 1).select();
b1 = boxplot(info1, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([-0.005 0.15]);
set(gca, 'YColor', 'w', 'XColor', 'w','box','off')
p(2, 3, 2, 1).title({'1:100'})

info1 = [info1CoaL info1PcxL];
groupingV = ones(1,length(info1(:)));
groupingV(length(info1CoaL + 1) : end) = 2;

p(2, 3, 2, 2).select();
b1 = boxplot(info1, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'horizontal', 'symbol', '', 'widths', 0.6);
xlim([-0.005 0.15]);
set(gca, 'YColor', 'w', 'box','off')
p(2, 3, 2, 2).title({'1:10000'})
p(2, 3, 2).xlabel({'Information (bit/spike)'});

%%
p.select('all');
p.de.margin = 2;
p(1).marginright = 30;
p(1,2).marginbottom = 10;
p(2,1,1).marginright = 15;
p(2,2,1).marginright = 10;
p(2,3,1).marginright = 10;
p(2,1).marginbottom = 25;
p(2,2).marginbottom = 25;
p(2, 1, 2, 1).marginbottom = 10;
p(2, 2, 2, 1).marginbottom = 10;
p(2, 3, 2, 1).marginbottom = 10;
p.margin = [20 15 5 10];
p.fontsize = 12;
p.fontname = 'Avenir';

