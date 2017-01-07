% x = {sua_MI_coa, sua_MI_pcx};
% g = [zeros(1,length(sua_MI_coa)) ones(1,length(sua_MI_pcx))];
%
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% plotSpread(x','categoryIdx',g', 'categoryColors',{coaC,pcxC}, 'showMM',3)
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%
%
% x = {sua_MI_coaChemical, sua_MI_pcxChemical};
% g = [zeros(1,length(sua_MI_coaChemical)) ones(1,length(sua_MI_pcxChemical))];
%
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% plotSpread(x','categoryIdx',g', 'categoryColors',{coaC,pcxC}, 'showMM',3)
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%
%
% x = {sua_MI_coaValence, sua_MI_pcxValence};
% g = [zeros(1,length(sua_MI_coaValence)) ones(1,length(sua_MI_pcxValence))];
%
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% plotSpread(x','categoryIdx',g', 'categoryColors',{coaC,pcxC}, 'showMM',3)
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%
% xapp = nanmean(weigthsValenceCoa,2);
% yapp = nanmean(weigthsValencePcx,2);
% x = {xapp, yapp};
% g = [zeros(1,length(xapp)) ones(1,length(yapp))];
%
% figure
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% plotSpread(x','categoryIdx',g', 'categoryColors',{coaC,pcxC}, 'showMM',3)
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%
%%
odors = 1:10;
[auRocVCoa significantCoa] = findAurocValence(coaAA.esp, odors, 1);
[auRocVPcx significantPcx] = findAurocValence(pcxAA.esp, odors, 1);
xapp = auRocVCoa;
yapp = auRocVPcx;
x = {xapp, yapp};
g = [zeros(1,length(xapp)) ones(1,length(yapp))];

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plotSpread(x','categoryIdx',g', 'categoryColors',{[252,146,114]./255,[158,202,225]./255})
hold on
xapp = auRocVCoa(abs(significantCoa)==1);
yapp = auRocVPcx(abs(significantPcx)==1);
x = {xapp, yapp};
g = [zeros(1,length(xapp)) ones(1,length(yapp))];
plotSpread(x','categoryIdx',g', 'categoryColors',{coaC,pcxC})
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

[h,p, chi2stat,df] = prop_test([numel(xapp) numel(yapp)], [numel(auRocVCoa) numel(auRocVPcx)], 1)
%% Correlation Matrix Odor Representations
[rhoOdorRepresentationsSigCoa, rhoMeanOdorRepresentationsSigCoa, evaCoa] = findOdorRepresentationCorrelation(coaNM.esp, 1:13, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [-0.5 0.5];
imagesc(rhoOdorRepresentationsSigCoa, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
% colormap(brewermap([],'*YlGnBu'))
colormap(brewermap([],'*RdYlBu'))
colorbar
title('Corrleation between odor representations - plCoA')

[rhoOdorRepresentationsSigPcx, rhoMeanOdorRepresentationsSigPcx, evaPcx] = findOdorRepresentationCorrelation(pcxNM.esp, 1:13, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [-0.5 0.5];
imagesc(rhoOdorRepresentationsSigPcx, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
% colormap(brewermap([],'*YlGnBu'))
colormap(brewermap([],'*RdYlBu'))
colorbar
title('Corrleation between odor representations - aPCx')


[rhoOdorRepresentationsSigCoa, rhoMeanOdorRepresentationsSigCoa, evaCoa] = findOdorRepresentationCorrelation(coa15.esp, 1:15, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [-0.5 0.5];
imagesc(rhoOdorRepresentationsSigCoa, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
% colormap(brewermap([],'*YlGnBu'))
colormap(brewermap([],'*RdYlBu'))
colorbar
title('Corrleation between odor representations - plCoA')

[rhoOdorRepresentationsSigPcx, rhoMeanOdorRepresentationsSigPcx, evaPcx] = findOdorRepresentationCorrelation(pcx15.esp, 1:15, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [-0.5 0.5];
imagesc(rhoOdorRepresentationsSigPcx, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
% colormap(brewermap([],'*YlGnBu'))
colormap(brewermap([],'*RdYlBu'))
colorbar
title('Corrleation between odor representations - aPCx')

[rhoOdorRepresentationsSigCoa, rhoMeanOdorRepresentationsSigCoa, evaCoa] = findOdorRepresentationCorrelation(coaAA.esp, 1:10, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [-0.5 0.5];
imagesc(rhoOdorRepresentationsSigCoa, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
% colormap(brewermap([],'*YlGnBu'))
colormap(brewermap([],'*RdYlBu'))
colorbar
title('Corrleation between odor representations - plCoA')

[rhoOdorRepresentationsSigPcx, rhoMeanOdorRepresentationsSigPcx, evaPcx] = findOdorRepresentationCorrelation(pcxAA.esp, 1:10, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [-0.5 0.5];
imagesc(rhoOdorRepresentationsSigPcx, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
% colormap(brewermap([],'*YlGnBu'))
colormap(brewermap([],'*RdYlBu'))
colorbar
title('Corrleation between odor representations - aPCx')
%%
[rhoOdorRepresentationsSigCoa, rhoMeanOdorRepresentationsSigCoa, evaCoa] = findOdorRepresentationCorrelation(coaCS2.esp, 1:15, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 0.5];
imagesc(rhoOdorRepresentationsSigCoa, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
% colormap(brewermap([],'*YlGnBu'))
colormap(brewermap([],'*RdYlBu'))
colorbar
title('Corrleation between odor representations - plCoA')

[rhoOdorRepresentationsSigPcx, rhoMeanOdorRepresentationsSigPcx, evaPcx] = findOdorRepresentationCorrelation(pcxCS2.esp, 1:15, 1, 0, 0);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
clims = [0 0.5];
imagesc(rhoOdorRepresentationsSigPcx, clims)
axis square
colormap(brewermap([],'*PuBuGn'))
% colormap(brewermap([],'*YlGnBu'))
colormap(brewermap([],'*RdYlBu'))
colorbar
title('Corrleation between odor representations - aPCx')

%% proportion of labeled lines
lratio = 0.5;
responsiveTrialsCoa = [];
esperimento = 0;
esp = coa15.esp;
n_odors = 15;
allSingleExcCoa15 = [];
allSingleInhCoa15 = [];
for idxExp = 1 : length(esp)
    esperimento = esperimento + 1;
    excRespCoa(esperimento,:) = [0 0];
    inhRespCoa(esperimento,:) = [0 0];
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    excRespCoa(esperimento,1) = excRespCoa(esperimento,1) + 15;
                    inhRespCoa(esperimento,1) = inhRespCoa(esperimento,1) + 15;
                    appExcResp = zeros(1,n_odors);
                    appInhResp = zeros(1,n_odors);
                    for idxOdor = 1:n_odors
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                            responsiveTrialsCoa = [responsiveTrialsCoa; double(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000ms)];
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            excRespCoa(esperimento,2) = excRespCoa(esperimento,2) + 1;
                            appExcResp(idxOdor) = 1;
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                            inhRespCoa(esperimento,2) = inhRespCoa(esperimento,2) + 1;
                            appInhResp(idxOdor) = 1;
                        end
                    end
                    if sum(appExcResp) == 1
                        allSingleExcCoa15 = [allSingleExcCoa15; appExcResp];
                    end
                    if sum(appInhResp) == 1
                        allSingleInhCoa15 = [allSingleInhCoa15; appInhResp];
                    end
                end
            end
        end
    end
end
figure
mean_p_singleExc = mean(allSingleExcCoa15);
sem_p_singleExc = sqrt((mean(allSingleExcCoa15).*(1-mean(allSingleExcCoa15)))./size(allSingleExcCoa15,1));
barwitherr(sem_p_singleExc, mean_p_singleExc, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])
figure
mean_p_singleInh = mean(allSingleInhCoa15);
sem_p_singleInh = sqrt((mean(allSingleInhCoa15).*(1-mean(allSingleInhCoa15)))./size(allSingleInhCoa15,1));
barwitherr(sem_p_singleInh, mean_p_singleInh, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])



esp = coaAA.esp;
odors = [4     6     7     9    10     1     2     3     5     8];
allSingleExcCoaAA = [];
allSingleInhCoaAA = [];
for idxExp = 1 : length(esp)
    esperimento = esperimento + 1;
    excRespCoa(esperimento,:) = [0 0];
    inhRespCoa(esperimento,:) = [0 0];
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    excRespCoa(esperimento,1) = excRespCoa(esperimento,1) + 10;
                    inhRespCoa(esperimento,1) = inhRespCoa(esperimento,1) + 10;
                    appExcResp = zeros(1,n_odors);
                    appInhResp = zeros(1,n_odors);
                    idxO = 0;
                    for idxOdor = odors
                        idxO = idxO + 1;
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                            responsiveTrialsCoa = [responsiveTrialsCoa; double(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000ms)];
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            excRespCoa(esperimento,2) = excRespCoa(esperimento,2) + 1;
                            appExcResp(idxO) = 1;
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                            inhRespCoa(esperimento,2) = inhRespCoa(esperimento,2) + 1;
                            appInhResp(idxO) = 1;
                        end
                    end
                    if sum(appExcResp) == 1
                        allSingleExcCoaAA = [allSingleExcCoaAA; appExcResp];
                    end
                    if sum(appInhResp) == 1
                        allSingleInhCoaAA = [allSingleInhCoaAA; appInhResp];
                    end
                end
            end
        end
    end
end
figure
mean_p_singleExc = mean(allSingleExcCoaAA);
sem_p_singleExc = sqrt((mean(allSingleExcCoaAA).*(1-mean(allSingleExcCoaAA)))./size(allSingleExcCoaAA,1));
barwitherr(sem_p_singleExc, mean_p_singleExc, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])
figure
mean_p_singleInh = mean(allSingleInhCoaAA);
sem_p_singleInh = sqrt((mean(allSingleInhCoaAA).*(1-mean(allSingleInhCoaAA)))./size(allSingleInhCoaAA,1));
barwitherr(sem_p_singleInh, mean_p_singleInh, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])

esp = coaNM.esp;
n_odors = 13;
allSingleExcCoaNM = [];
allSingleInhCoaNM = [];
for idxExp = 1 : length(esp)
    esperimento = esperimento + 1;
    excRespCoa(esperimento,:) = [0 0];
    inhRespCoa(esperimento,:) = [0 0];
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    excRespCoa(esperimento,1) = excRespCoa(esperimento,1) + 13;
                    inhRespCoa(esperimento,1) = inhRespCoa(esperimento,1) + 13;
                    appExcResp = zeros(1,n_odors);
                    appInhResp = zeros(1,n_odors);
                    for idxOdor = 1:n_odors
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                            responsiveTrialsCoa = [responsiveTrialsCoa; double(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000ms)];
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            excRespCoa(esperimento,2) = excRespCoa(esperimento,2) + 1;
                            appExcResp(idxOdor) = 1;
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                            inhRespCoa(esperimento,2) = inhRespCoa(esperimento,2) + 1;
                            appInhResp(idxOdor) = 1;
                        end
                    end
                    if sum(appExcResp) == 1
                        allSingleExcCoaNM = [allSingleExcCoaNM; appExcResp];
                    end
                    if sum(appInhResp) == 1
                        allSingleInhCoaNM = [allSingleInhCoaNM; appInhResp];
                    end
                end
            end
        end
    end
end
figure
mean_p_singleExc = mean(allSingleExcCoaNM);
sem_p_singleExc = sqrt((mean(allSingleExcCoaNM).*(1-mean(allSingleExcCoaNM)))./size(allSingleExcCoaNM,1));
barwitherr(sem_p_singleExc, mean_p_singleExc, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])
figure
mean_p_singleInh = mean(allSingleInhCoaNM);
sem_p_singleInh = sqrt((mean(allSingleInhCoaNM).*(1-mean(allSingleInhCoaNM)))./size(allSingleInhCoaNM,1));
barwitherr(sem_p_singleInh, mean_p_singleInh, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])


responsiveTrialsPcx = [];
esperimento = 0;
esp = pcx15.esp;
n_odors = 15;
allSingleExcPcx15 = [];
allSingleInhPcx15 = [];
for idxExp = 1 : length(esp)
    esperimento = esperimento + 1;
    excRespPcx(esperimento,:) = [0 0];
    inhRespPcx(esperimento,:) = [0 0];
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    excRespPcx(esperimento,1) = excRespPcx(esperimento,1) + 15;
                    inhRespPcx(esperimento,1) = inhRespPcx(esperimento,1) + 15;
                    appExcResp = zeros(1,n_odors);
                    appInhResp = zeros(1,n_odors);
                    for idxOdor = 1:n_odors
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                            responsiveTrialsPcx = [responsiveTrialsPcx; double(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000ms)];
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            excRespPcx(esperimento,2) = excRespPcx(esperimento,2) + 1;
                            appExcResp(idxOdor) = 1;
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                            inhRespPcx(esperimento,2) = inhRespPcx(esperimento,2) + 1;
                            appInhResp(idxOdor) = 1;
                        end
                    end
                    if sum(appExcResp) == 1
                        allSingleExcPcx15 = [allSingleExcPcx15; appExcResp];
                    end
                    if sum(appInhResp) == 1
                        allSingleInhPcx15 = [allSingleInhPcx15; appInhResp];
                    end
                end
            end
        end
    end
end
figure
mean_p_singleExc = mean(allSingleExcPcx15);
sem_p_singleExc = sqrt((mean(allSingleExcPcx15).*(1-mean(allSingleExcPcx15)))./size(allSingleExcPcx15,1));
barwitherr(sem_p_singleExc, mean_p_singleExc, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])
figure
mean_p_singleInh = mean(allSingleInhPcx15);
sem_p_singleInh = sqrt((mean(allSingleInhPcx15).*(1-mean(allSingleInhPcx15)))./size(allSingleInhPcx15,1));
barwitherr(sem_p_singleInh, mean_p_singleInh, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])


esp = pcxAA.esp;
odors = [4     6     7     9    10     1     2     3     5     8];
allSingleExcPcxAA = [];
allSingleInhPcxAA = [];
for idxExp = 1 : length(esp)
    esperimento = esperimento + 1;
    excRespPcx(esperimento,:) = [0 0];
    inhRespPcx(esperimento,:) = [0 0];
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    excRespPcx(esperimento,1) = excRespPcx(esperimento,1) + 10;
                    inhRespPcx(esperimento,1) = inhRespPcx(esperimento,1) + 10;
                    appExcResp = zeros(1,n_odors);
                    appInhResp = zeros(1,n_odors);
                    idxO = 0;
                    for idxOdor = odors
                        idxO = idxO + 1;
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                            responsiveTrialsPcx = [responsiveTrialsPcx; double(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000ms)];
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            excRespPcx(esperimento,2) = excRespPcx(esperimento,2) + 1;
                            appExcResp(idxO) = 1;
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                            inhRespPcx(esperimento,2) = inhRespPcx(esperimento,2) + 1;
                            appInhResp(idxO) = 1;
                        end
                    end
                    if sum(appExcResp) == 1
                        allSingleExcPcxAA = [allSingleExcPcxAA; appExcResp];
                    end
                    if sum(appInhResp) == 1
                        allSingleInhPcxAA = [allSingleInhPcxAA; appInhResp];
                    end
                end
            end
        end
    end
end
figure
mean_p_singleExc = mean(allSingleExcPcxAA);
sem_p_singleExc = sqrt((mean(allSingleExcPcxAA).*(1-mean(allSingleExcPcxAA)))./size(allSingleExcPcxAA,1));
barwitherr(sem_p_singleExc, mean_p_singleExc, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])
figure
mean_p_singleInh = mean(allSingleInhPcxAA);
sem_p_singleInh = sqrt((mean(allSingleInhPcxAA).*(1-mean(allSingleInhPcxAA)))./size(allSingleInhPcxAA,1));
barwitherr(sem_p_singleInh, mean_p_singleInh, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])


esp = pcxNM.esp;
n_odors = 13;
allSingleExcPcxNM = [];
allSingleInhPcxNM = [];
for idxExp = 1 : length(esp)
    esperimento = esperimento + 1;
    excRespPcx(esperimento,:) = [0 0];
    inhRespPcx(esperimento,:) = [0 0];
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    excRespPcx(esperimento,1) = excRespPcx(esperimento,1) + 13;
                    inhRespPcx(esperimento,1) = inhRespPcx(esperimento,1) + 13;
                    appExcResp = zeros(1,n_odors);
                    appInhResp = zeros(1,n_odors);
                    for idxOdor = 1:n_odors
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                            responsiveTrialsPcx = [responsiveTrialsPcx; double(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).trialExcPeak1000ms)];
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            excRespPcx(esperimento,2) = excRespPcx(esperimento,2) + 1;
                            appExcResp(idxOdor) = 1;
                        end
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                            inhRespPcx(esperimento,2) = inhRespPcx(esperimento,2) + 1;
                            appInhResp(idxOdor) = 1;
                        end
                    end
                    if sum(appExcResp) == 1
                        allSingleExcPcxNM = [allSingleExcPcxNM; appExcResp];
                    end
                    if sum(appInhResp) == 1
                        allSingleInhPcxNM = [allSingleInhPcxNM; appInhResp];
                    end
                end
            end
        end
    end
end
figure
mean_p_singleExc = mean(allSingleExcPcxNM);
sem_p_singleExc = sqrt((mean(allSingleExcPcxNM).*(1-mean(allSingleExcPcxNM)))./size(allSingleExcPcxNM,1));
barwitherr(sem_p_singleExc, mean_p_singleExc, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])
figure
mean_p_singleInh = mean(allSingleInhPcxNM);
sem_p_singleInh = sqrt((mean(allSingleInhPcxNM).*(1-mean(allSingleInhPcxNM)))./size(allSingleInhPcxNM,1));
barwitherr(sem_p_singleInh, mean_p_singleInh, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])


%%
pExcitatoryResponsesPcx = excRespPcx(:,2)./excRespPcx(:,1);
mean_pExcitatoryResponsesPcx = mean(pExcitatoryResponsesPcx);
sem_pExcitatoryResponsesPcx = std(pExcitatoryResponsesPcx)./sqrt(length(pExcitatoryResponsesPcx-1));

pInhibitoryResponsesPcx = inhRespPcx(:,2)./inhRespPcx(:,1);
mean_pInhibitoryResponsesPcx = mean(pInhibitoryResponsesPcx);
sem_pInhibitoryResponsesPcx = std(pInhibitoryResponsesPcx)./sqrt(length(pInhibitoryResponsesPcx-1));

pExcitatoryResponsesCoa = excRespCoa(:,2)./excRespCoa(:,1);
mean_pExcitatoryResponsesCoa = mean(pExcitatoryResponsesCoa);
sem_pExcitatoryResponsesCoa = std(pExcitatoryResponsesCoa)./sqrt(length(pExcitatoryResponsesCoa-1));

pInhibitoryResponsesCoa = inhRespCoa(:,2)./inhRespCoa(:,1);
mean_pInhibitoryResponsesCoa = mean(pInhibitoryResponsesCoa);
sem_pInhibitoryResponsesCoa = std(pInhibitoryResponsesCoa)./sqrt(length(pInhibitoryResponsesCoa-1));



meanExc = [mean_pExcitatoryResponsesCoa mean_pExcitatoryResponsesPcx];
semExc = [sem_pExcitatoryResponsesCoa sem_pExcitatoryResponsesPcx];
meanInh = [mean_pInhibitoryResponsesCoa mean_pInhibitoryResponsesPcx];
semInh = [sem_pInhibitoryResponsesCoa sem_pInhibitoryResponsesPcx];
means = [meanExc;meanInh];
sems = [ semExc; semInh];
figure
b = barwitherr(sems, means);
b(1).EdgeColor = coaC;
b(1).FaceColor = coaC;
b(2).EdgeColor = pcxC;
b(2).FaceColor = pcxC;

set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
meanExc
sum(excRespCoa(:,2))./sum(excRespCoa(:,1))
sum(excRespPcx(:,2))./sum(excRespPcx(:,1))
[h,p, chi2stat,df] = prop_test([sum(excRespCoa(:,2)) sum(excRespPcx(:,2))], [sum(excRespCoa(:,1)) sum(excRespPcx(:,1))], 0)
meanInh
[h,p, chi2stat,df] = prop_test([sum(inhRespCoa(:,2)) sum(inhRespPcx(:,2))], [sum(inhRespCoa(:,1)) sum(inhRespPcx(:,1))], 0)
%%
mean_responsiveTrialsPcx = nanmean(responsiveTrialsPcx);
sem_responsiveTrialsPcx = sqrt((nanmean(responsiveTrialsPcx) .* (1-nanmean(responsiveTrialsPcx))) ./ (size(responsiveTrialsPcx,1)-1));

mean_responsiveTrialsCoa = nanmean(responsiveTrialsCoa);
sem_responsiveTrialsCoa = sqrt((nanmean(responsiveTrialsCoa) .* (1-nanmean(responsiveTrialsCoa))) ./ (size(responsiveTrialsCoa,1)-1));

figure
errorbar(mean_responsiveTrialsCoa, sem_responsiveTrialsCoa, '-o', 'color', coaC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0.5 1])
xlim([0 11])
ylabel('Fraction of Excitatory Responses')
xlabel('Trials')
figure
errorbar(mean_responsiveTrialsPcx, sem_responsiveTrialsPcx, '-o', 'color', pcxC)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0.5 1])
xlim([0 11])
ylabel('Fraction of Excitatory Responses')
xlabel('Trials')

%% average response in early 5 and late 5 trials
c = 0;
u = 0;
esp = coa15.esp;
for idxExp = 1 : length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    c = c + 1;
                    for idxOdor = 1:15
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            u = u + 1;
                        end
                    end
                end
            end
        end
    end
end



esp = coaNM.esp;
for idxExp = 1 : length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    c = c + 1;
                    for idxOdor = 1:13
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            u = u + 1;
                        end
                    end
                end
            end
        end
    end
end

responsesEarlyLateCoa = nan(u,2);
responsesEarlyLatePCoa = zeros(u,2);

c = 0;
u = 0;
esp = coa15.esp;
for idxExp = 1 : length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    c = c + 1;
                    for idxOdor = 1:15
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            u = u + 1;
                            responsesEarlyLateCoa(u,1) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(1:5))-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms(1:5));
                            responsesEarlyLateCoa(u,2) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(6:10))-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms(6:10));
                            responsesEarlyLatePCoa(u,1) = ttest2(responsesEarlyLateCoa(u,1), responsesEarlyLateCoa(u,2));
                            if responsesEarlyLatePCoa(u,1) < 0.05
                                if (responsesEarlyLateCoa(u,1) - responsesEarlyLateCoa(u,2)) > 0
                                    responsesEarlyLatePCoa(u,2) = 1;
                                else
                                    responsesEarlyLatePCoa(u,2) = -1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end




esp = coaNM.esp;
for idxExp = 1 : length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    c = c + 1;
                    for idxOdor = 1:13
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            u = u + 1;
                            responsesEarlyLateCoa(u,1) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(1:5))-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms(1:5));
                            responsesEarlyLateCoa(u,2) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(6:10))-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms(6:10));
                             responsesEarlyLatePCoa(u,1) = ttest2(responsesEarlyLateCoa(u,1), responsesEarlyLateCoa(u,2));
                            if responsesEarlyLatePCoa(u,1) < 0.05
                                if (responsesEarlyLateCoa(u,1) - responsesEarlyLateCoa(u,2)) > 0
                                    responsesEarlyLatePCoa(u,2) = 1;
                                else
                                    responsesEarlyLatePCoa(u,2) = -1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

%%
c = 0;
u = 0;
esp = pcx15.esp;
for idxExp = 1 : length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    c = c + 1;
                    for idxOdor = 1:15
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            u = u + 1;
                        end
                    end
                end
            end
        end
    end
end


esp = pcxNM.esp;
for idxExp = 1 : length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    c = c + 1;
                    for idxOdor = 1:13
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            u = u + 1;
                        end
                    end
                end
            end
        end
    end
end


responsesEarlyLatePcx = nan(u,2);
responsesEarlyLatePPcx = zeros(u,2);
c = 0;
u = 0;
esp = pcx15.esp;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    c = c + 1;
                    for idxOdor = 1:15
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            u = u + 1;
                            responsesEarlyLatePcx(u,1) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(1:5))-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms(1:5));
                            responsesEarlyLatePcx(u,2) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(6:10))-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms(6:10));
                             responsesEarlyLatePPcx(u,1) = ttest2(responsesEarlyLatePcx(u,1), responsesEarlyLatePcx(u,2));
                            if responsesEarlyLatePPcx(u,1) < 0.05
                                if (responsesEarlyLatePcx(u,1) - responsesEarlyLatePcx(u,2)) > 0
                                    responsesEarlyLatePPcx(u,2) = 1;
                                else
                                    responsesEarlyLatePPcx(u,2) = -1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end



esp = pcxNM.esp;
for idxExp = 1 : length(pcxNM.esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    c = c + 1;
                    for idxOdor = 1:13
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            u = u + 1;
                            responsesEarlyLatePcx(u,1) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(1:5))-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms(1:5));
                            responsesEarlyLatePcx(u,2) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(6:10))-...
                                mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms(6:10));
                            responsesEarlyLatePPcx(u,1) = ttest2(responsesEarlyLatePcx(u,1), responsesEarlyLatePcx(u,2));
                            if responsesEarlyLatePPcx(u,1) < 0.05
                                if (responsesEarlyLatePcx(u,1) - responsesEarlyLatePcx(u,2)) > 0
                                    responsesEarlyLatePPcx(u,2) = 1;
                                else
                                    responsesEarlyLatePPcx(u,2) = -1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[440 86 560 712]);
labels = {'1-5', '6-10'};
my_ttest2_boxplot(responsesEarlyLateCoa(:,1), responsesEarlyLateCoa(:,2), coaC, labels);
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

[h, p, ci, stats] = ttest(responsesEarlyLateCoa(:,1), responsesEarlyLateCoa(:,2))
decreasingCoa = sum(responsesEarlyLatePCoa(:,2)>0)./size(responsesEarlyLatePCoa,1)
increasingCoa = sum(responsesEarlyLatePCoa(:,2)<0)./size(responsesEarlyLatePCoa,1)
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[440 86 560 712]);
labels = {'1-5', '6-10'};
my_ttest2_boxplot(responsesEarlyLatePcx(:,1), responsesEarlyLatePcx(:,2), pcxC, labels);
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

[h, p, ci, stats] = ttest(responsesEarlyLatePcx(:,1), responsesEarlyLatePcx(:,2))
decreasingPcx = sum(responsesEarlyLatePPcx(:,2)>0)./size(responsesEarlyLatePPcx,1)
increasingPcx = sum(responsesEarlyLatePPcx(:,2)<0)./size(responsesEarlyLatePPcx,1)


%% Fraction of excited neurons per odor
nOdors = 13;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaNM.esp, 1:nOdors, 0.5, 1);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxNM.esp, 1:nOdors, 0.5, 1);

pExcRespNeuronOdorCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa', 1,nOdors);
pInhRespNeuronOdorCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa', 1,nOdors);
meanExcCoaNM = mean(pExcRespNeuronOdorCoa);
semExcCoaNM = std(pExcRespNeuronOdorCoa)./sqrt(size(pExcRespNeuronOdorCoa,1)-1);
meanInhCoaNM = mean(pInhRespNeuronOdorCoa);
semInhCoaNM = std(pInhRespNeuronOdorCoa)./sqrt(size(pInhRespNeuronOdorCoa,1)-1);

pExcRespNeuronOdorPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx', 1,nOdors);
pInhRespNeuronOdorPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx', 1,nOdors);
meanExcPcxNM = mean(pExcRespNeuronOdorPcx);
semExcPcxNM = std(pExcRespNeuronOdorPcx)./sqrt(size(pExcRespNeuronOdorPcx,1)-1);
meanInhPcxNM = mean(pInhRespNeuronOdorPcx);
semInhPcxNM = std(pInhRespNeuronOdorPcx)./sqrt(size(pInhRespNeuronOdorPcx,1)-1);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semExcCoaNM, meanExcCoaNM, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semInhCoaNM, meanInhCoaNM, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semExcPcxNM, meanExcPcxNM, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semInhPcxNM, meanInhPcxNM, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
%%
nOdors = 15;
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coa15.esp, 1:nOdors, 0.5, 1);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcx15.esp, 1:nOdors, 0.5, 1);

pExcRespNeuronOdorCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa', 1,nOdors);
pInhRespNeuronOdorCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa', 1,nOdors);
meanExcCoa15 = mean(pExcRespNeuronOdorCoa);
semExcCoa15 = std(pExcRespNeuronOdorCoa)./sqrt(size(pExcRespNeuronOdorCoa,1)-1);
meanInhCoa15 = mean(pInhRespNeuronOdorCoa);
semInhCoa15= std(pInhRespNeuronOdorCoa)./sqrt(size(pInhRespNeuronOdorCoa,1)-1);

pExcRespNeuronOdorPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx', 1,nOdors);
pInhRespNeuronOdorPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx', 1,nOdors);
meanExcPcx15 = mean(pExcRespNeuronOdorPcx);
semExcPcx15= std(pExcRespNeuronOdorPcx)./sqrt(size(pExcRespNeuronOdorPcx,1)-1);
meanInhPcx15 = mean(pInhRespNeuronOdorPcx);
semInhPcx15 = std(pInhRespNeuronOdorPcx)./sqrt(size(pInhRespNeuronOdorPcx,1)-1);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semExcCoa15, meanExcCoa15, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semInhCoa15, meanInhCoa15, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semExcPcx15, meanExcPcx15, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semInhPcx15, meanInhPcx15, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])

%%
odors = [4     6     7     9    10     1     2     3     5     8];
nOdors = length(odors);
[totalSUACoa, totalResponsiveSUACoa, totalResponsiveNeuronPerOdorCoa, totalSUAExpCoa] = findNumberOfSua(coaAA.esp, odors, 1, 1);
[totalSUAPcx, totalResponsiveSUAPcx, totalResponsiveNeuronPerOdorPcx, totalSUAExpPcx] = findNumberOfSua(pcxAA.esp, odors, 1, 1);

pExcRespNeuronOdorCoa = totalResponsiveNeuronPerOdorCoa.idxExc.idxO1 ./ repmat(totalSUAExpCoa', 1,nOdors);
pInhRespNeuronOdorCoa = totalResponsiveNeuronPerOdorCoa.idxInh.idxO1 ./ repmat(totalSUAExpCoa', 1,nOdors);
meanExcCoaAA = mean(pExcRespNeuronOdorCoa);
semExcCoaAA = std(pExcRespNeuronOdorCoa)./sqrt(size(pExcRespNeuronOdorCoa,1)-1);
meanInhCoaAA = mean(pInhRespNeuronOdorCoa);
semInhCoaAA = std(pInhRespNeuronOdorCoa)./sqrt(size(pInhRespNeuronOdorCoa,1)-1);

pExcRespNeuronOdorPcx = totalResponsiveNeuronPerOdorPcx.idxExc.idxO1 ./ repmat(totalSUAExpPcx', 1,nOdors);
pInhRespNeuronOdorPcx = totalResponsiveNeuronPerOdorPcx.idxInh.idxO1 ./ repmat(totalSUAExpPcx', 1,nOdors);
meanExcPcxAA = mean(pExcRespNeuronOdorPcx);
semExcPcxAA = std(pExcRespNeuronOdorPcx)./sqrt(size(pExcRespNeuronOdorPcx,1)-1);
meanInhPcxAA = mean(pInhRespNeuronOdorPcx);
semInhPcxAA = std(pInhRespNeuronOdorPcx)./sqrt(size(pInhRespNeuronOdorPcx,1)-1);

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semExcCoaAA, meanExcCoaAA, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semInhCoaAA, meanInhCoaAA, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semExcPcxAA, meanExcPcxAA, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
barwitherr(semInhPcxAA, meanInhPcxAA, 'EdgeColor', pcxC, 'FaceColor', pcxC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.35])
%%
sniffLength1 = findSniffLength(coa15.esp);
sniffLength2 = findSniffLength(coaAA.esp);
sniffLength3 = findSniffLength(pcx15.esp);
sniffLength4 = findSniffLength(pcxAA.esp);
%%
sniffLength5 = findSniffLength(coaNM.esp);
sniffLength6 = findSniffLength(coaCS2.esp);
sniffLength7 = findSniffLength(pcxNM.esp);
sniffLength8 = findSniffLength(pcxCS2.esp);
%%
sniffLength = [sniffLength1 sniffLength2 sniffLength3 sniffLength4 sniffLength5 sniffLength6 sniffLength7 sniffLength8];
[fi, xi] = ksdensity(sniffLength);
figure
plot(xi, fi, '-k', 'linewidth', 2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%% LFP power
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
meanB = mean(betaR1(:,1:15));
semB = std(betaR1)./sqrt(size(betaR1,1)-1);
barwitherr(semB, meanB, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
meanB = mean(abs(gammaR1(:,1:15)));
semB = std(abs(gammaR1(:,1:15)))./sqrt(size(gammaR1,1)-1);
barwitherr(semB, meanB, 'EdgeColor', coaC, 'FaceColor', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%% Fano Factor
M15p = find_Baseline_DeltaRsp_FanoFactor_new(pcx15.esp, 1:15, 1000, 0);
M15c = find_Baseline_DeltaRsp_FanoFactor_new(coa15.esp, 1:15, 1000, 0);
Mnmp = find_Baseline_DeltaRsp_FanoFactor_new(pcxNM.esp, 1:15, 1000, 0);
Mnmc = find_Baseline_DeltaRsp_FanoFactor_new(coaNM.esp, 1:15, 1000, 0);
%%
ffCOA15 = M15c.ff;
ffPCX15 = M15p.ff;
sigCOA15 = M15c.significance;
sigPCX15 = M15p.significance;

ffCOA15 = ffCOA15(:);
ffPCX15 = ffPCX15(:);
sigCOA15 = logical(sigCOA15(:));
sigPCX15 = logical(sigPCX15(:));


ffCOAnm = Mnmc.ff;
ffPCXnm = Mnmp.ff;
sigCOAnm = Mnmc.significance;
sigPCXnm = Mnmp.significance;

ffCOAnm = ffCOAnm(:);
ffPCXnm = ffPCXnm(:);
sigCOAnm = logical(sigCOAnm(:));
sigPCXnm = logical(sigPCXnm(:));




allffCoa = [ffCOA15; ffCOAnm];
allffPcx = [ffPCX15; ffPCXnm];
allSigCoa = [sigCOA15; sigCOAnm];
allSigPcx = [sigPCX15; sigPCXnm];

%%
[fiCoa xiCoa] = ksdensity(allffCoa);
[fiPcx xiPcx] = ksdensity(allffPcx);
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(xiCoa, fiCoa, 'color', coaC, 'linewidth', 1) 
hold on
plot(xiPcx, fiPcx, 'color', pcxC, 'linewidth', 1) 
ylabel('Fraction of Responses')
xlabel('Fano Factor')
axis tight
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
figure
x = {allffCoa allffPcx};
g = [zeros(1,length(allffCoa)), ones(1,length(allffPcx))];
plotSpread(x, 'categoryIdx', g, 'categoryColors', [coaC; pcxC], 'showMM', 3)
ylabel('Information (bits)')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
clear data
lratio = 0.5;
odors = 1:15;
params.boxwidth = 100;
params.alignTime = 4000;
esp = [];
espe = [];
esp = pcx15.esp;
espe = pcx15_1.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
            if ~isempty(esp(idxExp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                for idxOdor = odors
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                            c = c + 1;
                            data(c).spikes = double(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
                    end
                end
            end
        end
    end
    end
end
esp = pcxNM.esp;
espe = pcxNM_1.espe;
for idxExp =  1:length(esp)
    for idxShank = 1:4
            if ~isempty(esp(idxExp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                for idxOdor = odors
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                            c = c + 1;
                            data(c).spikes = double(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
                    end
                end
            end
        end
    end
    end
end
c
ResultPcx1000 = VarVsMean(data, 3000:50:7000, params);


odors = 1:15;
esp = coa15.esp;
espe = coa15_1.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
            if ~isempty(esp(idxExp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                for idxOdor = odors
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                            c = c + 1;
                            data(c).spikes = double(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
                    end
                end
            end
        end
    end
    end
end
esp = coaNM.esp;
espe = coaNM_1.espe;
for idxExp =  1:length(esp)
    for idxShank = 1:4
            if ~isempty(esp(idxExp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                for idxOdor = odors
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                            c = c + 1;
                            data(c).spikes = double(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
                    end
                end
            end
        end
    end
    end
end
c
ResultCoa1000 = VarVsMean(data, 3000:50:7000, params);

%%
figure;
shadedErrorBar(ResultCoa1000.times, smooth(ResultCoa1000.FanoFactor, 10, 'loess'), ResultCoa1000.Fano_95CIs, 'r');
hold on
shadedErrorBar(ResultPcx1000.times, smooth(ResultPcx1000.FanoFactor, 10, 'loess'), ResultPcx1000.Fano_95CIs, 'b');
alpha('0.5')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
figure;
plot(ResultCoa1000.times, smooth(ResultCoa1000.FanoFactor, 10, 'loess'), 'color', coaC, 'linewidth', 2);
hold on
plot(ResultPcx1000.times, smooth(ResultPcx1000.FanoFactor, 10, 'loess'), 'color', pcxC, 'linewidth', 2);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%



%%
odors = [1 2 3 11 12 13 4 5 6 8 9 10 7 14 15];
[odorCorrelationsCoa15] = findCorrelationsOdors_new(coa15.esp, odors);
[ odorCorrelationsPcx15] = findCorrelationsOdors_new(pcx15.esp, odors);
figure
scatter(odorCorrelationsCoa15(:), odorCorrelationsPcx15(:))
axis square

[rho, pVal] = corr(odorCorrelationsCoa15(:), odorCorrelationsPcx15(:))


%%
odors = 1:15;
[ odorCorrelationsCoaCS] = findCorrelationsOdors_new(coaCS2.esp, odors);
[odorCorrelationsPcxCS] = findCorrelationsOdors_new(pcxCS2.esp, odors);
figure
scatter(odorCorrelationsCoaCS(:), odorCorrelationsPcxCS(:))
axis square

[rho, pVal] = corr(odorCorrelationsCoaCS(:), odorCorrelationsPcxCS(:))

%%
odors = 1:13;
odorCorrelationsCoaNM = findCorrelationsOdors_new(coaNM.esp, odors);
odorCorrelationsPcxNM = findCorrelationsOdors_new(pcxNM.esp, odors);

[rho, pVal] = corr(odorCorrelationsCoaNM(:), odorCorrelationsPcxNM(:));



figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
scatter(odorCorrelationsCoaNM(:), odorCorrelationsPcxNM(:), [], 'k', 'filled')
axis square
xlabel('Odors in plCoA')
ylabel('Odors in aPCx')
title('correlation: 0.34 - p < 0.01')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
odors = 1:10;
odorCorrelationsCoaAA = findCorrelationsOdors_new(coaAA.esp, odors);
odorCorrelationsPcxAA = findCorrelationsOdors_new(pcxAA.esp, odors);

figure
scatter(odorCorrelationsCoaAA(:), odorCorrelationsPcxAA(:))
axis square

[rho, pVal] = corr(odorCorrelationsCoaAA(:), odorCorrelationsPcxAA(:))
%%
coaOdors = [odorCorrelationsCoa15(:); odorCorrelationsCoaNM(:)];
pcxOdors = [odorCorrelationsPcx15(:); odorCorrelationsPcxNM(:)];

[rho, pVal] = corr(coaOdors(:), pcxOdors(:))


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
scatter(coaOdors(:), pcxOdors(:), [], 'k', 'filled')
axis square
xlabel('Odors in plCoA')
ylabel('Odors in aPCx')
title('correlation: 0.26 - p < 0.001')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
ce15 = mean(allSingleExcCoa15);  
ci15 = mean(allSingleInhCoa15);
ceAA = mean(allSingleExcCoaAA);
ciAA = mean(allSingleInhCoaAA);
ceNM = mean(allSingleExcCoaNM);
ciNM = mean(allSingleInhCoaNM);

pe15 = mean(allSingleExcPcx15);
pi15 = mean(allSingleInhPcx15);
peAA = mean(allSingleExcPcxAA);
piAA = mean(allSingleInhPcxAA);
peNM = mean(allSingleExcPcxNM);
piNM = mean(allSingleInhPcxNM);

ce = [ce15 ceAA ceNM];
ci = [ci15 ciAA ciNM];
pe = [pe15 peAA peNM];
pi = [pi15 piAA piNM];

edges = 0 : 0.05 : 0.4;
%%
figure
histogram(ce, edges, 'normalization', 'probability', 'EdgeColor', 'w', 'FaceColor', coaC, 'EdgeAlpha', 1, 'FaceAlpha', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])

figure
histogram(ci, edges, 'normalization', 'probability', 'EdgeColor', 'w', 'FaceColor', coaC, 'EdgeAlpha', 1, 'FaceAlpha', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])

figure
histogram(pe, edges, 'normalization', 'probability', 'EdgeColor', 'w', 'FaceColor', pcxC, 'EdgeAlpha', 1, 'FaceAlpha', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])

figure
histogram(pi, edges, 'normalization', 'probability', 'EdgeColor', 'w', 'FaceColor', pcxC, 'EdgeAlpha', 1, 'FaceAlpha', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])
%%
pEpcx = [meanExcPcx15 meanExcPcxAA meanExcPcxNM];
pIpcx = [meanInhPcx15 meanInhPcxAA meanInhPcxNM];

pEcoa = [meanExcCoa15 meanExcCoaAA meanExcCoaNM];
pIcoa= [meanInhCoa15 meanInhCoaAA meanInhCoaNM];
%%
edges = 0 : 0.05 : 0.3;
figure
histogram(pEcoa, edges, 'normalization', 'probability', 'EdgeColor', 'w', 'FaceColor', coaC, 'EdgeAlpha', 1, 'FaceAlpha', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])

figure
histogram(pIcoa, edges, 'normalization', 'probability', 'EdgeColor', 'w', 'FaceColor', coaC, 'EdgeAlpha', 1, 'FaceAlpha', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])

figure
histogram(pEpcx, edges, 'normalization', 'probability', 'EdgeColor', 'w', 'FaceColor', pcxC, 'EdgeAlpha', 1, 'FaceAlpha', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])

figure
histogram(pIpcx, edges, 'normalization', 'probability', 'EdgeColor', 'w', 'FaceColor', pcxC, 'EdgeAlpha', 1, 'FaceAlpha', 1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
ylim([0 0.5])





