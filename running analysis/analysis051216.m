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
lfp_fs = 1000;
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

%%
lfpTrials = lfpBands(3).band;
from = 12;
to = 20;
%%
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
%% plCOA: 082615-d5500 idxOdor=3 / PC: 081715-d3800 idxOdor=
t = 1:length(y);
Fs = 1000;
minFrequency = 5;
maxFrequency = 30;
waveletCenterFrequency = 5/(2*pi);
dt = 1/Fs;
time = -2:dt:length(y)*dt-2;
time(end) = [];
wname  = 'bump';
scalesCWT = helperCWTTimeFreqVector(minFrequency,maxFrequency,waveletCenterFrequency,dt,32);




for idxOdor = 1:15
    titolo = sprintf('Pcx2 odor %d', idxOdor);
    figure
    set(gcf,'Position',[10 53 1022 999]);
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    for idxTrial = 1:10
        % idxOdor = 10;
        % idxTrial  = 3;
        A = [];
        A(1,:) = downsample(squeeze(breath(idxTrial,from*20000:to*20000,idxOdor)),20);
        A(2,:) = zscore(squeeze(lfpTrials(idxTrial,from*1000:to*1000,idxOdor)));
        x = A(1,:);
        y = A(2,:);
        subplot(5,2,idxTrial)
        plot(time,y, 'color', [165,0,38]./255, 'linewidth', 1)
        set(gca, 'box', 'off', 'tickDir', 'out')
        %ylim([-100 100])
    end
    suptitle(titolo)
    figure
    set(gcf,'Position',[1028 58 1022 999]);
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    for idxTrial = 1:10
        % idxOdor = 10;
        % idxTrial  = 3;
        A = [];
        A(1,:) = downsample(squeeze(breath(idxTrial,from*20000:to*20000,idxOdor)),20);
        A(2,:) = zscore(squeeze(lfpTrials(idxTrial,from*1000:to*1000,idxOdor)));
        x = A(1,:);
        y = A(2,:);
        lfpS = cwtft({y,dt},'wavelet',wname,...
            'scales',scalesCWT,'PadMode','symw');
        subplot(5,2,idxTrial)
        helperCWTTimeFreqPlot(lfpS.cfs,t,lfpS.frequencies,'surf',...
            [],'Seconds','Hz');
        colormap(brewermap([],'*PuBuGn'))
        %clim([0 100]);
    end
    suptitle(titolo)
end
% subplot(2,2,3)
% plot(time,x, 'color',[49,54,149]./255, 'linewidth', 1)
% set(gca, 'box', 'off', 'tickDir', 'out')
% sniffS = cwtft({x,dt},'wavelet',wname,...
%     'scales',scalesCWT,'PadMode','symw');
% subplot(2,2,4)
% helperCWTTimeFreqPlot(sniffS.cfs,t,sniffS.frequencies,'surf',...
%     'Respiration','Seconds','Hz')
% %%
% figure;
% [wcoh, ~, F] = wcoherence(x,y,Fs);
% 
% surf(t,F,abs(wcoh).^2); view(0,90); shading interp;
% axis tight;
% hc = colorbar;
% hc.Label.String = 'Coherence';
% title('Wavelet Coherence')
% xlabel('Seconds'),ylabel('Hz');
% ylim([minFrequency maxFrequency]);

