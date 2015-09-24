%% MUA responses (low threshold spike detection, no breathing warping)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

popResp = zeros(odors,29999);

for idxOdor = 1:odors
    for idxExperiment = 1 : length(List)
        for idxShank = 1:4
            popResp(idxOdor,:) = popResp(idxOdor,:) + mean(muaExp(idxExperiment).shank(idxShank).odor(idxOdor).sdf_trialMua);
        end
    end
end

odorsRearranged = [1 8 2 9 3 10 4 11 5 12 6 13 7 14 15];

Xfig = 900;
Yfig = 800;
figure;
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')
idxPlot = 1;
for idxOdor = odorsRearranged
    subplot(8,2,idxPlot)
    xAxis = 1:size(popResp,2);
    xticks = [1 1000 2000 3000];
    xlab = {'-1', '0', '1', '2'};
    area(popResp(idxOdor,14000:17000), 'FaceColor',[250,159,181]/255)
    line([1000 1000], [0 max(popResp(:))], 'Color', [222,45,38]/255);
    set(gca, 'XTick', xticks);
    set(gca, 'XTickLabel', xlab);
    set(gca,'YColor','w')
    xlabel('sec')
    axis tight
    set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
    idxPlot =idxPlot + 1;
end
suptitle('MUA responses (low threshold spike detection, no breathing warping)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');