function [d_prime_null] = findDPrimeNullDistribution(sdfCycleBsl, latencyPeakBsl, n_trials)

d_prime_null = zeros(1,1000);

for iSample = 1:1000
    
    idx1 = randi(size(sdfCycleBsl,1), 1, n_trials);
    firstSample = sdfCycleBsl(idx1,:);
    remainingsdfCycleBsl = sdfCycleBsl;
    remainingsdfCycleBsl(idx1,:) = [];
    idx2 = randi(size(sdfCycleBsl,1) - round(size(sdfCycleBsl,1)/3), 1, n_trials);
    secondSample = remainingsdfCycleBsl(idx2,:);
    
    if latencyPeakBsl - 25 < 1
        amplitudePeakBsl1 = sum(firstSample(:,latencyPeakBsl : latencyPeakBsl + 50), 2);
        amplitudePeakBsl2 = sum(secondSample(:,latencyPeakBsl : latencyPeakBsl + 50), 2);
    end
    if latencyPeakBsl + 24 > size(firstSample,2)
        amplitudePeakBsl1 = sum(firstSample(:,latencyPeakBsl - 50: latencyPeakBsl), 2);
        amplitudePeakBsl2 = sum(secondSample(:,latencyPeakBsl - 50: latencyPeakBsl), 2);
    end
    if latencyPeakBsl - 25 >= 1 && latencyPeakBsl + 24 <= size(firstSample,2)
        amplitudePeakBsl1 = sum(firstSample(:,latencyPeakBsl - 25: latencyPeakBsl + 24), 2);
        amplitudePeakBsl2 = sum(secondSample(:,latencyPeakBsl - 25 : latencyPeakBsl + 24), 2);
    end
    
    meanAmpl1 = mean(amplitudePeakBsl1);
    stdAmpl1 = std(amplitudePeakBsl1);
    meanAmpl2 = mean(amplitudePeakBsl2);
    stdAmpl2 = std(amplitudePeakBsl2);
    d_prime_null(iSample) = (meanAmpl1 - meanAmpl2) / sqrt(0.5 * (stdAmpl1 + stdAmpl2));
end


    
    
