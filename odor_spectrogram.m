exp = 3;

close all
load('CSC0.mat', 'lfp_data', 'lfp_fs')
load('dig1.mat');
toFolder = uigetdir('', 'Save in');


signal = Dig_inputs;

 
pre = 3;
post = 5;
pre2 = 20;
response_window = 3;
odors = 7;
bin_size = 0.2;
fs = 20000;
thres = .5;


app=find(signal>thres);
app1=SplitVec(app,'consecutive'); %crea delle celle di segmenti soprasoglia consecutivi
app=[];
for j=1:length(app1) %per ogni segmento
    [maxvalue, maxind]=max(signal(app1{j})); %trova il picco (indice relativo all'inizio del segmento)
    app(j)=app1{j}(maxind); %e ne memorizza l'indice (relativo all'inizio della sweep) in un vettore dei timestamps degli AP nella sweep i
end

app_sec=app./fs;








params.Fs=lfp_fs;
params.fpass=[0 70]; 
params.pad=0;
params.tapers=[10 19];

movingwin=[0.5 0.05]; 
params.tapers=[5 9];
params.trialave = 1;
params.err = 0;


h = figure;
for k = 1:odors
    j = 1;
    
    for i = k:odors:length(app_sec)     %cycles through trials
        lfp_data1(j,:,k) = rmlinesc(lfp_data((app_sec(i) - pre) * params.Fs + 1 : (app_sec(i) + post) * params.Fs), params);
        j=j+1;
    end
    [S1,t,f]=mtspecgramc(lfp_data1(:,:,k)', movingwin, params); % compute spectrogram
    subplot(odors,1,k)
    plot_matrix(S1,t,f);
    xlabel([]); % plot spectrogram
    caxis([8 28]);
    
end

set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('odor_spectrograms%d.eps', exp);
saveas(h,fullfile(toFolder,stringa_fig),'epsc')

h = figure;
for k = 1:odors
    oep(1,:) = mean(lfp_data1(:,:,k),1);
    subplot(odors,1,k)
    plot(oep)
end

h = figure;
for z = 1:odors:length(app_sec)
    lfp_data2(j,:) = rmlinesc(lfp_data((app_sec(z) - pre2) * params.Fs + 1 : (app_sec(z) - pre) * params.Fs), params);
    [S,f]=mtspectrumc(lfp_data2(j,:), params); %compute power spectrum
    hold on
    plot_vector(S,f);
end
title('Power spectrum')
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('LFPpowers%d.eps', exp);
saveas(h,fullfile(toFolder,stringa_fig),'epsc')

clear all

