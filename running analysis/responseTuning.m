responsiveUnit4cycles = 0;
responsiveUnit300ms = 0;
cells = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            cells = cells + 1;
            responsivenessExc4cycles = zeros(1,odors);
            responsivenessInh4cycles = zeros(1,odors);
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            for idxOdor = 1:odors
                responsivenessExc4cycles(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh4cycles(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                responsivenessExc300ms = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessInh300ms = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
            end
            if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0
                responsiveUnit4cycles = responsiveUnit4cycles + 1;
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                responsiveUnit300ms = responsiveUnit300ms + 1;
            end
        end
    end
end

%%
Icell300ms = zeros(responsiveUnit300ms,1);
Icell4Cycles = zeros(responsiveUnit4cycles,1);
excP300ms = zeros(cells,1);
inhP300ms = zeros(cells,1);
rspP300ms = zeros(cells,1);
excP4Cycles = zeros(cells,1);
inhP4Cycles = zeros(cells,1);
rspP4Cycles = zeros(cells,1);
idxCell4Cycles = 0;
idxCell300ms = 0;
idxCell = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            idxCell = idxCell + 1;
            responsivenessExc4cycles = zeros(1,odors);
            responsivenessInh4cycles = zeros(1,odors);
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            for idxOdor = 1:odors
                responsivenessExc4cycles(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh4cycles(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                responsivenessExc300ms(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessInh300ms (idxOdor)= exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
            end
            if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0
                idxCell4Cycles = idxCell4Cycles + 1;
                Icell4Cycles(idxCell4Cycles) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).I4Cycles;
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                idxCell300ms = idxCell300ms + 1;
                Icell300ms(idxCell300ms) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms;
            end
            excP4Cycles(idxCell) = sum(responsivenessExc4cycles)./odors;
            inhP4Cycles(idxCell) = sum(responsivenessInh4cycles)./odors;
            rspP4Cycles(idxCell) = sum(responsivenessExc4cycles + responsivenessInh4cycles)./odors;
            excP300ms(idxCell) = sum(responsivenessExc300ms)./odors;
            inhP300ms(idxCell) = sum(responsivenessInh300ms)./odors;
            rspP300ms(idxCell) = sum(responsivenessExc300ms + responsivenessInh300ms)./odors;
        end
    end
end

%%
Icell300msGood = Icell300ms(Icell300ms == real(Icell300ms));
Icell4CyclesGood = Icell4Cycles(Icell4Cycles == real(Icell4Cycles));
max4 = max(Icell4CyclesGood);
min4 = min(Icell4CyclesGood);
max300 = max(Icell300msGood);
min300 = min(Icell300msGood);
edges4 = floor(min4):0.01:ceil(max4);
edges300 = floor(min300):0.01:ceil(max300);


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(Icell4CyclesGood, edges4);
edges(1) = [];
h1 = area(edges, N./length(Icell4CyclesGood));
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('information - first 4 cycles')


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(Icell300msGood, edges300);
edges(1) = [];
h1 = area(edges, N./length(Icell300msGood));
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('information - first 300 ms')

%%
max4 = max(excP4Cycles);
min4 = min(excP4Cycles);
max300 = max(excP300ms);
min300 = min(excP300ms);
edges4 = -0.05:0.1:1.05;
edges300 = -0.05:0.1:1.05;


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(excP4Cycles, edges4);
% edges(end) = [];
% h1 = area(edges, N./length(excP4Cycles));
h1 = histogram(excP4Cycles,edges4, 'normalization', 'probability');
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('excitatory probability - first 4 cycles')


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(excP300ms, edges300);
% edges(end) = [];
% h1 = area(edges, N./length(excP300ms));
h1 = histogram(excP300ms,edges300, 'normalization', 'probability');
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('excitatory probability - first 300 ms')

%%
max4 = max(inhP4Cycles);
min4 = min(inhP4Cycles);
max300 = max(inhP300ms);
min300 = min(inhP300ms);
edges4 = -0.05:0.1:1.05;
edges300 = -0.05:0.1:1.05;


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(inhP4Cycles, edges4);
% edges(1) = [];
% h1 = area(edges, N./length(inhP4Cycles));
h1 = histogram(inhP4Cycles,edges4, 'normalization', 'probability');
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('inhibitory probability  - first 4 cycles')


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(inhP300ms, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(inhP300ms));
h1 = histogram(inhP300ms,edges300, 'normalization', 'probability');
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('inhibitory probability  - first 300 ms')

%%
max4 = max(rspP4Cycles);
min4 = min(rspP4Cycles);
max300 = max(rspP300ms);
min300 = min(rspP300ms);
edges4 = -0.05:0.1:1.05;
edges300 = -0.05:0.1:1.05;


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(rspP4Cycles, edges4);
% edges(1) = [];
% h1 = area(edges, N./length(rspP4Cycles));
h1 = histogram(rspP4Cycles,edges4, 'normalization', 'probability');
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('response probability  - first 4 cycles')


figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
% [N,edges] = histcounts(rspP300ms, edges300);
% edges(1) = [];
% h1 = area(edges, N./length(rspP300ms));
h1 = histogram(rspP300ms,edges300, 'normalization', 'probability');
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('response probability  - first 300 ms')

%%
save('responseTuning.mat', 'Icell300ms', 'Icell4Cycles', 'excP4Cycles', 'inhP4Cycles', 'excP300ms', 'inhP300ms', 'rspP4Cycles', 'rspP300ms');
