

pre = 3;
post = 5;
pre2 = 20;
response_window = 3;
odors = 15;
bin_size = 0.2;
fs = 20000;
lfp_fs = 1000;

params.Fs=lfp_fs;
params.fpass=[0 70]; 
params.pad=0;
params.tapers=[10 19];

movingwin=[0.5 0.05]; 
params.tapers=[5 9];
params.trialave = 1;
params.err = 0;


for idxExp = 1:length(List)
    cd(List{idxExp})
    lfp_data1 = nan(10,7999,15);
    lfp_data = extractLFP('CSC0.mat');
    load('breathing.mat', 'sec_on_rsp')
%     h = figure;
%     set(h,'color','white', 'PaperPositionMode', 'auto');
    for idxOdor = 1:odors
        j = 1;
        for idxTrial = 1:10     %cycles through trials
            x = rmlinesc(lfp_data((sec_on_rsp(idxTrial, idxOdor) - pre) * params.Fs + 1 : (sec_on_rsp(idxTrial, idxOdor) + post) * params.Fs), params);
            lfp_data1(idxTrial,:,idxOdor) = x(1:7999);
        end
%         [S1,t,f]=mtspecgramc(lfp_data1(:,:,idxOdor)', movingwin, params); % compute spectrogram
%         subplot(3,5,idxOdor)
%         plot_matrix(S1,t,f);
%         xlabel([]); % plot spectrogram
%         caxis([8 28]);
    end

    
    h = figure;
    set(h,'color','white', 'PaperPositionMode', 'auto');
    for idxOdor = 1:odors
        oep(1,:) = mean(lfp_data1(:,:,idxOdor),1);
        subplot(3,5,idxOdor)
        plot(oep(2000:5000))
    end
    experimentName = sprintf('exp %d', idxExp);
    suptitle(experimentName)
end

x =rmlinesc(lfp_data(round((sec_on_rsp(idxTrial, idxOdor) - pre) *params.Fs + 1) : round((sec_on_rsp(idxTrial, idxOdor) + post) * params.Fs)), params);