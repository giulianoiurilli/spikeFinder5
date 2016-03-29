
nodors = 15;
mua = [];
muaSpikeCount1 = [];
bigMua = [];
idxU = 0;
cellLog = [];
auROCValence = [];
infoValence = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length((espe(idxExp).shankNowarp(idxShank).cell));
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxU = idxU + 1;
                for idxOdor = 1:nodors
                    for idxTrial = 1:10
%                         mua(idxU,:,idxTrial, idxOdor) = spikeDensity(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:), 0.1);
                        muaSpikeCount1(idxU,idxTrial, idxOdor) = double(sum(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,15001:16000)));
%                         muaSpikeCount(idxU, :, idxTrial, idxOdor) = slidePSTH(double(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:)), 200, 50);                        
                    end
                    responsiveNeurons(idxU,idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                end
%                 auROCValence(idxU) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).auROC1sBetweenValenceClassIdentity;
%                 infoValence(idxU) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1sBetweenValenceClassIdentity;
%                   info1s(idxU) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                cellLog(idxU,:) = [idxExp, idxShank, idxUnit];
            end
        end
    end
end

%%
% figure;
% distributionPlot(auROCValence(:),'histOri','right','color','r','showMM',0, 'globalNorm', 1,'xyOri', 'flipped')
% figure;
% distributionPlot(infoValence(:),'histOri','right','color','r','showMM',0, 'globalNorm', 1,'xyOri', 'flipped')
figure;
distributionPlot(info1s(:),'histOri','right','color','r','showMM',0, 'globalNorm', 1,'xyOri', 'flipped')
%%
m=nan(size(cellLog,1),nodors);
v=nan(size(cellLog,1),nodors);
FF=nan(size(cellLog,1),nodors);
varG=nan(size(cellLog,1),nodors);
for idxCell = 1:size(cellLog,1)
    for idxOdor = 1:nodors
        resp = [];
        resp = double(squeeze(muaSpikeCount1(idxCell,:, idxOdor)));
        m(idxCell,idxOdor)= mean(resp);
        v(idxCell,idxOdor) = var(resp);
        FF(idxCell,idxOdor) = v(idxCell,idxOdor)./m(idxCell,idxOdor);
        varG(idxCell,idxOdor) = partNeuralVariance(resp);
    end
end
%%

meanVarGCoa = nanmean(varGCoa(:,1:10));
semVarGCoa = nanstd(varGCoa(:,1:10)) ./ sqrt(size(varGCoa(~isnan(varGCoa)),1));
meanVarGPcx = nanmean(varGPcx(:,1:10));
semVarGPcx = nanstd(varGPcx(:,1:10)) ./ sqrt(size(varGPcx(~isnan(varGPcx)),1));
meanMCoa = nanmean(mCoa(:,1:10));
semMCoa = nanstd(mCoa(:,1:10)) ./ sqrt(size(mCoa(~isnan(mCoa)),1));
meanMPcx = nanmean(mPcx(:,1:10));
semMPcx = nanstd(mPcx(:,1:10)) ./ sqrt(size(mPcx(~isnan(mPcx)),1));
meanVarGCoa(6) = 1.042;
semVarGCoa(6) = 0.0388;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot([1:5], meanVarGCoa(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC)
hold on
errbar([1:5], meanVarGCoa(1:5), semVarGCoa(1:5), 'color', coaC, 'linewidth', 2);
hold on
plot([1:5] + 0.2, meanVarGPcx(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC)

hold on
errbar([1:5] + 0.2, meanVarGPcx(1:5), semVarGPcx(1:5), 'color', pcxC, 'linewidth', 2);

set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot([6:10], meanVarGCoa(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([6:10] + 0.2, meanVarGPcx(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([6:10], meanVarGCoa(6:10), semVarGCoa(6:10), 'color', coaC, 'linewidth', 2);
hold on
errbar([6:10] + 0.2, meanVarGPcx(6:10), semVarGPcx(6:10), 'color', pcxC, 'linewidth', 2);
xlim([0 11])
ylim([0 3])
set(gca,'box','off')
set(gca,'TickDir', 'out')
xlabel('Odor ID')
ylabel('Variance of the Mean Firing Rate - 1000 ms')

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot([1:5], meanMCoa(1:5), 'o', 'markersize', 10, 'markeredgecolor', coaC)
hold on
plot([1:5] + 0.2, meanMPcx(1:5), 'o', 'markersize', 10, 'markeredgecolor', pcxC)
hold on
errbar([1:5], meanMCoa(1:5), semMCoa(1:5), 'color', coaC, 'linewidth', 2);
hold on
errbar([1:5] + 0.2, meanMPcx(1:5), semMPcx(1:5), 'color', pcxC, 'linewidth', 2);
xlim([0 11])

plot([6:10], meanMCoa(6:10), 'o', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([6:10] + 0.2, meanMPcx(6:10), 'o', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([6:10], meanMCoa(6:10), semMCoa(6:10), 'color', coaC, 'linewidth', 2);
hold on
errbar([6:10] + 0.2, meanMPcx(6:10), semMPcx(6:10), 'color', pcxC, 'linewidth', 2);
xlim([0 11])
%ylim([0 3])
set(gca,'box','off')
set(gca,'TickDir', 'out')
xlabel('Odor ID')
ylabel('Mean Firing Rate - 1000 ms')






%%
figure
hold on
for idxO = 4
    plot(m(:,idxO), v(:,idxO), 'ko')
end
for idxO = 6
    plot(m(:,idxO), v(:,idxO), 'ro')
end
hold off

[~,~,stats] = anova1(varG)
multcompare(stats)

%%
nodors = 10;
mua = [];
muaSpikeCount1 = [];
bigMua = [];
idxU = 0;
cellLog = [];
auROCValence = [];
infoValence = [];
shank = [];
for idxShank = 1:4
    idxU = 0;
    for idxExp = 1:length(esp)
        for idxUnit = 1:length((espe(idxExp).shankNowarp(idxShank).cell));
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxU = idxU + 1;
                for idxOdor = 1:nodors
                    shank{idxShank}.digResp(idxU,idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    shank{idxShank}.anResp(idxU,idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
end

for idxShank = 1:4
    av(idxShank,:) = sum(shank{idxShank}.digResp) ./ repmat(size(shank{idxShank}.digResp,1),1, nodors);
end
figure; plot(av(:,6:10))
    