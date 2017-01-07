function my_ttest2_boxplot(group1, group2, color, labels)

%boxplot([group1,group2], labels)
hold on
for ii=1:length(group1)
  plot([4,5],[group1(ii),group2(ii)],'-ok',...
       'MarkerFaceColor', color, 'MarkerSize', 10, 'color', color)
end
xlim([2 7])
set(gca, 'xTick', [4 5]);
set(gca, 'XTickLabel', labels) ;
hold off