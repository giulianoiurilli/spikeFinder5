neuron = shank(1).spike_matrix{1}(:,:,1);
delta = 0.001;
simTypeSelect=0;

for i = 1:size(neuron,1)
    spikeTimes = find(neuron(i,:)==1);
    spikeTimes = spikeTimes/1000;
    nst{i} = nspikeTrain(spikeTimes, '1', delta);
end

%time = 0:(1/0.001):nst.maxTime;
spikeColl = nstColl(nst);
figure; spikeColl.plot;

figure
psthGLM = spikeColl.psthGLM(bin_size);
h2 = psthGLM.plot([],{{' ''k'',''Linewidth'',4'}});
legend off;

time = 0:delta:pre+post;

%Create covariates
baseline = Covariate(time,ones(length(time),1),'Baseline','time','s','',{'\mu'});
odorStim = zeros(1,length(time));
odorStim(pre/delta:(pre+response_window)/delta) = 1;
stim = Covariate(time, odorStim, 'Odor', 'time', 's', 'ON', {'odor'});
windowTimes = [0.001 0.002];

numBasis = (pre+post)/bin_size;
spikeColl.resample(1/delta);
spikeColl.setMaxTime(pre+post);

dN = spikeColl.dataToMatrix';
dN(dN>1) = 1;

basisWidth = (spikeColl.maxTime - spikeColl.minTime)/numBasis;

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
Q0 = spikeColl.estimateVarianceAcrossTrials(numBasis, windowTimes,...
    numVarEstIter,fitType);
A=eye(numBasis,numBasis);
delta = 1/spikeColl.sampleRate;

%% Run the SSGLM Filter


Q0d=diag(Q0);
neuronName = psthResult.neuronNumber;
[xK,WK, WkuFinal,Qhat,gammahat,fitResults,stimulus,stimCIs,logll,...
    QhatAll,gammahatAll,nIter]=DecodingAlgorithms.PPSS_EMFB(A,Q0d,x0,...
    dN,fitType,delta,gamma0,windowTimes, numBasis,neuronName);

fR = fitResults.toStructure;
psthR = psthResult.toStructure;


fitResults = FitResult.fromStructure(fR);
psthResult = FitResult.fromStructure(psthR);


