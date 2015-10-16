odorToUse = [1 8 6 13 7 14];
shank_unitPairs = [1,5;...
                   3,2;...
                   3,3;...
                   3,5;...
                   4,3];

edgesAngles = -360*5:360:360*10;
sniffMeanAngle = [];
for idxOdor = odorToUse
    for idxShankUnit = 1:size(shank_unitPairs,1)
        idxShank = shank_unitPairs(idxShankUnit,1);
        idxUnit = shank_unitPairs(idxShankUnit,2);
        spikeAnglePerSniff = [];
        j = 1;
        for idxTrial = 2:9
            unitAllAngles = [];
            sniffBin = [];
            unitAllAngles = rad2deg(shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial{idxTrial});
            [~, sniffBin] = histc(unitAllAngles, edgesAngles);
            for idxSniff = 1:length(edgesAngles)
                spikesInSniff = [];
                spikesInSniff = unitAllAngles(sniffBin == idxSniff);
                if ~isempty(spikesInSniff)
                    if idxSniff < 6
                        spikesInSniff = spikesInSniff + (6 - idxSniff)*360;
                        spikeAnglePerSniff(j).sniff{idxSniff} = spikesInSniff;
                    else
                        spikesInSniff = spikesInSniff - (idxSniff - 6)*360;
                        spikeAnglePerSniff(j).sniff{idxSniff} = spikesInSniff;
                    end
                else
                    spikeAnglePerSniff(j).sniff{idxSniff} = [];
                end
            end
            j = j+1;
        end
        for idxSniff = 1:length(edgesAngles)
            app = [];
            for idxTrial = 1:8
                app = [app spikeAnglePerSniff(idxTrial).sniff{idxSniff}];
            end
            alpha = [];
            alpha = circ_mean(deg2rad(app), [], 2);
            alpha = rad2deg(alpha);
            if alpha < 0
                alpha = 360 + alpha;
            end
            if isempty(alpha)
                alpha = NaN;
            end
            sniffMeanAngle(idxShankUnit, idxSniff, idxOdor) = alpha;      
        end
    end
end


%%
figure
hold on
idxConc = 1;
for idxOdor = [7 14]
    traces = squeeze(sniffMeanAngle(:,:,idxOdor));
    if idxConc == 1
        plot(traces(1,:), ':r', 'linewidth', 1)
        plot(traces(5,:), ':k', 'linewidth', 1)

    else
        plot(traces(1,:), 'r', 'linewidth', 1)
        plot(traces(5,:), 'k', 'linewidth', 1)

    end
    idxConc = idxConc + 1;
end
hold off
        %xlim = ([4 15]);
        
%%
figure;
idxPlot = 1;
for idxOdor = [1 8]
    risposte = [];
    risposteHz = [];
    for idxCycle = 1:4
        for idxUnit = 1:size(shank_unitPairs,1)
            idxShank = shank_unitPairs(idxUnit,1);
            idxCell = shank_unitPairs(idxUnit,2);
            risposte(idxUnit,:,idxCycle) = mean(squeeze(shank(idxShank).cell(idxCell).odor(idxOdor).sdf_trialRad(:,(10+idxCycle)*360+1:(10+idxCycle+1)*360)));
            risposteHz(idxUnit,:,idxCycle) = mean(squeeze(shank(idxShank).cell(idxCell).odor(idxOdor).sdf_trialHz(:,(10+idxCycle)*360+1:(10+idxCycle+1)*360)));
        end
        subplot(2,4,idxPlot)
        rispPlot = squeeze(risposte(:,:,idxCycle));
        plot(rispPlot', 'linewidth', 1);
        idxPlot = idxPlot + 1;
    end
end

%%
figure;
idxPlot = 1;
for idxOdor = [1 8]
    rispostems = [];
        for idxUnit = 1:size(shank_unitPairs,1)
            idxShank = shank_unitPairs(idxUnit,1);
            idxCell = shank_unitPairs(idxUnit,2);
            rispostems(idxUnit,:) = mean(shankNowarp(idxShank).cell(idxCell).odor(idxOdor).sdf_trialNoWarp(:,15000:15300));
        end
        subplot(2,1,idxPlot)
        
        plot(rispostems', 'linewidth', 1);
        idxPlot = idxPlot + 1;
    
end

%%
odorToUse = [1 8 2 9 3 10 4 11 5 12 6 13 7 14];
idxO = 1;
odor = [];
for idxOdor = odorToUse
    odor(idxO).cycle = [];
    for idxCycle = 1:4
        odor(idxO).cycle(idxCycle).risposte = []; 
        idxUnit = 1;
        for idxExp = 1:7
        for idxShank = 1:4
        for idxCell = 1:length(shank(idxShank).spiketimesUnit)
            odor(idxO).cycle(idxCycle).risposte(idxUnit,:) = mean(squeeze(exp(idxExp).shank(idxShank).cell(idxCell).odor(idxOdor).smoothedPsth(:,(5+idxCycle)*360+1:(5+idxCycle+1)*360)));
            idxUnit = idxUnit + 1;
        end
        end
        end
    end
    idxO = idxO + 1;
end


matCycle = [];
for idxCycle = 1:4
    for idxOdor = 1:14
        app = []; app = odor(idxOdor).cycle(idxCycle).risposte;
        matCycle(:,idxOdor,idxCycle) = app(:);
    end
end

for idxCycle = 1:4
    figure
    app = [];
    app = squeeze(matCycle(:,:,idxCycle));
    dist = pdist(app');
    dist = squareform(dist);
    Z = linkage(dist);
    dendrogram(Z);
end
%%
shank_unitPairs = [1,5;...
    3,2;...
    3,3;...
    3,5;...
    4,3];

from = 12;
to = 18;
xtime = -3:1/1000:3;


for idxFig = 1:size(shank_unitPairs,1)
    idxShank = shank_unitPairs(idxFig,1);
    idxUnit = shank_unitPairs(idxFig, 2);
    figure
    set(gcf,'Position',[1 5 1000 900]);
    set(gcf,'Color','w')
    p = panel();
    p.pack('v',{1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15});
    idxPlot = 0;
    for idxOdor = 1:odors
        useOdor = odorsRearranged(idxOdor);
        idxPlot = idxPlot + 1;
        spikesMatMs = [];
        spikesMatMs = shankNowarp(idxShank).cell(idxUnit).odor(useOdor).spikeTimesTrial;
        p(idxPlot).select()
        plotSpikeRaster(spikesMatMs,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell', [-3 3]);
        ylabel(listOdors(idxOdor))
        %axis tight,
        ymax = get(gca, 'YLim');
        hold on
        plot([0 0], ymax, 'color', [44,162,95]/255, 'linewidth', 1);
        set(gca,'YTick',[]),
        set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
    end
    neuronID = [];
    neuronID = sprintf('shank%d - unit%d', idxShank, idxUnit);
    p.title(neuronID)
    p.de.margin = 1;
    p.margin = [8 6 4 6];
    %     p(2).marginleft = 30;
    p.select('all');
end

%%
xtime = -1:1/1000:1;
for idxOdor = 14
    
    for idxTrial = [3 4]
        idxP = 1;
        respira = downsample(squeeze(breath(idxTrial,:,idxOdor)), 20);
        respira = zscore(respira(14000:16000));
        beta = zscore(lfpBands(5).band(idxTrial,14000:16000, idxOdor));
        n1 = shankNowarp(1).cell(5).odor(idxOdor).spikeTimesTrial{idxTrial};
        n1(n1<-1) = [];
        n1(n1>1) = [];
        n1 = (n1*1000)+1000;
        n2 = shankNowarp(4).cell(3).odor(idxOdor).spikeTimesTrial{idxTrial};
        n2(n2<-1) = [];
        n2(n2>1) = [];
        n2 = (n2*1000)+1000;
        figure
        plot(respira, 'k', 'linewidth', 1);
        hold on
        plot(beta, 'r', 'linewidth', 1);
        ymax = get(gca, 'YLim');
        for idxSpike = 1:length(n1)
            plot([n1(idxSpike) n1(idxSpike)], ymax, 'color', [8,48,107]/255, 'linewidth', 1);
        end
        for idxSpike = 1:length(n2)
            plot([n2(idxSpike) n2(idxSpike)], ymax, 'color', [241,105,19]/255, 'linewidth', 1);
        end      
        set(gca,'YTick',[]),
        set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
        hold off
    end
end

            




    


