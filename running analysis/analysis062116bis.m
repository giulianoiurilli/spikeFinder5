X11 = McoaAA.DeltaRspMean;
X12 = McoaAA.SpikeCount;
X13 = McoaAA.ls;

[~, bestOdorX11] = max(X11, [], 2);
for idxO = 1:10
    idxCells = [];
    idxCells = find(bestOdorX11 == idxO);
    app = nan(1,numel(idxCells));
    for idxC = 1:numel(idxCells)
        app(idxC) = lifetime_sparseness(squeeze(X12(idxCells(idxC),:,1:10)));
    end
    meanAppCoa(idxO) = nanmean(app);
    semAppCoa(idxO) = nanstd(app) ./ sqrt(numel(app) - 1);
end

Y11 = MpcxAA.DeltaRspMean;
Y12 = MpcxAA.SpikeCount;
Y13 = MpcxAA.ls;

[~, bestOdorY11] = max(Y11, [], 2);
for idxO = 1:10
    idxCells = [];
    idxCells = find(bestOdorY11 == idxO);
    app = nan(1,numel(idxCells));
    for idxC = 1:numel(idxCells)
        app(idxC) = lifetime_sparseness(squeeze(Y12(idxCells(idxC),:,1:10)));
    end
    meanAppPcx(idxO) = nanmean(app);
    semAppPcx(idxO) = nanstd(app) ./ sqrt(numel(app) - 1);
end

%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
meanX = reshape(meanAppCoa,5,2);
semX = reshape(semAppCoa,5,2);
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('ls')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
meanY = reshape(meanAppPcx,5,2);
semY = reshape(semAppPcx,5,2);
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('ls')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)
    
    

