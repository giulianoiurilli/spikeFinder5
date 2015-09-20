load('units.mat');
load('parameters.mat');    

for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        baseline = [];
        stdAmplitudePeakBsl = [];
        baseline = shank(idxShank).cell(idxUnit).cycleBslMultiple;
        latencyPeakBsl = shank(idxShank).cell(idxUnit).cycleBslPeakLatencyMean;
        for idxSample = 1:1000
            idxRnd = randi(size(baseline,1), n_trials,1);
            appBsl = baseline(idxRnd, :);
            if latencyPeakBsl - 25 < 1
                amplitudePeakBsl = sum(appBsl(:,latencyPeakBsl : latencyPeakBsl + 50), 2);
            end
            if latencyPeakBsl + 24 > size(appBsl,2)
                amplitudePeakBsl = sum(appBsl(:,latencyPeakBsl - 50: latencyPeakBsl), 2);
            end
            if latencyPeakBsl - 25 >= 1 && latencyPeakBsl + 24 <= size(appBsl,2)
                amplitudePeakBsl = sum(appBsl(:,latencyPeakBsl - 25: latencyPeakBsl + 24), 2);
            end
            stdAmplitudePeakBsl(idxSample) = std(amplitudePeakBsl);
        end
        shank(idxShank).cell(idxUnit).averageStdAmplitudePeakBsl = mean(stdAmplitudePeakBsl);
        meanAmplitudePeakBsl = shank(idxShank).cell(idxUnit).cycleBslPeakAmplitude;
        for idxOdor = 1:odors
            app = [];
            app = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial;
            shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial_Zscored = (app - meanAmplitudePeakBsl)/mean(stdAmplitudePeakBsl);
        end
    end
end

save('units.mat', 'shank', '-append')   
    
