function plotTunings(idxShank, idxUnit)

load('parameters.mat')
load('units.mat', 'shank')

odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
    'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
    'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};


listOdors = {'TMT^-4', 'TMT^-2', 'DMT^-4', 'DMT^-2', 'MT^-4', 'MT^-2',...
    'IBA^-4', 'IBA^-2', 'IAA^-4', 'IAA^-2', 'HXD^-4', 'HXD^-2', 'BTD^-4', 'BTD^-2', 'rose'};
odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];
yTicks = 1:odors;


useColor = {'Maroon', 'SaddleBrown', 'Chocolate', 'Tan'};


Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);

p.pack({1/3 1/3 1/3},{20 20 20 20 20});


cycleSpikeRateBslT =  shank(idxShank).cell(idxUnit).cycleBslSpikeRateHz(2);
for idxCycle = 1:4
    tuningCycle = [];
    idxPlot = 1;
    for idxOdor = odorsRearranged
        tuningCycle(idxPlot) = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseAnalogicHz(idxCycle);
        idxPlot = idxPlot+1;
    end
    p(1,idxCycle).select()
    barh(tuningCycle, 1, 'FaceColor', rgb(useColor(idxCycle)));
    hold on
    plot([cycleSpikeRateBslT cycleSpikeRateBslT],[0 15.5], ':k', 'linewidth', 2)
    if idxCycle == 1
        set(gca, 'YTick' , yTicks);
        set(gca, 'YTickLabel', listOdors);
        xlabel('Average cycle spike rate (Hz) - Tuning');
    else
        set(gca, 'YTick' , []);
        set(gca, 'YTickLabel', []);
        
    end
    cycleTitle = sprintf('cycle %d', idxCycle);
    p(1,idxCycle).title(cycleTitle)
    set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
    %axis tight
end


cyclePeakRateBslT =  shank(idxShank).cell(idxUnit).cycleBslPeakAmplitudeHz(2);
for idxCycle = 1:4
    tuningCycle = [];
    idxPlot = 1;
    for idxOdor = odorsRearranged
        tuningCycle(idxPlot) = shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz(idxCycle);
        idxPlot = idxPlot+1;
    end
    p(2,idxCycle).select()
    barh(tuningCycle, 1, 'FaceColor', rgb(useColor(idxCycle)));
    hold on
    plot([cyclePeakRateBslT cyclePeakRateBslT],[0 15.5],  ':k', 'linewidth', 2)
    if idxCycle == 1
        set(gca, 'YTick' , yTicks);
        set(gca, 'YTickLabel', listOdors);
        xlabel('Spike rate peak (Hz) - Tuning')
    else
        set(gca, 'YTick' , []);
        set(gca, 'YTickLabel', []);
        
    end
    set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
    %axis tight
end


cycleAuRocBslT =  0.75;
for idxCycle = 1:4
    tuningCycle = [];
    idxPlot = 1;
    for idxOdor = odorsRearranged
        tuningCycle(idxPlot) = shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMaxHz(idxCycle);
        idxPlot = idxPlot+1;
    end
    p(3,idxCycle).select()
    %figure
    barh(tuningCycle, 1, 'FaceColor', rgb(useColor(idxCycle)));
    xlim([0.5 1])
    hold on
    plot([cycleAuRocBslT cycleAuRocBslT], [0 15.5], ':k', 'linewidth', 2)
    if idxCycle == 1
        set(gca, 'YTick' , yTicks);
        set(gca, 'YTickLabel', listOdors);
        xlabel('auROCs - Tuning');
    else
        set(gca, 'YTick' , []);
        set(gca, 'YTickLabel', []);
        
    end
    set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
    %axis tight
end

cycleSpikeRateBslT =  shank(idxShank).cell(idxUnit).cycleBslSpikeRateHz(2);
tuningCycle = [];
idxPlot =1;
for idxOdor = odorsRearranged
    tuningCycle(idxPlot) = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseAnalogicHz);
    idxPlot = idxPlot+1;
end
p(1,5).select()
barh(tuningCycle, 1);
hold on
plot([cycleSpikeRateBslT cycleSpikeRateBslT],[0 15.5], ':k', 'linewidth', 2)
set(gca, 'YTick' , []);
set(gca, 'YTickLabel', []);
p(1,5).title('Average of 10 cycles')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
%axis tight


cyclePeakRateBslT =  shank(idxShank).cell(idxUnit).cycleBslPeakAmplitudeHz(2);
tuningCycle = [];
idxPlot =1;
for idxOdor = odorsRearranged
    tuningCycle(idxPlot) = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz);
    idxPlot = idxPlot+1;
end
p(2,5).select()
barh(tuningCycle, 1);
hold on
plot([cyclePeakRateBslT cyclePeakRateBslT],[0 15.5],  ':k', 'linewidth', 2)
set(gca, 'YTick' , []);
set(gca, 'YTickLabel', []);
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
    %axis tight
    
p(3,5).select()
set(gca,'YTick',[])
set(gca, 'YTickLabel', []);
set(gca,'YColor','w')
set(gca,'XTick',[])
set(gca,'XColor','w')
set(gca, 'XTickLabel', []);






%p.de.margin = 1;
p.margin = [15 15 4 6];
p(1).marginbottom = 20;
p(2).marginbottom = 20;
p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');

