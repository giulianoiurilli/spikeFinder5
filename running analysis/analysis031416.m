%% Generate a gamma process by approximating a log-normal distribution of the neuronal response (LN model)

% The stimulus is close or distant to the preferred stimulus for the neuron
% (correlation close to 1 or -1), however there is some gaussian noise in the
% stimulus
% Tha variance of the gaussian process shrinks as the stimulus becomes less noisy 

stimulusDrive1 = random('normal', 1.5,1, 1,1000);
neuronLambda1 = exp(stimulusDrive1);
mean(neuronLambda1)
spikeCount1 = poissrnd(neuronLambda1);
mean(spikeCount1)
stimulusDrive2 = random('normal', 0,1, 1,1000);
neuronLambda2 = exp(stimulusDrive2);
spikeCount2 = poissrnd(neuronLambda2);
stimulusDrive3 = random('normal', 2,0.05, 1,1000);
neuronLambda3 = exp(stimulusDrive3);
mean(neuronLambda1)
spikeCount3 = poissrnd(neuronLambda3);
mean(spikeCount3)
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[138 281 1352 739]);

subplot(3,3,1)
h1 = histogram(stimulusDrive1, 'Normalization', 'pdf');
h1.FaceColor = [255,127,0]/255;
h1.EdgeColor = [255,127,0]/255;
xlim([-5 5]);
title('The stimulus is close to the best one for this cell, but it is noisy')
box off
subplot(3,3,4)
h2 = histogram(neuronLambda1, 'Normalization', 'pdf');
h2.FaceColor = [51,160,44]/255;
h2.EdgeColor = [51,160,44]/255;
hold on
pd = fitdist(neuronLambda1(:), 'gamma');
x = 0:0.1:50; hold on; y = pdf(pd, x); plot(x, y, '-r')
hold off
xlim([0 50]);
ylabel('Stimulus-Driven Firing Rate Distribution')
box off
subplot(3,3,7)
h2 = histogram(spikeCount1, 'Normalization', 'pdf');
h2.FaceColor = [31,120,180]/255;
h2.EdgeColor = [31,120,180]/255;
hold on
pd = fitdist(spikeCount1(:), 'poisson');
x = 0:50; y = pdf(pd, x); plot(x, y, '-k')
pd = fitdist(spikeCount1(:), 'NegativeBinomial');
x = 0:50;  y = pdf(pd, x); plot(x, y, '-')
hold off
xlim([0 50]);
ylabel('Observed Firing Rate Distribution')
box off

subplot(3,3,2)
h1 = histogram(stimulusDrive2, 'Normalization', 'pdf');
h1.FaceColor = [255,127,0]/255;
h1.EdgeColor = [255,127,0]/255;
xlim([-5 5]);
title('The stimulus is far from the best one for this cell, but it is noisy')
box off
subplot(3,3,5)
h2 = histogram(neuronLambda2, 'Normalization', 'pdf');
h2.FaceColor = [51,160,44]/255;
h2.EdgeColor = [51,160,44]/255;
hold on
pd = fitdist(neuronLambda2(:), 'gamma');
x = 0:0.1:50; hold on; y = pdf(pd, x); plot(x, y, '-r')
hold off
xlim([0 50]);
box off
subplot(3,3,8)
h2 = histogram(spikeCount2, 'Normalization', 'pdf');
h2.FaceColor = [31,120,180]/255;
h2.EdgeColor = [31,120,180]/255;
hold on
pd = fitdist(spikeCount2(:), 'poisson');
x = 0:50; y = pdf(pd, x); plot(x, y, '-k')
pd = fitdist(spikeCount2(:), 'NegativeBinomial');
x = 0:50; y = pdf(pd, x); plot(x, y, '-')
hold off
xlim([0 50]);
box off

subplot(3,3,3)
h1 = histogram(stimulusDrive3, 'Normalization', 'pdf');
h1.FaceColor = [255,127,0]/255;
h1.EdgeColor = [255,127,0]/255;
xlim([-5 5]);
title('The stimulus is close to the best one for this cell, but it is not noisy')
box off
subplot(3,3,6)
h2 = histogram(neuronLambda3, 'Normalization', 'pdf');
h2.FaceColor = [51,160,44]/255;
h2.EdgeColor = [51,160,44]/255;
hold on
pd = fitdist(neuronLambda3(:), 'gamma');
x = 0:0.1:50; hold on; y = pdf(pd, x); plot(x, y, '-r')
hold off
xlim([0 50]);
box off
subplot(3,3,9)
h3 = histogram(spikeCount3, 'Normalization', 'pdf');
h3.FaceColor = [31,120,180]/255;
h3.EdgeColor = [31,120,180]/255;
hold on
pd = fitdist(spikeCount3(:), 'poisson');
x = 0:50; y = pdf(pd, x); plot(x, y, '-k')
pd = fitdist(spikeCount3(:), 'NegativeBinomial');
x = 0:50; y = pdf(pd, x); plot(x, y, '-')
hold off
xlim([0 50]);
box off
%%
% %% Generate a gamma process as a sum of N inputs with same mean Mu and exponential distribution
% % In this case the variance of the gamma process increase with the number
% % of inputs.
% % The more inputs for the same stimulus the neuron gets (preferred stimulus) the more large and variable becomes its response
% 
% inputs1 = random('Exponential', 10, 50, 1000);
% inputs2 = random('Exponential', 10, 10, 1000);
% neuronLambda1 = sum(inputs1); 
% neuronLambda2 = sum(inputs2); 
% figure
% subplot(1,2,1)
% h2 = histogram(neuronLambda1, 'Normalization', 'pdf');
% h2.FaceColor = [51,160,44]/255;
% h2.EdgeColor = [51,160,44]/255;
% hold on
% pd = fitdist(neuronLambda1(:), 'gamma');
% x = 0:0.1:14; hold on; y = pdf(pd, x); plot(x, y, '-r')
% hold off
% % xlim([0 10]);
% subplot(1,2,2)
% h2 = histogram(neuronLambda2, 'Normalization', 'pdf');
% h2.FaceColor = [51,160,44]/255;
% h2.EdgeColor = [51,160,44]/255;
% hold on
% pd = fitdist(neuronLambda2(:), 'gamma');
% x = 0:0.1:14; hold on; y = pdf(pd, x); plot(x, y, '-r')
% hold off
% % xlim([0 10]);
% 
% %% generate a log-normal as a multiplication of many normal inputs
% inputs1 = random('Normal', 0.05, 0.1, 50, 1000);
% inputs2 = random('Normal', 0.05, 0.01, 50, 1000);
% neuronLambda1 = exp(sum(inputs1)); 
% neuronLambda2 = exp(sum(inputs2)); 
% figure
% subplot(1,2,1)
% h2 = histogram(neuronLambda1, 'Normalization', 'pdf');
% h2.FaceColor = [51,160,44]/255;
% h2.EdgeColor = [51,160,44]/255;
% hold on
% pd = fitdist(neuronLambda1(:), 'gamma');
% x = 0:0.1:100; hold on; y = pdf(pd, x); plot(x, y, '-r')
% hold off
% % xlim([0 10]);
% subplot(1,2,2)
% h2 = histogram(neuronLambda2, 'Normalization', 'pdf');
% h2.FaceColor = [51,160,44]/255;
% h2.EdgeColor = [51,160,44]/255;
% hold on
% pd = fitdist(neuronLambda2(:), 'gamma');
% x = 0:0.1:100; hold on; y = pdf(pd, x); plot(x, y, '-r')
% hold off
% 
% 
% 
% %%
idxExp = 1;

mua = [];
muaSpikeCount = [];
bigMua = [];
idxU = 0;
for idxShank = 1:4
    for idxUnit = 1:length((espe(idxExp).shankNowarp(idxShank).cell));
        idxU = idxU + 1;
        for idxOdor = 1:14
            for idxTrial = 1:10
                mua(idxU,:,idxTrial, idxOdor) = spikeDensity(espe(1).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:), 0.1);
                muaSpikeCount1(idxU,idxTrial, idxOdor) = double(sum(espe(1).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,15001:15300)));
                muaSpikeCount2(idxU,idxTrial, idxOdor) = double(sum(espe(1).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,15500:17000)));
                muaSpikeCount(idxU, :, idxTrial, idxOdor) = slidePSTH(double(espe(1).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:)), 200, 50);
            end
        end
        cellLog(idxU,:) = [idxShank, idxUnit];
    end
end
clear sniffData sniffF
for idxOdor = 1:14
    for idxTrial = 1:10
        sniffData(:,idxTrial,idxOdor) = simSniff(breath, idxOdor, idxTrial);
        A = squeeze(sniffData(:,idxTrial,idxOdor));
        [s, f, t, po] = spectrogram(A, 400, 300, [], 1000);
        [q, nd] = max(10*log10(po));
        x = smooth(f(nd))';
        sniffF(:,idxTrial,idxOdor) = x;
    end
end
% 
% n_trials = 10;
% %%
% odors = 1:14;
% idxCell = 0;
% for idxExp =  1:length(espe)
%     for idxShank = 1:4
%         for idxUnit = 1:length(espe(idxExp).shankNowarp(idxShank).cell)
%             %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
%                 idxCell = idxCell + 1;
%                 for idxOdor = odors
%                     for idxTrial = 1:n_trials
%                         Data.Spiketimes.Experiment(idxExp).Shank(idxShank).spiketimes{idxTrial, idxOdor, idxUnit} = find(double(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:))==1)./1000;
%                     end
%                 end
%             %end
%         end
%     end
% end
% 

%%

m=nan(size(cellLog,1),14);
v=nan(size(cellLog,1),14);
FF=nan(size(cellLog,1),14);
varG=nan(size(cellLog,1),14);
for idxCell = 1:size(cellLog,1)
    for idxOdor = 1:14
        resp = [];
        resp = double(squeeze(muaSpikeCount1(idxCell,:, idxOdor)));
        m(idxCell,idxOdor)= mean(resp);
        v(idxCell,idxOdor) = var(resp);
        varG(idxCell,idxOdor) = partNeuralVariance(resp);
    end
end

figure;
hold on
for idxCell = 1:size(cellLog,1)
plot([1:14],m(idxCell,:), 'k-')
end
plot([1:14],nanmean(m), 'r-', 'linewidth', 2)
hold off
figure;
hold on
for idxCell = 1:size(cellLog,1)
plot([1:14],varG(idxCell,:), 'k-')
end
plot([1:14],nanmean(varG), 'r-', 'linewidth', 2)
hold off



figure;
plot(nanmean(m),nanmean(varG), 'ko')

figure
hold on
c = ['r', 'g', 'b'];
idxi = 0;
for idx = [1 7 2]
    idxi = idxi + 1;
    plot(m(:,idx), v(:,idx), 'o', 'color', c(idxi))
end
hold off


%%
idxExp = 1;
idxShank = 3;
idxUnit = 1;


cellID = [idxShank idxUnit];
idxCell = find(ismember(cellLog,cellID,'rows'));

clear m v FF varG

for idxOdor = 1:14
    resp = [];
    resp = double(squeeze(muaSpikeCount1(idxCell,:, idxOdor)));
    m(idxOdor)= mean(resp);
    v(idxOdor) = var(resp);
    FF(idxOdor) = v/m;
    varG(idxOdor) = partNeuralVariance(resp);
end
figure
plot(m, v, 'ro')
line([0 max(v)], [0 max(v)])
ylim([0 max(v)+20])
xlim([0 max(v)+20])

figure
plot([1:14],sqrt(varG), 'r-')



%%
idxExp = 1;
idxShank = 4;
idxUnit = 3;


cellID = [idxShank idxUnit];
idxCell = find(ismember(cellLog,cellID,'rows'));

clear resp m v FF varG msniff vsniff
idxO = 0;
for idxOdor = 1:14
    idxO = idxO + 1;
    resp = [];
    sniff = [];
    resp = double(squeeze(muaSpikeCount(idxCell,:, :,idxOdor)))';
    sniff = squeeze(sniffF(:,:,idxOdor))';
    m(:, idxO) = mean(resp)';
    v(:, idxO) = var(resp)';
    FF(:, idxO) = v(:, idxO)./m(:, idxO);
    msniff(:, idxO) = mean(sniff)';
    vsniff(:, idxO) = var(sniff)';
    for idxBin = 1:size(resp,2)
        varG(idxBin, idxO) = partNeuralVariance(resp(:,idxBin));
    end
end

%%
idxO1 = 4;
idxO2 = 12;
figure
subplot(6,1,1)
plot(m(:,idxO1))
hold on
plot(m(:,idxO2))
hold off
xlim([260 400])
subplot(6,1,2)
plot(v(:,idxO1))
hold on
plot(v(:,idxO2))
hold off
xlim([260 400])
subplot(6,1,3)
plot(FF(:,idxO1))
hold on
plot(FF(:,idxO2))
hold off
xlim([260 400])
subplot(6,1,4)
plot(varG(:,idxO1))
hold on
plot(varG(:,idxO2))
hold off
xlim([260 400])
subplot(6,1,5)
plot(msniff(:,idxO1))
hold on
plot(msniff(:,idxO2))
hold off
xlim([130 200])
subplot(6,1,6)
plot(vsniff(:,idxO1))
hold on
plot(vsniff(:,idxO2))
hold off
xlim([130 200])



%%
time = 0:1/1000:6;


idxOdor = 6;
cellID = 4;
cellID = [idxShank idxUnit];
idxCell = find(ismember(cellLog,cellID,'rows'));
figure
hold on
for idxTrial = 1:n_trials
    spikeTimes{idxTrial} = Data.Spiketimes.Experiment(idxExp).Shank(idxShank).spiketimes{idxTrial, idxOdor, idxUnit};
    nst{idxTrial} = nspikeTrain(spikeTimes{idxTrial});
    nst{idxTrial}.setName(num2str(cellID));
    plot(time,squeeze(mua(idxCell,13000:19000,idxTrial, idxOdor)), '-k')
end
plot(time,squeeze(mean(mua(idxCell,13000:19000,:, idxOdor),3)), '-r', 'linewidth', 2)
hold off
minTime = 13;
maxTime = 19;
spikeColl = nstColl(nst);
figure
spikeColl.setMinTime(minTime); spikeColl.setMaxTime(maxTime);
spikeColl.plot;
