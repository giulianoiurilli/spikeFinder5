

%% Filter LFP in distinct bands


    


%% Extract spike phases


phaseSpikes = [];

for idxBand = 1:5
    
    for idxOdor = 1:15
        phaseSpikes = zeros(10,30000);
        for idxTrial = 1:10
            timesSpikes = [];
            angleSpikes = [];
            angles = [];
            timesSpikes = shankNowarp(4).cell(3).odor(idxOdor).spikeMatrixNoWarp(idxTrial,:);
            angles = lfpBands(idxBand).angle(idxTrial,:,idxOdor);
            angles = rad2deg(angles);
            phaseSpikes(idxTrial, timesSpikes == 1) = angles(timesSpikes == 1);
        end
        shankNowarp(4).cell(3).odor(idxOdor).band(idxBand).angleSpikes = [];
        shankNowarp(4).cell(3).odor(idxOdor).band(idxBand).angleSpikes = phaseSpikes;
    end
end

%% Extract inhalation onsets
inaOnset = [];
for idxOdor = 1:15
    for idxTrial = 1:10
        app = [];
        respiro = [];
        inalazioni = [];
        ina_on_app = [];
        ina_on = [];
        app = downsample(breath(idxTrial,:,idxOdor),20);
        respiro = app;
        inalazioni = respiro<0;
        app_in = diff(inalazioni);
        ina_on_app = find(app_in==1);
        ina_on_app = ina_on_app + 1;
        ina_on(:,1) = ina_on_app';
        sec_ina_on = ina_on/newFs;
        sec_ina_on = sec_ina_on - repmat(pre,length(sec_ina_on),1);
        ina_post = sec_ina_on(sec_ina_on>0);
        [indice_ina,~] = find(sec_ina_on == ina_post(1));
        ina_on(indice_ina,2) = 1;
        inaOnset(idxOdor).odor{idxTrial} = ina_on;
    end
end

%%

idxOdor = 13;
xresp = [];
for idxTrial = 1:10
    idxRow = 1;
    edges = [];
    edges = inaOnset(idxOdor).odor{idxTrial};
    firstInh = find(edges(:,2) == 1);
    edges(:,2) = [];
    edges(1:firstInh - 10) = [];
    edges(20:end) = [];
    x = shankNowarp(4).cell(3).odor(idxOdor).band(2).angleSpikes(idxTrial,:);
    
    for idxSniff = 1:length(edges) - 1
        app = [];
        app = x(edges(idxSniff):edges(idxSniff+1));
        xresp(idxTrial).apAngles{idxSniff} = app(app>0);
        idxRow = idxRow + 1;
    end
end

%%

figure
set(gcf,'Position',[1 656 536 149]);
set(gcf,'Color','w')
idxPlot = 1;
p = panel();
p.pack('h',{1/10 1/10 1/10 1/10 1/10 ...
    1/10 1/10 1/10 1/10 1/10});
%p.pack('h',{20 20 20 20 20});
%p.pack('h',{1/6 1/6 1/6 1/6 1/6 1/6});

for idxTrial = 1:10
    p(idxPlot).select();
    %plotSpikeRaster(cycleTrial(idxTrial).cycleBin,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell', [0 360]);
    plotSpikeRaster(xresp(idxTrial).apAngles,'PlotType','scatter','XLimForCell', [0 360]);
    %set(gca,'YTick',[]), set(gca,'YColor','w')
    set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
    idxPlot = idxPlot+1;
end

p.de.margin = 10;
p.margin = [8 6 4 6];
p.select('all');

%%


idxOdor = 14;
idxShank = 4;
idxUnit = 3;

respira = squeeze(breath(:,:,idxOdor));
respira = respira';
respira = downsample(respira,20);
respira = respira';
respRhythm = respira(:,from*1000:to*1000);
respRhythm = respRhythm';
respRhythm = zscore(respRhythm);
respRhythm = respRhythm';

lfpdelta = squeeze(lfpBands(2).band(:,:,idxOdor));
lfpdelta = lfpdelta(:,from*1000:to*1000);
lfpdelta = lfpdelta';
lfpdelta = zscore(lfpdelta);
lfpdelta = lfpdelta';

spikeCell =  squeeze(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:,from*1000:to*1000));
spikeCell = spikeCell';
spikeCell = zscore(spikeCell);
spikeCell = spikeCell';



figure
set(gcf,'Position',[-1261 42 673 655]);
set(gcf,'Color','w')
p = panel();
p.pack('v',{10 10 10 10 10 10 10 10 10 10});
for idxTrial = 1:10
    p(idxTrial).select()
    hold on
    plot(xtime, respRhythm(idxTrial,:), 'k', 'linewidth', 1)
    plot(xtime, lfpdelta(idxTrial,:), 'b', 'linewidth', 1)
    plot(xtime, spikeCell(idxTrial,:), 'r', 'linewidth', 1)
    ymax = get(gca, 'YLim');
    plot([0 0], ymax, 'color', [44,162,95]/255, 'linewidth', 1);
    set(gca,'YTick',[]),
    set(gca,'YColor','w')
    set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
end

p.title('but-2')
p.de.margin = 4;
p.margin = [8 6 4 6];
p.select('all');

    
    
        
 
    
















