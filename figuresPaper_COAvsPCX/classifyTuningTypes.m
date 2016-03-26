% [actOdorCoa15, aurocs1000msSortedCoa15, aurocs300msSortedCoa15, cellLogCoa15, i1sCoa15, l1sCoa15] = proportionActivatingOdors(coa15.esp, odors);
% [actOdorCoaAA, aurocs1000msSortedCoaAA, aurocs300msSortedCoaAA, cellLogCoaAA, i1sCoaAA, l1sCoaAA] = proportionActivatingOdors(coaAA.esp, odors);
% [actOdorPcx15, aurocs1000msSortedPcx15, aurocs300msSortedPcx15, cellLogPcx15, i1sPcx15, l1sPcx15] = proportionActivatingOdors(pcx15.esp, odors);
% [actOdorPcxAA, aurocs1000msSortedPcxAA, aurocs300msSortedPcxAA, cellLogPcxAA, i1sPcxAA, l1sPcxAA] = proportionActivatingOdors(pcxAA.esp, odors);
% 
% %%
% auROCsort = [aurocs1000msSortedCoa15; aurocs1000msSortedCoaAA; aurocs1000msSortedPcx15; aurocs1000msSortedPcxAA];
i1s = [ i1sCoa15, i1sCoaAA, i1sPcx15, i1sPcxAA]';
l1s = [ l1sCoa15, l1sCoaAA, l1sPcx15, l1sPcxAA]';
% cellLog = [cellLogCoa15; cellLogCoaAA; cellLogPcx15; cellLogPcxAA];
% sizeCoa = size(cellLogCoa15,1) + size(cellLogCoaAA,1);
% C = ones(size(auROCsort,1),4);
% C(sizeCoa+1:end,1) = 2;
% C(:,2:4) = cellLog;
% 
% %auROCsort = [aurocs1000msSortedPcx15];
% options = statset('MaxIter',1000); 
% c = 1;
% clusterX = [];
% gmfit = [];
% for k = 2:15
%     gmfit{k} = fitgmdist(auROCsort,k,'CovarianceType','diagonal',...
%         'SharedCovariance',false,'Options',options, 'Regularize', 1e-10);
%     clusterX{k} = cluster(gmfit{k},auROCsort);
%     aic(k) = gmfit{k}.AIC;
%     bic(k) = gmfit{k}.BIC;
% %     mahalDist = mahal(gmfit{k},X0);
% %     subplot(2,2,c);
% %     h1 = gscatter(scores(:,1),scores(:,2),clusterX);
% %     hold on;
% %     for m = 1:k;
% %         idx = mahalDist(:,m)<=threshold;
% %         Color = h1(m).Color*0.75 + -0.5*(h1(m).Color - 1);
% %         h2 = plot(X0(idx,1),X0(idx,2),'.','Color',Color,'MarkerSize',1);
% %         uistack(h2,'bottom');
% %     end
% %     plot(gmfit{k}.mu(:,1),gmfit{k}.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
% %     hold off
% %     c = c + 1;
% end
% %%
% figure; bar(bic); title('BIC')
% figure; bar(aic); title('AIC')
% [M,I] = min([bic]);


%%
figure;
set(gcf,'Position',[385 203 1103 814]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
j = 5;
idxPlot = 0;
for idxClust = [2 4 1 3 5]
    idxPlot = idxPlot + 1;
    subplot(j,2, idxPlot)
    app = find(clusterX{j}==idxClust);
    A = auROCsort(app,:);
    I = i1s(app,:);
    L = l1s(app,:);
    area = C(app,1);
    appCoa = A(area==1, :);
    appIcoa = I(area==1, :);
    appLcoa = L(area==1, :);
    meanI = nanmean(appIcoa);
    meanL = nanmedian(appLcoa);
    for idxMember = 1:length(appCoa)
        plot(appCoa(idxMember,:), '-','Color', [0.8 0.8 0.8]);
        hold on
    end
    prop = sprintf('%.1f %%', size(appCoa,1) ./ sizeCoa * 100);
    labelY = sprintf('l.s.: %.1f - i: %.1f', meanL, meanI);
    plot(mean(appCoa), '-','Color', coaC, 'linewidth', 4);
    ylabel(labelY);
    title(prop)
    line([1 15], [0.5 0.5], 'LineStyle',':', 'Color', [215,48,39]/255)
    line([1 15], [0.25 0.25], 'LineStyle',':', 'Color', [26,152,80]/255)
    line([1 15], [0.75 0.75], 'LineStyle',':', 'Color', [26,152,80]/255)
    xlim([0.5, 15.5]);
    ylim([0 1]);
    set(gca, 'TickDir', 'out')
    box off
    idxPlot = idxPlot + 1;
    subplot(j,2, idxPlot)
    appPcx = A(area==2, :);
    appIpcx = I(area==2, :);
    appLpcx = L(area==1, :);
    meanI = nanmean(appIpcx);
    meanL = nanmedian(appLpcx);
    for idxMember = 1:length(appPcx)
        plot(appPcx(idxMember,:), '-','Color', [0.8 0.8 0.8]);
        hold on
    end
    prop = sprintf('%.1f %%', size(appPcx,1) ./ (size(auROCsort,1) - sizeCoa) * 100);
    labelY = sprintf('l.s.: %.1f - i: %.1f', meanL, meanI);
    ylabel(labelY);
    title(prop)
    plot(mean(appPcx), '-','Color', pcxC, 'linewidth', 4);
    line([1 15], [0.5 0.5], 'LineStyle',':', 'Color', [215,48,39]/255)
    line([1 15], [0.25 0.25], 'LineStyle',':', 'Color', [26,152,80]/255)
    line([1 15], [0.75 0.75], 'LineStyle',':', 'Color', [26,152,80]/255)
    xlim([0.5, 15.5]);
    ylim([0 1]);
    set(gca, 'TickDir', 'out')
    box off
end




