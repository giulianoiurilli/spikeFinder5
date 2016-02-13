coaScT = [corrSameCoa'];
pcxScT = [corrSamePcx'];
allScT = [coaScT pcxScT];
groupingV = ones(1,length(allScT(:)));
groupingV(length(coaScT + 1) : end) = 2;

boxplot(allScT, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5, 'datalim', [-0.2 0.4]);
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
%xlim([-0.005 0.15]);
set(gca, 'XColor', 'w', 'box','off')

figure;
coaScT = [corrAcrossCoa'];
pcxScT = [corrAcrossPcx'];
allScT = [coaScT pcxScT];
groupingV = ones(1,length(allScT(:)));
groupingV(length(coaScT + 1) : end) = 2;

boxplot(allScT, groupingV, 'plotstyle', 'traditional', 'boxstyle', 'outline', 'colors', 'rk', 'notch', 'on', 'orientation', 'vertical', 'symbol', '', 'widths', 0.5);
h = findobj(gca,'Tag','Box');
colorToUse = {'k', 'r'};
for j=1:length(h)
    patch(get(h(j),'XData'),get(h(j),'YData'),colorToUse{j},'FaceAlpha',.7);
end
%xlim([-0.005 0.15]);
set(gca, 'XColor', 'w', 'box','off')