
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
time = 0:0.001:4; time(end) = [];
binsize = 0.1;
stimData = zeros(1,length(time));
stimData(1000:3000) = 1;
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
    app = coaAA1.espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,14000:18000);
    app1=[];
    app1 = find(app==1)./1000;
    spikeTimes{idxTrial} = app1;
    nst{idxTrial} = nspikeTrain(spikeTimes{idxTrial});
    nst{idxTrial}.setName(num2str(cellID));
end

minTime = 0;
maxTime = 3;
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
%%
simTypeSelect='poisson'; 
numBasis = 6;
windowTimes=[0:.001:.003];
dN=spikeColl.dataToMatrix';  % Convert the spikeTrains into a matrix
                             % of 1's and 0's corresponding to the presence
                             % or absense of a spike in each time window.
dN(dN>1)=1;                  % One should sample finely enough so there is
                             % one spike per bin. Here we make sure that
                             % this is the case regardless of the
                             % sampleRate

% The width of each rectangular basis pulse is determined by Tmax and by the
% number of basis pulses to use.
basisWidth=(spikeColl.maxTime-spikeColl.minTime)/numBasis;

if(simTypeSelect==0)
    fitType='binomial';
else
    fitType='poisson';
end
if(strcmp(fitType,'binomial'))
    Algorithm = 'BNLRCG';   % BNLRCG - faster Truncated, L-2 Regularized,
                            % Binomial Logistic Regression with Conjugate
                            % Gradient Solver by Demba Ba (demba@mit.edu).
else
    Algorithm = 'GLM';      % Standard Matlab GLM (Can be used for binomial or
                            % or Poisson CIFs
end

% Use the values obtained from a PSTH to initialize the SSGLM filter
[psthSig, ~, psthResult] =spikeColl.psthGLM(basisWidth,windowTimes,fitType);
gamma0=psthResult.getHistCoeffs';%+.1*randn(size(histCoeffs));
gamma0(isnan(gamma0))=-5; % Depending on the amount of data the
                          % the psth may not identify all parameters
                          % Just make sure that the estimates are real
                          % numbers

x0=psthResult.getCoeffs;  %The initial estimate for the SSGLM model

% Estimate the variance within each time bin across trials
numVarEstIter=10;
Q0 = spikeColl.estimateVarianceAcrossTrials(numBasis,windowTimes,...
    numVarEstIter,fitType);
A=eye(numBasis,numBasis);
delta = 1/spikeColl.sampleRate;
%% Run the SSGLM Filter

CompilingHelpFile=0;
    % Commented out to speed up help file creation ...
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

 if(~isempty(numBasis))
    basisWidth = (maxTime-minTime)/numBasis;
    sampleRate=1/delta;
    unitPulseBasis=nstColl.generateUnitImpulseBasis(basisWidth,...
        minTime,maxTime,sampleRate);
    basisMat = unitPulseBasis.data;
 end
t0 = 1;
tf = 2;
[spikeRateBinom, ProbMat,sigMat]=DecodingAlgorithms.computeSpikeRateCIs(xK,...
    WkuFinal,dN,t0,tf,fitType,delta,gammahat,windowTimes);

t01 = [0 1];
tf1 = [1 2];
[spikeRateBinom1, ProbMat1,sigMat1]=DecodingAlgorithms.computeSpikeRateDiffCIs(xK,...
    WkuFinal,dN,t01,tf1,fitType,delta,gammahat,windowTimes);
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
time = minTime:delta:maxTime;
 basisMat = unitPulseBasis.data;
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
