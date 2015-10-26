apcx_churches = [1 3 5 7];
plcoa_churches = [2 4 6 8];
churchMsAllaPCX = [];
churchRadAllaPCX = [];
churchSniffAllaPCX = [];
churchMsAllInhaPCX = [];
churchRadAllInhaPCX = [];
churchSniffAllInhaPCX = [];
churchMsAllplCoA = [];
churchRadAllplCoA = [];
churchSniffAllplCoA = [];
churchMsAllInhplCoA = [];
churchRadAllInhplCoA = [];
churchSniffAllInhplCoA = [];


k = 1;
z = 1;
for i = apcx_churches
    for j = 1:length(allChurches(i).excMs)
        churchMsAllaPCX(k).spikes = allChurches(i).excMs(j).spikes;
        churchRadAllaPCX(k).spikes = allChurches(i).excRad(j).spikes;
        churchSniffAllaPCX(k).spikes = allChurches(i).excSniff(j).spikes;
        k = k + 1;
    end
    for j = 1:length(allChurches(i).inhMs)
        churchMsAllInhaPCX(z).spikes = allChurches(i).inhMs(j).spikes;
        churchRadAllInhaPCX(z).spikes = allChurches(i).inhRad(j).spikes;
        churchSniffAllInhaPCX(z).spikes = allChurches(i).inhSniff(j).spikes;
        z = z+ 1;
    end
end

k = 1;
z = 1;
for i = plcoa_churches
    for j = 1:length(allChurches(i).excMs)
        churchMsAllplCoA(k).spikes = allChurches(i).excMs(j).spikes;
        churchRadAllplCoA(k).spikes = allChurches(i).excRad(j).spikes;
        churchSniffAllplCoA(k).spikes = allChurches(i).excSniff(j).spikes;
        k = k + 1;
    end
    for j = 1:length(allChurches(i).inhMs)
        churchMsAllInhplCoA(z).spikes = allChurches(i).inhMs(j).spikes;
        churchRadAllInhplCoA(z).spikes = allChurches(i).inhRad(j).spikes;
        churchSniffAllInhplCoA(z).spikes = allChurches(i).inhSniff(j).spikes;
        z = z+ 1;
    end
end


%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[100 41 1273 739]);

times = 60:50:3000;
fanoParams.alignTime = 500;
fanoParams.boxWidth = 50;
myResult = VarVsMean(churchMsAllaPCX, times, fanoParams);
%plotFano(myResult)
subplot(3,3,1)
title('50 ms bins')
hold on
plot(myResult.times,myResult.meanRateAll, 'k', 'lineWidth', 1);
plot(myResult.times,myResult.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('time (ms)')
ylabel('spikes/s')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,4)
plot(myResult.scatterDataAll(15).mn, myResult.scatterDataAll(15).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResult.scatterData(15).mn, myResult.scatterData(15).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off

set(gca,'xlim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
set(gca,'ylim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,7)
[AX, h1, h2] = plotyy(myResult.times, myResult.FanoFactorAll, myResult.times, myResult.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('time (ms)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');





fanoParamsRad.alignTime = 360*3;
fanoParamsSniff.boxWidth = 60;
timesRad = 361:60:360*10;
myResultRad = VarVsMean(churchRadAllaPCX, timesRad, fanoParamsRad);
% plotFano(myResultRad)
subplot(3,3,2)
title('60 deg bins')
hold on
plot(myResultRad.times,myResultRad.meanRateAll, 'k', 'lineWidth', 1);
plot(myResultRad.times,myResultRad.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phase (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,5)
plot(myResultRad.scatterDataAll(16).mn, myResultRad.scatterDataAll(16).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResultRad.scatterData(16).mn, myResultRad.scatterData(16).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
set(gca,'ylim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,8)
[AX, h1, h2] = plotyy(myResultRad.times, myResultRad.FanoFactorAll, myResultRad.times, myResultRad.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');




timesSniff = 361:360:360*10;
fanoParamsSniff.boxWidth = 360;
fanoParamsSniff.alignTime = 360*3;
myResultSniff = VarVsMean(churchSniffAllaPCX, timesSniff, fanoParamsSniff);
% plotFano(myResultSniff)
subplot(3,3,3)
title('whole sniff bins')
hold on
plot(myResultSniff.times,myResultSniff.meanRateAll, 'k', 'lineWidth', 1);
plot(myResultSniff.times,myResultSniff.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phases (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,6)
plot(myResultSniff.scatterDataAll(4).mn, myResultSniff.scatterDataAll(4).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResultSniff.scatterData(4).mn, myResultSniff.scatterData(4).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
set(gca,'ylim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,9)
[AX, h1, h2] = plotyy(myResultSniff.times, myResultSniff.FanoFactorAll, myResultSniff.times, myResultSniff.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');


%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[100 41 1273 739]);

times = 60:50:3000;
fanoParams.alignTime = 500;
fanoParams.boxWidth = 50;
myResult = VarVsMean(churchMsAllplCoA, times, fanoParams);
%plotFano(myResult)
subplot(3,3,1)
title('50 ms bins')
hold on
plot(myResult.times,myResult.meanRateAll, 'k', 'lineWidth', 1);
plot(myResult.times,myResult.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('time (ms)')
ylabel('spikes/s')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,4)
plot(myResult.scatterDataAll(15).mn, myResult.scatterDataAll(15).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResult.scatterData(15).mn, myResult.scatterData(15).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off

set(gca,'xlim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
set(gca,'ylim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,7)
[AX, h1, h2] = plotyy(myResult.times, myResult.FanoFactorAll, myResult.times, myResult.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('time (ms)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');





fanoParamsRad.alignTime = 360*3;
fanoParamsSniff.boxWidth = 60;
timesRad = 361:60:360*10;
myResultRad = VarVsMean(churchRadAllplCoA, timesRad, fanoParamsRad);
% plotFano(myResultRad)
subplot(3,3,2)
title('60 deg bins')
hold on
plot(myResultRad.times,myResultRad.meanRateAll, 'k', 'lineWidth', 1);
plot(myResultRad.times,myResultRad.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phase (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,5)
plot(myResultRad.scatterDataAll(16).mn, myResultRad.scatterDataAll(16).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResultRad.scatterData(16).mn, myResultRad.scatterData(16).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
set(gca,'ylim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,8)
[AX, h1, h2] = plotyy(myResultRad.times, myResultRad.FanoFactorAll, myResultRad.times, myResultRad.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');




timesSniff = 361:360:360*10;
fanoParamsSniff.boxWidth = 360;
fanoParamsSniff.alignTime = 360*3;
myResultSniff = VarVsMean(churchSniffAllplCoA, timesSniff, fanoParamsSniff);
% plotFano(myResultSniff)
subplot(3,3,3)
title('whole sniff bins')
hold on
plot(myResultSniff.times,myResultSniff.meanRateAll, 'k', 'lineWidth', 1);
plot(myResultSniff.times,myResultSniff.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phases (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,6)
plot(myResultSniff.scatterDataAll(4).mn, myResultSniff.scatterDataAll(4).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResultSniff.scatterData(4).mn, myResultSniff.scatterData(4).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
set(gca,'ylim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,9)
[AX, h1, h2] = plotyy(myResultSniff.times, myResultSniff.FanoFactorAll, myResultSniff.times, myResultSniff.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[100 41 1273 739]);

times = 60:50:3000;
fanoParams.alignTime = 500;
fanoParams.boxWidth = 50;
myResult = VarVsMean(churchMsAllInhaPCX, times, fanoParams);
%plotFano(myResult)
subplot(3,3,1)
title('50 ms bins')
hold on
plot(myResult.times,myResult.meanRateAll, 'k', 'lineWidth', 1);
plot(myResult.times,myResult.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('time (ms)')
ylabel('spikes/s')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,4)
plot(myResult.scatterDataAll(15).mn, myResult.scatterDataAll(15).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResult.scatterData(15).mn, myResult.scatterData(15).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off

set(gca,'xlim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
set(gca,'ylim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,7)
[AX, h1, h2] = plotyy(myResult.times, myResult.FanoFactorAll, myResult.times, myResult.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('time (ms)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');





fanoParamsRad.alignTime = 360*3;
fanoParamsSniff.boxWidth = 60;
timesRad = 361:60:360*10;
myResultRad = VarVsMean(churchRadAllInhaPCX, timesRad, fanoParamsRad);
% plotFano(myResultRad)
subplot(3,3,2)
title('60 deg bins')
hold on
plot(myResultRad.times,myResultRad.meanRateAll, 'k', 'lineWidth', 1);
plot(myResultRad.times,myResultRad.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phase (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,5)
plot(myResultRad.scatterDataAll(16).mn, myResultRad.scatterDataAll(16).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResultRad.scatterData(16).mn, myResultRad.scatterData(16).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
set(gca,'ylim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,8)
[AX, h1, h2] = plotyy(myResultRad.times, myResultRad.FanoFactorAll, myResultRad.times, myResultRad.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');




timesSniff = 361:360:360*10;
fanoParamsSniff.boxWidth = 360;
fanoParamsSniff.alignTime = 360*3;
myResultSniff = VarVsMean(churchSniffAllInhaPCX, timesSniff, fanoParamsSniff);
% plotFano(myResultSniff)
subplot(3,3,3)
title('whole sniff bins')
hold on
plot(myResultSniff.times,myResultSniff.meanRateAll, 'k', 'lineWidth', 1);
plot(myResultSniff.times,myResultSniff.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phases (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,6)
plot(myResultSniff.scatterDataAll(4).mn, myResultSniff.scatterDataAll(4).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResultSniff.scatterData(4).mn, myResultSniff.scatterData(4).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
set(gca,'ylim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,9)
[AX, h1, h2] = plotyy(myResultSniff.times, myResultSniff.FanoFactorAll, myResultSniff.times, myResultSniff.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');


%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[100 41 1273 739]);

times = 60:50:3000;
fanoParams.alignTime = 500;
fanoParams.boxWidth = 50;
myResult = VarVsMean(churchMsAllInhplCoA, times, fanoParams);
%plotFano(myResult)
subplot(3,3,1)
title('50 ms bins')
hold on
plot(myResult.times,myResult.meanRateAll, 'k', 'lineWidth', 1);
plot(myResult.times,myResult.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('time (ms)')
ylabel('spikes/s')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,4)
plot(myResult.scatterDataAll(15).mn, myResult.scatterDataAll(15).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResult.scatterData(15).mn, myResult.scatterData(15).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off

set(gca,'xlim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
set(gca,'ylim',[0, ceil(max(myResult.scatterDataAll(15).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(3,3,7)
[AX, h1, h2] = plotyy(myResult.times, myResult.FanoFactorAll, myResult.times, myResult.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('time (ms)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');





fanoParamsRad.alignTime = 360*3;
fanoParamsSniff.boxWidth = 60;
timesRad = 361:60:360*10;
myResultRad = VarVsMean(churchRadAllInhplCoA, timesRad, fanoParamsRad);
% plotFano(myResultRad)
subplot(3,3,2)
title('60 deg bins')
hold on
plot(myResultRad.times,myResultRad.meanRateAll, 'k', 'lineWidth', 1);
plot(myResultRad.times,myResultRad.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phase (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,5)
plot(myResultRad.scatterDataAll(16).mn, myResultRad.scatterDataAll(16).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResultRad.scatterData(16).mn, myResultRad.scatterData(16).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
set(gca,'ylim',[0, ceil(max(myResultRad.scatterDataAll(16).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,8)
[AX, h1, h2] = plotyy(myResultRad.times, myResultRad.FanoFactorAll, myResultRad.times, myResultRad.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');




timesSniff = 361:360:360*10;
fanoParamsSniff.boxWidth = 360;
fanoParamsSniff.alignTime = 360*3;
myResultSniff = VarVsMean(churchSniffAllInhplCoA, timesSniff, fanoParamsSniff);
% plotFano(myResultSniff)
subplot(3,3,3)
title('whole sniff bins')
hold on
plot(myResultSniff.times,myResultSniff.meanRateAll, 'k', 'lineWidth', 1);
plot(myResultSniff.times,myResultSniff.meanRateSelect, 'r', 'lineWidth', 1);
hold off
xlabel('respiration phases (deg)')
ylabel('spikes/1000 deg')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,6)
plot(myResultSniff.scatterDataAll(4).mn, myResultSniff.scatterDataAll(4).var, '.', 'MarkerSize', 20, 'color', 'k')
hold on
plot(myResultSniff.scatterData(4).mn, myResultSniff.scatterData(4).var, '.', 'MarkerSize', 20, 'color', 'r')
plot([0 100], [0 100], 'lineWidth', 1, 'color', [99,99,99]/255);
hold off
set(gca,'xlim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
set(gca,'ylim',[0, ceil(max(myResultSniff.scatterDataAll(4).var))]);
%axis tight
xlabel('mean counts')
ylabel('variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(3,3,9)
[AX, h1, h2] = plotyy(myResultSniff.times, myResultSniff.FanoFactorAll, myResultSniff.times, myResultSniff.FanoFactor);
h1.LineWidth = 1;
h2.LineWidth = 1;
h1.Color = 'k';
h2.Color = 'r';
set(AX,{'ycolor'},{'k';'r'})
xlabel('respiration phases (deg)')
ylabel('Fano factor')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');