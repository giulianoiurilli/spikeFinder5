clear
load('units.mat');

idxShank = 1;
idxUnit = 1;
idxOdor = 6;
n_trials = 10;
varianzaG_resp = 0.2;


delta = 0.001;
time = 0:delta:10;
time(end-1:end) = [];
r_resp = 1/varianzaG_resp;
s_resp = varianzaG_resp;
numRealizations = 1;
clear spikeCollSim
clear lambda


for idxTrial = 1:n_trials
    G_resp = gamrnd(r_resp,s_resp);
    actualResponse = (mean(squeeze(shank(idxShank).SUA.sdf_trial{idxUnit}(:,:,idxOdor))) * 1000) * G_resp;
    mu(idxTrial,:) = actualResponse;
    lambda = Covariate(time,actualResponse, '\lambda(t)','time','s',...
        'spikes/sec',{'\lambda_{1}'},{{' ''b'', ''LineWidth'' ,2'}});
    spikeCollSim{idxTrial} = CIF.simulateCIFByThinningFromLambda(lambda,numRealizations);
    a{idxTrial} = spikeCollSim{idxTrial}.nstrain{1,1}.spikeTimes;
end


figure
LineFormat.Color =  'k';
plotSpikeRaster(a,'PlotType','vertline', 'VertSpikeHeight', 1, 'LineFormat', LineFormat);
set(gca,'XColor','w')
set(gca,'YColor','w')
