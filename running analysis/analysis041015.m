x = auRoccoaAA;
x(x<0.5) = NaN;
x(significancecoaAA==0) = NaN;
for j = 1:15
    app = [];
    app = x(:,j);
    app(isnan(app)) = [];
    notnanX(j) = numel(app);
end
meanX = nanmean(x(:,1:10));
semX = nanstd(x(:,1:10)) ./ sqrt(notnanX(1:10) - ones(1,10));

y = auRocpcxAA;
y(y<0.5) = NaN;
y(significancepcxAA==0) = NaN;
for j = 1:15
    app = [];
    app = y(:,j);
    app(isnan(app)) = [];
    notnanY(j) = numel(app);
end
meanY = nanmean(y(:,1:10));
semY = nanstd(y(:,1:10)) ./ sqrt(notnanY(1:10) - ones(1,10));

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot([1:5], meanX(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC)
hold on
errbar([1:5], meanX(1:5), semX(1:5), 'color', coaC, 'linewidth', 2);
hold on
plot([1:5] + 0.2, meanY(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
hold on
errbar([1:5] + 0.2, meanY(1:5), semY(1:5), 'color', pcxC, 'linewidth', 2);

plot([6:10], meanX(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([6:10] + 0.2, meanY(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([6:10], meanX(6:10), semX(6:10), 'color', coaC, 'linewidth', 2);
hold on
errbar([6:10] + 0.2, meanY(6:10), semY(6:10), 'color', pcxC, 'linewidth', 2);
xlim([0 11])
ylim([0 3])
set(gca,'box','off')
set(gca,'TickDir', 'out')
xlabel('Odor ID')
ylabel('auROC - 1000 ms')


cc1 = [255 255 255; 227,26,28] ./ 255;
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
meanX = reshape(meanX(1:10),5,2);
semX = reshape(semX(1:10),5,2);
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
meanY = reshape(meanY(1:10),5,2);
semY = reshape(semY(1:10),5,2);
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
    