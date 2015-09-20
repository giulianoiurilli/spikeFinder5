function show_lfp(filename, interval)

load(filename,'lfp_data', 'lfp_fs');

params.Fs=lfp_fs;
params.fpass=[0 70]; 
params.pad=0;
params.tapers=[10 19];


subplot(3,1,1)
lfp_data1 = rmlinesc(lfp_data(interval(1) * params.Fs + 1 : interval(2) * params.Fs), params); %remove line noise
timex = interval(1):1/params.Fs:interval(2);
timex(end) = [];
timex = timex - interval(1);
plot(timex,lfp_data1, 'k');
title('LFP'), xlabel('sec'), ylabel('microV'), axis tight

[S,f]=mtspectrumc(lfp_data1, params); %compute power spectrum
subplot(3,1,2)
plot_vector(S,f);
title('Power spectrum')

movingwin=[0.5 0.05]; 
params.tapers=[5 9];
[S1,t,f]=mtspecgramc(lfp_data1, movingwin, params); % compute spectrogram
subplot(3,1,3)
plot_matrix(S1,t,f);
xlabel([]); % plot spectrogram
caxis([8 28]);