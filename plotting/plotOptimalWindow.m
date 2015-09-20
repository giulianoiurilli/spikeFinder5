function plotOptimalWindow(idxShank, idxUnit, idxOdor, idxCycle)


load('parameters.mat')
load('units.mat', 'shank')
aur = shank(idxShank).cell(idxUnit).odor(idxOdor).aurocAllHz(:,:,idxCycle);
binSizes = 5:5:cycleLengthDeg;
timePoints = 5:5:cycleLengthDeg;

axTicks = 1:5:360;
axTicks(16:end) = [];

axLabels = {'5',    '30',    '55',    '80',   '105',   '130',   '155',   '180',   '205',   '230',   '255',   '280',   '305',   '330',   '355'};

y = shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinWindowResponseHz(idxCycle);
x = shank(idxShank).cell(idxUnit).odor(idxOdor).bestTimeBinResponseHz(idxCycle);
x = find(binSizes == x);
y = find(binSizes == y);

figure; imagesc(aur, [0 1]); colormap(brewermap([],'*RdBu')); axis square
hold on
rectangle('Position',[x,y,1,1],...
'Curvature',[1,1],...
'LineWidth',2,...
'FaceColor', 'g');
colorbar

ylabel('bin width (deg)')
xlabel('cycle phase (deg)')

set(gca, 'XTick' , axTicks);
set(gca, 'YTick' , axTicks);
set(gca, 'XTickLabel' , axLabels);
set(gca, 'YTickLabel' , axLabels);

set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
