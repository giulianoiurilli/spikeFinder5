function [distOdors, distOdorsDecorr] = findOdorDistances(esp, odors)

odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = [];
                    app = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms; %- ...
                    %esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    baselineCell1All(idxCell1,:,idxO) = app2;
                end
            end
        end
    end
end


%% Odor distances - Means - MDS - hierarchical clustering
X = [];
responseCell1Mean = responseCell1Mean';
responseCell1Mean = zscore(responseCell1Mean);

nRep = 1000;
D = zeros(nRep, odors*(odors-1)/2);
DS = D;
for idxRep = 1:nRep
    idxCell = randsample(size(responseCell1Mean,2), 100);
    X = responseCell1Mean(:,idxCell);
    D(idxRep, :) = pdist(X, 'correlation');
    for idxUnit = 1:100
        idxOdor = randperm(15);
        X(:,idxUnit) = X(idxOdor, idxUnit);
    end
    DS(idxRep, :) = pdist(X, 'correlation');
end
distOdors = mean(D);
distOdorsDecorr = mean(DS);
% figure;
% maxD = max(distOdors);
% minD = min(distOdors);
% edges = minD:0.025:maxD;
% [N,edges] = histcounts(distOdors, edges,'normalization', 'probability');
% [N1,edges] = histcounts(distOdorsDecorr, edges,'normalization', 'probability');
% edges(end) = [];
% h1 = area(edges, N);
% h1.FaceColor = 'k';
% h1.EdgeColor = 'k';
% alpha(h1, 0.5)
% hold on
% plot(edges,N1, ':k')
% set(gca,'YColor','w','box','off')

% D = squareform(D);
% Z = linkage(D);
% Y = mdscale(D, 3, 'criterion', 'stress');
% 
% distancePcx = D;
% treePcx = Z;
% figure;
% clims = [0 2];
% imagesc(D, clims); 
% colormap(brewermap([],'*RdBu')); axis tight; axis square
% set(gca,'YColor','w')
% set(gca,'XColor','w')
% set(gca,'XTick',[])
% set(gca,'XTickLabel',[])
% set(gca,'YTick',[])
% set(gca,'YTickLabel',[])
% figure;
% dendrogram(Z)
% figure;
% C = [228,26,28;
% 55,126,184;
% 77,175,74;
% 152,78,163;
% 255,127,0]./255;
% idxC = 0;
% for idx = 0:3:12
%     idxC = idxC + 1;
%     scatter3(Y(1 + idx : 3 + idx, 1), Y(1 + idx : 3 + idx, 2), Y(1 + idx : 3 + idx, 3), 150, C(idxC,:), 'filled');
% hold on
% end
