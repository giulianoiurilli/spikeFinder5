idxExp = 6;
idxShank = 4;
idxUnit = 11;
idxOdor = 2;

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
delta = 1/sampleRate;
time = 0:0.001:30; time(end) = [];
binsize = 0.1;
stimData = zeros(1,length(time));
stimData(15000:17000) = 1;
% idxExp = 1;
% idxOdor = 14;
% idxUnit = 3;
selfHist = [] ; NeighborHist = []; 
cellID = 1;
stim = Covariate(time, stimData, 'Stimulus', 'time', 's', 'on', {'stim'});
baseline = Covariate(time, ones(length(time),1), 'Baseline', 'time', 's', '', {'\mu'});
for idxTrial = 1:n_trials
    %spikeTimes{idxTrial} = Data.Spiketimes.Experiment(idxExp).Shank(idxShank).spiketimes{idxTrial, idxOdor, idxUnit};
    app = [];
    app = coaAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:);
    app1=[];
    app1 = find(app==1)./1000;
    spikeTimes{idxTrial} = app1;
    nst{idxTrial} = nspikeTrain(spikeTimes{idxTrial});
    nst{idxTrial}.setName(num2str(cellID));
end

minTime = 14.8;
maxTime = 16;
spikeColl = nstColl(nst);
covariatesColl = CovColl({baseline,stim});
h = figure;
subplot(2,1,1)
spikeColl.resample(1/delta);
spikeColl.setMinTime(minTime); spikeColl.setMaxTime(maxTime);
spikeColl.plot;
subplot(2,1,2)
stim.getSigInTimeWindow(minTime,maxTime).plot([],{{' ''r'' '}}); legend off;
set(gca, 'ytick', [-0.5 1.5])


numBasis = 5;
dN = spikeColl.dataToMatrix';
dN(dN>1) = 1;
basisWidth = (spikeColl.maxTime - spikeColl.minTime)/numBasis;
windowTimes = [0:0.001:0.003];
fitType = 'poisson';
Algorithm = 'GLM'; 

[psthSig, ~, psthResult] = spikeColl.psthGLM(basisWidth, windowTimes, fitType);
gamma0 = psthResult.getHistCoeffs';
gamma0(isnan(gamma0)) = -5;
x0 = psthResult.getCoeffs;
numVarEstIter = 10;
Q0 = spikeColl.estimateVarianceAcrossTrials(numBasis, windowTimes, numVarEstIter, fitType);
A = eye(numBasis, numBasis);
delta = 1/spikeColl.sampleRate;
figure
psthSig.plot([],{{' ''k'',''Linewidth'',4'}});
if ~isempty(numBasis)
    unitPulseBasis = nstColl.generateUnitImpulseBasis(basisWidth, minTime, maxTime, sampleRate);
    basisMat = unitPulseBasis.data;
end


CompilingHelpFile = 0;
if(~CompilingHelpFile)
    Q0d=diag(Q0);
    neuronName = psthResult.neuronNumber;
    [xK,WK, WkuFinal,Qhat,gammahat,fitResults,stimulus,stimCIs,logll,...
        QhatAll,gammahatAll,nIter]=DecodingAlgorithms.PPSS_EMFB(A,Q0d,x0,...
        dN,fitType,delta,gamma0,windowTimes, numBasis,neuronName);
    
    fR = fitResults.toStructure;
    psthR = psthResult.toStructure;
end

%%
t0 = 14;%minTime;
tf = 16;%maxTime;
[spikeRateBinom, ProbMat,sigMat]=DecodingAlgorithms.computeSpikeRateCIs(xK,...
    WkuFinal,dN,t0,tf,fitType,delta,gammahat,windowTimes);
%%
lt=find(sigMat(1,:)==1,1,'first');
display(['The learning trial (compared to the first trial) is trial #' ...
    num2str(find(sigMat(1,:)==1,1,'first'))]);
scrsz = get(0,'ScreenSize');
h=figure('OuterPosition',[scrsz(3)*.1 scrsz(4)*.1 scrsz(3)*.8 scrsz(4)*.8]);

subplot(2,3,1);
spikeRateBinom.setName(['(' num2str(maxTime) '-0)^-1*\Lambda(0,' ...
    num2str(maxTime) ')']);
spikeRateBinom.plot([],{{' ''k'',''Linewidth'',4'}});
% e = Events(lt,{''});
% e.plot;
v=axis;
plot(lt*[1;1],v(3:4),'r','Linewidth',2);
hx=xlabel('Trial [k]','Interpreter','none'); hold all;
hy=ylabel('Average Firing Rate [spikes/sec]','Interpreter','none');
set([hx, hy],'FontName', 'Arial','FontSize',12,'FontWeight','bold');
title(['Learning Trial:' num2str(lt)],'FontWeight','bold',...
            'Fontsize',12,...
            'FontName','Arial');
h=subplot(2,3,[2 3 5 6]);
K=size(dN,1);
colormap(flipud(gray));
imagesc(ProbMat); hold on;
for k=1:K
    for m=(k+1):K
        if(sigMat(k,m)==1)
            plot3(m,k,1,'r*'); hold on;
        end
    end
end
%
set(h,'XAxisLocation','top','YAxisLocation','right');
hx=xlabel('Trial Number','Interpreter','none'); hold all;
hy=ylabel('Trial Number','Interpreter','none');
set([hx, hy],'FontName', 'Arial','FontSize',12,'FontWeight','bold');

subplot(2,3,4)
stim1 = Covariate(time, basisMat*stimulus(:,1),'Trial1','time','s',...
    'spikes/sec');
temp = ConfidenceInterval(time, basisMat*squeeze(stimCIs(:,1,:)));
stim1.setConfInterval(temp);
stimlt = Covariate(time, basisMat*stimulus(:,lt),'Trial1','time','s',...
    'spikes/sec');
temp = ConfidenceInterval(time, basisMat*squeeze(stimCIs(:,lt,:)));
temp.setColor('r');
stimlt.setConfInterval(temp);
stimltm1 = Covariate(time, basisMat*stimulus(:,lt-1),'Trial1','time','s',...
    'spikes/sec');
temp = ConfidenceInterval(time, basisMat*squeeze(stimCIs(:,lt-1,:)));
temp.setColor('r');
stimltm1.setConfInterval(temp);

% figure;
h1=stim1.plot([],{{' ''k'',''Linewidth'',4'}}); hold all;
h2=stimlt.plot([],{{' ''r'',''Linewidth'',4'}});
hx=xlabel('time [s]','Interpreter','none'); hold all;
hy=ylabel('Firing Rate [spikes/sec]','Interpreter','none');
set([hx, hy],'FontName', 'Arial','FontSize',12,'FontWeight','bold');

title({'Learning Trial Vs. Baseline Trial';'with 95% CIs'},'FontWeight','bold',...
            'Fontsize',12,...
            'FontName','Arial');
h_legend=legend([h1(1) h2(1)],'\lambda_{1}(t)',['\lambda_{' num2str(lt) '}(t)']);
pos = get(h_legend,'position');
set(h_legend, 'position',[pos(1)+.03 pos(2)+.01 pos(3:4)]);


