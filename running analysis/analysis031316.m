clear all
close all
delta = 0.001;
TmaxResponse1 = 2;
TmaxResponse2 = 1;
TmaxBaseline = 2;
time1 = 0:delta:TmaxResponse1;
time2 = 0:delta:TmaxResponse2;
time0 = 0:delta:TmaxBaseline;

time = 0:delta:TmaxResponse1+TmaxResponse2 + 2*TmaxBaseline;
f = 4;
l1 = -6;
n1 = 1;

for i = 1:10
    varianzaG = 1;
    r = 1/varianzaG;
    s = varianzaG^2;
    k = gamrnd(r,s);
    stim1 = -n1*exp(l1*time1) + k*10;
    l2 = -4;
    n2 = 1;
    stim2 = n2*exp(l2*time2) + 1;
    baseline = n1*ones(1,TmaxBaseline*1/delta);
    
    stim = [baseline stim1 stim2 baseline];
    stim(end) = [];
    % figure; plot(time, stim)
    
    lambdaData = stim;
    resp1 = sin(2*pi*f*time1) .* exp(-10*time1)+0.1;
    resp2 = sin(2*pi*f*time2)+0.5;
    resp0 = sin(2*pi*f*time0)+0.5;
    resp = [resp0 resp1 resp2 resp0];
    resp(end-2:end) = [];
    lambdaData = stim .* resp;
    % figure; plot(time, lambdaData)
    
    
    
    lambda = Covariate(time,lambdaData, '\lambda(t)','time','s',...
        'spikes/sec',{'\lambda_{1}'},{{' ''b'', ''LineWidth'' ,2'}});
    numRealizations = 1;
    spikeCollSim{i} = CIF.simulateCIFByThinningFromLambda(lambda,numRealizations);
    % figure()
    % spikeCollSim.plot;
    
    
    a{i} = spikeCollSim{i}.nstrain{1,1}.spikeTimes;
    spikeCount(i) = numel(a{i}(find(a{i}>2&a{i}<4)));
end
LineFormat.Color =  'k';
plotSpikeRaster(a,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[0 7], 'LineFormat', LineFormat);

mean(spikeCount)
var(spikeCount)

[sN, sPP, sG, sN_empirical, lHat, varGHat] = partNeuralVariance(spikeCount)
%%
idxExp = 1;
idxShank = 4;
idxUnit = 3;
idxOdor = 6;

cellID = 1;
for idxTrial = 1:n_trials
    spikeTimes{idxTrial} = Data.Spiketimes.Experiment(idxExp).Shank(idxShank).spiketimes{idxTrial, idxOdor, idxUnit};
    nst{idxTrial} = nspikeTrain(spikeTimes{idxTrial});
    nst{idxTrial}.setName(num2str(cellID));
end
minTime = 10;
maxTime = 25;
spikeColl = nstColl(nst);
psthUnit = spikeColl.psth(0.1);
figure
h1 = psthUnit.plot([], {{' ''k'', ''Linewidth'', 2'}});

spikeColl.setMinTime(13); spikeColl.setMaxTime(19);
figure;
spikeColl.plot;

snipCellOdorSniff = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);

[respCellOdorPairPSTHExcMn, respCellOdorPairPSTHExcSd, respCellOdorPairPSTHExcFF, respCellOdorPairPSTHExcCV] = slidePSTH(snipCellOdorSniff, 100, 5);
figure;
plot(respCellOdorPairPSTHExcMn)
figure;
plot(respCellOdorPairPSTHExcFF)



cellID = [idxShank idxUnit];
idxCell = find(ismember(cellLog,cellID,'rows'));
thisSUA = squeeze(mua(idxCell,:,:,idxOdor))';
lData = mean(thisSUA)*1000;

delta = 0.001;
time = 0:delta:30;
time(end-1:end) = [];

figure;
plot(time, lData)

stimDrive = (lData - min(lData)) ./ (max(lData) - min(lData));
figure;
plot(time, stimDrive)


%%
delta = 0.001;
time = 0:delta:30;
time(end-1:end) = [];
x = ones(1,29999);
r = length(x(15000:17099));
lambdaRest = 5;
lambdaResp = linspace(30,5,r);
offset = 4;
baseline1 = x(1:15000) * lambdaRest;
baseline2 = x(17100:29999) * lambdaRest;
response = x(15000:17099) .* lambdaResp;

Fs = 1000;
%Period
t = 0:1/Fs:30;
t(end-1:end) = [];
%Frequency
f = 3;
%Generate
resp = sin(2*pi*f*t);



varianzaG_rest = 0.8;
r_rest = 1/varianzaG_rest;
s_rest = varianzaG_rest;
varianzaG_resp = 0.2;
r_resp = 1/varianzaG_resp;
s_resp = varianzaG_resp;
numRealizations = 1;
clear spikeCollSim
clear lambda
for idxTrial = 1:10
    G_rest = gamrnd(r_rest,s_rest);
    G_resp = gamrnd(r_resp,s_resp);
    bsl1 = baseline1 * G_rest;
    bsl2 = baseline2 * G_rest;
    rsp = response * G_resp;
    trace = [bsl1 rsp bsl2];
    trace(end) = [];
%     trace = trace.* resp;
    mu(idxTrial,:) = trace;
    lambda = Covariate(time,trace, '\lambda(t)','time','s',...
        'spikes/sec',{'\lambda_{1}'},{{' ''b'', ''LineWidth'' ,2'}});
    spikeCollSim{idxTrial} = CIF.simulateCIFByThinningFromLambda(lambda,numRealizations);
    a{idxTrial} = spikeCollSim{idxTrial}.nstrain{1,1}.spikeTimes;
    spikeCount(idxTrial) = numel(a{idxTrial}(find(a{idxTrial}>15 & a{idxTrial}<17)));
    
        G_rest = 1;
    G_resp = 1;
    bsl1 = baseline1 * G_rest;
    bsl2 = baseline2 * G_rest;
    rsp = response * G_resp;
    trace = [bsl1 rsp bsl2];
    trace(end) = [];
    muP(idxTrial,:) = trace;
    lambdaP = Covariate(time,trace, '\lambda(t)','time','s',...
        'spikes/sec',{'\lambda_{1}'},{{' ''b'', ''LineWidth'' ,2'}});
    spikeCollSimP{idxTrial} = CIF.simulateCIFByThinningFromLambda(lambdaP,numRealizations);
    b{idxTrial} = spikeCollSimP{idxTrial}.nstrain{1,1}.spikeTimes;
    spikeCountP(idxTrial) = numel(b{idxTrial}(find(b{idxTrial}>15 & b{idxTrial}<17)));
end

figure
subplot(2,1,1)
hold on
for idxTrial = 1:10
    plot(time, mu(idxTrial,:), 'color', [115,115,115]./255);
end
plot(time, mean(mu), 'color', [215,48,31]./255, 'linewidth', 2); 
xlim([13 19]);
ylim([0 max(mu(:))]);
ylabel('spikes/s')
set(gca, 'XTick' , []);
set(gca, 'XTickLabel', []);
set(gca,'XColor','w')
set(gca,'TickDir','out')
hold off
subplot(2,1,2)
LineFormat.Color =  'k';
plotSpikeRaster(a,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[13 19], 'LineFormat', LineFormat);
set(gca,'XColor','w')
set(gca,'YColor','w')

figure
subplot(2,1,1)
hold on
for idxTrial = 1:10
    plot(time, muP(idxTrial,:), 'color', [115,115,115]./255);
end
plot(time, mean(muP), 'color', [215,48,31]./255, 'linewidth', 2); 
xlim([13 19]);
ylim([0 max(mu(:))]);
ylabel('spikes/s')
set(gca, 'XTick' , []);
set(gca, 'XTickLabel', []);
set(gca,'XColor','w')
set(gca,'TickDir','out')
hold off
subplot(2,1,2)
LineFormat.Color =  'k';
plotSpikeRaster(b,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[13 19], 'LineFormat', LineFormat);
set(gca,'XColor','w')
set(gca,'YColor','w')




mean(spikeCount)
var(spikeCount)
[varGHat, rHat, sHat, mN_empirical, mN_Hat, varN_empirical, varN_Hat, varGFraction ] = partNeuralVariance(spikeCount)




%%
idxExp = 1;
idxShank = 4;
idxUnit = 1;

cellID = [idxShank idxUnit];
idxCell = find(ismember(cellLog,cellID,'rows'));

figure
hold on
for idxOdor = 1:14
    resp = [];
    resp = squeeze(muaSpikeCount(idxCell,:, idxOdor));
    m(idxOdor)= mean(resp);
    v(idxOdor) = var(resp);
    FF(idxOdor) = v/m;
end
plot(m, v, 'ro')
line([0 max(v)], [0 max(v)])
hold off
ylim([0 max(v)+20])
xlim([0 max(v)+20])