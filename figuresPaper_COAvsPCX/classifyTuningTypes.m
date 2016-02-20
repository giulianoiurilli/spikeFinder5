
auROCsort = [auROCsortCoa];
%auROCsort = [auROCsortPcx];
options = statset('MaxIter',1000); 
c = 1;
clusterX = [];
gmfit = [];
for k = 2:15
    gmfit{k} = fitgmdist(auROCsort,k,'CovarianceType','diagonal',...
        'SharedCovariance',false,'Options',options, 'Regularize', 1e-10);
    clusterX{k} = cluster(gmfit{k},auROCsort);
    aic(k) = gmfit{k}.AIC;
    bic(k) = gmfit{k}.BIC;
%     mahalDist = mahal(gmfit{k},X0);
%     subplot(2,2,c);
%     h1 = gscatter(scores(:,1),scores(:,2),clusterX);
%     hold on;
%     for m = 1:k;
%         idx = mahalDist(:,m)<=threshold;
%         Color = h1(m).Color*0.75 + -0.5*(h1(m).Color - 1);
%         h2 = plot(X0(idx,1),X0(idx,2),'.','Color',Color,'MarkerSize',1);
%         uistack(h2,'bottom');
%     end
%     plot(gmfit{k}.mu(:,1),gmfit{k}.mu(:,2),'kx','LineWidth',2,'MarkerSize',10)
%     hold off
%     c = c + 1;
end
%%
figure; bar(bic); title('BIC')
figure; bar(aic); title('AIC')
[M,I] = min([bic]);


%%
figure;
set(gcf,'Position',[322 822 1435 145]);
j = 7;
for idxClust = 1:j
    subplot(1,j, idxClust)
    app = find(clusterX{j}==idxClust);
%     appCoa = app(app<=size(auROCsortCoa,1));
%     appPcx = app(app<=size(auROCsortCoa,1));
    for idxMember = 1:length(app)
        plot(auROCsort(app(idxMember),:), '-','Color', [0.8 0.8 0.8]);
        hold on
    end
    plot(mean(auROCsort(app,:)), '-','Color', 'r');
    line([1 15], [0.5 0.5], 'LineStyle',':', 'Color', [0.7 0.7 0.7])
    line([1 15], [0.25 0.25], 'LineStyle',':')
    line([1 15], [0.75 0.75], 'LineStyle',':')
    xlim([1, 15]);
    ylim([0 1]);
end
suptitle('PC')



