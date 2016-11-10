odors = 1:6;
[responsivityCoa, auROCCoa, nCellsExpCoa] = findResponsivityAndAurocPerShank(coa.esp, odors, 0);
[responsivityPcx, auROCPcx, nCellsExpPcx] = findResponsivityAndAurocPerShank(pcx.esp, odors, 0);

%%

fractionPerConcentrationCoa = [];
prefOdorCoa = [];
for idxOdor = 1:6
    for idxShank = 1:4
        app = responsivityCoa{idxShank}(:,idxOdor);
        app1 = [];
        appBest = auROCCoa{idxShank};
        for idxExp = 1:size(nCellsExpCoa,1)
            app1 = app(1:nCellsExpCoa(idxExp,idxShank),:);
            app(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            fractionPerConcentrationCoa(idxShank,idxOdor, idxExp) = sum(app1)./size(app1,1);
            appBest1 = appBest(1:nCellsExpCoa(idxExp,idxShank),:);
            appBest(1:nCellsExpCoa(idxExp,idxShank),:) = [];
            prefOdor_app = [];
            for idxNeuron = 1:size(appBest1,1)
                [~,idxOdor] = max(appBest1(idxNeuron, :));
                prefOdor_app(idxNeuron) = idxOdor;
            end
            prefOdorCoa(idxShank,:, idxExp) = histcounts(prefOdor_app, 1:7) ./ size(appBest1,1);
        end
    end
end

fractionPerConcentrationPcx = [];
prefOdorPcx = [];
for idxOdor = 1:6
    for idxShank = 1:4
        app = responsivityPcx{idxShank}(:,idxOdor);
        app1 = [];
        appBest = auROCPcx{idxShank};
        for idxExp = 1:size(nCellsExpPcx,1)
            app1 = app(1:nCellsExpPcx(idxExp,idxShank),:);
            app(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            fractionPerConcentrationPcx(idxShank,idxOdor, idxExp) = sum(app1)./size(app1,1);
            appBest1 = appBest(1:nCellsExpPcx(idxExp,idxShank),:);
            appBest(1:nCellsExpPcx(idxExp,idxShank),:) = [];
            prefOdor_app = [];
            for idxNeuron = 1:size(appBest1,1)
                [~,idxOdor] = max(appBest1(idxNeuron, :));
                prefOdor_app(idxNeuron) = idxOdor;
            end
            prefOdorPcx(idxShank,:, idxExp) = histcounts(prefOdor_app, 1:7) ./ size(appBest1,1);
        end
    end
end


%%
fractionPerConcentrationCoa(isnan(fractionPerConcentrationCoa)) = 0;
fractionPerConcentrationPcx(isnan(fractionPerConcentrationPcx)) = 0;
fractionPerConcentrationCoa_Mean = mean(fractionPerConcentrationCoa,3);
fractionPerConcentrationCoa_SEM = std(fractionPerConcentrationCoa,[],3)./sqrt(3);
fractionPerConcentrationPcx_Mean = mean(fractionPerConcentrationPcx,3);
fractionPerConcentrationPcx_SEM = std(fractionPerConcentrationPcx,[],3)./sqrt(3);

prefOdorCoa(isnan(prefOdorCoa)) = 0;
prefOdorPcx(isnan(prefOdorPcx)) = 0;
prefOdorCoa_Mean = mean(prefOdorCoa,3);
prefOdorCoa_SEM = std(prefOdorCoa,[],3)./sqrt(3);
prefOdorPcx_Mean = mean(prefOdorPcx,3);
prefOdorPcx_SEM = std(prefOdorPcx,[],3)./sqrt(3);

%%

figure
set(gcf,'Position',[286 462 687 273]);
 set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(fractionPerConcentrationCoa_SEM, fractionPerConcentrationCoa_Mean);
ylim([0 0.3])
set(gca, 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
title('fraction of excited neurons - plCoA')

figure
set(gcf,'Position',[286 462 687 273]);
 set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(fractionPerConcentrationPcx_SEM, fractionPerConcentrationPcx_Mean);
ylim([0 0.5])
set(gca, 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
title('fraction of excited neurons - aPCx')

figure
set(gcf,'Position',[286 462 687 273]);
 set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(prefOdorCoa_SEM, prefOdorCoa_Mean);
ylim([0 0.5])
set(gca, 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
title('preferred odor - plCoA')

figure
set(gcf,'Position',[286 462 687 273]);
 set(gcf,'color','white', 'PaperPositionMode', 'auto');
b = barwitherr(prefOdorPcx_SEM, prefOdorPcx_Mean);
ylim([0 0.5])
set(gca, 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
title('preferred odor - aPCx')
%%
[noiseCorr1000msCoa, noiseNCorr1000msCoa] = trialCorrelationsShank_new(coa.esp, odors);
[noiseCorr1000msPcx, noiseNCorr1000msPcx] = trialCorrelationsShank_new(pcx.esp, odors);

%%
x(1) = nanmean(noiseCorr_0_1000ms);
x(2) = nanmean(noiseCorr_1_1000ms);
x(3) = nanmean(noiseCorr_2_1000ms);
x(4) = nanmean(noiseCorr_3_1000ms);
figure; bar(x)


x(1) = nanmean(noiseNCorr_0_1000ms);
x(2) = nanmean(noiseNCorr_1_1000ms);
x(3) = nanmean(noiseNCorr_2_1000ms);
x(4) = nanmean(noiseNCorr_3_1000ms);
figure; bar(x)

%%
X = [noiseCorr_0_1000ms noiseCorr_1_1000ms noiseCorr_2_1000ms noiseCorr_3_1000ms];
gX = [ones(length(noiseCorr_0_1000ms),1)' 2*ones(length(noiseCorr_1_1000ms),1)'...
    3*ones(length(noiseCorr_2_1000ms),1)' 4*ones(length(noiseCorr_3_1000ms),1)'];

[p, tabl, stats] = anova1(X, gX)
multcompare(stats)

%%
X = [signalCorr_0_1000ms signalCorr_1_1000ms signalCorr_2_1000ms signalCorr_3_1000ms];
gX = [ones(length(signalCorr_0_1000ms),1)' 2*ones(length(signalCorr_1_1000ms),1)'...
    3*ones(length(signalCorr_2_1000ms),1)' 4*ones(length(signalCorr_3_1000ms),1)'];

[p, tabl, stats] = anova1(X, gX)
multcompare(stats)
