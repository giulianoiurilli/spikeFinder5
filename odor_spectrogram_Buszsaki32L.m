close all



% load('dig1.mat');
% signal = Dig_inputs;
toFolder = folder; %uigetdir('', 'Save in');



params.fpass=[0 70];
params.pad=0;
params.tapers=[10 19];

movingwin=[0.5 0.05];
params.tapers=[5 9];
params.trialave = 1;
params.err = 0;

% app=find(signal>thres);
% app1=SplitVec(app,'consecutive'); %crea delle celle di segmenti soprasoglia consecutivi
% app=[];
% for j=1:length(app1) %per ogni segmento
%     [maxvalue, maxind]=max(signal(app1{j})); %trova il picco (indice relativo all'inizio del segmento)
%     app(j)=app1{j}(maxind); %e ne memorizza l'indice (relativo all'inizio della sweep) in un vettore dei timestamps degli AP nella sweep i
% end
% 
% app_sec=app./fs;



        


    params.Fs=1000;
    
%     h = figure;
    for k = 1:odors
        j = 1;
        for i = 1:n_trials     %cycles through trials
            lfp_data1(j,:,k) = rmlinesc(lfp_data((sec_on_rsp(i,k) - pre) * params.Fs + 1 : (sec_on_rsp(i,k) + post) * params.Fs), params);
            lfp_data_delta_1(j,:,k) = rmlinesc(lfp_data_delta((sec_on_rsp(i,k) - pre) * params.Fs + 1 : (sec_on_rsp(i,k) + post) * params.Fs), params);
            j=j+1;
        end
%         [S1,t1,f1]=mtspecgramc(lfp_data1(:,:,k)', movingwin, params); % compute spectrogram
%         subplot(odors,1,k)
%         plot_matrix(S1,t1,f1);
%         xlabel([]); % plot spectrogram
%         caxis([8 28]);  
    end
    
%     set(h,'color','white', 'PaperPositionMode', 'auto');
%     stringa_fig=sprintf('odor_spectrograms%d.eps', exp);
%     saveas(h,fullfile(toFolder,stringa_fig),'epsc')
    save(filename ,'lfp_data1', 'lfp_data_delta_1', '-append');
    
%     h = figure;
%     for k = 1:odors
%         oep(1,:) = mean(lfp_data1(:,:,k),1);
%         subplot(odors,1,k)
%         plot(oep)
%     end
%     set(h,'color','white', 'PaperPositionMode', 'auto');
%     stringa_fig=sprintf('odor_oep%d.eps', exp);
%     saveas(h,fullfile(toFolder,stringa_fig),'epsc')
    
        
%     for k = 1:odors
%         figure
%        j = 1; 
%        for i = 1:n_trials
%            subplot(10,1,j)
%            plot(reRefFiltSamples(1,(sec_on_rsp(i,k) - pre) * fs + 1 : (sec_on_rsp(i,k) + post) * fs))
%            j = j + 1;
%        end      
%     end
    
%     h = figure;
%     for i = n_trials
%         lfp_data2(j,:) = rmlinesc(lfp_data((sec_on_rsp(i,k) - pre - 10) * params.Fs + 1 : (sec_on_rsp(i,k) - pre) * params.Fs), params);
%         [S,f]=mtspectrumc(lfp_data2(j,:), params); %compute power spectrum
%         hold on
%         plot_vector(S,f);
%     end
%     title('Power spectrum')
%     set(h,'color','white', 'PaperPositionMode', 'auto');
%     stringa_fig=sprintf('LFPpowers%d.eps', exp);
%     saveas(h,fullfile(toFolder,stringa_fig),'epsc')
    
    for k = 1:odors
        X = lfp_data_delta_1(:,:,k);
        y = hilbert(X');
        lfp_sigphase(:,:,k) = angle(y);
    end
    
    save(filename , 'lfp_sigphase','-append');


