idxExp = 1
idxShank = 3
idxUnit = 3

figure
set(gcf,'Position',[118 454 1767 519]);
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
    subplot(3, 5, idxOdor)
    p1 = patch(patchX, patchY, [191,211,230]/255);
    set(p1, 'EdgeColor', 'none');
    hold on
    LineFormat.Color =  'k';
    plotSpikeRaster(responses.spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 7], 'LineFormat', LineFormat);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
    auROC1(idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
    pValue1(idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
end
%auROC1(pValue1==0) = 0.05;
figure
bar(auROC1)