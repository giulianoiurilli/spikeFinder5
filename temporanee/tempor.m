            
load('units.mat');
load('parameters.mat');

cycleLength = round(2*pi, 2) / radPerMs;

for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        for idxOdor = 1:odors
            
            psthBreathingBins = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth);
            meanBsl = zeros(1, 2 * preInhalations);
            meanBsl(1:2:2*preInhalations-1) = mean(psthBreathingBins(1 : 2 : 2 * preInhalations - 1));
            meanBsl(2:2:2*preInhalations) = mean(psthBreathingBins(2 : 2 : 2 * preInhalations));
            repeatfor = floor(postInhalations / preInhalations);
            andadd = mod(2 * postInhalations, 2 * preInhalations);
            meanBsl = repmat(meanBsl, 1, 1 + repeatfor);
            meanBsl = [meanBsl meanBsl(1:andadd)];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl = meanBsl;
        end
    end
end


save('units.mat', 'shank', '-append')