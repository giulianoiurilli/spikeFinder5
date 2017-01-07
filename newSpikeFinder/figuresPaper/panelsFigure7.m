[CorrSameCoaNM, CorrOtherCoaNM] = signalCorrelationWithinAndBetween(coaNM.esp, 1:13, 0.5, 0);
[CorrSameCoa15, CorrOtherCoa15] = signalCorrelationWithinAndBetween(coaNM.esp, 1:15, 0.5, 0);
[CorrSamePcxNM, CorrOtherPcxNM] = signalCorrelationWithinAndBetween(pcxNM.esp, 1:13, 0.5, 0);
[CorrSamePcx15, CorrOtherPcx15] = signalCorrelationWithinAndBetween(pcxNM.esp, 1:15, 0.5, 0);

[noiseCorrW1000msCoaNM, noiseCorrB1000msCoaNM, noiseCorrW1000msCoaNMSig, noiseCorrB1000msCoaNMSig] = findNoiseCorrelation_new(coaNM.esp, 1:13, 0.5);
[noiseCorrW1000msPcxNM, noiseCorrB1000msPcxNM, noiseCorrW1000msPcxNMSig, noiseCorrB1000msPcxNMSig] = findNoiseCorrelation_new(pcxNM.esp, 1:13, 0.5);

[noiseCorrW1000msCoa15, noiseCorrB1000msCoa15, noiseCorrW1000msCoa15Sig, noiseCorrB1000msCoa15Sig] = findNoiseCorrelation_new(coa15.esp, 1:15, 0.5);
[noiseCorrW1000msPcx15, noiseCorrB1000msPcx15, noiseCorrW1000msPcx15Sig, noiseCorrB1000msPcx15Sig] = findNoiseCorrelation_new(pcx15.esp, 1:15, 0.5);

%%
figure
sameNM = [CorrSameCoaNM CorrSamePcxNM];
g = [zeros(1, length(CorrSameCoaNM)) ones(1,length(CorrSamePcxNM))];
boxplot(sameNM, g, 'color', [coaC; pcxC], 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-1 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
otherNM = [CorrOtherCoaNM CorrOtherPcxNM];
g = [zeros(1, length(CorrOtherCoaNM)) ones(1,length(CorrOtherPcxNM))];
boxplot(otherNM, g, 'color', [coaC; pcxC], 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-1 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
same15 = [CorrSameCoa15 CorrSamePcx15];
g = [zeros(1, length(CorrSameCoa15)) ones(1,length(CorrSamePcx15))];
boxplot(same15, g, 'color', [coaC; pcxC], 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-1 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
other15 = [CorrOtherCoa15 CorrOtherPcx15];
g = [zeros(1, length(CorrOtherCoa15)) ones(1,length(CorrOtherPcx15))];
boxplot(other15, g, 'color', [coaC; pcxC], 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-1 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)


%%
figure
sameNM = [noiseCorrW1000msCoaNM noiseCorrW1000msPcxNM];
g = [zeros(1, length(noiseCorrW1000msCoaNM)) ones(1,length(noiseCorrW1000msPcxNM))];
boxplot(sameNM, g, 'color', [coaC; pcxC], 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-1 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
otherNM = [noiseCorrB1000msCoaNM noiseCorrB1000msPcxNM];
g = [zeros(1, length(noiseCorrB1000msCoaNM)) ones(1,length(noiseCorrB1000msPcxNM))];
boxplot(otherNM, g, 'color', [coaC; pcxC], 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-1 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
same15 = [noiseCorrW1000msCoa15 noiseCorrW1000msPcx15];
g = [zeros(1, length(noiseCorrW1000msCoa15)) ones(1,length(noiseCorrW1000msPcx15))];
boxplot(same15, g, 'color', [coaC; pcxC], 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-1 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
other15 = [noiseCorrB1000msCoa15 noiseCorrB1000msPcx15];
g = [zeros(1, length(noiseCorrB1000msCoa15)) ones(1,length(noiseCorrB1000msPcx15))];
boxplot(other15, g, 'color', [coaC; pcxC], 'ColorGroup', g, 'Notch', 'on', 'BoxStyle', 'filled', 'Whisker', 0)
ylim([-1 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
figure

[fPcx,xiPcx] = ksdensity(CorrSameCoaNM);
plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
hold on
line([mean(CorrSameCoaNM(~isnan(CorrSameCoaNM))) mean(CorrSameCoaNM(~isnan(CorrSameCoaNM)))], [0 max(fPcx)], 'linewidth', 1,'color', coaC)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
hold on

[fPcx,xiPcx] = ksdensity(CorrSamePcxNM);
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
hold on
line([mean(CorrSamePcxNM(~isnan(CorrSamePcxNM))) mean(CorrSamePcxNM(~isnan(CorrSamePcxNM)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
title('Signal Correlation - Within - NM')

figure

[fPcx,xiPcx] = ksdensity(CorrOtherCoaNM);
plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
hold on
line([mean(CorrOtherCoaNM(~isnan(CorrOtherCoaNM))) mean(CorrOtherCoaNM(~isnan(CorrOtherCoaNM)))], [0 max(fPcx)], 'linewidth', 1,'color', coaC)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
hold on

[fPcx,xiPcx] = ksdensity(CorrOtherPcxNM);
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
hold on
line([mean(CorrOtherPcxNM(~isnan(CorrOtherPcxNM))) mean(CorrOtherPcxNM(~isnan(CorrOtherPcxNM)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
title('Signal Correlation - Between - NM')




%%
figure

[fPcx,xiPcx] = ksdensity(CorrSameCoa15);
plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
hold on
line([mean(CorrSameCoa15(~isnan(CorrSameCoa15))) mean(CorrSameCoa15(~isnan(CorrSameCoa15)))], [0 max(fPcx)], 'linewidth', 1,'color', coaC)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
hold on

[fPcx,xiPcx] = ksdensity(CorrSamePcx15);
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
hold on
line([mean(CorrSamePcx15(~isnan(CorrSamePcx15))) mean(CorrSamePcx15(~isnan(CorrSamePcx15)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
title('Signal Correlation - Within - 15')

figure

[fPcx,xiPcx] = ksdensity(CorrOtherCoa15);
plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
hold on
line([mean(CorrOtherCoa15(~isnan(CorrOtherCoa15))) mean(CorrOtherCoa15(~isnan(CorrOtherCoa15)))], [0 max(fPcx)], 'linewidth', 1,'color', coaC)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
hold on

[fPcx,xiPcx] = ksdensity(CorrOtherPcx15);
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
hold on
line([mean(CorrOtherPcx15(~isnan(CorrOtherPcx15))) mean(CorrOtherPcx15(~isnan(CorrOtherPcx15)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
xlabel('signal correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
title('Signal Correlation - Between - 15')

%%
figure

[fPcx,xiPcx] = ksdensity(noiseCorrW1000msCoaNMSig);
hold on
line([mean(noiseCorrW1000msCoaNMSig(~isnan(noiseCorrW1000msCoaNMSig))) mean(noiseCorrW1000msCoaNMSig(~isnan(noiseCorrW1000msCoaNMSig)))], [0 max(fPcx)], 'linewidth', 1,'color', coaC)
plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
xlabel('noise correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
hold on

[fPcx,xiPcx] = ksdensity(noiseCorrW1000msPcxNMSig);
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
hold on
line([mean(noiseCorrW1000msPcxNMSig(~isnan(noiseCorrW1000msPcxNMSig))) mean(noiseCorrW1000msPcxNMSig(~isnan(noiseCorrW1000msPcxNMSig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
xlabel('noise correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
title('Noise Correlation - Within - NM')

figure

[fPcx,xiPcx] = ksdensity(noiseCorrB1000msCoaNMSig);
plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
hold on
line([mean(noiseCorrB1000msCoaNMSig(~isnan(noiseCorrB1000msCoaNMSig))) mean(noiseCorrB1000msCoaNMSig(~isnan(noiseCorrB1000msCoaNMSig)))], [0 max(fPcx)], 'linewidth', 1,'color', coaC)
xlabel('noise correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
hold on

[fPcx,xiPcx] = ksdensity(noiseCorrB1000msPcxNMSig);
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
hold on
line([mean(noiseCorrB1000msPcxNMSig(~isnan(noiseCorrB1000msPcxNMSig))) mean(noiseCorrB1000msPcxNMSig(~isnan(noiseCorrB1000msPcxNMSig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
xlabel('noise correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
title('Noise Correlation - Between - NM')

%%
figure

[fPcx,xiPcx] = ksdensity(noiseCorrW1000msCoa15Sig);
plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
hold on
line([mean(noiseCorrW1000msCoa15Sig(~isnan(noiseCorrW1000msCoa15Sig))) mean(noiseCorrW1000msCoa15Sig(~isnan(noiseCorrW1000msCoa15Sig)))], [0 max(fPcx)], 'linewidth', 1,'color', coaC)
xlabel('noise correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
hold on

[fPcx,xiPcx] = ksdensity(noiseCorrW1000msPcx15Sig);
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
hold on
line([mean(noiseCorrW1000msPcx15Sig(~isnan(noiseCorrW1000msPcx15Sig))) mean(noiseCorrW1000msPcx15Sig(~isnan(noiseCorrW1000msPcx15Sig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
xlabel('noise correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
title('Noise Correlation - Within - 15')

figure

[fPcx,xiPcx] = ksdensity(noiseCorrB1000msCoa15Sig);
plot(xiPcx,fPcx,'color', coaC, 'linewidth', 1)
hold on
line([mean(noiseCorrB1000msCoa15Sig(~isnan(noiseCorrB1000msCoa15Sig))) mean(noiseCorrB1000msCoa15Sig(~isnan(noiseCorrB1000msCoa15Sig)))], [0 max(fPcx)], 'linewidth', 1,'color', coaC)
xlabel('noise correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
hold on

[fPcx,xiPcx] = ksdensity(noiseCorrB1000msPcx15Sig);
hold on
line([mean(noiseCorrB1000msPcx15Sig(~isnan(noiseCorrB1000msPcx15Sig))) mean(noiseCorrB1000msPcx15Sig(~isnan(noiseCorrB1000msPcx15Sig)))], [0 max(fPcx)], 'linewidth', 1,'color', pcxC)
plot(xiPcx,fPcx,'color', pcxC, 'linewidth', 1)
xlabel('noise correlation')
ylabel('p.d.f.')
xlim([-1.2 1.2])
title('Noise Correlation - Between - 15')
%%
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coaCS2.esp, 1:15, 0.5, 1);
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcxCS2.esp, 1:15, 0.5, 1);

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
 for idxConc = 1:5
     subplot(5,1,idxConc)
     for idxOdor = 1:3
         app = (squeeze(fractionPerConcentrationCoa(:,idxConc,idxOdor,:)))';
         app(isnan(app)) = 0;
         app(app>1) = 0;
         media = nanmean(app);
         errore = std(app) ./ sqrt(size(fractionPerConcentrationCoa,4) - 1);
         means(:,idxOdor) = media';
         sems(:,idxOdor) = errore';
         errorbar(1:4, means(:,idxOdor)', sems(:,idxOdor)',...
             '-o', 'LineWidth', 1, 'MarkerEdgeColor', colors(idxOdor,:), 'MarkerFaceColor', colors(idxOdor,:), 'MarkerSize', 8, 'color', colors(idxOdor,:))
         hold on
     end
     ylim([0 0.3])
     set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
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
         errorbar(1:4, means(:,idxOdor)', sems(:,idxOdor)',...
             '-o', 'LineWidth', 1, 'MarkerEdgeColor', colors(idxOdor,:), 'MarkerFaceColor', colors(idxOdor,:), 'MarkerSize', 8, 'color', colors(idxOdor,:))
         hold on
     end
     ylim([0 0.3])
     set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
 end
 


 %% Distributions per Shank

[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coaNM.esp, 1:13, 1, 0);



edges = 0.5:13.5;
%
fractionPerOdorCoa = [];


%
 for idxShank = 1:4
        app1 = responsivityCoa{1,idxShank};
        app2 = auROCCoa{1,idxShank};
        for idxExp = 1:size(nCellsExpCoa,1)
            app11 = app1(1:nCellsExpCoa(idxExp,idxShank),:);
            app1(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpCoa(idxExp,idxShank),:);
            app2(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            app4 = freq./sum(nCellsExpCoa(idxExp,:),2);
            fractionPerOdorCoa(idxShank,:, idxExp) = app4;
        end
 end
%%
x = squeeze(fractionPerOdorCoa(:,3, :));
x = x';
figure
means = mean(x);
sems = std(x)./sqrt(size(x,1)-1);
errorbar(1:4, means, sems,...
    '-o', 'LineWidth', 1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 8, 'color', 'k')
hold on
x = 1:4;
a = polyfit(x,means,1);
y1 = polyval(a,x);
plot(x,y1, '-', 'color', [35, 139, 69]./255, 'linewidth', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
         

%%
slopes = zeros(size(fractionPerOdorCoa,3), size(fractionPerOdorCoa,2));
for idxExp = 1:size(fractionPerOdorCoa,3)
    app1 = [];
    app1 = squeeze(fractionPerOdorCoa(:,:,idxExp));
    for idxOdor = 1:size(fractionPerOdorCoa,2)
        app2 = app1(:,idxOdor);
        if sum(app2) > 0
            y1 = app2';
            x = 1:4;
            a = polyfit(x,y1,1);
            slopesCoaNM(idxExp, idxOdor) = a(1);
        end
    end
end
figure

errorbar(1:size(fractionPerOdorCoa,2), mean(slopesCoaNM), std(slopesCoaNM)./sqrt(size(fractionPerOdorCoa,3)-1),...
    'o',  'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 6)
ylim([-0.1 0.1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
                            

%%
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coa15.esp, 1:15, 1, 0);



edges = 0.5:15.5;
%
fractionPerOdorCoa = [];


%
 for idxShank = 1:4
        app1 = responsivityCoa{1,idxShank};
        app2 = auROCCoa{1,idxShank};
        for idxExp = 1:size(nCellsExpCoa,1)
            app11 = app1(1:nCellsExpCoa(idxExp,idxShank),:);
            app1(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpCoa(idxExp,idxShank),:);
            app2(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            app4 = freq./sum(nCellsExpCoa(idxExp,:),2);
            fractionPerOdorCoa(idxShank,:, idxExp) = app4;
        end
 end

slopes = zeros(size(fractionPerOdorCoa,3), size(fractionPerOdorCoa,2));
for idxExp = 1:size(fractionPerOdorCoa,3)
    app1 = [];
    app1 = squeeze(fractionPerOdorCoa(:,:,idxExp));
    for idxOdor = 1:size(fractionPerOdorCoa,2)
        app2 = app1(:,idxOdor);
        if sum(app2) > 0
            y1 = app2';
            x = 1:4;
            a = polyfit(x,y1,1);
            slopesCoa15(idxExp, idxOdor) = a(1);
        end
    end
end
figure

errorbar(1:size(fractionPerOdorCoa,2), mean(slopesCoa15), std(slopesCoa15)./sqrt(size(fractionPerOdorCoa,3)-1),...
    'o',  'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 6)
ylim([-0.1 0.1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
                            

%%
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coaAA.esp, 1:10, 1, 0);



edges = 0.5:10.5;
%
fractionPerOdorCoa = [];


%
 for idxShank = 1:4
        app1 = responsivityCoa{1,idxShank};
        app2 = auROCCoa{1,idxShank};
        for idxExp = 1:size(nCellsExpCoa,1)
            app11 = app1(1:nCellsExpCoa(idxExp,idxShank),:);
            app1(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpCoa(idxExp,idxShank),:);
            app2(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            app4 = freq./sum(nCellsExpCoa(idxExp,:),2);
            fractionPerOdorCoa(idxShank,:, idxExp) = app4;
        end
 end

slopes = zeros(size(fractionPerOdorCoa,3), size(fractionPerOdorCoa,2));
for idxExp = 1:size(fractionPerOdorCoa,3)
    app1 = [];
    app1 = squeeze(fractionPerOdorCoa(:,:,idxExp));
    for idxOdor = 1:size(fractionPerOdorCoa,2)
        app2 = app1(:,idxOdor);
        if sum(app2) > 0
            y1 = app2';
            x = 1:4;
            a = polyfit(x,y1,1);
            slopesCoaAA(idxExp, idxOdor) = a(1);
        end
    end
end
figure

errorbar(1:size(fractionPerOdorCoa,2), nanmean(slopesCoaAA), nanstd(slopesCoaAA)./sqrt(size(fractionPerOdorCoa,3)-1),...
    'o',  'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 6)
ylim([-0.1 0.1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
                            
 
 %% Distributions per Shank

[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcxNM.esp, 1:13, 1, 0);


edges = 0.5:13.5;
%
fractionPerOdorPcx = [];


%
 for idxShank = 1:4
        app1 = responsivityPcx{1,idxShank};
        app2 = auROCPcx{1,idxShank};
        for idxExp = 1:size(nCellsExpPcx,1)
            app11 = app1(1:nCellsExpPcx(idxExp,idxShank),:);
            app1(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpPcx(idxExp,idxShank),:);
            app2(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            app4 = freq./sum(nCellsExpPcx(idxExp,:),2);
            fractionPerOdorPcx(idxShank,:, idxExp) = app4;
        end
 end

slopes = zeros(size(fractionPerOdorPcx,3), size(fractionPerOdorPcx,2));
for idxExp = 1:size(fractionPerOdorPcx,3)
    app1 = [];
    app1 = squeeze(fractionPerOdorPcx(:,:,idxExp));
    for idxOdor = 1:size(fractionPerOdorPcx,2)
        app2 = app1(:,idxOdor);
        if sum(app2) > 0
            y1 = app2';
            x = 1:4;
            a = polyfit(x,y1,1);
            slopesPcxNM(idxExp, idxOdor) = a(1);
        end
    end
end
figure

errorbar(1:size(fractionPerOdorPcx,2), mean(slopesPcxNM), std(slopesPcxNM)./sqrt(size(fractionPerOdorPcx,3)-1),...
    'o',  'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 6)
ylim([-0.1 0.1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
                            

%%
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcx15.esp, 1:15, 1, 0);


edges = 0.5:15.5;
%
fractionPerOdorPcx = [];


%
 for idxShank = 1:4
        app1 = responsivityPcx{1,idxShank};
        app2 = auROCPcx{1,idxShank};
        for idxExp = 1:size(nCellsExpPcx,1)
            app11 = app1(1:nCellsExpPcx(idxExp,idxShank),:);
            app1(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpPcx(idxExp,idxShank),:);
            app2(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            app4 = freq./sum(nCellsExpPcx(idxExp,:),2);
            fractionPerOdorPcx(idxShank,:, idxExp) = app4;
        end
 end

slopes = zeros(size(fractionPerOdorPcx,3), size(fractionPerOdorPcx,2));
for idxExp = 1:size(fractionPerOdorPcx,3)
    app1 = [];
    app1 = squeeze(fractionPerOdorPcx(:,:,idxExp));
    for idxOdor = 1:size(fractionPerOdorPcx,2)
        app2 = app1(:,idxOdor);
        if sum(app2) > 0
            y1 = app2';
            x = 1:4;
            a = polyfit(x,y1,1);
            slopesPcx15(idxExp, idxOdor) = a(1);
        end
    end
end
figure

errorbar(1:size(fractionPerOdorPcx,2), mean(slopesPcx15), std(slopesPcx15)./sqrt(size(fractionPerOdorPcx,3)-1),...
    'o',  'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 6)
ylim([-0.1 0.1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
                            

%%

[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcxAA.esp, 1:10, 1, 0);


edges = 0.5:10.5;
%
fractionPerOdorPcx = [];


%
 for idxShank = 1:4
        app1 = responsivityPcx{1,idxShank};
        app2 = auROCPcx{1,idxShank};
        for idxExp = 1:size(nCellsExpPcx,1)
            app11 = app1(1:nCellsExpPcx(idxExp,idxShank),:);
            app1(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpPcx(idxExp,idxShank),:);
            app2(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            app4 = freq./sum(nCellsExpPcx(idxExp,:),2);
            fractionPerOdorPcx(idxShank,:, idxExp) = app4;
        end
 end

slopes = zeros(size(fractionPerOdorPcx,3), size(fractionPerOdorPcx,2));
for idxExp = 1:size(fractionPerOdorPcx,3)
    app1 = [];
    app1 = squeeze(fractionPerOdorPcx(:,:,idxExp));
    for idxOdor = 1:size(fractionPerOdorPcx,2)
        app2 = app1(:,idxOdor);
        if sum(app2) > 0
            y1 = app2';
            x = 1:4;
            a = polyfit(x,y1,1);
            slopesPcxAA(idxExp, idxOdor) = a(1);
        end
    end
end
figure

errorbar(1:size(fractionPerOdorPcx,2), nanmean(slopesPcxAA), nanstd(slopesPcxAA)./sqrt(size(fractionPerOdorPcx,3)-1),...
    'o',  'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 6)
ylim([-0.1 0.1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
                            
%%
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coaCS2.esp, 1:15, 1, 0);



edges = 0.5:15.5;
%
fractionPerOdorCoa = [];


%
 for idxShank = 1:4
        app1 = responsivityCoa{1,idxShank};
        app2 = auROCCoa{1,idxShank};
        for idxExp = 1:size(nCellsExpCoa,1)
            app11 = app1(1:nCellsExpCoa(idxExp,idxShank),:);
            app1(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpCoa(idxExp,idxShank),:);
            app2(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            app4 = freq./sum(nCellsExpCoa(idxExp,:),2);
            fractionPerOdorCoa(idxShank,:, idxExp) = app4;
        end
 end

slopes = zeros(size(fractionPerOdorCoa,3), size(fractionPerOdorCoa,2));
for idxExp = 1:size(fractionPerOdorCoa,3)
    app1 = [];
    app1 = squeeze(fractionPerOdorCoa(:,:,idxExp));
    for idxOdor = 1:size(fractionPerOdorCoa,2)
        app2 = app1(:,idxOdor);
        if sum(app2) > 0
            y1 = app2';
            x = 1:4;
            a = polyfit(x,y1,1);
            slopesCoa15(idxExp, idxOdor) = a(1);
        end
    end
end
figure

errorbar(1:size(fractionPerOdorCoa,2), mean(slopesCoa15), std(slopesCoa15)./sqrt(size(fractionPerOdorCoa,3)-1),...
    'o',  'MarkerEdgeColor', coaC, 'MarkerFaceColor', coaC, 'MarkerSize', 6)
ylim([-0.1 0.1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)


%%
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcxCS2.esp, 1:15, 1, 0);


edges = 0.5:15.5;
%
fractionPerOdorPcx = [];


%
 for idxShank = 1:4
        app1 = responsivityPcx{1,idxShank};
        app2 = auROCPcx{1,idxShank};
        for idxExp = 1:size(nCellsExpPcx,1)
            app11 = app1(1:nCellsExpPcx(idxExp,idxShank),:);
            app1(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app22 = app2(1:nCellsExpPcx(idxExp,idxShank),:);
            app2(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            app3 = app11.*app22;
            [~, maxAuroc] = max(app3, [], 2);
            nonRespons = sum(app3,2);
            maxAuroc(nonRespons == 0) = [];
            freq = histcounts(maxAuroc, edges);
            app4 = freq./sum(nCellsExpPcx(idxExp,:),2);
            fractionPerOdorPcx(idxShank,:, idxExp) = app4;
        end
 end

slopes = zeros(size(fractionPerOdorPcx,3), size(fractionPerOdorPcx,2));
for idxExp = 1:size(fractionPerOdorPcx,3)
    app1 = [];
    app1 = squeeze(fractionPerOdorPcx(:,:,idxExp));
    for idxOdor = 1:size(fractionPerOdorPcx,2)
        app2 = app1(:,idxOdor);
        if sum(app2) > 0
            y1 = app2';
            x = 1:4;
            a = polyfit(x,y1,1);
            slopesPcx15(idxExp, idxOdor) = a(1);
        end
    end
end
figure

errorbar(1:size(fractionPerOdorPcx,2), mean(slopesPcx15), std(slopesPcx15)./sqrt(size(fractionPerOdorPcx,3)-1),...
    'o',  'MarkerEdgeColor', pcxC, 'MarkerFaceColor', pcxC, 'MarkerSize', 6)
ylim([-0.1 0.1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
                            
