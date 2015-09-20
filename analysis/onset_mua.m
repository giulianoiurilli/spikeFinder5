

for k = 1:15
    onset = [];
    for sha = 1:4
        for s = 1:length(shank(sha).spiketimesUnit)
                if shank(sha).excitatory_odors_t{s}(k) == 1
                    onset = [onset shank(sha).timeOnset{s}(k)];
                end
        end
    end
    inizia(k) = nanmean(onset);
end

figure
plot(inizia)
            
                       
                       