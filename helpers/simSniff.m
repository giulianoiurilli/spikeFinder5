function yySniff1 = simSniff(breath, odorX, trialX)

%% Trova tutte le inalazioni ed esalazioni per quell'odore in quel trial
fs = 20000;
respiro = squeeze(breath(trialX,:,odorX));
inalazioni = respiro<0;
app_in = diff(inalazioni);
ina_on = find(app_in==1);
ina_on = ina_on + 1;
ina_on = ina_on';
esalazioni = respiro>0;
app_ex = diff(esalazioni);
exa_on = find(app_ex==1);
exa_on = exa_on + 1;
exa_on = exa_on';
ina_on = ina_on/fs;
exa_on = exa_on/fs;
ina_esa = [ina_on; exa_on];
ina_esa = sort(ina_esa);
idxStart = find(ina_esa>=15, 1);
halSniffPeakTimePostOnset = diff(ina_esa(idxStart:end))/2;
halSniffPeakTimePostOnset = [halSniffPeakTimePostOnset; halSniffPeakTimePostOnset(end)];
peakTimesPostOnset = ina_esa(idxStart:end) + halSniffPeakTimePostOnset;
halSniffPeakTimePreOnset = diff(ina_esa(1:idxStart))/2;
halSniffPeakTimePreOnset = [halSniffPeakTimePreOnset(1); halSniffPeakTimePreOnset];
peakTimesPreOnset = ina_esa(1:idxStart) - halSniffPeakTimePreOnset;
sniffTraceTimes = [peakTimesPreOnset; ina_esa; peakTimesPostOnset];
sniffTraceTimes = sort(sniffTraceTimes);
sniffTraceTimes = [0; sniffTraceTimes];
sniffTraceTimes(sniffTraceTimes>=30) = 30;
if sniffTraceTimes(end) < 30
   sniffTraceTimes = [sniffTraceTimes; 30]; 
end
idxStart = find(sniffTraceTimes>=15, 1);
ySniff = nan*ones(size(sniffTraceTimes));
ySniff(idxStart:2:end) = 0;
ySniff(idxStart:-2:1) = 0;
ySniff(idxStart+1:4:end) = 1;
ySniff(idxStart+1:-4:1) = 1;
ySniff(idxStart+3:4:end) = -1;
ySniff(idxStart+3:-4:1) = -1;
xx = sniffTraceTimes(1):1/1000:sniffTraceTimes(end);
yySniff1 = interp1(sniffTraceTimes, ySniff, xx, 'pchip');
% figure; 
% plot(sniffTraceTimes, ySniff, 'o', xx, yySniff1);
yySniff1(end) = [];

%%







