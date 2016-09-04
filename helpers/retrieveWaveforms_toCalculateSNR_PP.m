function Waveforms = retrieveWaveforms_toCalculateSNR_PP

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
        tetrode{j}.n_spikes{k} = numel(unitList(unitList==k));  % quanti spikes per unita' per tetrodo ci sono
        tetrode{j}.averageWaveform{k} = nanmean(table2array(nameTetrode(nameTetrode.Unit == k, 7:end)));
        %% new for SNR
        %here waveforms for each channel in the tetrode are concatenated.
        allWavefs = table2array(nameTetrode(nameTetrode.Unit == k, 7:end));
        meanWavef = tetrode{j}.averageWaveform{k};
        deviats = bsxfun(@minus, allWavefs, meanWavef);
        noise_SD = nanstd(deviats(:));
        signal_DEV = range(meanWavef);
        tetrode{j}.SNR{k}.SNR_allCatChannels = signal_DEV / (2*noise_SD);
        % separating the 4 channels
        deviats_sep = reshape(deviats, [],32,4);
        meanWavef_sep = reshape(meanWavef, [],32,4);
        for pp = 1:4
            dev_ch = deviats_sep(:,:,pp);
            noise_SD_sep(pp) = nanstd(dev_ch(:));
            signal_DEV_sep(pp) = range(meanWavef_sep(:,:,pp));
            SNR_sep(pp) = signal_DEV_sep(pp) / (2*noise_SD_sep(pp));
        end
        [~,indexBestChannel] = max(signal_DEV_sep);
        tetrode{j}.SNR{k}.SNR_bestChannel = SNR_sep(indexBestChannel);
        tetrode{j}.SNR{k}.SNR_singleChannels = SNR_sep;
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
            probe{p}.SNR{z} = tetrode{j}.SNR{k};
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
    %     n_goodUnits = sum(probe{1,j}.flagUnit);
    %     goodUnits = find(probe{1,j}.flagUnit == 1);
    %     k = 0;
    %     for z = goodUnits
    %         k = k + 1;
    nU = numel(shank(j).spiketimesUnit);
    for z = 1:nU
        Waveforms{j}.unit{z}.waveform = probe{1,j}.averageWaveform{1,z};
        Waveforms{j}.unit{z}.SNR = probe{1,j}.SNR{1,z};
        Waveforms{j}.unit{z}.flag = probe{1,j}.flagUnit(z);
    end
end

% save('Waveforms.mat', 'Waveforms')

    
