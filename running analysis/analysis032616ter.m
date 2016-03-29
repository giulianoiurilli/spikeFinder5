


idxExp = 5;
idxShank = 1;
idxUnit = 5;
color = pcxC;


figure
set(gcf,'Position',[118 454 1767 519]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
patchY = [0 0.006 0.006 0];
patchX = [-0.1 -0.1 2 2];
t = -15:0.001:15;
t(end-1:end) = [];
idxO = 0;
mark = {'-', '--', ':'};
hold on
    p1 = patch(patchX, patchY, [191,211,230]/255);
    set(p1, 'EdgeColor', 'none');
for idxOdor = [1 11 12]
    idxO = idxO + 1;
    spikes = zeros(10,30000);
    for idxTrial = 1:10
        spikes(idxTrial,:) = pcxAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
    end
    x = spikeDensity(mean(spikes), 0.1);


    %hold on
    plot(t,x, 'linewidth', 2, 'color', color, 'linestyle', '-')
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
end

for idxOdor = [5 13 14]
    idxO = idxO + 1;
    spikes = zeros(10,30000);
    for idxTrial = 1:10
        spikes(idxTrial,:) = pcxAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
    end
    x = spikeDensity(mean(spikes), 0.1);


    %hold on
    plot(t,x, 'linewidth', 2, 'color', color, 'linestyle', ':')
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
end
xlim([-2 5])

    
    
    
    
