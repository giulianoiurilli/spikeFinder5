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
                muaSpikeCount(idxU,idxTrial, idxOdor) = esp(1).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse2000ms(idxTrial);
            end
        end
        cellLog(idxU,:) = [idxShank, idxUnit];
    end
%     for idxOdor = 1:14
%         for idxTrial = 1:10
%             bigMua(idxShank,:,idxTrial, idxOdor) = spikeDensity(shankMua(idxShank).odor(idxOdor).spikeMatrixMua(idxTrial,:), 0.1);
%         end
%     end
end






%%
n_trials = 10;
sniffKeep = nan(10,297,7);
popActivityKeep = nan(10,298,7);
sdfKeep = nan(10,298,7);

idxShank = 1;
idxUnit = 5;
cellID = [idxShank idxUnit];
idxCell = find(ismember(cellLog,cellID,'rows'));
thisSUA = squeeze(mua(idxCell,:,:,:));
thisSUASpikeCount = squeeze(muaSpikeCount(idxCell,:,:,[11 2 4 8 12 13 14]));
otherSUA = mua;
otherSUA(idxCell,:,:,:) = [];
time = -15:1/1000:15;
time(end) = [];
idxO = 0;
sniffKeep = nan(10,297,7);
moveActivityKeep = nan(10,298,7);
popActivityKeep = nan(10,298,7);
sdfKeep = nan(10,298,7);
for idxOdor = [11 2 4 8 12 13 14]
    idxO = idxO + 1;
    figure;
    set(gcf,'Position',[-1820 674 1532 296]);
    clear p
    p = panel();
    p.pack('v', {1/4 1/4 1/4 1/4});
    p(1).pack('h', {1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10});
    p(2).pack('h', {1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10});
    p(3).pack('h', {1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10});
    p(4).pack('h', {1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10 1/10});
    sniffData = nan(1,30000);
    for idxTrial = 1:n_trials
        p(1,idxTrial).select()
        sniffData = simSniff(breath, idxOdor, idxTrial);
        [s, f, t, po] = spectrogram(sniffData, 400, 300, [], 1000);
        [q, nd] = max(10*log10(po));
        x = smooth(f(nd))';
        sniffKeep(idxTrial,:,idxO) = x;
        plot(t, x, '-r')
        ylim([0 10]);
        xlim([13 19])
        p(2,idxTrial).select()
        moveData = abs(squeeze(move(idxTrial,:,idxOdor)));
        plot(time(13000:19000), moveData(13000:19000), '-c');
        xlim([-2 4])
        moveActivityKeep(idxTrial,:,idxO)= moveData(200:100:end-1);
        p(3,idxTrial).select()
        popActivity = squeeze(sum(otherSUA(:,:,idxTrial,idxOdor),1));
        plot(time(13000:19000), popActivity(13000:19000), '-b')
        popActivityKeep(idxTrial,:,idxO)= popActivity(200:100:end);
        ylim([0 0.15]);
        xlim([-2 4])
        p(4,idxTrial).select()
        sdf = squeeze(thisSUA(:,idxTrial, idxOdor));
        sdfKeep(idxTrial,:,idxO) = sdf(200:100:end);
        plot(time(13000:19000), sdf(13000:19000), '-k')
        ylim([0 0.06]);
        xlim([-2 4])
        
        
        
        %         spikeTimes = Data.Spiketimes.Experiment(1).Shank(4).spiketimes{idxTrial, idxOdor, cell};
        %         nst = nspikeTrain(spikeTimes);
        %         spikeColl = nstColl(nst);
        %         spikeColl.setMinTime(13); spikeColl.setMaxTime(19);
        
        p.select('all');
        p.de.margin = 10;
        p(1).marginbottom = 10;
        p(2).marginbottom = 10;
        p(3).marginbottom = 10;
    end
end
popActivityKeep(:,end,:) = [];
sdfKeep(:,end,:) = [];
moveActivityKeep(:,end,:) = [];
%%
sdfKeepMean = squeeze(mean(sdfKeep(:,149:169,:),2));
popActivityKeepMean = squeeze(mean(popActivityKeep(:,149:169,:),2));
sniffKeepMean = squeeze(mean(sniffKeep(:,149:169,:),2));
moveActivityKeepMean = squeeze(mean(moveActivityKeep(:,149:169,:),2));
thisSUASpikeCount = thisSUASpikeCount(:);
odorID = repmat(1:7,10,1);
trialID = repmat([0:9]', 1, 7);

%%
spikeCounts = thisSUASpikeCount(:);
sdfKeepMean = sdfKeepMean(:);
popActivityKeepMean = popActivityKeepMean(:);
sniffKeepMean = sniffKeepMean(:);
moveActivityKeepMean = moveActivityKeepMean(:);
odorID = odorID(:);
trialID = trialID(:);
sua = sdfKeepMean;
pop = popActivityKeepMean;
resp = sniffKeepMean;
mov = moveActivityKeepMean;
%%
figure()
subplot(2,3,1)
gscatter(popActivityKeepMean,sdfKeepMean, odorID, [], 'ooo')
title('SUA vs MUA grouped by odor')
subplot(2,3,2)
gscatter(sniffKeepMean,sdfKeepMean, odorID, [], 'ooo')
title('SUA vs sniffing rate grouped by odor')
subplot(2,3,3)
gscatter(moveActivityKeepMean,sdfKeepMean, odorID, [], 'ooo')
title('SUA vs movement grouped by odor')
subplot(2,3,4)
gscatter(popActivityKeepMean,sdfKeepMean, trialID, [], 'ooo')
title('SUA vs MUA grouped by trial')
subplot(2,3,5)
gscatter(sniffKeepMean,sdfKeepMean, trialID, [], 'ooo')
title('SUA vs sniffing rate grouped by trail')
subplot(2,3,6)
gscatter(moveActivityKeepMean,sdfKeepMean, trialID, [], 'ooo')
title('SUA vs movement grouped by trail')

%%
% sua = zscore(sdfKeepMean);
pop = zscore(popActivityKeepMean);
mov = zscore(moveActivityKeepMean);
% resp  = zscore(sniffKeepMean);
%%
responses = [];
responses = table(spikeCounts,sua,pop,resp, mov, trialID, odorID);
responses.odorID = nominal(responses.odorID);
%responses.trialID = nominal(responses.trialID);
fit0 = stepwiselm(responses, 'constant', 'ResponseVar', 'sua', 'PredictorVars', {'pop', 'resp', 'odorID', 'trialID', 'mov'})
% fit0 = stepwiselm(responses, 'constant', 'ResponseVar', 'sua', 'PredictorVars', {'resp', 'odorID'})
% fit0 = stepwiselm(responses, 'sua~resp', 'ResponseVar', 'sua', 'PredictorVars', {'pop', 'resp', 'odorID', 'trialID'})
% fit1 = fitlm(responses, 'ResponseVar', 'sua', 'PredictorVars', {'pop'})
% fit2 = fitlm(responses, 'ResponseVar', 'sua', 'PredictorVars', {'resp'})
% fit3 = fitlm(responses, 'ResponseVar', 'sua', 'PredictorVars', {'odorID'})
% fit4 = fitlm(responses, 'ResponseVar', 'sua', 'PredictorVars', {'trialID'})
% fit5 = fitlm(responses, 'sua ~ resp  + odorID + trialID + odorID*trialID')

%%
fit10 = stepwiseglm(responses, 'constant', 'ResponseVar', 'spikeCounts', 'PredictorVars', {'pop', 'resp', 'odorID', 'trialID', 'mov'}, 'Distribution', 'Poisson', 'DispersionFlag', 0, 'Criterion', 'bic')

%fit20 = stepwiselm(responses, 'constant', 'ResponseVar', 'pop', 'PredictorVars', { 'resp', 'odorID', 'trialID'})




