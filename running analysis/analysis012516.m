for idxShank = 1:4
    mediePCX(idxShank) = nanmean(pcxAA.simTun1000{idxShank});
    medieCOA(idxShank) = nanmean(coaAA.simTun1000{idxShank});
    semPCX(idxShank) = nanstd(pcxAA.simTun1000{idxShank}) ./ sqrt(size(pcxAA.simTun1000{idxShank},2));
    semCOA(idxShank) = nanstd(coaAA.simTun1000{idxShank}) ./ sqrt(size(coaAA.simTun1000{idxShank},2));
end


figure;
errorbar(mediePCX, semPCX, '-ks', 'linewidth', 2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', 10)
hold on
errorbar(semPCX, semCOA, '-rs', 'linewidth', 2, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r', 'MarkerSize', 10)
ylim([-0.1 0.1])
title('sig corr across mice - 15 - first 1000 ms')
    