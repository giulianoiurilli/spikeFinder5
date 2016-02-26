% rep = 100;
% odorsRearranged1 = nan*ones(rep,8);
% h = nan*ones(rep,2);
% p = nan*ones(rep,4);
% for idxRep = 1:rep
%     idxOd = randperm(15,8);
%     od = 1:15;
%     odorsRearranged1(idxRep,:) = od(idxOd);
%     [accuracyResponsesPcxAAaa, accuracyBaselinePcxAAaa] = l_svmClassify(pcx.esp, odorsRearranged1(idxRep,:));
%     % odorsRearranged = [8 11 12 5 2 14 4 10];
% %     [accuracyResponsesCoaAAaa, accuracyBaselineCoaAAaa] = l_svmClassify(coa.esp, odorsRearranged1(idxRep,:));
%     
%     [h(idxRep,2), p(idxRep,2), ci, stats] = ttest2(accuracyResponsesCoaAAaa(:), accuracyResponsesPcxAAaa(:));
%     [h(idxRep,1), p(idxRep,1), ci, stats] = ttest2(accuracyBaselineCoaAAaa(:), accuracyBaselinePcxAAaa(:));
%     p(idxRep,3) = mean(accuracyBaselineCoaAAaa(:)) - mean(accuracyBaselinePcxAAaa(:));
%     p(idxRep,4) = mean(accuracyResponsesCoaAAaa(:)) - mean(accuracyResponsesPcxAAaa(:));
% end

%odorsRearranged = [3 8 10 1 13 11 9 14]; %pcx1
odorsRearranged = [2 12 13 1 8 3 15 5]; %pcx2
[accuracyResponsesPcxAAaa, accuracyBaselinePcxAAaa, accuracyShuffledPcxAAaa] = l_svmClassify(pcx.esp, odorsRearranged);
% odorsRearranged = 1:15;
% [accuracyResponsesPcxAAaa, accuracyBaselinePcxAAaa] = l_svmClassify(pcx15.esp, odorsRearranged);
% % 
odorsRearranged = [8 11 12 5 2 14 4 10]; %coa1
[accuracyResponsesCoaAAaa, accuracyBaselineCoaAAaa, accuracyShuffledCoaAAaa] = l_svmClassify(coa.esp, odorsRearranged);
% odorsRearranged = 1:15;
% [accuracyResponsesCoaAAaa, accuracyBaselineCoaAAaa] = l_svmClassify(coa15.esp, odorsRearranged);
% % % 
% [accuracyResponsesPcxAAaa, accuracyBaselinePcxAAaa] = l_svmClassify(pcx.esp, odorsRearranged1(81,:));
[hh, pp] = ttest2(accuracyResponsesCoaAAaa(:), accuracyResponsesPcxAAaa(:))
% % %[accuracyResponsesCoaAAaa, accuracyBaselineCoaAAaa] = l_svmClassify(coa.esp, odorsRearranged1(100,:));
figure
plot([2 6], [mean(accuracyBaselineCoaAAaa(:)) mean(accuracyResponsesCoaAAaa(:))], 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([3 7], [mean(accuracyBaselinePcxAAaa(:)) mean(accuracyResponsesPcxAAaa(:))], 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([2 6], [mean(accuracyBaselineCoaAAaa(:)) mean(accuracyResponsesCoaAAaa(:))], [std(accuracyBaselineCoaAAaa(:))./sqrt(length(accuracyResponsesCoaAAaa(:))) std(accuracyResponsesCoaAAaa(:))./sqrt(length(accuracyResponsesCoaAAaa(:)))], 'r', 'linewidth', 2); 
hold on
errbar([3 7], [mean(accuracyBaselinePcxAAaa(:)) mean(accuracyResponsesPcxAAaa(:))], [std(accuracyBaselinePcxAAaa(:))./sqrt(length(accuracyResponsesPcxAAaa(:))) std(accuracyResponsesPcxAAaa(:))./sqrt(length(accuracyResponsesPcxAAaa(:)))], 'k', 'linewidth', 2); 
xlim([0 9])
ylim([40 100]);
line([0 9], [50 50], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
%line([0 9], [1/8*100 1/8*100], 'LineStyle', ':', 'linewidth', 1, 'Color', 'k')
set(gca, 'XColor', 'w', 'box','off')

