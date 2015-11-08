parameters
%% find exc and inh responsive cell-odor pairs
responsiveUnitExc300ms = 0;
responsiveUnitInh300ms = 0;
responsiveUnitExc4cycles = 0;
responsiveUnitInh4cycles = 0;
allUnits = 0;
for idxExp = 1 : length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            for idxOdor = 1:odors
                responsiveUnitExc4cycles = responsiveUnitExc4cycles + (exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1);
                responsiveUnitInh4cycles = responsiveUnitInh4cycles + (exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1);
                responsiveUnitExc300ms = responsiveUnitExc300ms + (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1);
                responsiveUnitInh300ms = responsiveUnitInh300ms + (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1);
                allUnits = allUnits + 1;
            end
        end
    end
end

%% make distributions of delta spikes, auROC, p-values, mean spike counts, var spike counts, Fano factors for each response
excDeltaSpikes300ms = zeros(responsiveUnitExc300ms,1);
excDeltaSpikes4cycles = zeros(responsiveUnitExc4cycles,1);
inhDeltaSpikes300ms = zeros(responsiveUnitInh300ms,1);
inhDeltaSpikes4cycles = zeros(responsiveUnitInh4cycles,1);
allUnitsDeltaSpikes4 = zeros(allUnits,1);
allUnitsDeltaSpikes300 = zeros(allUnits,1);

excAuRoc300ms = zeros(responsiveUnitExc300ms,1);
excAuRoc4cycles = zeros(responsiveUnitExc4cycles,1);
inhAuRoc300ms = zeros(responsiveUnitInh300ms,1);
inhAuRoc4cycles = zeros(responsiveUnitInh4cycles,1);
allAuRocSpikes4 = zeros(allUnits,1);
allAuRocSpikes300 = zeros(allUnits,1);

excPValue300ms = zeros(responsiveUnitExc300ms,1);
excPValue4cycles = zeros(responsiveUnitExc4cycles,1);
inhPValue300ms = zeros(responsiveUnitInh300ms,1);
inhPValue4cycles = zeros(responsiveUnitInh4cycles,1);
allPValueSpikes4 = zeros(allUnits,1);
allPValueSpikes300 = zeros(allUnits,1);

excMeanRsp300ms = zeros(responsiveUnitExc300ms,1);
excMeanRsp4cycles = zeros(responsiveUnitExc4cycles,1);
inhMeanRsp300ms = zeros(responsiveUnitInh300ms,1);
inhMeanRsp4cycles = zeros(responsiveUnitInh4cycles,1);
allMeanRsp4 = zeros(allUnits,1);
allMeanRsp300 = zeros(allUnits,1);

excVarRsp300ms = zeros(responsiveUnitExc300ms,1);
excVarRsp4cycles = zeros(responsiveUnitExc4cycles,1);
inhVarRsp300ms = zeros(responsiveUnitInh300ms,1);
inhVarRsp4cycles = zeros(responsiveUnitInh4cycles,1);
allVarRsp4 = zeros(allUnits,1);
allVarRsp300 = zeros(allUnits,1);

excFanoRsp300ms = zeros(responsiveUnitExc300ms,1);
excFanoRsp4cycles = zeros(responsiveUnitExc4cycles,1);
inhFanoRsp300ms = zeros(responsiveUnitInh300ms,1);
inhFanoRsp4cycles = zeros(responsiveUnitInh4cycles,1);
allFanoRsp4 = zeros(allUnits,1);
allFanoRsp300 = zeros(allUnits,1);

peakLat = zeros(responsiveUnitExc300ms,1);
hWidth = zeros(responsiveUnitExc300ms,1);


idxE4 = 0;
idxI4 = 0;
idxE300 = 0;
idxI300 = 0;
idxAll4 = 0;
idxAll300 = 0;
for idxExp = 1 : length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            for idxOdor = 1:odors
                idxAll4 = idxAll4 + 1;
                idxAll300 = idxAll300 + 1;
                
                allUnitsDeltaSpikes4(idxAll4) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse) - ...
                    mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl);
                allAuRocSpikes4(idxAll4) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles;
                allPValueSpikes4(idxAll4) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).pValue4cycles;
                allMeanRsp4(idxAll4) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse);
                allVarRsp4(idxAll4) = var(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse);
                if allMeanRsp4(idxAll4) > 0
                    allFanoRsp4(idxAll4) = allVarRsp4(idxAll4) ./ allVarRsp4(idxAll4);
                else
                    allFanoRsp4(idxAll4) = 0;
                end
                
                allUnitsDeltaSpikes300(idxAll300) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                    mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                if allUnitsDeltaSpikes300(idxAll300) == -Inf
                    [idxExp idxShank idxUnit idxOdor]
                    mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms)
                    mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms)
                end
                allAuRocSpikes300(idxAll300) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                allPValueSpikes300(idxAll300) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms;
                allMeanRsp300(idxAll300) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                allVarRsp300(idxAll300) = var(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                if allMeanRsp300(idxAll300) > 0 
                    allFanoRsp300(idxAll300) = allVarRsp300(idxAll300) ./ allVarRsp300(idxAll300);
                else
                    allFanoRsp300(idxAll300) = 0;
                end
                
                    
                    
                    
                if exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1
                    idxE4 = idxE4 + 1;
                    excDeltaSpikes4cycles(idxE4) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse) - ...
                        mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl);
                    excAuRoc4cycles(idxE4) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles;
                    excPValue4cycles(idxE4) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).pValue4cycles;
                    excMeanRsp4cycles(idxE4)  = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse);
                    excVarRsp4cycles(idxE4)  = var(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse);
                    if excMeanRsp4cycles(idxE4) > 0
                        excFanoRsp4cycles(idxE4) = excVarRsp4cycles(idxE4) ./ excMeanRsp4cycles(idxE4);
                    else
                        excFanoRsp4cycles(idxE4)  = 0;
                    end
                end
                if exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1
                    idxI4 = idxI4 + 1;
                    inhDeltaSpikes4cycles(idxI4) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse) - ...
                        mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl);
                    inhAuRoc4cycles(idxI4)  = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles;
                    inhPValue4cycles(idxI4)  = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).pValue4cycles;
                end
                if exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1
                    idxE300 = idxE300 + 1;
                    excDeltaSpikes300ms(idxE300) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                        mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    excAuRoc300ms(idxE300)  = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    excPValue300ms(idxE300)  = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms;
                    excMeanRsp300ms(idxE300) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                    excVarRsp300ms(idxE300) = var(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                    if excMeanRsp300ms(idxE300) > 0
                        excFanoRsp300ms(idxE300) = excVarRsp300ms(idxE300) ./ excMeanRsp300ms(idxE300);
                    else
                        excFanoRsp300ms(idxE300) = 0;
                    end
                    peakLat(idxE300) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency300ms;
                    hWidth(idxE300) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth300ms;
                end
                if exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1
                    idxI300 = idxI300 + 1;
                    inhDeltaSpikes300ms(idxI300) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                        mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    inhAuRoc300ms(idxI300) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    inhPValue300ms(idxI300) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms;
                end
            end
        end
    end
end

%% plot delta spikes
max4 = max(allUnitsDeltaSpikes4);
min4 = min(allUnitsDeltaSpikes4);
max300 = max(allUnitsDeltaSpikes300);
min300 = min(allUnitsDeltaSpikes300);
edges4 = floor(min4):ceil(max4);
edges300 = floor(min300):ceil(max300);

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(allUnitsDeltaSpikes4, edges4);
edges(end) = [];
h0 = area(edges, N./allUnits);
h0.FaceColor = [255 255 191]/255;
h0.EdgeColor = [255 255 191]/255;
hold on
[N,edges] = histcounts(excDeltaSpikes4cycles, edges4);
edges(1) = [];
h1 = area(edges, N./allUnits);
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
hold on
[N,edges] = histcounts(inhDeltaSpikes4cycles, edges4);
edges(end) = [];
h2 = area(edges, N./allUnits);
h2.FaceColor = [50 136 189]/255;
h2.EdgeColor = [50 136 189]/255;
xlabel('number of spikes above/below the baseline')
ylabel('proportion of neuron-odor responses (%)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(allUnitsDeltaSpikes300, edges300);
edges(end) = [];
h0 = area(edges, N./allUnits);
h0.FaceColor = [255 255 191]/255;
h0.EdgeColor = [255 255 191]/255;
hold on
[N,edges] = histcounts(excDeltaSpikes300ms, edges300);
edges(1) = [];
h1 = area(edges, N./allUnits);
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
hold on
[N,edges] = histcounts(inhDeltaSpikes300ms, edges300);
edges(end) = [];
h2 = area(edges, N./allUnits);
h2.FaceColor = [50 136 189]/255;
h2.EdgeColor = [50 136 189]/255;
xlabel('number of spikes above/below the baseline')
ylabel('proportion of neuron-odor responses')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 300 ms')


%% plot discriminability

edges4 = 0:0.1:1;
edges300 = 0:0.1:1;

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(allAuRocSpikes4, edges4);
edges(end) = [];
h0 = area(edges, N./allUnits);
h0.FaceColor = [255 255 191]/255;
h0.EdgeColor = [255 255 191]/255;
hold on
[N,edges] = histcounts(excAuRoc4cycles, edges4);
edges(1) = [];
h1 = area(edges, N./allUnits);
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
hold on
[N,edges] = histcounts(inhAuRoc4cycles, edges4);
edges(end) = [];
h2 = area(edges, N./allUnits);
h2.FaceColor = [50 136 189]/255;
h2.EdgeColor = [50 136 189]/255;
xlabel('odor discriminability (auROC)')
ylabel('proportion of neuron-odor responses (%)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(allAuRocSpikes300, edges300);
edges(end) = [];
h0 = area(edges, N./allUnits);
h0.FaceColor = [255 255 191]/255;
h0.EdgeColor = [255 255 191]/255;
hold on
[N,edges] = histcounts(excAuRoc300ms, edges300);
edges(1) = [];
h1 = area(edges, N./allUnits);
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
hold on
[N,edges] = histcounts(inhAuRoc300ms, edges300);
edges(end) = [];
h2 = area(edges, N./allUnits);
h2.FaceColor = [50 136 189]/255;
h2.EdgeColor = [50 136 189]/255;
xlabel('odor discriminability (auROC)')
ylabel('proportion of neuron-odor responses')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 300 ms')

%% plot auROC vs p-value
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
h0 = scatter(allAuRocSpikes4, allPValueSpikes4, 'filled');
h0.MarkerFaceColor = [255 255 191]/255;
h0.MarkerEdgeColor = [255 255 191]/255;
hold on
h1 = scatter(excAuRoc4cycles, excPValue4cycles, 'filled');
h1.MarkerFaceColor = [213 62 79]/255;
h1.MarkerEdgeColor = [213 62 79]/255;
hold on
h2 = scatter(inhAuRoc4cycles, inhPValue4cycles, 'filled');
h2.MarkerFaceColor = [50 136 189]/255;
h2.MarkerEdgeColor = [50 136 189]/255;
xlabel('odor discriminability (auROC)')
ylabel('p-value')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
h0 = scatter(allAuRocSpikes300, allPValueSpikes300, 'filled');
h0.MarkerFaceColor = [255 255 191]/255;
h0.MarkerEdgeColor = [255 255 191]/255;
hold on
h1 = scatter(excAuRoc300ms, excPValue300ms, 'filled');
h1.MarkerFaceColor = [213 62 79]/255;
h1.MarkerEdgeColor = [213 62 79]/255;
hold on
h2 = scatter(inhAuRoc300ms, inhPValue300ms, 'filled');
h2.MarkerFaceColor = [50 136 189]/255;
h2.MarkerEdgeColor = [50 136 189]/255;
xlabel('odor discriminability (auROC)')
ylabel('p-value')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 300 ms')

%% plot mean vs variance
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
h0 = scatter(allMeanRsp4, allVarRsp4, 'filled');
h0.MarkerFaceColor = [255 255 191]/255;
h0.MarkerEdgeColor = [255 255 191]/255;
hold on
h1 = scatter(excMeanRsp4cycles, excVarRsp4cycles, 'filled');
h1.MarkerFaceColor = [213 62 79]/255;
h1.MarkerEdgeColor = [213 62 79]/255;
xlabel('mean spike count');
ylabel('variance spike count');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
h0 = scatter(allMeanRsp300, allVarRsp300, 'filled');
h0.MarkerFaceColor = [255 255 191]/255;
h0.MarkerEdgeColor = [255 255 191]/255;
hold on
h1 = scatter(excMeanRsp300ms, excVarRsp300ms, 'filled');
h1.MarkerFaceColor = [213 62 79]/255;
h1.MarkerEdgeColor = [213 62 79]/255;
xlabel('mean spike count');
ylabel('variance spike count');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 300 ms')


%% plot Fano factor
max4 = max(allFanoRsp4);
min4 = min(allFanoRsp4);
max300 = max(allFanoRsp300);
min300 = min(allFanoRsp300);
edges4 = floor(min4):ceil(max4);
edges300 = floor(min300):ceil(max300);
edges4 = 0:0.1:10;
edges300 = 0:0.1:10;

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(allFanoRsp4, edges4);
% edges(end) = [];
% h0 = area(edges, N./allUnits);
% h0.FaceColor = [255 255 191]/255;
% h0.EdgeColor = [255 255 191]/255;
hold on
[N,edges] = histcounts(excFanoRsp4cycles, edges4);
edges(1) = [];
h1 = area(edges, N./allUnits);
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
xlabel('Fano factor');
ylabel('proportion of neuron-odor responses')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(allFanoRsp300, edges300);
% edges(end) = [];
% h0 = area(edges, N./allUnits);
% h0.FaceColor = [255 255 191]/255;
% h0.EdgeColor = [255 255 191]/255;
hold on
[N,edges] = histcounts(excFanoRsp300ms, edges300);
edges(1) = [];
h1 = area(edges, N./allUnits);
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
xlabel('Fano factor');
ylabel('proportion of neuron-odor responses')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('first 300 ms')

%%
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
violin(peakLat, 'facecolor', [213 62 79]/255,  'edgecolor', 'none', 'facealpha', 0.5);
set(gca,'XColor','w')
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('peak latency - first 300 ms')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
violin(hWidth, 'facecolor', [213 62 79]/255,  'edgecolor', 'none', 'facealpha', 0.5);
set(gca,'XColor','w')
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('half width response - first 300 ms')


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
markerSizes = linspace(min(hWidth),max(hWidth), length(hWidth)) ./ 10;
markerColor =  [213 62 79]/255;
markerColor = repmat(markerColor, length(hWidth), 1);
A = [excMeanRsp300ms peakLat hWidth];
A = sortrows(A,size(A,2));
h1 = scatter(A(:,1), A(:,2), markerSizes, markerColor, 'filled');
% h1.MarkerFaceColor = [213 62 79]/255;
% h1.MarkerEdgeColor = [213 62 79]/255;
xlabel('mean spike count');
ylabel('peak latency');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('spike count vs peak latency vs half width response - first 300 ms')





