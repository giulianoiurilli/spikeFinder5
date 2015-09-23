odorsRearranged = [1 8 2 9 3 10 4 11 5 12 6 13 7 14 15];

Xfig = 900;
Yfig = 800;
figure;
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')

idxPlot = 1;
for idxOdor = 1:odors
    bigMuaApp = zeros(4,3000);
    for idxShank = 1:4
        bigMuaApp(idxShank,:) = mean(shankMua(idxShank).odor(idxOdor).sdf_trialMua(:,14000:17000-1),1);
    end
    bigMuaApp = mean(bigMuaApp);
    subplot(8,2,idxPlot)
    xAxis = 1:length(bigMuaApp);
    xticks = [1 980 2000 3000];
    xlab = {'-1', '0', '1', '2'};
    area(bigMuaApp, 'FaceColor',[153,216,201]/255)
    line([980 980], [0 max(bigMuaApp)], 'Color', [136,86,167]/255);
    set(gca, 'XTick', xticks);
    set(gca, 'XTickLabel', xlab);
    set(gca,'YColor','w')
    xlabel('sec')
    axis tight
    set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
    idxPlot =idxPlot + 1;
end
