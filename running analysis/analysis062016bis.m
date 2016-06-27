figure;
plot([2 6 10], [mean(accuracyResponses2Coa15(:)) mean(accuracyResponses2CoaAAValence(:)) mean(accuracyResponses2CoaAAMixValence(:))], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([3 7 11], [mean(accuracyResponses2Pcx15(:)) mean(accuracyResponses2PcxAAValence(:)) mean(accuracyResponses2PcxAAMixValence(:))], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([2 6 10], [mean(accuracyResponses2Coa15(:)) mean(accuracyResponses2CoaAAValence(:)) mean(accuracyResponses2CoaAAMixValence(:))],...
    [std(accuracyResponses2Coa15(:))./sqrt(length(accuracyResponses2Coa15(:)))...
    std(accuracyResponses2CoaAAValence)./sqrt(length(accuracyResponses2CoaAAValence(:)))...
    std(accuracyResponses2CoaAAMixValence(:))./sqrt(length(accuracyResponses2CoaAAMixValence(:)))], 'r', 'linewidth', 2); %
hold on
errbar([3 7 11], [mean(accuracyResponses2Pcx15(:)) mean(accuracyResponses2PcxAAValence(:)) mean(accuracyResponses2PcxAAMixValence(:))],...
    [std(accuracyResponses2Pcx15(:))./sqrt(length(accuracyResponses2Pcx15(:)))...
    std(accuracyResponses2PcxAAValence)./sqrt(length(accuracyResponses2PcxAAValence(:)))...
    std(accuracyResponses2PcxAAMixValence(:))./sqrt(length(accuracyResponses2PcxAAMixValence(:)))], 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
xlim([0 13])
ylim([50 100]);

%%
figure;
plot([2], [mean(accuracyResponses2Coa15(:))], 'ro', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([4], [mean(accuracyResponses2Pcx15(:))], 'ko', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar(2, mean(accuracyResponses2Coa15(:)), std(accuracyResponses2Coa15(:))./sqrt(length(accuracyResponses2Coa15(:))), 'r', 'linewidth', 2); %
hold on
errbar(4, mean(accuracyResponses2Pcx15(:)), std(accuracyResponses2Pcx15(:))./sqrt(length(accuracyResponses2Pcx15(:))), 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
plot(0:6, 100*ones(1,7)*1/5, 'k:')

for k = 1:150
    hold on
    plot([2.5], CoaNoDecorr15_sim(k), 'ro', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', 'w')
    hold on
    plot([4.5], PcxNoDecorr15_sim(k), 'ro', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', 'w')
end
xlim([1 6])
ylim([0 100]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
set(gca, 'XColor', 'w', 'box','off')
title('15 odors')

%%
figure;
plot([2], [mean(accuracyResponses2CoaAAValence(:))], 'ro', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([4], [mean(accuracyResponses2PcxAAValence(:))], 'ko', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar(2, mean(accuracyResponses2CoaAAValence(:)), std(accuracyResponses2CoaAAValence(:))./sqrt(length(accuracyResponses2CoaAAValence(:))), 'r', 'linewidth', 2); %
hold on
errbar(4, mean(accuracyResponses2PcxAAValence(:)), std(accuracyResponses2PcxAAValence(:))./sqrt(length(accuracyResponses2PcxAAValence(:))), 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
plot(0:6, 100*ones(1,7)*1/2, 'k:')

for k = 1:numel(aa2CoaNoDecorr)
    hold on
    plot([2.5], aa2CoaNoDecorr(k), 'ro', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', 'w')
    hold on
    plot([4.5], aa2PcxNoDecorr(k), 'ro', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', 'w')
end
xlim([1 6])
ylim([0 100]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
set(gca, 'XColor', 'w', 'box','off')
title('Innate valence')

%%
figure;
plot([2], [mean(accuracyResponses2CoaAAMixValence(:))], 'ro', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([4], [mean(accuracyResponses2PcxAAMixValence(:))], 'ko', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar(2, mean(accuracyResponses2CoaAAMixValence(:)), std(accuracyResponses2CoaAAMixValence(:))./sqrt(length(accuracyResponses2CoaAAMixValence(:))), 'r', 'linewidth', 2); %
hold on
errbar(4, mean(accuracyResponses2PcxAAMixValence(:)), std(accuracyResponses2PcxAAMixValence(:))./sqrt(length(accuracyResponses2PcxAAMixValence(:))), 'k', 'linewidth', 2); %./sqrt(length(accuracyResponsesPcxAA(:)))
plot(0:6, 100*ones(1,7)*1/2, 'k:')

xlim([0 6])
ylim([0 100]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
set(gca, 'XColor', 'w', 'box','off')
title('Mix - Innate valence')