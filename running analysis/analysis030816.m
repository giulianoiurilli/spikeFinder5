n_trials = 10;
%%
odors = 1:14;
idxCell = 0;
for idxExp =  1:length(espe)
    for idxShank = 1:4
        for idxUnit = 1:length(espe(idxExp).shankNowarp(idxShank).cell)
            %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell = idxCell + 1;
                for idxOdor = odors
                    for idxTrial = 1:n_trials
                        Data.Spiketimes.Experiment(idxExp).Shank(idxShank).spiketimes{idxTrial, idxOdor, idxUnit} = find(double(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:))==1)./1000;
                    end
                end
            %end
        end
    end
end
%%
clear spikeTimes
clear nst
clear c
clear results
clear neuronsColl
clear covariatesColl
clear trial
clear trialColl
clear cfgColl

n_trials = 10;
sampleRate = 1000;
time = 0:0.001:30; time(end) = [];
binsize = 0.1;
stimData = zeros(1,length(time));
stimData(15000:17000) = 1;
idxExp = 1;
idxOdor = 14;
idxShank = 4;
idxUnit = 3;
selfHist = [] ; NeighborHist = []; 

for idxTrial = 1
    sniffData = simSniff(breath, idxOdor, 2);
    stim = Covariate(time, stimData, 'Stimulus', 'time', 's', 'on', {'stim'});
    baseline = Covariate(time, ones(length(time),1), 'Baseline', 'time', 's', '', {'\mu'});
    sniff = Covariate(time, sniffData, 'Respiration', 'time', 's', 'mV', {'respiration'});
    sniffAndStimulus = Covariate(time, [sniffData' stimData'], 'RespirationAndOdor', 'time', 's', 'mV', {'respiration', 'odor'});

            cellID= 1;
            spikeTimes = Data.Spiketimes.Experiment(idxExp).Shank(idxShank).spiketimes{2, idxOdor, idxUnit};
            nst = nspikeTrain(spikeTimes);
            nst.setName(num2str(idxTrial));
%                 [m,ind,ShiftTime] = max(results.Residual.xcov(sniff).windowedSignal([0,1]));
%                 sniffAndStimulus = sniffAndStimulus.shift(ShiftTime);
%                 sniff = sniff.shift(ShiftTime);
%                 stim = stim.shift(ShiftTime);
        
    
nspikeColl = nstColl(nst);
cc = CovColl({baseline, sniff, stim, sniffAndStimulus});
trial = Trial(nspikeColl, cc);
trial.plot
%     trialColl{idxTrial} =  TrialConfig({{'Baseline','\mu'},{'RespirationAndOdor','respiration', 'odor'}}, sampleRate,selfHist,NeighborHist);
%     cfgColl{idxTrial} = ConfigColl(trialColl{idxTrial});
%     results{idxTrial} = Analysis.RunAnalysisForAllNeurons(trial{idxTrial}, cfgColl{idxTrial},0);
    %results{idxTrial}.lambda.setDataLabels({'\lambda_{const+resp+odor}'});
end

% for idxTrial = 1:9
%     for idxUnit = 1:
    

%%

n_trials = 10;
spikeColl = nstColl(nst);
spikeColl.setMinTime(13); spikeColl.setMaxTime(19);
figure;
spikeColl.plot;
set(gca, 'YTick', 0:2:n_trials, 'YTickLabel', 0:2:n_trials);
set(gca, 'XTick', 13:19, 'XTickLabel', -2:4);
xlabel('time [s]', 'Interpreter', 'none', 'Fontname', 'Avenir', 'Fontsize', 12, 'FontWeight', 'bold') 
ylabel('trial [k]', 'Interpreter', 'none', 'Fontname', 'Avenir', 'Fontsize', 12, 'FontWeight', 'bold') 
% 
% %%
% % traditional psth and GLM psth
% figure;
% 
% psthUnit = spikeColl.psth(binsize);
% psthGLMUnit = spikeColl.psthGLM(binsize);
% h1 = psthUnit.plot([], {{' ''k'', ''Linewidth'', 2'}});
% h2 = psthGLMUnit.plot([], {{' ''rx'', ''Linewidth'', 2'}});
% xlabel('time [s]', 'Interpreter', 'none', 'Fontname', 'Arial', 'Fontsize', 12, 'FontWeight', 'bold') 
% ylabel('spikes/sec', 'Interpreter', 'none', 'Fontname', 'Arial', 'Fontsize', 12, 'FontWeight', 'bold') 
% h_legend = legend([h1(1) h2(1)], 'PSTH', 'PSTH_{glm}'); 
% 
% %% 
% 
% 
% 
% 
% 
cc = CovColl({stim, baseline});
cc = CovColl({sniff, baseline});
% 
% 
spikeColl2 = nstColl(nst);
trial = Trial(spikeColl2,cc);
figure;
subplot(3,1,1);
nst2 = nst;
nst2.setMinTime(10); nst2.setMaxTime(25);
nst2.plot;
set(gca, 'ytick', [0 1]);
subplot(3,1,2);
sniff.getSigInTimeWindow(10,25).plot([],{{' ''k'' '}}); legend off;
set(gca, 'ytick', [-0.5 1.5])
subplot(3,1,3);
stim.getSigInTimeWindow(10,25).plot([],{{' ''r'' '}}); legend off;
set(gca, 'ytick', [-0.5 1.5])
% 
% 
c{1} = TrialConfig({{'Baseline','\mu'}},sampleRate,selfHist,NeighborHist);
 c{1}.setName('Baseline');
  cfgColl= ConfigColl(c);
  results = Analysis.RunAnalysisForAllNeurons(trial,cfgColl,0);
%% 
  %find onset response in  trial 2
  figure;
  subplot(7,2,[1 3 5])
  results.Residual.xcov(sniff).windowedSignal([0,1]).plot;
  ylabel('');
  [m,ind,ShiftTime] = max(results.Residual.xcov(sniff).windowedSignal([0,1]));
title(['Cross Correlation Function - Peak at t=' num2str(ShiftTime) ' sec'],'FontWeight','bold',...
'FontSize',12,...
'FontName','Arial');
hold on;
h=plot(ShiftTime,m,'ro','Linewidth',3);
set(h, 'MarkerFaceColor',[1 0 0], 'MarkerEdgeColor',[1 0 0]);
hx=xlabel('Lag [s]','Interpreter','none');
set(hx,'FontName', 'Arial','FontSize',12,'FontWeight','bold');
%%
clear cc
sniffAndStimulus = sniffAndStimulus.shift(ShiftTime);
sniff = sniff.shift(ShiftTime);
stim = stim.shift(ShiftTime);
cc = CovColl({baseline, sniffAndStimulus, sniff, stim});
trial2 = Trial(spikeColl2,cc);
clear c;
c{1} = TrialConfig({{'Baseline','\mu'}},sampleRate,selfHist,...
NeighborHist);
c{1}.setName('Baseline');
c{3} = TrialConfig({{'Baseline','\mu'},{'Respiration','respiration'}},...
sampleRate,selfHist,NeighborHist);
c{3}.setName('Baseline+Respiration');
c{2} = TrialConfig({{'Baseline','\mu'},{'RespirationAndOdor','respiration', 'odor'}},...
sampleRate,selfHist,NeighborHist);
c{2}.setName('Baseline+Respiration+Odor');
c{4} = TrialConfig({{'Baseline','\mu'},{'Stimulus','stim'}},...
sampleRate,selfHist,NeighborHist);
c{4}.setName('Baseline+Stimulus');
cfgColl= ConfigColl(c);
results = Analysis.RunAnalysisForAllNeurons(trial2,cfgColl,0);
%%
sampleRate=1000;
delta=1/sampleRate*1;
maxWindow=2; numWindows=32;
windowTimes =unique(round([0 logspace(log10(delta),...
log10(maxWindow),numWindows)]*sampleRate)./sampleRate);
results =Analysis.computeHistLagForAll(trial2,windowTimes,...
{{'Baseline','\mu'},{'RespirationAndOdor','respiration', 'odor'}, {'Respiration','respiration'}, {'Stimulus','stim'},},'BNLRCG',0,sampleRate,0);
KSind = find(results{1}.KSStats.ks_stat == min(results{1}.KSStats.ks_stat));
AICind = find((results{1}.AIC(2:end)-results{1}.AIC(1))== ...
min(results{1}.AIC(2:end)-results{1}.AIC(1))) +1;
BICind = find((results{1}.BIC(2:end)-results{1}.BIC(1))== ...
min(results{1}.BIC(2:end)-results{1}.BIC(1))) +1;
if(AICind==1)
AICind=inf;
end
if(BICind==1)
BICind=inf; %sometime BIC is non-decreasing and the index would be 1
end
windowIndex = min([AICind,BICind]) %use the minimum order model
Summary = FitResSummary(results);
%%
clear c;
if(windowIndex>1)
selfHist = windowTimes(1:windowIndex+1);
else
selfHist = [];
end
NeighborHist = []; sampleRate = 1000;

subplot(7,2,2);
x=0:length(windowTimes)-1;
plot(x,results{1}.KSStats.ks_stat,'.-'); axis tight; hold on;
plot(x(windowIndex),results{1}.KSStats.ks_stat(windowIndex),'r*');
set(gca,'XTick', 0:5:results{1}.numResults-1,'XTickLabel',[],...
'TickLength', [.02 .02] , ...
'XMinorTick', 'on','LineWidth'   , 1);
hy=ylabel('KS Statistic');
set(hy,'FontName', 'Arial','FontSize',12,'FontWeight','bold');
dAIC = results{1}.AIC-results{1}.AIC(1);
title({'Model Selection via change'; 'in KS Statistic, AIC, and BIC'},...
'FontWeight','bold',...
'FontSize',12,...
'FontName','Arial');
subplot(7,2,4); plot(x,dAIC,'.-');
set(gca,'XTick', 0:5:results{1}.numResults-1,'XTickLabel',[],...
'TickLength', [.02 .02] , ...
'XMinorTick', 'on','LineWidth'   , 1);
hy=ylabel('\Delta AIC');axis tight; hold on;
set(hy,'FontName', 'Arial','FontSize',12,'FontWeight','bold');
plot(x(windowIndex),dAIC(windowIndex),'r*');
dBIC = results{1}.BIC-results{1}.BIC(1);
subplot(7,2,6); plot(x,dBIC,'.-');
hy=ylabel('\Delta BIC'); axis tight; hold on;
plot(x(windowIndex),dBIC(windowIndex),'r*');
hx=xlabel('# History Windows, Q');
set([hx, hy],'FontName', 'Arial','FontSize',12,'FontWeight','bold');
set(gca, ...
'TickLength'  , [.02 .02] , ...
'XMinorTick'  , 'on'      , ...
'XTick'       , 0:5:results{1}.numResults-1, ...
'LineWidth'   , 1         );
% Compare Baseline, Baseline+Stimulus Model, Baseline+History+Stimulus
% Addition of the history effect yields a model that falls within the 95%
% CI of the KS plot.
c{1} = TrialConfig({{'Baseline','\mu'}},sampleRate,[],NeighborHist);
c{1}.setName('Baseline');
c{2} = TrialConfig({{'Baseline','\mu'},{'RespirationAndOdor','respiration', 'odor'}},...
sampleRate,windowTimes(1:windowIndex),[]);
c{2}.setName('Baseline+Respiration+Odor + Hist');
c{3} = TrialConfig({{'Baseline','\mu'},{'Respiration','respiration'}},...
sampleRate,[],[]);
c{3}.setName('Baseline+Respiration');
c{4} = TrialConfig({{'Baseline','\mu'},{'Stimulus','stim'}},...
sampleRate,[],[]);
c{4}.setName('Baseline+Odor');
cfgColl= ConfigColl(c);
results = Analysis.RunAnalysisForAllNeurons(trial2,cfgColl,0);
%results.plotResults;
%
results.lambda.setDataLabels({'\lambda_{const}',...
'\lambda_{const+resp+odor+hist}', '\lambda_{const+resp+hist}', '\lambda_{const+stim+hist}'});
subplot(7,2,[9 11 13]); results.KSPlot;
subplot(7,2,[10 12 14]); results.plotCoeffs; legend off;
figure
results.plotCoeffs;
% 
% 
%   
% 
% 
% 
% 
