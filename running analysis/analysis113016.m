coaC = [228,26,28] ./ 255;
pcxC = [55,126,184]./255;
%%
pcxAA = load('aPCx_AAmix_2.mat');
pcx15 = load('aPCx_15_2.mat');
coa15 = load('plCoA_15_2.mat');
coaAA = load('plCoA_AAmix_2.mat');
pcxNM = load('aPCx_natMix_2.mat');
coaNM = load('plCoA_natMix_2.mat');
coaCS1 = load('plCoA_CS1_2.mat');
coaCS2 = load('plCoA_CS2_2.mat');
pcxCS2 = load('aPCx_CS2_2.mat');
pcxCS1 = load('aPCx_CS1_2.mat');

pcxAA_1 = load('aPCx_AAmix_1.mat');
pcx15_1 = load('aPCx_15_1.mat');
coa15_1 = load('plCoA_15_1.mat');
coaAA_1 = load('plCoA_AAmix_1.mat');
pcxNM_1 = load('aPCx_natMix_1.mat');
coaNM_1 = load('plCoA_natMix_1.mat');
coaCS1_1 = load('plCoA_CS1_1.mat');
coaCS2_1 = load('plCoA_CS2_1.mat');
pcxCS2_1 = load('aPCx_CS2_1.mat');
pcxCS1_1 = load('aPCx_CS1_1.mat');
%%
l_ratio = [];
isolation_distance = [];
snr = [];
[lr, id, sn] = retrieveQualityMetrics(pcxAA.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(pcx15.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(pcxNM.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(pcxCS1.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(pcxCS2.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(coaAA.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(coa15.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(coaNM.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(coaCS1.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];
[lr, id, sn] = retrieveQualityMetrics(coaCS2.esp);
l_ratio = [l_ratio lr];
isolation_distance = [isolation_distance id];
snr = [snr sn];

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[34 145 1317 655]);
subplot(2,3,4)
scatter(snr, l_ratio, [], 'k')
title('SNR vs L-ratio')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
subplot(2,3,5)
scatter(snr, isolation_distance, [], 'k')
ylim([0 100])
title('SNR vs Isolation Distance')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
subplot(2,3,6)
scatter(l_ratio, isolation_distance, [], 'k')
ylim([0 100])
title('L-ratio vs Isolation Distance')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

subplot(2,3,1)
histogram(snr(snr<40), 50)
title('SNR')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

subplot(2,3,2)
histogram(l_ratio(l_ratio<40), 50)
title('L-ratio')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

subplot(2,3,3)
histogram(isolation_distance(isolation_distance<100), 50)
title('Isolation Distance')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
sniff_modulation_index_pcx15 = retrieveSniffModulationIndex(pcx15.esp);
sniff_modulation_index_pcxAA = retrieveSniffModulationIndex(pcxAA.esp);
sniff_modulation_index_pcxNM = retrieveSniffModulationIndex(pcxNM.esp);
sniff_modulation_index_pcxCS1 = retrieveSniffModulationIndex(pcxCS1.esp);
sniff_modulation_index_pcxCS2 = retrieveSniffModulationIndex(pcxCS2.esp);
smiPcx = [sniff_modulation_index_pcx15 sniff_modulation_index_pcxAA sniff_modulation_index_pcxNM sniff_modulation_index_pcxCS1 sniff_modulation_index_pcxCS2];

sniff_modulation_index_coa15 = retrieveSniffModulationIndex(coa15.esp);
sniff_modulation_index_coaAA = retrieveSniffModulationIndex(coaAA.esp);
sniff_modulation_index_coaNM = retrieveSniffModulationIndex(coaNM.esp);
sniff_modulation_index_coaCS1 = retrieveSniffModulationIndex(coaCS1.esp);
sniff_modulation_index_coaCS2 = retrieveSniffModulationIndex(coaCS2.esp);
smiCoa = [sniff_modulation_index_coa15 sniff_modulation_index_coaAA sniff_modulation_index_coaNM sniff_modulation_index_coaCS1 sniff_modulation_index_coaCS2];
%%
figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
% subplot(1,2,1)
[f, xi] = ksdensity(smiPcx, 'bandwidth', 0.1);
plot(xi, smooth(f,3), 'color', 'k');
% histogram(smiPcx, 200)
% ylim([0 10])
% xlim([0 50])
% set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
hold on
[f, xi] = ksdensity(smiCoa(smiCoa<500), 'bandwidth', 0.1);
plot(xi, smooth(f,3), 'color', 'r');
% histogram(smiCoa, 200)
ylim([0 0.025])
xlim([0 30])
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
%%
[trough_to_peak_ratio_pcx15, trough_to_peak_time_pcx15, half_amplitude_duration_pcx15] = retrieveSpikeFeatures(pcx15.esp);
[trough_to_peak_ratio_pcxAA, trough_to_peak_time_pcxAA, half_amplitude_duration_pcxAA] = retrieveSpikeFeatures(pcxAA.esp);
[trough_to_peak_ratio_pcxNM, trough_to_peak_time_pcxNM, half_amplitude_duration_pcxNM] = retrieveSpikeFeatures(pcxNM.esp);
[trough_to_peak_ratio_pcxCS1, trough_to_peak_time_pcxCS1, half_amplitude_duration_pcxCS1] = retrieveSpikeFeatures(pcxCS1.esp);
[trough_to_peak_ratio_pcxCS2, trough_to_peak_time_pcxCS2, half_amplitude_duration_pcxCS2] = retrieveSpikeFeatures(pcxCS2.esp);
trough_to_peak_ratio_pcx = [trough_to_peak_ratio_pcx15 trough_to_peak_ratio_pcxAA trough_to_peak_ratio_pcxNM trough_to_peak_ratio_pcxCS1 trough_to_peak_ratio_pcxCS2];
trough_to_peak_time_pcx = [trough_to_peak_time_pcx15 trough_to_peak_time_pcxAA trough_to_peak_time_pcxNM trough_to_peak_time_pcxCS1 trough_to_peak_time_pcxCS2];
half_amplitude_duration_pcx = [half_amplitude_duration_pcx15 half_amplitude_duration_pcxAA half_amplitude_duration_pcxNM half_amplitude_duration_pcxCS1 half_amplitude_duration_pcxCS2];



[trough_to_peak_ratio_coa15, trough_to_peak_time_coa15, half_amplitude_duration_coa15] = retrieveSpikeFeatures(coa15.esp);
[trough_to_peak_ratio_coaAA, trough_to_peak_time_coaAA, half_amplitude_duration_coaAA] = retrieveSpikeFeatures(coaAA.esp);
[trough_to_peak_ratio_coaNM, trough_to_peak_time_coaNM, half_amplitude_duration_coaNM] = retrieveSpikeFeatures(coaNM.esp);
[trough_to_peak_ratio_coaCS1, trough_to_peak_time_coaCS1, half_amplitude_duration_coaCS1] = retrieveSpikeFeatures(coaCS1.esp);
[trough_to_peak_ratio_coaCS2, trough_to_peak_time_coaCS2, half_amplitude_duration_coaCS2] = retrieveSpikeFeatures(coaCS2.esp);
trough_to_peak_ratio_coa = [trough_to_peak_ratio_coa15 trough_to_peak_ratio_coaAA trough_to_peak_ratio_coaNM trough_to_peak_ratio_coaCS1 trough_to_peak_ratio_coaCS2];
trough_to_peak_time_coa = [trough_to_peak_time_coa15 trough_to_peak_time_coaAA trough_to_peak_time_coaNM trough_to_peak_time_coaCS1 trough_to_peak_time_coaCS2];
half_amplitude_duration_coa = [half_amplitude_duration_coa15 half_amplitude_duration_coaAA half_amplitude_duration_coaNM half_amplitude_duration_coaCS1 half_amplitude_duration_coaCS2];

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
dat = [trough_to_peak_ratio_coa', trough_to_peak_time_coa'];
n = hist3(dat, [75 75]);
n = n/size(dat,1);
n1 = n';
n1(size(n,1) + 1, size(n,2) + 1) = 0;
xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);
h = pcolor(xb,yb,n1);
h.ZData = ones(size(n1)) * -max(max(n));
colormap(hot) % heat map
xlabel('trough-to-peak amplitude ratio')
ylabel('trough-to-peak time (ms)')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
dat = [trough_to_peak_ratio_pcx', trough_to_peak_time_pcx'];
n = hist3(dat, [75 75]);
n = n/size(dat,1);
n1 = n';
n1(size(n,1) + 1, size(n,2) + 1) = 0;
xb = linspace(min(dat(:,1)),max(dat(:,1)),size(n,1)+1);
yb = linspace(min(dat(:,2)),max(dat(:,2)),size(n,1)+1);
h = pcolor(xb,yb,n1);
h.ZData = ones(size(n1)) * -max(max(n));
colormap(hot) % heat map
xlabel('trough-to-peak amplitude ratio')
ylabel('trough-to-peak time (ms)')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%%
[ls300Coa15, ls1000Coa15] = retrieveLifetimeSparseness(coa15.esp);
[ls300CoaNM, ls1000CoaNM] = retrieveLifetimeSparseness(coaNM.esp);
[ls300Pcx15, ls1000Pcx15] = retrieveLifetimeSparseness(pcx15.esp);
[ls300PcxNM, ls1000PcxNM] = retrieveLifetimeSparseness(pcxNM.esp);

[i300Coa15, i1000Coa15] = retrievePoissonInformation(coa15.esp);
[i300CoaNM, i1000CoaNM] = retrievePoissonInformation(coaNM.esp);
[i300Pcx15, i1000Pcx15] = retrievePoissonInformation(pcx15.esp);
[i300PcxNM, i1000PcxNM] = retrievePoissonInformation(pcxNM.esp);

[trough_to_peak_ratio_coa15, trough_to_peak_time_coa15, half_amplitude_duration_coa15] = retrieveSpikeFeatures(coa15.esp);
[trough_to_peak_ratio_coaNM, trough_to_peak_time_coaNM, half_amplitude_duration_coaNM] = retrieveSpikeFeatures(coaNM.esp);
[trough_to_peak_ratio_pcx15, trough_to_peak_time_pcx15, half_amplitude_duration_pcx15] = retrieveSpikeFeatures(pcx15.esp);
[trough_to_peak_ratio_pcxNM, trough_to_peak_time_pcxNM, half_amplitude_duration_pcxNM] = retrieveSpikeFeatures(pcxNM.esp);


ls300Coa = [ls300Coa15 ls300CoaNM];
ls1000Coa = [ls1000Coa15 ls1000CoaNM];
ls300Pcx = [ls300Pcx15 ls300PcxNM];
ls1000Pcx = [ls1000Pcx15 ls1000PcxNM];
i300Coa = [i300Coa15 i300CoaNM];
i1000Coa = [i1000Coa15 i1000CoaNM];
i300Pcx = [i300Pcx15 i300PcxNM];
i1000Pcx = [i1000Pcx15 i1000PcxNM];
trough_to_peak_time_coa = [trough_to_peak_time_coa15 trough_to_peak_time_coaNM];
trough_to_peak_time_pcx = [trough_to_peak_time_pcx15 trough_to_peak_time_pcxNM];
smiPcx = [sniff_modulation_index_pcx15 sniff_modulation_index_pcxNM];
smiCoa = [sniff_modulation_index_coa15 sniff_modulation_index_coaNM];

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
subplot(1,2,1)
scatter(ls300Coa, trough_to_peak_time_coa, [], coaC)
hold on
scatter(ls300Pcx, trough_to_peak_time_pcx, [], pcxC)
xlabel('lifetime sparseness')
ylabel('trough-to-peak time (ms)')
title('first sniff')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
subplot(1,2,2)
scatter(ls1000Coa, trough_to_peak_time_coa, [], coaC)
hold on
scatter(ls1000Pcx, trough_to_peak_time_pcx, [], pcxC)
title('first second')
xlabel('lifetime sparseness')
ylabel('trough-to-peak time (ms)')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)


figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
subplot(1,2,1)
scatter(ls300Coa, smiCoa, [], coaC)
hold on
scatter(ls300Pcx, smiPcx, [], pcxC)
xlabel('lifetime sparseness')
ylabel('sniff modulation')
title('first sniff')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
subplot(1,2,2)
scatter(ls1000Coa, smiCoa, [], coaC)
hold on
scatter(ls1000Pcx, smiPcx, [], pcxC)
title('first second')
xlabel('lifetime sparseness')
ylabel('sniff modulation')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
subplot(1,2,1)
scatter(i300Coa, smiCoa, [], coaC)
hold on
scatter(i300Pcx, smiPcx, [], pcxC)
xlabel('bits/spike')
ylabel('sniff modulation')
title('first sniff')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
subplot(1,2,2)
scatter(i1000Coa, smiCoa, [], coaC)
hold on
scatter(i1000Pcx, smiPcx, [], pcxC)
title('first second')
xlabel('bits/spike')
ylabel('sniff modulation')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
scatter3(trough_to_peak_time_coa, smiCoa, ls300Coa, [], coaC)
hold on
scatter3(trough_to_peak_time_pcx, smiPcx, ls300Pcx, [], pcxC)
xlabel('trough-to-peak time (ms)')
ylabel('sniff modulation')
zlabel('lifetime sparseness')
title('first sniff')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)
