cells = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            cells = cells + 1;
        end
    end
end

%%
responses300ms = zeros(cells, odors);
responses4Cycles = zeros(cells, odors);
idxCell = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            idxCell = idxCell + 1;
            for idxOdor = 1:odors
                if exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1
                    responses4Cycles(idxCell, idxOdor) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse) - ...
                    mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl);
                else
                    responses4Cycles(idxCell, idxOdor) = 0;
                end
                if exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1
                    responses300ms(idxCell, idxOdor) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                    mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                else
                    responses300ms(idxCell, idxOdor) = 0;
                end
            end
        end
    end
end

%%
%responses300ms = responses300ms'; responses300ms = zscore(responses300ms); responses300ms = responses300ms';
%responses4Cycles = responses4Cycles'; responses4Cycles = zscore(responses4Cycles); responses4Cycles = responses4Cycles';
ps300ms = population_sparseness(responses300ms, size(responses300ms,1), size(responses300ms,2));
ls300ms = lifetime_sparseness(responses300ms, size(responses300ms,1), size(responses300ms,2));
ps4Cycles = population_sparseness(responses4Cycles, size(responses4Cycles,1), size(responses4Cycles,2));
ls4Cycles = lifetime_sparseness(responses4Cycles, size(responses4Cycles,1), size(responses4Cycles,2));

%%
edges4 = -0.05:0.1:1.05;
edges300 = -0.05:0.1:1.05;

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(ps4Cycles, edges4);
edges(1) = [];
h1 = area(edges, N./length(ps4Cycles));
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('population sparseness  - first 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(ls4Cycles, edges4);
edges(1) = [];
h1 = area(edges, N./length(ls4Cycles));
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(ps300ms, edges4);
edges(1) = [];
h1 = area(edges, N./length(ps300ms));
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('population sparseness  - first 300 ms')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
[N,edges] = histcounts(ls300ms, edges4);
edges(1) = [];
h1 = area(edges, N./length(ls300ms));
h1.FaceColor = [213 62 79]/255;
h1.EdgeColor = [213 62 79]/255;
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
title('lifetime sparseness  - first 300 ms')


%%
save('sparseness.mat', 'ls4Cycles', 'ps4Cycles', 'ls300ms', 'ps300ms');