
function plotResponses_in(esp, espe, idxExp, idxShank, idxUnit, color)

%colorS = [228,26,28]./255;
figure
set(gcf,'Position',[56 51 176 1006]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
% patchY = [0 0.01 0.01 0];
% patchX = [0 0 2 2];
t = -15:0.001:15;
t(end-1:end) = [];
x = nan(15,length(t));
mass = nan(1,15);
mini = nan(1,15);
info = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;

for idxOdor = 1:15
    spikes = zeros(10,30000);
    for idxTrial = 1:10
        spikes(idxTrial,:) = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
    end
    x(idxOdor,:) = spikeDensity(mean(spikes), 0.1);
    mass(idxOdor) = max(x(idxOdor,15000:20000));
    mini(idxOdor) = min(x(idxOdor,:));
    aurox(idxOdor)  = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC2000ms;
end

minimo = min(mini);
massimo = max(mass);

for idxOdor = 1:15
    subplot(15, 1, idxOdor)
    plot(t,x(idxOdor,:) .* 1000, 'linewidth', 1, 'color', color)
    if idxOdor<15
        set(gca, 'XTick' , []);
        set(gca, 'XTickLabel', []);
        set(gca,'XColor','w')
    end
    line([0 0], [-5 massimo*1000], 'linewidth', 1, 'color', [89 89 89]/255, 'LineStyle', ':');
    line([2 2], [-5 massimo*1000], 'linewidth', 1, 'color', [89 89 89]/255, 'LineStyle', ':');
    titolo = sprintf('auROC: %0.2f', aurox(idxOdor));
    set(gca,  'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 12, 'box', 'off')
    tit = title(titolo);
    tit.FontSize = 10;
    tit.FontWeight = 'normal';
    xlim([-5 10]);
    ylim([-5, massimo*1000]);
end
informazione = sprintf('Odor Predictability: %0.2f', info);
suptitle(informazione)

end