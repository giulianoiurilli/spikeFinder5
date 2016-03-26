function plotResponses(espe, esp, idxExp, idxShank, idxUnit, color)


% idxExp = 1
% idxShank = 3
% idxUnit = 3

figure
set(gcf,'Position',[118 454 1767 519]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
patchY = [0 10 10 0];
patchX = [0 0 2 2];
for idxOdor = 1:15
    for idxTrial = 1:10
        app = [];
        app = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
        app1=[];
        app1 = find(app==1);
        app1 = (app1./1000) - 15;
        responses.spikes{idxTrial} = app1;
    end
    A300ms(:, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
    A1s(:, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
    subplot(3, 5, idxOdor)
    p1 = patch(patchX, patchY, [191,211,230]/255);
    set(p1, 'EdgeColor', 'none');
    hold on
    LineFormat.Color =  color;
    plotSpikeRaster(responses.spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 7], 'LineFormat', LineFormat);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
    auROC1(idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
    auROC300(idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
end
%auROC1(pValue1==0) = 0.05;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
subplot(2,1,1)
bar(auROC300)
xlabel('odor ID')
ylabel('auROC - first sniff')
subplot(2,1,2)
bar(auROC1)
xlabel('odor ID')
ylabel('auROC - first second')

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
subplot(2,2,1)
bar(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms)
ylim([0 1]);
grid on
ylabel('Lifetime Sparseness - first sniff')
subplot(2,2,2)
bar(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s)
ylabel('Lifetime Sparseness - first second')
ylim([0 1]);
grid on

subplot(2,2,3)
bar(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms)
ylim([0 1]);
grid on
ylabel('Stimulus Predictability (bits) - first sniff')
subplot(2,2,4)
bar(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s)
ylabel('Stimulus Predictability (bits) - first second')
ylim([0 1]);
grid on