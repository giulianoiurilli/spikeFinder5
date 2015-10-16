%% Analysis of LFP responses and coherence between respiration, movement, LFP, MUA and single units

%%
% Load default parameters
load('parameters.mat')

odorsRearranged = [1, 8, 2, 9, 3, 10, 4, 11, 5, 12, 6, 13, 7, 14, 15];      %sort odors
listOdors = {'TMT^-4', 'TMT^-2', 'DMT^-4', 'DMT^-2', 'MT^-4', 'MT^-2',...
             'IBA^-4', 'IBA^-2', 'IAA^-4', 'IAA^-2', 'HXD^-4', 'HXD^-2', 'BTD^-4', 'BTD^-2', 'rose'};

%% Load experiment
% This is experiment 081715 - depth: 3800. Mua and LFP from shank 1.
% 
% <</Users/Giuliano/Documents/MATLAB/spikeFinder5/running analysis/html/08-17-15_d3800_apcx.png>>
% 
idxShank = 1;
idxShank = shank_lfp(idxShank);
shankToLoad = sprintf('CSC%d.mat', idxShank);
load(shankToLoad, 'RawSamples', 'lfp_fs');
load('mua.mat');
load('UnitsNowarp.mat');
load('breathing.mat', 'breath', 'sec_on_rsp', 'delay_on');
load('movement.mat');
move = mat2gray(move, [min(move(:)) max(move(:))]);     %normalize between 0 and 1 for easier comparisons between plots


%% Extract LFPs in the theta, beta and gamma bands.
newFs = lfp_fs;
lfp(:,1) = downsample(RawSamples,fs/newFs);

n = 4;              %filter order
fpass = [1 7;...    %theta
        10 30;...   %beta
        25 50];     %gamma 

for idxBand = 1:3;
    [b,a] = butter(n,fpass(idxBand,:)*2/newFs);         %build filter
    lfp(:,idxBand + 1) = filtfilt(b,a,lfp(:,1));        %zero-phase bandpass filtering
end

%extract window of interest: 30 sec centered on the onset of the first
%inhalation after valve onset
row_lfp = zeros(1, (pre+post)*lfp_fs);
lfpTrials = zeros(10, (pre+post)*lfp_fs, odors);
for idxOdor = 1:odors   %cycles through odors
    for idxTrial = 1:10     %cycles through trials
        row_lfp = lfp(floor((sec_on_rsp(idxTrial,idxOdor) - pre)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) + post)*lfp_fs),1);
        row_lfp1 = row_lfp(1:(pre+post)*lfp_fs);
        lfpTrials(idxTrial,:,idxOdor) = row_lfp1;
        row_lfp = lfp(floor((sec_on_rsp(idxTrial,idxOdor) - pre)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) + post)*lfp_fs),2);
        row_lfp1 = row_lfp(1:(pre+post)*lfp_fs);
        lfpThetaTrials(idxTrial,:,idxOdor) = row_lfp1;
        row_lfp = lfp(floor((sec_on_rsp(idxTrial,idxOdor) - pre)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) + post)*lfp_fs),3);
        row_lfp1 = row_lfp(1:(pre+post)*lfp_fs);
        lfpBetaTrials(idxTrial,:,idxOdor) = row_lfp1;
        row_lfp = lfp(floor((sec_on_rsp(idxTrial,idxOdor) - pre)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) + post)*lfp_fs),4);
        row_lfp1 = row_lfp(1:(pre+post)*lfp_fs);
        lfpGammaTrials(idxTrial,:,idxOdor) = row_lfp1;
    end
end

%% 
% Align stimulus to the first inhalation for plotting.
delay = [];
stimulusOn = zeros(n_trials, (pre+post)*newFs, odors);
for idxOdor = 1:odors   %cycles through odors
    for idxTrial = 1:10     %cycles through trials
        startOdor = delay_on(idxTrial, idxOdor);
        stimulusOn(idxTrial,pre*newFs - round(startOdor*newFs) : pre*newFs - round(startOdor*newFs) + 2*newFs,idxOdor) = 1;
    end
end

%% The responses of some neurons recorded in this experiment
% Here I plot the spike rasters for eac odor on the left and the z-scored,
% smoothed PSTH (10 ms gaussian window) averaged across trials (red signal)
% on the right. Then I overlay the z-scored average respiration signal
% (black signal), the z-scored, averaged LFP (green) and the z-scored,
% averaged MUA (blue). Note that sniffs -2, -1 and +1 relative to the
% onset are larger due to the alignement. In general,, you will notice that
% LFP and MUA are quite in phase. Around the alignement point, but only
% before the onset, LFP and MUA are in entrained to the respiration rythm,
% but they disengage as soon as the odor is presented. It's hard to see an inhibition after the 
% stimulus onset, because decrease in MUA firing just follow the
% respiration cycle, however there is an eviden build-up of excitatory
% activity that generally peaks at around 400 ms (when more than 1-2
% sniffs have already happened). Higher concentrations generally elicit
% larger population excitatory responses.

shank_unitPairs = [1,4;...
                   1,5;...
                   3,1;...
                   3,2;...
                   3,3;...
                   3,5;...
                   4,1;...
                   4,3;...
                   4,4;...
                   4,5];
               
from = 12;
to = 18;
xtime = -3:1/1000:3;


for idxFig = 1:size(shank_unitPairs,1)
    idxShank = shank_unitPairs(idxFig,1);
    idxUnit = shank_unitPairs(idxFig, 2);
    figure
    set(gcf,'Position',[1 5 1000 900]);
    set(gcf,'Color','w')
    p = panel();
    p.pack({1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15 1/15},{50 50});
    idxPlot = 0;
    
    for idxOdor = 1:odors
        useOdor = odorsRearranged(idxOdor);
        idxPlot = idxPlot + 1;
        A = [];
        app = [];
        app = breath(:,from*20000:to*20000,useOdor);
        app = app';
        app = -zscore(downsample(app,20));
        A(1,:) = mean(app');
        app = [];
        app = lfpTrials(:,from*1000:to*1000,useOdor);
        app = app';
        app = -zscore(app);
        A(2,:) = mean(app');
        app = [];
        app = shankMua(idxShank).odor(useOdor).sdf_trialMua(:,from*1000 :to*1000);
        app = app';
        app = zscore(app);
        A(3,:) = mean(app');
        
        spikesMatMs = [];
        spikesMatMs = shankNowarp(idxShank).cell(idxUnit).odor(useOdor).spikeTimesTrial;
        smPSTH = [];
        smPSTH = shankNowarp(idxShank).cell(idxUnit).odor(useOdor).sdf_trialNoWarp(:,from*1000 :to*1000);
        smPSTH = smPSTH';
        smPSTH = zscore(smPSTH);
        smPSTH = smPSTH';
        smPSTH = mean(smPSTH);
        
        p(idxPlot,1).select()
        plotSpikeRaster(spikesMatMs,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell', [-3 3]);
        ylabel(listOdors(idxOdor))
        %axis tight,
        ymax = get(gca, 'YLim');
        hold on
        plot([0 0], ymax, 'color', [44,162,95]/255, 'linewidth', 1);
        set(gca,'YTick',[]),
        set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
        
        p(idxPlot,2).select()
        hold on
        plot(xtime, smPSTH, 'color', [227,26,28]/255, 'linewidth', 1);
        plot(xtime, A(1,:), 'k');
        plot(xtime, A(2,:), 'color', [49,163,84]/255);
        plot(xtime, A(3,:), 'color', [31,120,180]/255, 'linewidth', 1);
        axis tight
        legend('SUA', 'respiration', 'LFP', 'MUA')
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        ymax = get(gca, 'YLim');
        plot([0 0], ymax, 'color', [44,162,95]/255, 'linewidth', 1);
        set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
    end
    neuronID = [];
    neuronID = sprintf('shank%d - unit%d', idxShank, idxUnit);
    p.title(neuronID)
    p.de.margin = 1;
    p.margin = [8 6 4 6];
%     p(2).marginleft = 30;
    p.select('all');
end
    
%%
% *shank 1 - unit 4* 
% Sparse firing during baseline.
% A small excitatory response to HXD-1:10000 (but not to HXD-1:100) in
% sinch with the late population response.
% *shank 1 - unit 5*
% This unit fires a lot during rest and indeed the sniff-warped
% representation showed locking to the respiration rythm. You can already
% notice during the baseline that this neuron is a front-runner in the
% population activity. This becomes evident during the olfactory response:
% this neurons is reaching its peak soon after the MUA has started its
% ramp. Actually, thi bigger is the response, the bigger is the advance
% relative to the peak of the LFP and MUA. I suppose that this neuron can use phase
% relative to the sniff and to the population activity to encode odor identity.
% An important question that I will try to adress later regards the
% encoding of odor identity despite different concentartions of the same
% odor. One hypothess is that odor identy is preserved by manatining
% constant the phase for a given odor at different concentrations. I'd like to to propose a second hypothesis. 
% Odor concentration may be encoded by phase precession as for place cells:
% you get closer to an odor and the olfactory cells that prefer that odor
% advance their response. I don't see the odor identity thing as an issue.
% A combinatorial code can suffice for odor separation. I'm not even sure
% that the piriform cortex is actually representing odor identity as if it was taking pictures of odors. Perhaps,
% it just sorts the incoming flow of information from the bulbs in order to
% allow memory processes while the animal navigates the continously
% changing olfactory environment.
% I guess however that this process cannot be appreciated
% in the averaged signals shown here. I will address this point later.
% *shank 3 - unit 1*
% Not a big responder.
% *shank 3 - unit 2*
% This unit is a choroist. It responds only to some odors and when this
% happens its response is in sinch with the population activity. It also
% get inhibited by some other odors. The slowness of the population
% activity seems to b correlated with such inhibition.
% *shank 3 - unit 3*
% Another front-runner here. This unit shows sharp early responses to some
% odors. It generally responds more to more concentrated odors. Also, there
% is a concentration dependent phase precession visible at least for the first sniff, the only one that has been aligned here.
% This would favor the second hypothesis.
% *shank 3 - unit 5*
% This unit shows only inhibitory responses to some odors. This inhibition
% is usually bigger for lower concentrations for some odors. This is not consistent with
% the hypothesis that higher concentrations recruit more receptors and
% therefore the brain uses inhibition to keep the odor separation intact.
% *shank 4 - unit 1*
% Here we have another late responder. It even shows off responses usually
% preceded by some long-lasting inhibition.
% *shank 4 - unit 3*
% This unit shows another aspect of olfactory responses. This is a unit
% whose firing is clearly locked to the respiration rythm (this can be
% appreciated better after sniff warping). So, it shows what looks like a 'burst' of
% activity during the first sniff, but actually sometimes is just
% sniff-entraining. After the first sniff, this neuron starts responding
% more vigorously and in phase with the population activity response just as a normal choroist.
% *shank 4 - unit 4*
% Some weak early responses here, sometimes followed by longer period of
% inhibition.
% *shank 4 - unit 5*
% Mostly weak inhibitions.
               
               

%% Movement - respiration - LFP. Trial-by-trial.
% Let us consider only 4 odors: TMT 1:100 / TMT 1:10000 / butanedione 1:100
% / butanedione 1:10000.
% A 6 sec window centered on the first inhalation.
% Black trace: respiration. 
% Red trace: LFP, all bands.
idxShank = 1;
params.Fs=lfp_fs;
params.fpass=[1 50];
params.pad=0;
movingwin=[0.5 0.005];
params.tapers=[5 9];
params.trialave = 0;
params.err = 0;

from = 12;
to = 18;
xtime = -3:1/1000:3;
xtimeSniff = -3:1/20000:3;

for idxOdor = [1 2 13 14]
    useOdor = odorsRearranged(idxOdor);
    figure
    set(gcf,'Position',[1 5 1000 900]);
    set(gcf,'Color','w')
    idxPlot = 1;
    p = panel();
    p.pack('h',{50 50});
    p(1).pack('v', {10 10 10 10 10 10 10 10 10 10});
    for i = 1:10
        p(1,i).pack('v',{5, 20,75});
    end
    p(2).pack('v', {10 10 10 10 10 10 10 10 10 10});
    for idxTrial = 1:10
        
        lfpResp = zscore(squeeze(lfpTrials(idxTrial,from*1000:to*1000,useOdor)));
        sniff = zscore(squeeze(breath(idxTrial,from*20000:to*20000,useOdor)));
        odorOn = stimulusOn(idxTrial, from*1000:to*1000, useOdor);
        motion = move(idxTrial,from*1000:to*1000,useOdor); motion = abs(diff(motion)); motion = movingmean(motion,21,2);       
        
        p(1,idxTrial,1).select();
        area(odorOn, 'FaceColor', [51,160,44]/255)
        axis tight, set(gca,'YTick',[]), set(gca,'YColor','w'), set(gca,'XTick',[]), %set(gca,'XColor','w');
        
        p(1,idxTrial,2).select();      
        area(motion, 'FaceColor', [106,61,154]/255);
        axis tight, set(gca,'YTick',[]), set(gca,'YColor','w'), set(gca,'XTick',[]), %set(gca,'XColor','w');
        
        p(1,idxTrial,3).select();
        plot(xtimeSniff, sniff, 'k'); hold on; 
        plot(xtime, lfpResp, 'r'); 
        axis tight, 
        ymax = get(gca, 'YLim');
        plot([0 0], ymax, 'color', [44,162,95]/255, 'linewidth', 1);
        set(gca,'YTick',[]), set(gca,'YColor','w'),
%         while idxTrial < 10
%             set(gca,'XTick',[]); set(gca,'XColor','w');
%         end
        
        
        p(2,idxTrial).select();
        [S1,t,f]=mtspecgramc(lfpResp', movingwin, params);
        S1(floor(length(t)/2), :) = max(S1(:));
        plot_matrix(S1,t,f); axis tight
          
    end
    p.title(listOdors(idxOdor))
    p.de.margin = 1;
    p.margin = [8 6 4 6];
    p(2).marginleft = 30;
    for i = 1:10
    p(1,i).marginbottom = 3;
    end
    p.select('all');
end

%% Respiration - LFP - MUA. Trial-by-trial.
% Let us compare MUA and LFP/respiration. And let us zoom-in.
idxShank = 1;
from = 13;
to = 17;
xtime = -2:1/1000:2;
xtimeSniff = -2:1/20000:2;

for idxOdor = [1 2 13 14]
    useOdor = odorsRearranged(idxOdor);
    figure
    set(gcf,'Position',[1 5 1200 900]);
    set(gcf,'Color','w')
    idxPlot = 1;
    p = panel();
    p.pack('h',{50 50});
    p(1).pack('v', {20 20 20 20 20});
    p(2).pack('v', {20 20 20 20 20});
    for i = 1:5
        p(1,i).pack('v',{5,95});
        p(2,i).pack('v',{5,95});
    end
    
    for idxTrial = 1:5
        
        lfpResp = zscore(squeeze(lfpTrials(idxTrial,from*1000:to*1000,useOdor)));
        sniff = zscore(squeeze(breath(idxTrial,from*20000:to*20000,useOdor)));
        odorOn = stimulusOn(idxTrial, from*1000:to*1000, useOdor);    
        
        p(1,idxTrial,1).select();
        area(odorOn, 'FaceColor', [51,160,44]/255)
        axis tight, set(gca,'YTick',[]), set(gca,'YColor','w'), set(gca,'XTick',[]), %set(gca,'XColor','w');
        
        p(1,idxTrial,2).select();
        plot(xtimeSniff, sniff, 'k', 'linewidth', 1); hold on; 
        plot(xtime,zscore(shankMua(idxShank).odor(useOdor).sdf_trialMua(idxTrial,from*1000 :to*1000)), 'color', [117,107,177]/255, 'linewidth', 1);
        axis tight, 
        ymax = get(gca, 'YLim');
        plot([0 0], ymax, 'color', [44,162,95]/255, 'linewidth', 1);
        set(gca,'YTick',[]), set(gca,'YColor','w'),

        p(2,idxTrial,1).select();
        area(odorOn, 'FaceColor', [51,160,44]/255)
        axis tight, set(gca,'YTick',[]), set(gca,'YColor','w'), set(gca,'XTick',[]), %set(gca,'XColor','w');
        
        p(2,idxTrial,2).select();
        plot(xtime, lfpResp, 'r', 'linewidth', 1); hold on
        plot(xtime,zscore(shankMua(idxShank).odor(useOdor).sdf_trialMua(idxTrial,from*1000 :to*1000)), 'color', [117,107,177]/255, 'linewidth', 1);
        axis tight, 
        ymax = get(gca, 'YLim');
        plot([0 0], ymax, 'color', [44,162,95]/255, 'linewidth', 1);
          
    end
    p.title(listOdors(idxOdor))
    p.de.margin = 1;
    p.margin = [8 6 4 6];
    p(2).marginleft = 30;
    for i = 1:5
    p(1,i).marginbottom = 3;
    end
    p.select('all');
end

%% Coherence respiration - LFP - MUA
% Let us see what the coherence between these three signals lokks like. Two
% odors: TMT 1:100 and butanedione 1:100. Two trials (first and fifth
% trial) for each odor
% The x axis is time in ms. Onset: 3000 ms. The y axis tells you the length 
%of a cycle in ms.
idxShank = 1;
from = 12;
to = 18;

wname  = 'cmor1-1'; %I'm using a wavelet here
scales = 1:512;
ntw = 2;

for idxOdor = [2  14]
    for idxTrial = [1 5]
        A(1,:) = zscore(-downsample(squeeze(breath(idxTrial,from*20000:to*20000,idxOdor)),20));
        A(2,:) = -zscore((squeeze(lfpTrials(idxTrial,from*1000:to*1000,idxOdor))));
        A(3,:) = zscore(shankMua(idxShank).odor(idxOdor).sdf_trialMua(idxTrial,from*1000 :to*1000));
        x = A(1,:);
        y = A(2,:);
        z = A(3,:);
        wcoher(x,y,scales,wname,'ntw',ntw,'plot','all');    %resp vs LFP
        wcoher(x,z,scales,wname,'ntw',ntw,'plot','all');    %resp vs MUA
        wcoher(y,z,scales,wname,'ntw',ntw,'plot','all');    %   
    end
end
        

%%

idxUnit = 5;
from = 12;
to = 18;
xtime = -3:1/1000:3;

figure
%set(gcf,'Position',[1 5 1100 800]);
set(gcf,'Color','w')
idxPlot = 1;
for idxOdor = [1 8 7 14]
    A = [];
    app = [];
    app = breath(:,from*20000:to*20000,idxOdor);
    app = app';
    app = -zscore(downsample(app,20));
    A(1,:) = mean(app');
    app = [];
    app = lfpTrials(:,from*1000:to*1000,idxOdor);
    app = app';
    app = -zscore(app);
    A(2,:) = mean(app');
    app = [];
    app = shankMua(idxShank).odor(idxOdor).sdf_trialMua(:,from*1000 :to*1000);
    app = app';
    app = zscore(app);
    A(3,:) = mean(app');
    app = [];
    app = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:,from*1000 :to*1000);
    app = app';
    app = zscore(app);
    A(4,:) = mean(app');
    
    subplot(4,1, idxPlot)
    hold on
    plot(xtime, A(1,:), 'k'); axis tight
    plot(xtime, A(2,:)); axis tight
    plot(xtime, A(3,:)); axis tight
    plot(xtime, A(4,:)); axis tight
    hold off
    legend('respiration', 'LFP', 'MUA', 'single unit')
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
    idxPlot = idxPlot + 1;
end

        
        
        
        
        
        
        
        
        
        
        
        
        
        