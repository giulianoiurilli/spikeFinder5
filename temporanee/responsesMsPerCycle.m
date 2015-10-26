load('breathing.mat', 'sniffs');
for idxOdor = 1:odors
idxShank = 3;
idxUnit = 3;
%idxOdor = 13;

windowLength = 300;


A = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
C = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
firingRest = zeros(n_trials, 2*windowLength, 9);
firingOdor = zeros(n_trials, 2*windowLength, 9);
firingRestSum = zeros(n_trials, windowLength, 9);
firingOdorSum = zeros(n_trials, windowLength, 9);
for idxTrial = 1:n_trials
    snif = [];
    idxSniffsRest = [];
    idxSniffsOdor = [];
    snif = sniffs(idxOdor).trial(idxTrial).sniffPower(:,1)';
    onset = find(snif>0,1);
    idxSniffsRest = floor(15000 + floor(snif(onset-9:onset-1)*1000));
    idxSniffsOdor = floor(floor(snif(onset:onset+8)*1000) + 15000);
    for idxSnif = 1:9
        firingRest(idxTrial,:,idxSnif) = A(idxTrial, idxSniffsRest(idxSnif) - windowLength + 1 : idxSniffsRest(idxSnif) + windowLength);
        firingRestSum(idxTrial,:,idxSnif) = cumsum(C(idxTrial, idxSniffsRest(idxSnif) + 1 : idxSniffsRest(idxSnif) + windowLength),2);
        firingOdor(idxTrial,:,idxSnif) = A(idxTrial, idxSniffsOdor(idxSnif) - windowLength + 1 : idxSniffsOdor(idxSnif) + windowLength);
        firingOdorSum(idxTrial,:,idxSnif) = cumsum(C(idxTrial, idxSniffsOdor(idxSnif) + 1 : idxSniffsOdor(idxSnif) + windowLength),2);
    end
end





figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[121 60 1235 738]);

xtime = -windowLength+1:windowLength;
xtime = repmat(xtime',1,n_trials);
xtime2 = 1:windowLength;
xtime2 = repmat(xtime2',1,n_trials);
for idxPlot = 1:9
    meanFiring = [];
    subplot(4,9,idxPlot)
    plot(xtime,firingRest(:,:,idxPlot)', 'color', [189,189,189]/255)
    hold on
    meanFiring = mean(squeeze(firingRest(:,:,idxPlot)));
    plot(xtime(:,1)', meanFiring, 'lineWidth', 2, 'color', 'k');
    hold off
    axis tight
    set(gca,'ylim',[0, 0.14]);
end
for idxPlot = 1:9
    subplot(4,9,idxPlot + 9)
    meanFiring = [];
    plot(xtime,firingOdor(:,:,idxPlot)','color', [189,189,189]/255)
    hold on
    meanFiring = mean(squeeze(firingOdor(:,:,idxPlot)));
    plot(xtime(:,1)', meanFiring, 'lineWidth', 2, 'color', 'r');
    hold off
    axis tight
    set(gca,'ylim',[0, 0.14]);
end
for idxPlot = 1:9
    subplot(4,9,idxPlot + 18)
    plot(xtime2,firingRestSum(:,:,idxPlot)','color', [189,189,189]/255)
    hold on
    meanFiring = mean(squeeze(firingRestSum(:,:,idxPlot)));
    plot(xtime2(:,1)', meanFiring, 'lineWidth', 2, 'color', 'k');
    hold off
    axis tight
    set(gca,'ylim',[0, 15]);
end
for idxPlot = 1:9
    subplot(4,9,idxPlot + 27)
    meanFiring = [];
    plot(xtime2,firingOdorSum(:,:,idxPlot)','color', [189,189,189]/255)
    hold on
    meanFiring = mean(squeeze(firingOdorSum(:,:,idxPlot)));
    plot(xtime2(:,1)', meanFiring, 'lineWidth', 2, 'color', 'r');
    hold off
    axis tight
    set(gca,'ylim',[0, 15]);
end

end
