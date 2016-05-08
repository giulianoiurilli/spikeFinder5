[auroc300, significantAuroc300, auroc1Pcx15, significantAuroc1Pcx15] = makeTuningCurves2(pcx15.esp, odors);
[auroc300, significantAuroc300, auroc1PcxAA, significantAuroc1PcxAA] = makeTuningCurves2(pcxAA.esp, odors);
[auroc300, significantAuroc300, auroc1Coa15, significantAuroc1Coa15] = makeTuningCurves2(coa15.esp, odors);
[auroc300, significantAuroc300, auroc1CoaAA, significantAuroc1CoaAA] = makeTuningCurves2(coaAA.esp, odors);

%%
clims = [0 1];
figure
idx = 1:size(auroc1CoaAA,1);
idx = randperm(numel(idx));
auroc1CoaAA = auroc1CoaAA(idx,:);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
p = panel();
p.pack('h', {50 50});
p(1).select()
imagesc(auroc1CoaAA(:,1:5), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])

p(2).select()
imagesc(auroc1CoaAA(:,6:10), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p.select('all');
p.de.margin = 2;
p.margin = [10 5 5 5];
p.fontsize = 12;
p.fontname = 'Avenir';
%%
clims = [0 1];
figure
idx = 1:size(auroc1Coa15,1);
idx = randperm(numel(idx));
auroc1Coa15 = auroc1Coa15(idx,:);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
p = panel();
p.pack('h', {20 20 20 20 20});
p(1).select()
imagesc(auroc1Coa15(:,1:3), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])

p(2).select()
imagesc(auroc1Coa15(:,4:6), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

p(3).select()
imagesc(auroc1Coa15(:,7:9), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

p(4).select()
imagesc(auroc1Coa15(:,10:12), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

p(5).select()
imagesc(auroc1Coa15(:,13:15), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])


p.select('all');
p.de.margin = 2;
p.margin = [10 5 5 5];
p.fontsize = 12;
p.fontname = 'Avenir';
%%
figure
idx = 1:size(auroc1PcxAA,1);
idx = randperm(numel(idx));
auroc1PcxAA = auroc1PcxAA(idx,:);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
p = panel();
p.pack('h', {50 50});
p(1).select()
imagesc(auroc1PcxAA(:,1:5), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])

p(2).select()
imagesc(auroc1PcxAA(:,6:10), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
p.select('all');
p.de.margin = 2;
p.margin = [10 5 5 5];
p.fontsize = 12;
p.fontname = 'Avenir';
%%
clims = [0 1];
figure
idx = 1:size(auroc1Pcx15,1);
idx = randperm(numel(idx));
auroc1Pcx15 = auroc1Pcx15(idx,:);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
p = panel();
p.pack('h', {20 20 20 20 20});
p(1).select()
imagesc(auroc1Pcx15(:,1:3), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])

p(2).select()
imagesc(auroc1Pcx15(:,4:6), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

p(3).select()
imagesc(auroc1Pcx15(:,7:9), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

p(4).select()
imagesc(auroc1Pcx15(:,10:12), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

p(5).select()
imagesc(auroc1Pcx15(:,13:15), clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])


p.select('all');
p.de.margin = 2;
p.margin = [10 5 5 5];
p.fontsize = 12;
p.fontname = 'Avenir';

%%
clims = [0, 1];
clear X;
idx = 1:size(significantAuroc1PcxAA,1);
idx = randperm(numel(idx));
X = significantAuroc1PcxAA(idx,:);

figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(X(:,1:5), clims); colormap(brewermap([],'*RdBu')); axis tight
title('PcxAA')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca, 'fontname', 'Avenir', 'fontsize', 12, 'tickdir', 'out')

figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
imagesc(X(:,6:10), clims); colormap(brewermap([],'*RdBu')); axis tight
title('PcxAA')
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca, 'fontname', 'Avenir', 'fontsize', 12, 'tickdir', 'out')



%%
app = evalclusters(auroc1CoaAA,'gmdistribution','gap','KList',1:10)
figure;plot(app)