function Waveforms = retrieveWaveforms

% close all
% clear; clc
%%
spikeWaveforms1 = importSpikeFile('buzsaki32L_000.txt');
spikeWaveforms2 = importSpikeFile('buzsaki32L_001.txt');
spikeWaveforms3 = importSpikeFile('buzsaki32L_002.txt');
spikeWaveforms4 = importSpikeFile('buzsaki32L_003.txt');
spikeWaveforms5 = importSpikeFile('buzsaki32L_004.txt');
spikeWaveforms6 = importSpikeFile('buzsaki32L_005.txt');
spikeWaveforms7 = importSpikeFile('buzsaki32L_006.txt');
spikeWaveforms8 = importSpikeFile('buzsaki32L_007.txt');
load('units.mat');


%%
clear tetrode;
for j = 1:8
    tabella = sprintf('spikeWaveforms%d', j); 
    nameTetrode = eval(tabella);
    tabellaUnit = sprintf('spikeWaveforms%d.Unit', j); 
    unitList = eval(tabellaUnit);
    tetrode{j}.n_units = unique(unitList);
    for k = 1:numel(tetrode{j}.n_units)
        tetrode{j}.n_spikes{k} = numel(unitList(unitList==k));
        tetrode{j}.averageWaveform{k} = mean(table2array(nameTetrode(nameTetrode.Unit == k, 7:end)));
    end
end
%%
clear probe;
index = [1 2; 3 4; 5 6; 7 8];
for p = 1:4
    z = 0;
    for j = index(p,:)
        for k = 1:numel(tetrode{j}.n_units)
            z = z + 1;
            probe{p}.averageWaveform{z} = tetrode{j}.averageWaveform{k};
        end
    end
end
%%
for j = 1:4
    nU = numel(shank(j).spiketimesUnit);
    flagUnit = [];
    for k = 1:nU
        if isempty(shank(j).spiketimesUnit{k})
            probe{j}.flagUnit(k) = 0;
        else
            probe{j}.flagUnit(k) = 1;
        end
    end 
end
%%
for j = 1:4
    n_goodUnits = sum(probe{1,j}.flagUnit);
    goodUnits = find(probe{1,j}.flagUnit == 1);
    k = 0;
    for z = goodUnits
        k = k + 1;
        Waveforms{j}.unit{k}.waveform = probe{1,j}.averageWaveform{1,z};
    end
end

% save('Waveforms.mat', 'Waveforms')

    
