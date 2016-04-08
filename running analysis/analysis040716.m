spikeWaveforms1 = importSpikeFile('buzsaki32L_000.txt');
spikeWaveforms2 = importSpikeFile('buzsaki32L_001.txt');
spikeWaveforms3 = importSpikeFile('buzsaki32L_002.txt');
spikeWaveforms4 = importSpikeFile('buzsaki32L_003.txt');
spikeWaveforms5 = importSpikeFile('buzsaki32L_004.txt');
spikeWaveforms6 = importSpikeFile('buzsaki32L_005.txt');
spikeWaveforms7 = importSpikeFile('buzsaki32L_006.txt');
spikeWaveforms8 = importSpikeFile('buzsaki32L_007.txt');


%%
figure
subplot(1,2,1)
for u = 1:numel(unique(spikeWaveforms1.Unit))
    hold on
    plot3(table2array(spikeWaveforms1(spikeWaveforms1.Unit==u,3)),table2array(spikeWaveforms1(spikeWaveforms1.Unit==u,4)), table2array(spikeWaveforms1(spikeWaveforms1.Unit==u,5)), '.');
    view(3)
    grid on
        xlabel('Time (sec)'); ylabel('PC1'); zlabel('PC2');
end
    
subplot(1,2,2)
for u = 1:numel(unique(spikeWaveforms2.Unit))
    hold on
    plot3(table2array(spikeWaveforms2(spikeWaveforms2.Unit==u,3)), table2array(spikeWaveforms2(spikeWaveforms2.Unit==u,4)), table2array(spikeWaveforms2(spikeWaveforms2.Unit==u,5)), '.');
    view(3)
    grid on
    xlabel('Time (sec)'); ylabel('PC1'); zlabel('PC2');
end




figure
subplot(1,2,1)
for u = 1:numel(unique(spikeWaveforms3.Unit))
    hold on
    plot3(table2array(spikeWaveforms3(spikeWaveforms3.Unit==u,3)),table2array(spikeWaveforms3(spikeWaveforms3.Unit==u,4)), table2array(spikeWaveforms3(spikeWaveforms3.Unit==u,5)), '.');
    view(3)
    grid on
    xlabel('Time (sec)'); ylabel('PC1'); zlabel('PC2');
end
    
subplot(1,2,2)
for u = 1:numel(unique(spikeWaveforms4.Unit))
    hold on
    plot3(table2array(spikeWaveforms4(spikeWaveforms4.Unit==u,3)), table2array(spikeWaveforms4(spikeWaveforms4.Unit==u,4)), table2array(spikeWaveforms4(spikeWaveforms4.Unit==u,5)), '.');
    view(3)
    grid on
    xlabel('Time (sec)'); ylabel('PC1'); zlabel('PC2');
end




figure
subplot(1,2,1)
for u = 1:numel(unique(spikeWaveforms5.Unit))
    hold on
    plot3(table2array(spikeWaveforms5(spikeWaveforms5.Unit==u,3)),table2array(spikeWaveforms5(spikeWaveforms5.Unit==u,4)), table2array(spikeWaveforms5(spikeWaveforms5.Unit==u,5)), '.');
    view(3)
    grid on
    xlabel('Time (sec)'); ylabel('PC1'); zlabel('PC2');
end
    
subplot(1,2,2)
for u = 1:numel(unique(spikeWaveforms6.Unit))
    hold on
    plot3(table2array(spikeWaveforms6(spikeWaveforms6.Unit==u,3)), table2array(spikeWaveforms6(spikeWaveforms6.Unit==u,4)), table2array(spikeWaveforms6(spikeWaveforms6.Unit==u,5)), '.');
    view(3)
    xlabel('Time (sec)'); ylabel('PC1'); zlabel('PC2');
end




figure
subplot(1,2,1)
for u = 1:numel(unique(spikeWaveforms7.Unit))
    hold on
    plot3(table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,6)), table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,4)), table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,5)), '.');
    view(3)
    grid on
    xlabel('Time (sec)'); ylabel('PC1'); zlabel('PC2');
end
    
subplot(1,2,2)
for u = 1:numel(unique(spikeWaveforms8.Unit))
    hold on
    plot3(table2array(spikeWaveforms8(spikeWaveforms8.Unit==u,3)), table2array(spikeWaveforms8(spikeWaveforms8.Unit==u,4)), table2array(spikeWaveforms8(spikeWaveforms8.Unit==u,5)), '.');
    view(3)
    grid on
    xlabel('Time (sec)'); ylabel('PC1'); zlabel('PC2');
end

%%
figure
subplot(2,1,1)
for u = 1:numel(unique(spikeWaveforms7.Unit))
    hold on
    plot(table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,4)), table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,5)),'.');
    grid on
    xlabel('PC1'); ylabel('PC2');
end
subplot(2,1,2)
for u = 1:numel(unique(spikeWaveforms7.Unit))
    hold on
    plot3(table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,4)), table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,5)), table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,3)), '.');
    view(3)
    grid on
    xlabel('PC1'); ylabel('PC2'); zlabel('time (s)');
end


%%
figure
time = 0:1/20:1.6;
time(end) = [];
for u = 1:numel(unique(spikeWaveforms7.Unit))
    [~,minimo] = min(mean(table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,7:end))));
    hold on
    plot(mean(table2array(spikeWaveforms7(spikeWaveforms7.Unit==u,7 :end))));
end
xlabel('ms'); ylabel('µV');

%%
%clear all
d = dir('CSC*.mat');
d = {d.name};

%shanks = [ 30 26 20 25 21 17 27 22 28 23 31 16 19 24 29 18 0 15 7 1 2 13 8 9 6 14 4 3 10 11 5 12];
%I have to remap the channels due to Matlab ordering

shanks = [29 7 27 24 3 4 28 5];


load(d{29})
channels = zeros(8, size(reRefFiltSamples,2));
channels(1,:) = reRefFiltSamples;


k=2;
for i = shanks(1:end)
    load(d{i});
    channels(k,:) = reRefFiltSamples;
    k=k+1;
end

%%
allUnits = [];
k = 0;
allWaveforms = [];
figure;
hold on
for idx = [1 2 3 4 5 6 7 8 10 11]
    k = k + 1;
    tp = shank(4).spiketimesUnit{idx};
    waveform = nan(length(tp),33*8);
    for idxT = 1:length(tp)
        a1 = channels(1, tp(idxT)*20000-9:tp(idxT)*20000+23);
        a2 = channels(2, tp(idxT)*20000-9:tp(idxT)*20000+23);
        a3 = channels(3, tp(idxT)*20000-9:tp(idxT)*20000+23);
        a4 = channels(4, tp(idxT)*20000-9:tp(idxT)*20000+23);
        a5 = channels(5, tp(idxT)*20000-9:tp(idxT)*20000+23);
        a6 = channels(6, tp(idxT)*20000-9:tp(idxT)*20000+23);
        a7 = channels(7, tp(idxT)*20000-9:tp(idxT)*20000+23);
        a8 = channels(8, tp(idxT)*20000-9:tp(idxT)*20000+23);

        waveform(idxT, :) = [a1 a2 a3 a4 a5 a6 a7 a8];
    end
    plot(mean(waveform))
    allWaveforms = [allWaveforms;waveform];
    allUnits(k) = length(tp);
end
%%
[coeff, score] = pca(allWaveforms);
%%
figure;
hold on

to = 0;
for i = 1:length(allUnits)
    if i == 1
        plot3(score(1:allUnits(1),1), score(1:allUnits(1),2), score(1:allUnits(1),3), '.');
        from = allUnits(1);
    else
        to = from + allUnits(i);
        plot3(score(from+1:to,1), score(from+1:to,2), score(from+1:to,3), '.');
        from = from + allUnits(i);
    end
end
