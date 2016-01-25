%% Total number of recorded units

tot_units = cells;


%% Proportion of units responding to at least an odor

pR300 = size(responsesExc300,1)./tot_units;
SEpR300 = sqrt(pR300 * (1-pR300)/tot_units);
pR1000 = size(responsesExc1,1)./tot_units;
SEpR1000 = sqrt(pR1000 * (1-pR1000)/tot_units);


%% Number of cell odor pairs
cellOdorPairSpikeCount300 = 0;
for idxCell = 1:size(respExc300,1)
    for idxOdor = 1:odors
        if respExc300(idxCell,idxOdor) > 0
            cellOdorPairSpikeCount300 = cellOdorPairSpikeCount300 + 1;
        end
    end
end

cellOdorPairSpikeCount1000 = 0;
for idxCell = 1:size(respExc1,1)
    for idxOdor = 1:odors
        if respExc1(idxCell,idxOdor) > 0
            cellOdorPairSpikeCount1000 = cellOdorPairSpikeCount1000 + 1;
        end
    end
end

%% Spike count change

spikeCountChangeExc300 = zeros(1,cellOdorPairSpikeCount300);
spikeCountChangeExc1000 = zeros(1,cellOdorPairSpikeCount1000);

idxCellPair = 0;
for idxCell = 1:size(respExc300,1)
    for idxOdor = 1:odors
        if respExc300(idxCell,idxOdor) > 0
            idxCellPair = idxCellPair + 1;
            spikeCountChangeExc300(idxCellPair) = responsesExc300MinusMean(idxCell,idxOdor);
        end
    end
end

idxCellPair = 0;
for idxCell = 1:size(respExc1,1)
    for idxOdor = 1:odors
        if respExc1(idxCell,idxOdor) > 0
            idxCellPair = idxCellPair + 1;
            spikeCountChangeExc1000(idxCellPair) = responsesExc1000MinusMean(idxCell,idxOdor);
        end
    end
end

%% Coefficient of variation
spikeCountChangeCVExc300 = zeros(1,cellOdorPairSpikeCount300);
spikeCountChangeCVExc1000 = zeros(1,cellOdorPairSpikeCount1000);

idxCellPair = 0;
for idxCell = 1:size(respExc300,1)
    for idxOdor = 1:odors
        if respExc300(idxCell,idxOdor) > 0
            idxCellPair = idxCellPair + 1;
            spikeCountChangeExcCV300(idxCellPair) = responsesExc300MinusCV(idxCell,idxOdor);
        end
    end
end

idxCellPair = 0;
for idxCell = 1:size(respExc1,1)
    for idxOdor = 1:odors
        if respExc1(idxCell,idxOdor) > 0
            idxCellPair = idxCellPair + 1;
            spikeCountChangeExcCV1000(idxCellPair) = responsesExc1000MinusCV(idxCell,idxOdor);
        end
    end
end


%% Lifetime sparseness of excitatory responses
lsExc300 = lsExc300;
lsExc1000 = lsExc1;

%% Information of excitatory responses
infoExc300 = infoExc300;
infoExc1000 = infoExc1;


%% Signal correlation
signalCorelation

%% Signal correlation
noiseCorelation


%%
cd(folder)
save('responsesH8.mat', 'tot_units', 'pR300', 'SEpR300', 'SEpR300', 'pR1000', 'SEpR1000', 'cellOdorPairSpikeCount300', 'spikeCountChangeExc1000', 'spikeCountChangeCVExc300', 'spikeCountChangeCVExc1000',...
    'lsExc300', 'lsExc1000', 'infoExc300', 'infoExc1000', 'sigCorrW300ms', 'sigCorrB300ms', 'sigCorrW1000ms', 'sigCorrB1000ms', 'noiseCorrW300ms', 'noiseCorrB300ms', 'noiseCorrW1000ms', 'noiseCorrB1000ms','-append')
