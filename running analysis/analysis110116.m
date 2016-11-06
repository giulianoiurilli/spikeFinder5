odors = 1:15;
[tuningCurvesCoa, tuningCurvesSigCoa, rhoCoa, rhoSigCoa] = makeTuningCurves_new(coa15.esp, odors);
[tuningCurvesPcx, tuningCurvesSigPcx, rhoPcx, rhoSigPcx] = makeTuningCurves_new(pcx15.esp, odors);

%%
figure
histogram(rhoSigPcx,200, 'normalization', 'probability')
figure
histogram(rhoSigCoa,200, 'normalization', 'probability')

%%
%%
odorsRearranged = 1:15;
[scoresCoa, scoresMeanCoa, explainedMeanCoa, explaineStdCoa] = findCodingSpace_new(coa15.esp, odorsRearranged);


figure
colorClass1 = flipud([254,240,217;...
253,204,138;...
252,141,89;...
227,74,51;...
179,0,0]./255);

colorClass2 = flipud([239,243,255;...
189,215,231;...
107,174,214;...
49,130,189;...
8,81,156]./255);

colorClass3 = flipud([237,248,233;...
186,228,179;...
116,196,118;...
49,163,84;...
0,109,44]./255);

colorClass = cat(3,colorClass1, colorClass2, colorClass3);


k = 0;
for idxOdor = 1:3
    C = squeeze(colorClass(:,:,idxOdor));
    for idxConc = 1:5
        scatter3(scoresCoa(1 + k*5:5 + k*5, 1), scoresCoa(1 + k*5:5 + k*5, 2), scoresCoa(1 + k*5:5 + k*5, 3), 100, C(idxConc,:), 'o', 'filled');
        k = k + 1;
        hold on
%         scatter3(scoresMeanCoa(k, 1), scoresMeanCoa(k, 2), scoresMeanCoa(k, 3), 100, C, 'd','filled');
%         hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('plCOA');


%%
[scoresPcx, scoresMeanPcx, explainedMeanPcx, explaineStdPcx] = findCodingSpace_new(pcx15.esp, odorsRearranged);
figure
colorClass1 = flipud([254,240,217;...
253,204,138;...
252,141,89;...
227,74,51;...
179,0,0]./255);

colorClass2 = flipud([239,243,255;...
189,215,231;...
107,174,214;...
49,130,189;...
8,81,156]./255);

colorClass3 = flipud([237,248,233;...
186,228,179;...
116,196,118;...
49,163,84;...
0,109,44]./255);
symbolOdor = {'o', 's', 'p'};
k = 0;
colorClass = cat(3,colorClass1, colorClass2, colorClass3);
for idxOdor = 1:3
    C = squeeze(colorClass(:,:,idxOdor));
    for idxConc = 1:5
        scatter3(scoresPcx(1 + k*5:5 + k*5, 1), scoresPcx(1 + k*5:5 + k*5, 2), scoresPcx(1 + k*5:5 + k*5, 3), 100, C(idxConc,:), 'o', 'filled');
        k = k + 1;
        hold on
%         scatter3(scoresMeanCoa(k, 1), scoresMeanCoa(k, 2), scoresMeanCoa(k, 3), 100, C, 'd','filled');
%         hold on
    end
end
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');
title('PCX');

%%
figure;
shadedErrorBar(1:size(explainedMeanCoa,1), explainedMeanCoa', explaineStdCoa', 'r');
hold on
shadedErrorBar(1:size(explainedMeanPcx,1), explainedMeanPcx', explaineStdPcx', 'k');
title('15 odors')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)