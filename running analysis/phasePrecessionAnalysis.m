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
idxShank = 4;
idxShank = shank_lfp(idxShank);
shankToLoad = sprintf('CSC%d.mat', idxShank);
load(shankToLoad, 'RawSamples', 'lfp_fs');
% load('mua.mat');
load('unitsNowarp.mat');
load('units.mat');
load('breathing.mat', 'breath', 'sec_on_rsp', 'delay_on');
% load('movement.mat');
% move = mat2gray(move, [min(move(:)) max(move(:))]);     %normalize between 0 and 1 for easier comparisons between plots


%% Extract LFPs in the theta, beta and gamma bands.
rawLFP = [];
dsRawSamples = downsample(RawSamples,20);
rawLFP(:,1) = 0:1/lfp_fs:size(dsRawSamples,2)/lfp_fs; 
rawLFP(end) = [];
rawLFP(:,2) = dsRawSamples';
addpath(genpath('/Users/Giuliano/Documents/FMAToolbox'));

rawLFP = rawLFP';
for idxOdor = 1:odors   
    for idxTrial = 1:10     
        row_lfp = rawLFP(2,floor((sec_on_rsp(idxTrial,idxOdor) - pre)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) + post)*lfp_fs));
        row_lfp1 = row_lfp(1:(pre+post)*lfp_fs);
        lfpBands(1).band(idxTrial,:,idxOdor) = row_lfp1;
    end
end

bands = [1 7; ...
    5 30; ...
    10 30; ...
    30 80];

for idxBand = 1:4
    filtLFP = [];
    filtLFP = FilterLFP(rawLFP', 'passband', bands(idxBand,:), 'order', 4, 'ripple', 20, 'nyquist', lfp_fs/2, 'filter', 'cheby2');
    filtLFP = filtLFP';
    row_lfp = zeros(1, (pre+post)*lfp_fs);
    lfpBands(idxBand + 1).band = zeros(10, (pre+post)*lfp_fs, odors);
    for idxOdor = 1:odors   
        for idxTrial = 1:10     
            row_lfp = filtLFP(2,floor((sec_on_rsp(idxTrial,idxOdor) - pre)*lfp_fs) : floor((sec_on_rsp(idxTrial,idxOdor) + post)*lfp_fs));
            row_lfp1 = row_lfp(1:(pre+post)*lfp_fs);
            lfpBands(idxBand + 1).band(idxTrial,:,idxOdor) = row_lfp1;
        end
    end
end


%% Extract phases in each band


for idxBand = 1:5
    useBand = idxBand;
    lfpBands(useBand).angle = [];
    lfpBands(useBand).amplitude = [];
    lfpBands(useBand).unwrappedAngle = [];

    for idxOdor = 1:odors
        app = [];
        % app = lfpBands(useBand).band(:,from*1000:to*1000,useOdor);
        app = -lfpBands(useBand).band(:,:,idxOdor);
        app = app';
        h = [];
        fase = [];
        ampl = [];
        unwrapped = [];
        for j = 1:size(app,2) %trials
            h = hilbert(app(:,j));
            fase(:,j) = mod(angle(h),2*pi);
            ampl(:,j) = abs(h);
            unwrapped(:,j) = unwrap(fase(:,j));
        end
        lfpBands(useBand).angle(:,:,idxOdor) = fase';
        lfpBands(useBand).amplitude(:,:,idxOdor) = ampl';
        lfpBands(useBand).unwrappedAngle(:,:,idxOdor) = unwrapped';
    end
end

%% Extract inhalation onsets
inaOnset = [];
for idxOdor = 1:15
    for idxTrial = 1:10
        app = [];
        respiro = [];
        inalazioni = [];
        ina_on_app = [];
        ina_on = [];
        app = downsample(breath(idxTrial,:,idxOdor),20);
        respiro = app;
        inalazioni = respiro<0;
        app_in = diff(inalazioni);
        ina_on_app = find(app_in==1);
        ina_on_app = ina_on_app + 1;
        ina_on(:,1) = ina_on_app';
        sec_ina_on = ina_on/lfp_fs;
        sec_ina_on = sec_ina_on - repmat(pre,length(sec_ina_on),1);
        ina_post = sec_ina_on(sec_ina_on>0);
        [indice_ina,~] = find(sec_ina_on == ina_post(1));
        ina_on(indice_ina,2) = 1;
        inaOnset(idxOdor).odor{idxTrial} = ina_on;
    end
end

%% 
% Align stimulus to the first inhalation for plotting.
delay = [];
stimulusOn = zeros(n_trials, (pre+post)*lfp_fs, odors);
for idxOdor = 1:odors   %cycles through odors
    for idxTrial = 1:10     %cycles through trials
        startOdor = delay_on(idxTrial, idxOdor);
        stimulusOn(idxTrial,pre*lfp_fs - round(startOdor*lfp_fs) : pre*lfp_fs - round(startOdor*lfp_fs) + 2*lfp_fs,idxOdor) = 1;
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


lfpTrials = lfpBands(3).band;

shank_unitPairs = [1,5;...
                   3,2;...
                   3,3;...
                   3,5;...
                   4,3];
               
from = 12;
to = 20;
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
% ramp. Actually, the bigger is the response, the bigger is the advance
% relative to the peak of the LFP and MUA. I suppose that this neuron can use phase
% relative to the sniff and to the population activity to encode odor identity.
% An important question that I will try to address later regards the
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

%% Coherence between a single unit and respiration, LFP and MUA on a trial-by-trial base.
% Here I analyze time-course of the coherence for three neurons that show consistent responses to a given odor. 
% The phase precession hypothesis predicts that the phase will advance at
% each sniff while the odor concentration increases in the odor-delivery
% mask after the valve opens.
% This is what happens at each trial for movement, respiration, LFP and MUA.

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

useOdor = odorsRearranged(14);
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

%%
% The first trial is special. The odors elicit a a bout of fast sniffing
% (black signal) followed by the animal's movement on the ball (blue,
% signal above). I may want to discard this trial for the moment. The spectrograms
% on the lefts show an increase of the LFP power in the beta band a few
% hundreds of ms after the odor onset, but not earlier. This beta activity
% seems to be correlated with the slow increase of the population
% excitatory activity that we saw in the previous section.
% Let us see what changes in the coherence between these signals during
% trials 1, 3 and 4.

wname  = 'cmor1-1'; %I'm using a wavelet here
scales = 1:500;
ntw = 2;
scalesLabels = [451 401 351 301 251 201 151 101 51 1];
frequencies = scal2frq(scalesLabels, 'cmor1-1', 1/500);
for idxScale = 1:length(scalesLabels)
    transfomation = sprintf('scale: %d - frequency: %1f', scalesLabels(idxScale), round(frequencies(idxScale),1));
    disp(transfomation);
end

for idxOdor = 3
    for idxTrial = [1]% 3 4]
        A(1,:) = zscore(-downsample(squeeze(breath(idxTrial,from*20000:to*20000,idxOdor)),20));
        A(2,:) = -zscore((squeeze(lfpTrials(idxTrial,from*1000:to*1000,idxOdor))));
%         A(3,:) = zscore(shankMua(idxShank).odor(idxOdor).sdf_trialMua(idxTrial,from*1000 :to*1000));
        x = A(1,:);
        y = A(2,:);
%         z = A(3,:);
        wcoher(x,y,scales,wname,'ntw',ntw,'plot','all');    %resp vs LFP
        wcoherence(x,y,1000);
%         wcoher(x,z,scales,wname,'ntw',ntw,'plot','all');    %resp vs MUA
%         wcoher(y,z,scales,wname,'ntw',ntw,'plot','all');    %LFP vs MUA  
    end
end


%%
% _First trial_
% The wavelet transforms nicely show the shift from regular respiration in the low theta band (~ 3-4 Hz) 
% followed by rapid sniffing in the beta band after the first odor
% presentation. The LFP  shows theta activity at rest, a short
% episode of delta activity at the stimulus onset -the slow exciting response-
% that is gradually surfed by some beta activity that peaks toward the end
% of the stimulus. This beahvior is captured by the cross spectrum plots. 
% The modulus of the cross spectrum is high in the theta band before the
% stimulus and in the beta band following the stimulus. The angle plot
% shows that respiration and LFP are in phase at rest, out-of-phase at the
% onset of the stimulus during the slow excitation and out-of-phase, but at
% the opposite angle during the sniffing period and the beta oscillation of
% the LFP. So, the neural response is not just a phase resetting because it
% is there even during single trials. The neural activity entrains to the
% respiration rythm at rest as it wanted to stay tuned. The neural activity
% disengages itself during the response by slowing down for a little bit
% and then restarting at higher frequency but out-of-phase relative to
% sniffing now. Something apparently similar happend between respiration
% and MUA, however the relative phase are harder to decipher propably due
% to the probabilistic nature of the MUA signal that makes its fluctuations small during the beta activtiy.
% _Third and fourth trial_
% My impression is that the olfactory cortex can show beta activity
% indipendently from the sniffing activity.


%%
% In this section I will run again the coeherence analysis using the
% activity of single units instead of the MUA
% *Shank 4 - unit 3 - odor butanedione

idxShank = 4;
idxUnit = 3;
useOdor = 14;
smPSTH = [];
smPSTH = shankNowarp(idxShank).cell(idxUnit).odor(useOdor).sdf_trialNoWarp(:,from*1000 :to*1000);
smPSTH = smPSTH';
smPSTH = zscore(smPSTH);
smPSTH = smPSTH';



wname  = 'cmor1-1'; %I'm using a wavelet here
%wname  = 'bump'; %I'm using a wavelet here
scales = 1:1000;
ntw = 2;
scalesLabels = [469 417 365 313 261 209 157 106 53 1];
frequencies = scal2frq(scalesLabels, wname, 1/1000);
for idxScale = 1:length(scalesLabels)
    transfomation = sprintf('scale: %d - frequency: %1f', scalesLabels(idxScale), round(frequencies(idxScale),1));
    disp(transfomation);
end

for idxOdor = 14
    for idxTrial = [1 3 4]
        A(1,:) = zscore(-downsample(squeeze(breath(idxTrial,from*20000:to*20000,idxOdor)),20));
        A(2,:) = -zscore((squeeze(lfpTrials(idxTrial,from*1000:to*1000,idxOdor))));
        A(3,:) = smPSTH(idxTrial,:);
        x = A(1,:);
        y = A(2,:);
        z = A(3,:);
        wcoher(x,y,scales,wname,'ntw',ntw,'plot','all');    %resp vs LFP
        wcoher(x,z,scales,wname,'ntw',ntw,'plot','all');    %resp vs SUA
        wcoher(y,z,scales,wname,'ntw',ntw,'plot','all');    %LFP vs SUA  
    end
end

%%
% Just the most evident fact. This neuron lags behind each inhalation and
% is in phase with the LFP at rest, but shift forward relative to the other
% signals after the first sniff post-odor onset. This may be explained by
% an increase of the odor concentration in the nostrils after the first
% sniff.
% To futher investigate this phase precession, I'm going to measure the
% phase of each spike for each breathing cycle. I'm assuming that the
% breathing cycle is a good proxy for the LFP at this moment. Also, I'm
% going to discard the first trial.

idxShank = 4;
idxUnit = 3;

plotRasters(idxShank, idxUnit);

%%
% From this first plots you can see how the activity builds up cycle after
% cycle as expected from the previous analysis. Note that the unit responds
% strongly to butanedione 1:100 and more weakly, but still consistently to
% butanedione 1:10000.
useOdor = odorsRearranged(2);
unitPhases = shank(idxShank).cell(idxUnit).odor(useOdor).alphaTrial;
edgesPre = -preInhalations*360 : 360 : 0; 
edgesPost = 0:360:(postInhalations+1)*360;
for idxTrial = 1:10%[2 3 4 5 7 8]
    idxBin = 1;
    unitPhaseTrial = [];
    restSpikes = [];
    ap = [];
    ind = [];
    unitPhaseTrial = unitPhases{idxTrial};
    unitPhaseTrial = rad2deg(unitPhaseTrial);
    restSpikes = unitPhaseTrial(unitPhaseTrial<=0);
    [~, ind] = histc(restSpikes, edgesPre);
    for idxCycle = 1:preInhalations
        app = [];
        app = restSpikes(ind==idxCycle);
        app = app + (preInhalations - idxCycle + 1)*360;
        app(app<50) = [];
        cycleTrial(idxTrial).cycleBin{idxBin} = app;
        idxBin = idxBin + 1;
    end
    respSpikes = [];
    respSpikes = unitPhaseTrial(unitPhaseTrial>0);
    ind = [];
    [~, ind] = histc(respSpikes, edgesPost);
    for idxCycle = 1:postInhalations
        app = [];
        app = respSpikes(ind==idxCycle);
        app = app - (idxCycle - 1)*360;
        
        cycleTrial(idxTrial).cycleBin{idxBin} = app;
        idxBin = idxBin + 1;
    end
end
%%

figure
set(gcf,'Position',[1 656 536 149]);
set(gcf,'Color','w')
idxPlot = 1;
p = panel();
p.pack('h',{1/10 1/10 1/10 1/10 1/10 ...
    1/10 1/10 1/10 1/10 1/10});
%p.pack('h',{20 20 20 20 20});
%p.pack('h',{1/6 1/6 1/6 1/6 1/6 1/6});

for idxTrial = 1:10
    p(idxPlot).select();
    %plotSpikeRaster(cycleTrial(idxTrial).cycleBin,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell', [0 360]);
    plotSpikeRaster(cycleTrial(idxTrial).cycleBin,'PlotType','scatter','XLimForCell', [0 360]);
    %set(gca,'YTick',[]), set(gca,'YColor','w')
    set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
    idxPlot = idxPlot+1;
end
p.title(listOdors(useOdor))
p.de.margin = 10;
p.margin = [8 6 4 6];
p.select('all');

%%


figure
set(gcf,'Position',[1 656 536 149]);
set(gcf,'Color','w')

idxPlot = 1;
hold on
matrixPhase = zeros(10,360);
for idxTrial = 1:10
    
    %plotSpikeRaster(cycleTrial(idxTrial).cycleBin,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell', [0 360]);
    plotSpikeRaster(cycleTrial(idxTrial).cycleBin,'PlotType','scatter','XLimForCell', [0 360]);
    set(gca,'YTick',[]), set(gca,'YColor','w')
    set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
%     for i = 1:20
%         app = [];
%         app2 = [];
%         ind = [];
%         app = cycleTrial(idxTrial).cycleBin{i};
%         [~, ind] = find(app > 0);
%         app2(i,ind) = 1;
%         if ~isempty(app2)
%         matrixPhase = matrixPhase + app2;
%         end
%     end
end
hold off

%%
edgesAngles = 0:359;
matrixPhase = zeros(720,20,9);
for idxTrial = 2:10
    for idxCycle = 1:20
        app = [];
        app = cycleTrial(idxTrial).cycleBin{idxCycle};
        binnedSpikes = histc(app,edgesAngles);
        matrixPhase(1:360, idxCycle, idxTrial) = binnedSpikes';
        matrixPhase(361:720, idxCycle, idxTrial) = binnedSpikes';
    end
end

figure;
A = mean(matrixPhase(:,5:20,5:10),3);
filtMatrixPhase = imgaussfilt(A, [10,3],'FilterSize',[301,5]);
figure; imagesc((filtMatrixPhase'));
axis square

%%
figure
sizeDot = 12;
for idxTrial = 1:9;
    A = matrixPhase(:,:,idxTrial);
    plot(A', '.', 'Markersize', sizeDot, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [0 0 0]);
end
ylabel('phase')
xlabel('sniff')
set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');



        
        

    






        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    






















