[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coaCS2.esp, 1:15, 1);
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcxCS2.esp, 1:15, 1);

%%
fractionPerConcentrationCoa = [];
for idxOdor = 1:3
    for idxShank = 1:4
        app = squeeze(responsivityCoa{idxShank}(:,:,idxOdor));
        for idxExp = 1:size(nCellsExpCoa,1)
            app1 = app(1:nCellsExpCoa(idxExp,idxShank),:);
            app(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            fractionPerConcentrationCoa(idxShank,:,idxOdor, idxExp) = sum(app1)./size(app1,1);
        end
    end
end

fractionPerConcentrationPcx = [];
for idxOdor = 1:3
    for idxShank = 1:4
        app = squeeze(responsivityPcx{idxShank}(:,:,idxOdor));
        for idxExp = 1:size(nCellsExpPcx,1)
            app1 = app(1:nCellsExpPcx(idxExp,idxShank),:);
            app(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            fractionPerConcentrationPcx(idxShank,:,idxOdor, idxExp) = sum(app1)./size(app1,1);
        end
    end
end
 %%   
 figure
 set(gcf,'Position',[207 90 395 642]);
 set(gcf,'color','white', 'PaperPositionMode', 'auto');
 
 colors = [228,26,28;...
55,126,184;...
77,175,74] ./ 255;
 
 for idxConc = 1:5
     subplot(5,1,idxConc)
     means = [];
     sems = [];
     for idxOdor = 1:3
         app = (squeeze(fractionPerConcentrationCoa(:,idxConc,idxOdor,:)))';
         app(isnan(app)) = 0;
         media = mean(app);
         errore = std(app) ./ sqrt(size(fractionPerConcentrationCoa,4) - 1);
         means(:,idxOdor) = media';
         sems(:,idxOdor) = errore';
     end
     b = barwitherr(sems, means);
     ylim([0 0.3])
     b(1).EdgeColor = colors(1,:);
     b(2).EdgeColor = colors(2,:);
     b(3).EdgeColor = colors(3,:);
     b(1).FaceColor = colors(1,:);
     b(2).FaceColor = colors(2,:);
     b(3).FaceColor = colors(3,:);
     set(gca, 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
 end
 %%   
 figure
 set(gcf,'Position',[207 90 395 642]);
 set(gcf,'color','white', 'PaperPositionMode', 'auto');
 for idxConc = 1:5
     subplot(5,1,idxConc)
     for idxOdor = 1:3
         app = (squeeze(fractionPerConcentrationPcx(:,idxConc,idxOdor,:)))';
         app(isnan(app)) = 0;
         app(app>1) = 0;
         media = nanmean(app);
         errore = std(app) ./ sqrt(size(fractionPerConcentrationPcx,4) - 1);
         means(:,idxOdor) = media';
         sems(:,idxOdor) = errore';
     end
     b = barwitherr(sems, means);
     ylim([0 0.3])
     b(1).EdgeColor = colors(1,:);
     b(2).EdgeColor = colors(2,:);
     b(3).EdgeColor = colors(3,:);
     b(1).FaceColor = colors(1,:);
     b(2).FaceColor = colors(2,:);
     b(3).FaceColor = colors(3,:);
     set(gca, 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
 end
 
 
 %%
 for idxShank = 1:4
     for idxConc = 1:5
         app1 = squeeze(responsivityCoa{idxShank}(:,idxConc,:));
         app2 = squeeze(auROCCoa{idxShank}(:,idxConc,:));
         app3 = [];
         for idxCell = 1:size(app1,1)
             if sum(app1(idxCell,:)) > 0
                 app3 = [app3; app2(idxCell,:)];
             end
         end
         meanAuRocCoa(idxConc,:,idxShank) = mean(app3);
         semAuRocCoa(idxConc,:,idxShank) = std(app3)/sqrt(size(app3,1)-1);
     end
 end
 
 figure
 set(gcf,'Position',[207 90 395 642]);
 set(gcf,'color','white', 'PaperPositionMode', 'auto');
  for idxConc = 1:5
     subplot(5,1,idxConc)
%      for idxOdor = 1:3
%          plot(squeeze(meanAuRocCoa(idxConc,idxOdor,:)))
%          hold on
%      end
          b = barwitherr(squeeze(semAuRocCoa(idxConc,:,:))', squeeze(meanAuRocCoa(idxConc,:,:))');
     b(1).EdgeColor = colors(1,:);
     b(2).EdgeColor = colors(2,:);
     b(3).EdgeColor = colors(3,:);
     b(1).FaceColor = colors(1,:);
     b(2).FaceColor = colors(2,:);
     b(3).FaceColor = colors(3,:);
     ylim([0.5 1])
     set(gca, 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
  end
 
   %%
 for idxShank = 1:4
     for idxConc = 1:5
         app1 = squeeze(responsivityPcx{idxShank}(:,idxConc,:));
         app2 = squeeze(auROCPcx{idxShank}(:,idxConc,:));
         app3 = [];
         for idxCell = 1:size(app1,1)
             if sum(app1(idxCell,:)) > 0
                 app3 = [app3; app2(idxCell,:)];
             end
         end
         meanAuRocPcx(idxConc,:,idxShank) = mean(app3);
         semAuRocPcx(idxConc,:,idxShank) = std(app3)/sqrt(size(app3,1)-1);
     end
 end
 
 figure
 set(gcf,'Position',[207 90 395 642]);
 set(gcf,'color','white', 'PaperPositionMode', 'auto');
  for idxConc = 1:5
     subplot(5,1,idxConc)
%      for idxOdor = 1:3
%          plot(squeeze(meanAuRocPcx(idxConc,idxOdor,:)))
%          hold on
%      end
          b = barwitherr(squeeze(semAuRocPcx(idxConc,:,:))', squeeze(meanAuRocPcx(idxConc,:,:))');
     b(1).EdgeColor = colors(1,:);
     b(2).EdgeColor = colors(2,:);
     b(3).EdgeColor = colors(3,:);
     b(1).FaceColor = colors(1,:);
     b(2).FaceColor = colors(2,:);
     b(3).FaceColor = colors(3,:);
     ylim([0.5 1])
     set(gca, 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
  end
 
%%
[VariantCoa, InvariantCoa, nonmonotonicCoa, nonmonotonicSemCoa, monotonicDCoa, monotonicDSemCoa, monotonicICoa, monotonicISemCoa, cellLogInvCoa] = findConcInvarianceAndMonotonicity_new(coaCS.esp);
[VariantPcx, InvariantPcx, nonmonotonicPcx, nonmonotonicSemPcx, monotonicDPcx, monotonicDSemPcx, monotonicIPcx, monotonicISemPcx, cellLogInvPcx] = findConcInvarianceAndMonotonicity_new(pcxCS.esp);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
for idxOdor = 1:3
xMean = [VariantCoa(idxOdor) VariantPcx(idxOdor); InvariantCoa(idxOdor) InvariantPcx(idxOdor)];
semCoa = sqrt(xMean(1,1) * xMean(2,1) / (numel(sigAnovaCoa)-1));
semPcx = sqrt(xMean(1,2) * xMean(2,2) / (numel(sigAnovaPcx)-1));
xSem = [semCoa, semPcx; semCoa, semPcx];
subplot(3,1,idxOdor)
b = barwitherr(xSem, xMean);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
end


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
for idxOdor = 1:3
    xMean = [nonmonotonicCoa(idxOdor) nonmonotonicPcx(idxOdor); monotonicDCoa(idxOdor) monotonicDPcx(idxOdor); monotonicICoa(idxOdor) monotonicIPcx(idxOdor)];
    xSem = [nonmonotonicSemCoa(idxOdor) nonmonotonicSemPcx(idxOdor); monotonicDSemCoa(idxOdor) monotonicDSemPcx(idxOdor); monotonicISemCoa(idxOdor) monotonicISemPcx(idxOdor)];
    subplot(3,1,idxOdor)
    b = barwitherr(xSem, xMean);
    b(1).EdgeColor = coaC;
    b(1).FaceColor = coaC;
    b(2).EdgeColor = pcxC;
    b(2).FaceColor = pcxC;
    set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
end
%%
odors = 1:15;
[concCoa, totalResponsiveSUACoa] = findOdorDiscriminative_new2(coaCS.esp, odors);
[concPcx, totalResponsiveSUAPcx] = findOdorDiscriminative_new2(pcxCS.esp, odors);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
concCoaP = concCoa ./ totalResponsiveSUACoa;
concPcxP = concPcx ./ totalResponsiveSUAPcx;
p_1 = ones(1,5);
p_1Coa = p_1 - concCoaP;
p_1Pcx = p_1 - concPcxP;

for idxConc = 1:5
    semCoa(idxConc) = sqrt(concCoaP(idxConc) * p_1Coa(idxConc) ./  (totalResponsiveSUACoa-1));
    semPcx(idxConc) = sqrt(concPcxP(idxConc) * p_1Pcx(idxConc) ./  (totalResponsiveSUAPcx-1));
end

meanX = [concCoaP', concPcxP'];
semX = [semCoa' semPcx'];

b = barwitherr(semX, meanX);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)



%%
odorsRearranged = 1:15;
[rhoOdorRepresentationsSigCoa, rhoMeanOdorRepresentationsSigCoa] = findOdorRepresentationCorrelation(coaCS.esp, odorsRearranged);
[rhoOdorRepresentationsSigPcx, rhoMeanOdorRepresentationsSigPcx] = findOdorRepresentationCorrelation(pcxCS.esp, odorsRearranged);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 1];
imagesc(rhoOdorRepresentationsSigCoa, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
colorbar
title('Correlation between odor representations - plCoA')

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 1];
imagesc(rhoOdorRepresentationsSigPcx, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
colorbar
title('Correlation between odor representations - aPCx')


%%
odorsRearranged = 1:15;
% odorsRearranged = [15    2    13     1    12    3     5     4 8 14     11     10     6    9    7];
% odorsRearranged = [15    2    13     1    12    3     5     14 8 4     11     10     6    9    7];
[scoresCoa, scoresMeanCoa, explainedMeanCoa, explaineStdCoa] = findCodingSpace(coaCS.esp, odorsRearranged);


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
set(gcf,'color','white', 'PaperPositionMode', 'auto');

%%
odorsRearranged = 1:15;
[scoresPcx, scoresMeanPcx, explainedMeanPcx, explaineStdPcx] = findCodingSpace(pcxCS.esp, odorsRearranged);
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
set(gcf,'color','white', 'PaperPositionMode', 'auto');
%%
% odorsRearranged = [1    14    15    12    11     13     7    4     3     2     10 9 8 6 5];
% odorsRearranged = odorsRearranged([3 1 2 4 5 6 7 8 9 10 15 11 12 13 14]);
odorsRearranged = 1:15;
% odorsRearranged = [15    2    13     1    12     14     8    3     5     4     11     10     6    9    7];
% odorsRearranged = [15    2    13     1    12    3     5     14 8 4     11     10     6    9    7];
[ACoa, aCoa, bCoa, cCoa, dCoa, eCoa, f1Coa, f2Coa, f3Coa, g1Coa, g2Coa, g3Coa, h1Coa, h2Coa, h3Coa, i1Coa, i2Coa, i3Coa, l1Coa, l2Coa, l3Coa] =...
    findCorrelationsConc(coaCS.esp, odorsRearranged);

% odorsRearranged = [1    11     4    12     14     2    13     7     6    3     15    5     10    9    8];
% odorsRearranged = odorsRearranged([1 5 4 3 2 6 7 8 9 10 11 12 13 14 15]);
odorsRearranged = 1:15;
[APcx, aPcx, bPcx, cPcx, dPcx, ePcx, f1Pcx, f2Pcx, f3Pcx, g1Pcx, g2Pcx, g3Pcx, h1Pcx, h2Pcx, h3Pcx, i1Pcx, i2Pcx, i3Pcx, l1Pcx, l2Pcx, l3Pcx] =...
    findCorrelationsConc(pcxCS.esp, odorsRearranged);

AcoaMean = fliplr(mean(aCoa));
AcoaSEM = fliplr(std(aCoa)/sqrt(2));

ApcxMean = fliplr(mean(aPcx));
ApcxSEM = fliplr(std(aPcx)/sqrt(2));

%%
figure
plot(1:4, AcoaMean, '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(1.1:4.1, ApcxMean, '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(1:4, AcoaMean, AcoaSEM, 'r', 'linewidth', 2); %
hold on
errbar(1.1:4.1, ApcxMean, ApcxSEM, 'k', 'linewidth', 2);
%title('odor concentration')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
xlim([0.8 4.6]);
ylim([-1 1]);
ylabel('pairwise correlation')

%%

fmeanCoa = mean([f1Coa, f2Coa, f3Coa]);
fsemCoa = std([f1Coa, f2Coa, f3Coa])/sqrt(2);

gmeanCoa = mean([g1Coa, g2Coa, g3Coa]);
gsemCoa = std([g1Coa, g2Coa, g3Coa])/sqrt(2);

hmeanCoa = mean([h1Coa, h2Coa, h3Coa]);
hsemCoa = std([h1Coa, h2Coa, h3Coa])/sqrt(2);

imeanCoa = mean([i1Coa, i2Coa, i3Coa]);
isemCoa = std([i1Coa, i2Coa, i3Coa])/sqrt(2);

lmeanCoa = mean([l1Coa, l2Coa, l3Coa]);
lsemCoa = std([l1Coa, l2Coa, l3Coa])/sqrt(2);

meanICoa = [fmeanCoa gmeanCoa hmeanCoa imeanCoa lmeanCoa];
semICoa = [fsemCoa gsemCoa hsemCoa isemCoa lsemCoa];

fmeanPcx = mean([f1Pcx, f2Pcx, f3Pcx]);
fsemPcx = std([f1Pcx, f2Pcx, f3Pcx])/sqrt(2);

gmeanPcx = mean([g1Pcx, g2Pcx, g3Pcx]);
gsemPcx = std([g1Pcx, g2Pcx, g3Pcx])/sqrt(2);

hmeanPcx = mean([h1Pcx, h2Pcx, h3Pcx]);
hsemPcx = std([h1Pcx, h2Pcx, h3Pcx])/sqrt(2);

imeanPcx = mean([i1Pcx, i2Pcx, i3Pcx]);
isemPcx = std([i1Pcx, i2Pcx, i3Pcx])/sqrt(2);

lmeanPcx = mean([l1Pcx, l2Pcx, l3Pcx]);
lsemPcx = std([l1Pcx, l2Pcx, l3Pcx])/sqrt(2);

meanIPcx = [fmeanPcx gmeanPcx hmeanPcx imeanPcx lmeanPcx];
semIPcx = [fsemPcx gsemPcx hsemPcx isemPcx lsemPcx];

figure
plot(1:5, fliplr(meanICoa), '-o', 'color', coaC, 'MarkerSize', 5, 'MarkerFaceColor', coaC);
hold on
plot(1.1:5.1, fliplr(meanIPcx), '-o', 'color', pcxC, 'MarkerSize', 5, 'MarkerFaceColor', pcxC);
hold on
errbar(1:5, fliplr(meanICoa), fliplr(semICoa), 'r', 'linewidth', 2); %
hold on
errbar(1.1:5.1, fliplr(meanIPcx), fliplr(semIPcx), 'k', 'linewidth', 2);
%title('odor concentration')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
xlim([0.8 5.6]);
ylim([-1 1]);


