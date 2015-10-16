%% Analysis of neural sequences within and across sniffs

%% Let's give a look at the responses. 
% Let's start from the experiment 08-17-15/d3800 in anterior piriform
% cortex.
% 
% <</Users/Giuliano/Documents/MATLAB/spikeFinder5/running analysis/html/08-17-15_d3800_apcx.png>>
% 
idxExp = 1;
% I will pick only well-isolated units.

shank_unitPairs = [1,4;...
                   1,5;...
                   3,1;...
                   3,2;...
                   3,3;...
                   3,5;...
                   4,1;...
                   4,3;...
                   4,4;...
                   4,5];

odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];
psthTicks = [0:cycleLengthDeg:6*cycleLengthDeg]; 


%% 
% *All right, unit 5 on shank 1. Odor: TMT 1:10000*
idxShank = shank_unitPairs(2,1);
idxUnit = shank_unitPairs(2,2);

for idxOdor = 1%odorsRearranged
    spikesMatMs = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
    spikesPSTHsMs = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
    spikesMatRad = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
    spikesPSTHsRad = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth;
end

figure; 
set(gcf,'Position',[68 689 1135 109]);
subplot(1,2,1)
imagesc(spikesMatMs(:,14800:15200)); colormap('bone');freezeColors
ymax = get(gca, 'YLim');
hold on
plot([200 200], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
hold off
title('First sniff onset alignement');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(spikesPSTHsMs(:,14500:16000)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([500 500], ymax, 'g', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
hold off
set(gcf,'Color','w')

figure; 
subplot(1,2,1)
imagesc(spikesMatRad(:,3*cycleLengthDeg+1:5*cycleLengthDeg)); colormap('bone');freezeColors
ymax = get(gca, 'YLim');
hold on
plot([cycleLengthDeg cycleLengthDeg+1], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('deg');
hold off
set(gcf,'Position',[68 689 1135 109]);
set(gca, 'XTick' , psthTicks);
title('First sniff onset alignement and sniff warping - 1 sniff pre odor and 4 sniffs post odor');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(spikesPSTHsRad(:,2*cycleLengthDeg+1:8*cycleLengthDeg)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([2*cycleLengthDeg 2*cycleLengthDeg+1], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('deg');
set(gca, 'XTick' , psthTicks);
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
hold off
set(gcf,'Color','w')

figure; sniff = squeeze(breath(1:5,20*(14550:16000),1));
xtime = -450:1000;
hold on
for i = 1:5
    plot(xtime, sniff(i,:) - (i-1)*1.2, 'k', 'linewidth', 2); axis tight
end
xlabel('ms');
ymax = get(gca, 'YLim');
plot([0 0], ymax, 'r', 'linewidth', 2);
hold off
title('Sniffs');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
set(gca,'YTick',[])
set(gcf,'Color','w')

%% 
% *Same unit. Odor: isobutylacetate 1:10000*
idxShank = shank_unitPairs(2,1);
idxUnit = shank_unitPairs(2,2);

for idxOdor = 11%odorsRearranged
    spikesMatMs = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
    spikesPSTHsMs = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
    spikesMatRad = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
    spikesPSTHsRad = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth;
end

figure; 
subplot(1,2,1)
imagesc(spikesMatMs(:,14800:15200)); colormap('bone');freezeColors
ymax = get(gca, 'YLim');
hold on
plot([200 200], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
hold off
set(gcf,'Position',[68 689 1135 109]);
title('First sniff onset alignement');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(spikesPSTHsMs(:,14500:16000)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([500 500], ymax, 'g', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
hold off
set(gcf,'Color','w')

figure; 
subplot(1,2,1)
imagesc(spikesMatRad(:,3*cycleLengthDeg+1:5*cycleLengthDeg)); colormap('bone');freezeColors
ymax = get(gca, 'YLim');
hold on
plot([cycleLengthDeg cycleLengthDeg+1], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('deg');
hold off
set(gcf,'Position',[68 689 1135 109]);
set(gca, 'XTick' , psthTicks);
title('First sniff onset alignement and sniff warping');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(spikesPSTHsRad(:,2*cycleLengthDeg+1:8*cycleLengthDeg)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([2*cycleLengthDeg 2*cycleLengthDeg+1], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('deg');
set(gca, 'XTick' , psthTicks);
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
hold off
set(gcf,'Color','w')


figure; sniff = squeeze(breath(1:5,20*(14550:16000),11));
xtime = -450:1000;
hold on
for i = 1:5
    plot(xtime, sniff(i,:) - (i-1)*1.2, 'k', 'linewidth', 2); axis tight
end
xlabel('ms');
ymax = get(gca, 'YLim');
plot([0 0], ymax, 'r', 'linewidth', 2);
hold off
title('Sniffs');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
set(gca,'YTick',[])
set(gcf,'Color','w')


%% 
% Let's switch unit. *Shank 3, unit 3. Odor: 5-methylthiazol 1:10000*

idxShank = shank_unitPairs(5,1);
idxUnit = shank_unitPairs(5,2);

for idxOdor = 3%odorsRearranged
    spikesMatMs = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
    spikesPSTHsMs = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
    spikesMatRad = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
    spikesPSTHsRad = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth;
end

figure; 
subplot(1,2,1)
imagesc(spikesMatMs(:,14800:15200)); colormap('bone');freezeColors
ymax = get(gca, 'YLim');
hold on
plot([200 200], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
hold off
set(gcf,'Position',[68 689 1135 109]);
title('First sniff onset alignement');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(spikesPSTHsMs(:,14550:16000)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([500 500], ymax, 'g', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
hold off
subplot(1,2,2)
imagesc(spikesPSTHsMs(:,14500:16000)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([500 500], ymax, 'g', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
hold off
set(gcf,'Color','w')

figure; 
subplot(1,2,1)
imagesc(spikesMatRad(:,3*cycleLengthDeg+1:5*cycleLengthDeg)); colormap('bone');freezeColors
ymax = get(gca, 'YLim');
hold on
plot([cycleLengthDeg cycleLengthDeg+1], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('deg');
hold off
set(gcf,'Position',[68 689 1135 109]);
title('First sniff onset alignement and sniff warping');
set(gca, 'XTick' , psthTicks);
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(spikesPSTHsRad(:,2*cycleLengthDeg+1:8*cycleLengthDeg)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([2*cycleLengthDeg 2*cycleLengthDeg+1], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('deg');
set(gca, 'XTick' , psthTicks);
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
hold off
set(gcf,'Color','w')

figure; sniff = squeeze(breath(1:5,20*(14550:16000),3));
xtime = -450:1000;
hold on
for i = 1:5
    plot(xtime, sniff(i,:) - (i-1)*1.2, 'k', 'linewidth', 2); axis tight
end
xlabel('ms');
ymax = get(gca, 'YLim');
plot([0 0], ymax, 'r', 'linewidth', 2);
hold off
title('Sniffs');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
set(gca,'YTick',[])
set(gcf,'Color','w')

%% 
% *Shank 3, unit 3. Odor: 5-methylthiazol 1:10000*

idxShank = shank_unitPairs(5,1);
idxUnit = shank_unitPairs(5,2);

for idxOdor = odorsRearranged(12)%odorsRearranged
    spikesMatMs = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
    spikesPSTHsMs = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
    spikesMatRad = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
    spikesPSTHsRad = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth;
end

figure; 
subplot(1,2,1)
imagesc(spikesMatMs(:,14800:15200)); colormap('bone');freezeColors
ymax = get(gca, 'YLim');
hold on
plot([200 200], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
hold off
set(gcf,'Position',[68 689 1135 109]);
title('First sniff onset alignement');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(spikesPSTHsMs(:,14500:16000)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([500 500], ymax, 'g', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
hold off
subplot(1,2,2)
imagesc(spikesPSTHsMs(:,14550:16000)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([500 500], ymax, 'g', 'linewidth', 2);
ylabel('trial#'); xlabel('ms');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
hold off
set(gcf,'Color','w')

figure; 
subplot(1,2,1)
imagesc(spikesMatRad(:,3*cycleLengthDeg+1:5*cycleLengthDeg)); colormap('bone');freezeColors
ymax = get(gca, 'YLim');
hold on
plot([cycleLengthDeg cycleLengthDeg+1], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('deg');
hold off
set(gcf,'Position',[68 689 1135 109]);
title('First sniff onset alignement and sniff warping');
set(gca, 'XTick' , psthTicks);
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(spikesPSTHsRad(:,2*cycleLengthDeg+1:8*cycleLengthDeg)); colormap(brewermap([],'*RdBu'))
ymax = get(gca, 'YLim');
hold on
plot([2*cycleLengthDeg 2*cycleLengthDeg+1], ymax, 'r', 'linewidth', 2);
ylabel('trial#'); xlabel('deg');
set(gca, 'XTick' , psthTicks);
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
hold off
set(gcf,'Color','w')

figure; sniff = squeeze(breath(1:5,20*(14550:16000),odorsRearranged(12)));
xtime = -450:1000;
hold on
for i = 1:5
    plot(xtime, sniff(i,:) - (i-1)*1.2, 'k', 'linewidth', 2); axis tight
end
xlabel('ms');
ymax = get(gca, 'YLim');
plot([0 0], ymax, 'r', 'linewidth', 2);
hold off
title('Sniffs');
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
set(gca,'YTick',[])
set(gcf,'Color','w')

%%
% It's clear that breath-warping makes the onset of the first breath response
% sharper and unveils responses during the following sniffs. However, the
% spikes get diluted when the mouse sniffs (usually at the first trial).
% Sniffing increases the spike density in time coordinates. 
% For PSTHs (smoothed with a gaussian window of 10 deg)
% I use phase coordinates on the x axis, but Hz on the y axis. I normalize
% by the duration of each specific inhalation and exhalation. But again,
% this actually fixes the problem within a sniff, but not across sniffs.
% _There is an important thing to consider here. Let's imagine there is a 
% mouse that breaths at 2 Hz and one of its neurons emits a spike at each breath.
% Then, we present an odor and the mouse starts sniffing at 10 Hz. 
% This would result in a response even if the synaptic
% input hasn't changed._ *Weird!* _Well, if this neurons is actually
% modulated by the olfactory input as well, then the mouse must know how
% fast he's breathing to disambiguate it._
% On the other hand, I think that the circuit operates on a timescale
% of tens of milliseconds rather than hundreds, therefore the higher precision 
% provided by the breath-warping procedure may be more appropriate. 
% *Let's give a look at these breath-clock neurons. Here, there are two from
% shank 1 and shank 4.*

idxShank1 = 1;
idxUnit1 = 5;
idxShank2 = 4;
idxUnit2 = 3;

bslWindow = preInhalations * cycleLengthDeg;
odorWindow = 0:postInhalations;
rasterTicks = [-preInhalations :0.5: postInhalations] * 2 * pi; rasterTicks(end) = [];
psthTicks = [0.5 : 2 * (preInhalations + postInhalations) + 0.5]; psthTicks(end) = [];
sdfTicks = [0 : 180 : (preInhalations + postInhalations) * cycleLengthDeg]; %sdfTicks(end) = [];
ciclo = {'i', 'e'}; labels = repmat(ciclo, 1, preInhalations); labels{2 * preInhalations + 1} = '0'; labels{2 * preInhalations + 2} = 'e';
labelsPost = repmat(ciclo, 1, postInhalations - 1); labels = [labels labelsPost];
radTick = [1 cycleLengthDeg];
radLabels={'0','2\pi'};
useColorOnset = 'ForestGreen';

odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
             'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};


listOdors = {'TMT^-4', 'TMT^-2', 'DMT^-4', 'DMT^-2', 'MT^-4', 'MT^-2',...
             'IBA^-4', 'IBA^-2', 'IAA^-4', 'IAA^-2', 'HXD^-4', 'HXD^-2', 'BTD^-4', 'BTD^-2', 'rose'};
odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];

binSizes = 5:5:cycleLengthDeg;
timePoints = 5:5:cycleLengthDeg;

titolo1 = sprintf('shank %d, unit %d', idxShank1, idxUnit1);
titolo2 = sprintf('shank %d, unit %d', idxShank2, idxUnit2);



Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);

p.pack('h',{50 50});

p(1).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});
p(2).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});


%Find max peak for sdf plot
maxPeak = 0.1;
for idxOdor = odorsRearranged
    maxPeakOdor = max(shank(idxShank2).cell(idxUnit2).odor(idxOdor).cyclePeakResponseAnalogicHz);
    if maxPeakOdor >= maxPeak
        maxPeak = maxPeakOdor;
    end
end
    

% Raster plots
idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(1,idxPlot).select();
        plotSpikeRaster(shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(idxPlot))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxPlot).select();
        plotSpikeRaster(shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(1).title(titolo1);

idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(2,idxPlot).select();
        plotSpikeRaster(shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(idxPlot))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(2,idxPlot).select();
        plotSpikeRaster(shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(2).title(titolo2);



%p.de.margin = 1;
p.margin = [8 6 4 6];
%p(1).marginright = 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%
% Clearly, these two neurons encode breathing *and* odor
% identity/concentration

%% Coherence and cross-correlation between neurons

%% 
% Let's look at sequential activations of pairs of units by odors. We can
% use a cross-correlogram. Since, the previous comparison between the
% responses of two units showed that each unit respond to a given odor at a
% preffered breath cycle, I will clculate the cross-correlations in the
% first 4 cycles. Bin width: 5 deg.


idxShank1 = 1;
idxUnit1 = 5;
idxShank2 = 4;
idxUnit2 = 3;


figure;
set(gcf,'Position',[27 48 1382 754]);
set(gcf,'Color','w')

idxPlot = 1;
for idxOdor = odorsRearranged
    for idxCycle =1:4
        st1_app = shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial;
        st2_app = shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial;
        st1Bsl = [];
        st1Rsp = [];
        st2Bsl = [];
        st2Rsp = [];
        bslCC = [];
        rspCC = [];
        for idxTrial = 1:n_trials  
            app = [];
            app = st1_app{idxTrial};
            st1Rsp = app(app > (idxCycle-1) * 2 * pi & app < idxCycle * 2 * pi);       
            app = [];
            app = st2_app{idxTrial};
            st2Rsp = app(app > (idxCycle-1) * 2 * pi & app < idxCycle * 2 * pi);
            M1=[]; M2=[]; D=[];
            M1 = length(st1Rsp);
            M2 = length(st2Rsp);
            D = ones(M2,1)*st1Rsp - st2Rsp'*ones(1,M1);
            D = D(:);
            D = radtodeg(D);
            edges = [];
            Nrsp = [];
            [Nrsp edges] = histcounts(D,-360:5:360);
            rspCC(idxTrial,:) = Nrsp;     
        end
        rspCC = mean(rspCC);
        edges(end) = [];  
        h = subplot(15,4,idxPlot);
        area(edges, rspCC); axis tight
        set(h,'FontName','Arial','Fontsize',8,'FontWeight','normal','TickDir','out','Box','off');
        idxPlot = idxPlot + 1;
        drawnow
    end
end
%%
% So, these two units are quite in phase when they are not excited by an
% odor. Perhaps, unit 1 slightly precedes unit 2. However, everytime that a unit responds, its spikes
%tend to precede those of the other unit. See also figure below where I'm plotting the differential response relative to
%the baseline for unit 1 (blue) and unit 2 (red).

idxShank1 = 1;
idxUnit1 = 5;
idxShank2 = 4;
idxUnit2 = 3;
figure;
set(gcf,'Position',[27 48 1382 754]);
set(gcf,'Color','w')
idxPlot = 1;
for idxOdor = odorsRearranged
    for idxCycle =1:4
        st1_app = [];
        st2_app = [];
        st1_bsl = [];
        st1_bsl= [];
        st1_app= mean(shank(idxShank1).cell(idxUnit1).odor(idxOdor).sdf_trialHz(:,(idxCycle+3) * cycleLengthDeg + 1 : (idxCycle+4) * cycleLengthDeg));
        st2_app = mean(shank(idxShank2).cell(idxUnit2).odor(idxOdor).sdf_trialHz(:,(idxCycle+3) * cycleLengthDeg + 1: (idxCycle+4) * cycleLengthDeg));
        st1_bsl = mean(shank(idxShank1).cell(idxUnit1).cycleBslMultipleSdfHz);
        st2_bsl = mean(shank(idxShank2).cell(idxUnit2).cycleBslMultipleSdfHz);
        st1_app = st1_app - st1_bsl;
        st2_app = st2_app - st2_bsl;
        subplot(15,4,idxPlot)
        plot(st1_app, 'linewidth', 2); hold on; plot(st2_app, 'linewidth', 2); hold off; axis tight; 
        set(gca,'FontName','Arial','Fontsize',8,'FontWeight','normal','TickDir','out','Box','off');
        idxPlot = idxPlot + 1;
    end
end
        
        

%%
% Let's see what happen between the second unit from the previous plot and
% a different unit on shank3 (unit 3).
idxShank1 = 3;
idxUnit1 = 3;
idxShank2 = 4;
idxUnit2 = 3;

bslWindow = preInhalations * cycleLengthDeg;
odorWindow = 0:postInhalations;
rasterTicks = [-preInhalations :0.5: postInhalations] * 2 * pi; rasterTicks(end) = [];
psthTicks = [0.5 : 2 * (preInhalations + postInhalations) + 0.5]; psthTicks(end) = [];
sdfTicks = [0 : 180 : (preInhalations + postInhalations) * cycleLengthDeg]; %sdfTicks(end) = [];
ciclo = {'i', 'e'}; labels = repmat(ciclo, 1, preInhalations); labels{2 * preInhalations + 1} = '0'; labels{2 * preInhalations + 2} = 'e';
labelsPost = repmat(ciclo, 1, postInhalations - 1); labels = [labels labelsPost];
radTick = [1 cycleLengthDeg];
radLabels={'0','2\pi'};
useColorOnset = 'ForestGreen';

odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
             'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};


listOdors = {'TMT^-4', 'TMT^-2', 'DMT^-4', 'DMT^-2', 'MT^-4', 'MT^-2',...
             'IBA^-4', 'IBA^-2', 'IAA^-4', 'IAA^-2', 'HXD^-4', 'HXD^-2', 'BTD^-4', 'BTD^-2', 'rose'};
odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];

binSizes = 5:5:cycleLengthDeg;
timePoints = 5:5:cycleLengthDeg;

titolo1 = sprintf('shank %d, unit %d', idxShank1, idxUnit1);
titolo2 = sprintf('shank %d, unit %d', idxShank2, idxUnit2);



Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);

p.pack('h',{50 50});

p(1).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});
p(2).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});


%Find max peak for sdf plot
maxPeak = 0.1;
for idxOdor = odorsRearranged
    maxPeakOdor = max(shank(idxShank2).cell(idxUnit2).odor(idxOdor).cyclePeakResponseAnalogicHz);
    if maxPeakOdor >= maxPeak
        maxPeak = maxPeakOdor;
    end
end
    

% Raster plots
idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(1,idxPlot).select();
        plotSpikeRaster(shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(idxPlot))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxPlot).select();
        plotSpikeRaster(shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(1).title(titolo1);

idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(2,idxPlot).select();
        plotSpikeRaster(shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(idxPlot))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(2,idxPlot).select();
        plotSpikeRaster(shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(2).title(titolo2);



%p.de.margin = 1;
p.margin = [8 6 4 6];
%p(1).marginright = 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%
% And cross-correlations for each breath cycle


idxShank1 = 3;
idxUnit1 = 3;
idxShank2 = 4;
idxUnit2 = 3;


figure;
set(gcf,'Position',[27 48 1382 754]);
set(gcf,'Color','w')

idxPlot = 1;
for idxOdor = odorsRearranged
    for idxCycle =1:4
        st1_app = shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial;
        st2_app = shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial;
        st1Rsp = 0;
        st2Rsp = 0;
        bslCC = [];
        rspCC = [];
        for idxTrial = 1:n_trials  
            app = [];
            app = st1_app{idxTrial};
            st1Rsp = app(app > (idxCycle-1) * 2 * pi & app < idxCycle * 2 * pi);       
            app = [];
            app = st2_app{idxTrial};
            st2Rsp = app(app > (idxCycle-1) * 2 * pi & app < idxCycle * 2 * pi);
            M1=[]; M2=[]; D=[];
            M1 = length(st1Rsp);
            M2 = length(st2Rsp);
            D = ones(M2,1)*st1Rsp - st2Rsp'*ones(1,M1);
            D = D(:);
            D = radtodeg(D);
            edges = [];
            Nrsp = [];
            [Nrsp edges] = histcounts(D,-360:5:360);
            rspCC(idxTrial,:) = Nrsp;     
        end
        rspCC = mean(rspCC);
        edges(end) = [];  
        h = subplot(15,4,idxPlot);
        area(edges, rspCC); axis tight
        set(h,'FontName','Arial','Fontsize',8,'FontWeight','normal','TickDir','out','Box','off');
        idxPlot = idxPlot + 1;
        drawnow
    end
end

figure;
set(gcf,'Position',[27 48 1382 754]);
set(gcf,'Color','w')
idxPlot = 1;
for idxOdor = odorsRearranged
    for idxCycle =1:4
        st1_app = [];
        st2_app = [];
        st1_bsl = [];
        st1_bsl= [];
        st1_app= mean(shank(idxShank1).cell(idxUnit1).odor(idxOdor).sdf_trialHz(:,(idxCycle+3) * cycleLengthDeg + 1 : (idxCycle+4) * cycleLengthDeg));
        st2_app = mean(shank(idxShank2).cell(idxUnit2).odor(idxOdor).sdf_trialHz(:,(idxCycle+3) * cycleLengthDeg + 1: (idxCycle+4) * cycleLengthDeg));
        st1_bsl = mean(shank(idxShank1).cell(idxUnit1).cycleBslMultipleSdfHz);
        st2_bsl = mean(shank(idxShank2).cell(idxUnit2).cycleBslMultipleSdfHz);
        st1_app = st1_app - st1_bsl;
        st2_app = st2_app - st2_bsl;
        subplot(15,4,idxPlot)
        plot(st1_app, 'linewidth', 2); hold on; plot(st2_app, 'linewidth', 2); hold off; axis tight; 
        set(gca,'FontName','Arial','Fontsize',8,'FontWeight','normal','TickDir','out','Box','off');
        idxPlot = idxPlot + 1;
    end
end

%%
% Let's see what happen between the first unit from the first plot and
% unit 3 on shank3.

idxShank1 = 3;
idxUnit1 = 3;
idxShank2 = 1;
idxUnit2 = 5;

bslWindow = preInhalations * cycleLengthDeg;
odorWindow = 0:postInhalations;
rasterTicks = [-preInhalations :0.5: postInhalations] * 2 * pi; rasterTicks(end) = [];
psthTicks = [0.5 : 2 * (preInhalations + postInhalations) + 0.5]; psthTicks(end) = [];
sdfTicks = [0 : 180 : (preInhalations + postInhalations) * cycleLengthDeg]; %sdfTicks(end) = [];
ciclo = {'i', 'e'}; labels = repmat(ciclo, 1, preInhalations); labels{2 * preInhalations + 1} = '0'; labels{2 * preInhalations + 2} = 'e';
labelsPost = repmat(ciclo, 1, postInhalations - 1); labels = [labels labelsPost];
radTick = [1 cycleLengthDeg];
radLabels={'0','2\pi'};
useColorOnset = 'ForestGreen';

odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
             'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};


listOdors = {'TMT^-4', 'TMT^-2', 'DMT^-4', 'DMT^-2', 'MT^-4', 'MT^-2',...
             'IBA^-4', 'IBA^-2', 'IAA^-4', 'IAA^-2', 'HXD^-4', 'HXD^-2', 'BTD^-4', 'BTD^-2', 'rose'};
odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];

binSizes = 5:5:cycleLengthDeg;
timePoints = 5:5:cycleLengthDeg;

titolo1 = sprintf('shank %d, unit %d', idxShank1, idxUnit1);
titolo2 = sprintf('shank %d, unit %d', idxShank2, idxUnit2);



Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);

p.pack('h',{50 50});

p(1).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});
p(2).pack('v', {1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15 ...
    1/15 1/15 1/15 1/15 1/15});


%Find max peak for sdf plot
maxPeak = 0.1;
for idxOdor = odorsRearranged
    maxPeakOdor = max(shank(idxShank2).cell(idxUnit2).odor(idxOdor).cyclePeakResponseAnalogicHz);
    if maxPeakOdor >= maxPeak
        maxPeak = maxPeakOdor;
    end
end
    

% Raster plots
idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(1,idxPlot).select();
        plotSpikeRaster(shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(idxPlot))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(1,idxPlot).select();
        plotSpikeRaster(shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(1).title(titolo1);

idxPlot = 1;
for idxOdor = odorsRearranged
    if idxPlot == 15
        p(2,idxPlot).select();
        plotSpikeRaster(shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        ylabel(listOdors(idxPlot))
        set(gca, 'XTick' , rasterTicks);
        set(gca, 'XTickLabel', labels);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    else
        p(2,idxPlot).select();
        plotSpikeRaster(shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
            [-preInhalations postInhalations] * 2 * pi);
        line([0 0], [0 6], 'Color', rgb(useColorOnset))
        %ShadePlotForEmpahsis(odorWindow,'r',0.5);
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'YTick',[])
        %set(gca,'YColor','w')
        ylabel(listOdors(idxPlot))
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxPlot = idxPlot+1;
end

p(2).title(titolo2);



%p.de.margin = 1;
p.margin = [8 6 4 6];
%p(1).marginright = 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');


set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%
% And cross-correlations for each breath cycle


idxShank1 = 3;
idxUnit1 = 3;
idxShank2 = 1;
idxUnit2 = 5;


figure;
set(gcf,'Position',[27 48 1382 754]);
set(gcf,'Color','w')

idxPlot = 1;
for idxOdor = odorsRearranged
    for idxCycle =1:4
        st1_app = shank(idxShank1).cell(idxUnit1).odor(idxOdor).alphaTrial;
        st2_app = shank(idxShank2).cell(idxUnit2).odor(idxOdor).alphaTrial;
        st1Rsp = 0;
        st2Rsp = 0;
        bslCC = [];
        rspCC = [];
        for idxTrial = 1:n_trials  
            app = [];
            app = st1_app{idxTrial};
            st1Rsp = app(app > (idxCycle-1) * 2 * pi & app < idxCycle * 2 * pi);       
            app = [];
            app = st2_app{idxTrial};
            st2Rsp = app(app > (idxCycle-1) * 2 * pi & app < idxCycle * 2 * pi);
            M1=[]; M2=[]; D=[];
            M1 = length(st1Rsp);
            M2 = length(st2Rsp);
            D = ones(M2,1)*st1Rsp - st2Rsp'*ones(1,M1);
            D = D(:);
            D = radtodeg(D);
            edges = [];
            Nrsp = [];
            [Nrsp edges] = histcounts(D,-360:5:360);
            rspCC(idxTrial,:) = Nrsp;     
        end
        rspCC = mean(rspCC);
        edges(end) = [];  
        h = subplot(15,4,idxPlot);
        area(edges, rspCC); axis tight
        set(h,'FontName','Arial','Fontsize',8,'FontWeight','normal','TickDir','out','Box','off');
        idxPlot = idxPlot + 1;
        drawnow
    end
end

figure;
set(gcf,'Position',[27 48 1382 754]);
set(gcf,'Color','w')
idxPlot = 1;
for idxOdor = odorsRearranged
    for idxCycle =1:4
        st1_app = [];
        st2_app = [];
        st1_bsl = [];
        st1_bsl= [];
        st1_app= mean(shank(idxShank1).cell(idxUnit1).odor(idxOdor).sdf_trialHz(:,(idxCycle+3) * cycleLengthDeg + 1 : (idxCycle+4) * cycleLengthDeg));
        st2_app = mean(shank(idxShank2).cell(idxUnit2).odor(idxOdor).sdf_trialHz(:,(idxCycle+3) * cycleLengthDeg + 1: (idxCycle+4) * cycleLengthDeg));
        st1_bsl = mean(shank(idxShank1).cell(idxUnit1).cycleBslMultipleSdfHz);
        st2_bsl = mean(shank(idxShank2).cell(idxUnit2).cycleBslMultipleSdfHz);
        st1_app = st1_app - st1_bsl;
        st2_app = st2_app - st2_bsl;
        subplot(15,4,idxPlot)
        plot(st1_app, 'linewidth', 2); hold on; plot(st2_app, 'linewidth', 2); hold off; axis tight; 
        set(gca,'FontName','Arial','Fontsize',8,'FontWeight','normal','TickDir','out','Box','off');
        idxPlot = idxPlot + 1;
    end
end


%% Let's try a different thing! 
% Let's look at a raster plot where the rows are not trials, but distinct
% units on the same trial.

odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
             'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};


listOdors = {'TMT^-4', 'TMT^-2', 'DMT^-4', 'DMT^-2', 'MT^-4', 'MT^-2',...
             'IBA^-4', 'IBA^-2', 'IAA^-4', 'IAA^-2', 'HXD^-4', 'HXD^-2', 'BTD^-4', 'BTD^-2', 'rose'};
odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];

idxExp  =1;
shank_unitPairs = [1,4;...
    1,5;...
    3,1;...
    3,2;...
    3,3;...
    3,5;...
    4,1;...
    4,3;...
    4,4;...
    4,5];

spikesMatRad = [];
spikesPSTHsRad = [];
idxO = 1;
for idxOdor = odorsRearranged
    for idxTrial = 1:n_trials
        for idxPair = 1:length(shank_unitPairs)
            idxShank = shank_unitPairs(idxPair,1);
            idxUnit = shank_unitPairs(idxPair,2);
            spikesMatRad{idxOdor}(idxPair,:,idxTrial) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,1*cycleLengthDeg+1:8*cycleLengthDeg);
            spikesPSTHsRad{idxOdor}(idxPair,:,idxTrial) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth(idxTrial,1*cycleLengthDeg+1:8*cycleLengthDeg);
        end
    end
    idxO = idxO + 1;
end

for idxOdor = 1:length(odorsRearranged)
    for idxTrial = 1:n_trials
        for idxUnit = 1:length(shank_unitPairs)
            rasterUnits(idxOdor).trial(idxTrial).unit{idxUnit} = find(spikesMatRad{idxOdor}(idxUnit,:,idxTrial) > 0);
        end
    end
end


for idxTrial = 1:n_trials
    Xfig = 600;
    Yfig = 800;
    figure;
    set(gcf, 'Position',[1,5,Xfig,Yfig]);
    p = panel();
    p.pack('v', {1/15 1/15 1/15 1/15 1/15 ...
        1/15 1/15 1/15 1/15 1/15 ...
        1/15 1/15 1/15 1/15 1/15});
    
    for idxOdor = 1:length(odorsRearranged)
        if idxOdor < 15
            p(idxOdor).select()
            plotSpikeRaster(rasterUnits(idxOdor).trial(idxTrial).unit,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell', [1 360*8]);
            line([360*4 360*4], [0 length(shank_unitPairs)+1], 'Color', [0,109,44]/255)
     
            set(gca, 'XTick' , []);
            set(gca, 'XTickLabel', []);
            set(gca,'YTick',[])
            ylabel(listOdors(idxOdor))
        else
            p(15).select()
            plotSpikeRaster(rasterUnits(idxOdor).trial(idxTrial).unit,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell', [1 360*8]);
            line([360*4 360*4], [0 length(shank_unitPairs)+1], 'Color', [0,109,44]/255)
     
            set(gca, 'XTick' , []);
            set(gca, 'XTickLabel', []);
            set(gca,'YTick',[])
            ylabel(listOdors(idxOdor))
%             set(gca, 'XTick' , rasterTicks);
%             set(gca, 'XTickLabel', labels);
            set(gca,'YTick',[])
            %set(gca,'YColor','w')
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
        end
    end
    %p.de.margin = 1;
    p.margin = [8 6 4 6];
    %p(1).marginright = 10;
    p(2).marginleft = 30;
    %p(3).marginleft = 10;
    p.select('all');
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
end

















