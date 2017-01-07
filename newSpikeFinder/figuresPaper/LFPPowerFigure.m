coaC = [228,26,28] ./ 255;
pcxC = [55,126,184]./255;
%%
figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
errorbar(1:5, fliplr(mean(betaR1(:,11:15))), fliplr(std(betaR1(:,11:15))./sqrt(12)), '-o', 'LineWidth', 1, 'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 8, 'color', coaC)
set(gca, 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14, 'box', 'off')
ylabel('Fractional Power Change in the Beta Band')
xlabel('Concentration.')
ylim([-0.2 1])

%%
betaPcx = [betaPcx15; betaPcxAA; betaPcxNM];
betaCoa = [betaCoa15; betaCoaAA; betaCoaNM];
figure
set(gcf,'Position',[207 388 722 344]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr([std(betaCoa)./sqrt(length(betaCoa)-1) std(betaPcx)./sqrt(length(betaPcx)-1)], [mean(betaCoa) mean(betaPcx)])
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
ttest2(betaPcx, betaCoa)