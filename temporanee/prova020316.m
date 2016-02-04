%% C,D - Coding spaces
scoresCoaAA = [];
scoresPcxAA = [];
odorsRearranged = [14 4 11 2 8 5 12 10]; odorsRearranged = sort(odorsRearranged);
[scoresCoaAA, scoresMeanCoaAA] = findCodingSpace(coa2HL.esp, odorsRearranged);
odorsRearranged = [9 8 3 13 1 14 10 11]; odorsRearranged = sort(odorsRearranged);
[scoresPcxAA, scoresMeanPcxAA] = findCodingSpace(pcx2HL.esp, odorsRearranged);
%p(2,1).select()
colorClass = [118,42,131;...
    27,120,55]./255;
figure;
% colorClass = [228,26,28;...
%     55,126,184;...
%     77,175,74;...
%     152,78,163;...
%     255,127,0]./255;
symbolOdor = {'o', 's', 'p', 'd'};
k = 0;
for idxCat = 1:2
    C = colorClass(idxCat,:);
    for idxOdor = 1:4
        mT = symbolOdor{idxOdor};
        scatter3(scoresCoaAA(1 + k*5:5 + k*5, 1), scoresCoaAA(1 + k*5:5 + k*5, 2), scoresCoaAA(1 + k*5:5 + k*5, 3), 100, C, mT, 'filled');
        k = k + 1;
        hold on
%         scatter3(scoresMeanCoa(k, 1), scoresMeanCoa(k, 2), scoresMeanCoa(k, 3), 100, C, 'd','filled');
%         hold on
    end
end
axis square
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');

figure;
% p(2,2).select()
colorClass = [118,42,131;...
    27,120,55]./255;
% colorClass = [228,26,28;...
%     55,126,184;...
%     77,175,74;...
%     152,78,163;...
%     255,127,0]./255;
symbolOdor = {'o', 's', 'p', 'd'};
k = 0;
for idxCat = 1:2
    C = colorClass(idxCat,:);
    for idxOdor = 1:4
        mT = symbolOdor{idxOdor};
        scatter3(scoresPcxAA(1 + k*5:5 + k*5, 1), scoresPcxAA(1 + k*5:5 + k*5, 2), scoresPcxAA(1 + k*5:5 + k*5, 3),100, C, mT, 'filled');
        k = k + 1;
        hold on
%         scatter3(scoresPcxAA(k, 1), scoresPcxAA(k, 2), scoresPcxAA(k, 3), 100, C, 'd','filled');
%         hold on
    end
end
axis square
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');