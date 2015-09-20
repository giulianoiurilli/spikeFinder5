
d = dir('buzsaki32L_00*.txt');
d = {d.name};

idxUnitAll = 1;
for idxFile = 1:8
    
    spikeWaveforms = importSpikes(d{idxFile});
    
    spikeWaveforms = sortrows(spikeWaveforms, 2);
    
    n_units = max(spikeWaveforms(:,2));
    
    averageSpikeWaveform = zeros(n_units, size(spikeWaveforms,2) - 6);
    stdSpikeWaveform = zeros(n_units, size(spikeWaveforms,2) - 6);
    for idxUnit = 1:n_units
        averageSpikeWaveform(idxUnitAll,:) = mean(spikeWaveforms(spikeWaveforms(:,2) == idxUnit, 7:end));
        stdSpikeWaveform(idxUnitAll,:) = std(spikeWaveforms(spikeWaveforms(:,2) == idxUnit, 7:end));
        idxUnitAll = idxUnitAll + 1;
    end  
end