

windowLength = 250;
times = [50 150];
boxWidth = 200;
Tstart = times - floor(boxWidth/2) + 1;
Tend = times + ceil(boxWidth/2) + 1;


idxCell = 0;
for idxExp = 1 : length(List) - 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            for idxOdor = 1:15
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessExcMs(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
            end
            totResponsivenes = responsivenessExc + responsivenessExcMs;
            if sum(totResponsivenes) > 0
                idxCell = idxCell + 1;
                for idxOdor = 1:15
                    A = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
                    data.stimulus(idxOdor).neuron(idxCell).spikeCountsAllTrials = sum(A(:,15050:15350),2);
                    data.stimulus(idxOdor).neuron(idxCell).spikeCountsMean = mean(sum(A(:,15050:15350),2));
                    data.stimulus(idxOdor).neuron(idxCell).spikeCountsVariance = var(sum(A(:,15050:15350),2));
                end
            end
        end
    end
end

%%
nUnits = length(data.stimulus(1).neuron);
meanCounts = zeros(nUnits,1);
varCounts = zeros(nUnits,1);
c = 'k';
for idxOdor = 1:15
    for idxUnit = 1:length(data.stimulus(idxOdor).neuron)
        meanCounts(idxUnit) = data.stimulus(idxOdor).neuron(idxUnit).spikeCountsMean;
        varCounts(idxUnit) = data.stimulus(idxOdor).neuron(idxUnit).spikeCountsVariance;
    end
    figure;
    scatter(meanCounts, varCounts, [],c, 'filled');
    axis equal
end
        
    
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            