LCoa15 = find_Latencies(coa15.esp,odors);
LCoaAA = find_Latencies(coaAA.esp,odors);
LPcx15 = find_Latencies(pcx15.esp,odors);
LPcxAA = find_Latencies(pcxAA.esp,odors);

onsetCoa = [LCoa15.onset; LCoaAA.onset];
onsetPcx = [LPcx15.onset; LPcxAA.onset];

peakCoa = [LCoa15.peak; LCoaAA.peak];
peakPcx = [LPcx15.peak; LPcxAA.peak];

hwCoa = [LCoa15.hw; LCoaAA.hw];
hwPcx = [LPcx15.hw; LPcxAA.hw];

sigCoa = [LCoa15.sig; LCoaAA.sig];
sigPcx = [LPcx15.sig; LPcxAA.sig];

sigCoa = sigCoa(:);
sigPcx = sigPcx(:);

onsetCoa = onsetCoa(:);
onsetPcx = onsetPcx(:);

peakCoa = peakCoa(:);
peakPcx = peakPcx(:);

hwCoa = hwCoa(:);
hwPcx = hwPcx(:);


onsetCoa(sigCoa<1) = nan;
onsetPcx(sigPcx<1) = nan;

peakCoa(sigCoa<1) = nan;
peakPcx(sigPcx<1) = nan;

hwCoa(sigCoa<1) = nan;
hwPcx(sigPcx<1) = nan;


meanOnsetCoa = nanmean(onsetCoa);
semOnsetCoa = nanstd(onsetCoa) ./ sqrt(numel(onsetCoa)-1);
meanOnsetPcx = nanmean(onsetPcx);
semOnsetPcx = nanstd(onsetPcx) ./ sqrt(numel(onsetPcx)-1);

meanPeakCoa = nanmean(peakCoa);
semPeakCoa = nanstd(peakCoa) ./ sqrt(numel(peakCoa)-1);
meanPeakPcx = nanmean(peakPcx);
semPeakPcx = nanstd(peakPcx) ./ sqrt(numel(peakPcx)-1);

meanHwCoa = nanmean(hwCoa);
semHwCoa = nanstd(hwCoa) ./ sqrt(numel(hwCoa)-1);
meanHwPcx = nanmean(hwPcx);
semHwPcx = nanstd(hwPcx) ./ sqrt(numel(hwPcx)-1);


%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
meanX = [meanOnsetCoa' meanPeakCoa' meanHwCoa'];
semX = [semOnsetCoa' semPeakCoa' semHwCoa'];
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
meanY = [meanOnsetPcx' meanPeakPcx' meanHwPcx'];
semY = [semOnsetPcx' semPeakPcx' semHwPcx'];
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
%%

pOnset = ranksum(onsetCoa, onsetPcx)
meanOnset = [meanOnsetCoa meanOnsetPcx]
senOnset = [semOnsetCoa semOnsetPcx]

pPeak = ranksum(peakCoa, peakPcx)
meanPeak = [meanPeakCoa meanPeakPcx]
senPeak = [semPeakCoa semPeakPcx]

pHw = ranksum(hwCoa, hwPcx)
meanHw = [meanHwCoa meanHwPcx]
senHw = [semHwCoa semHwPcx]
