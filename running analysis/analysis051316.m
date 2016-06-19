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
semOnsetCoa = nanstd(onsetCoa) ./ numel(onsetCoa);
meanOnsetPcx = nanmean(onsetPcx);
semOnsetPcx = nanstd(onsetPcx) ./ numel(onsetPcx);

meanPeakCoa = nanmean(peakCoa);
semPeakCoa = nanstd(peakCoa) ./ numel(peakCoa);
meanPeakPcx = nanmean(peakPcx);
semPeakPcx = nanstd(peakPcx) ./ numel(peakPcx);

meanHwCoa = nanmean(hwCoa);
semHwCoa = nanstd(hwCoa) ./ numel(hwCoa);
meanHwPcx = nanmean(hwPcx);
semHwPcx = nanstd(hwPcx) ./ numel(hwPcx);


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
