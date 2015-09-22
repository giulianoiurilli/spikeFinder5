function klein(tetrodes)
fs = 20000;

for k=1:length(tetrodes)
    [spikes] = ss_default_params(fs);
    tetrode = tetrodes(k);
    pol = strcat('tetrode',num2str(tetrode),'.txt');
    filename = strcat(pol(1:end-4),'_spikesK.mat');
    %outfile = strcat(filename,'_spikesK');
    %load(outfile);
    load(filename);
    data1 = zeros(floor(size(data(1).reRefFiltSamples,2)/2), length(data));
    for i = 1:length(data)
        data1(:,i) = data(i).reRefFiltSamples(1:floor(size(data(1).reRefFiltSamples,2)/2))';
    end
    
    spikes = detect(data1, spikes);
    clear data
    clear data1
    clear data2
    spikes = ss_align(spikes);
%     spikes = ss_kmeans(spikes);
%     spikes = ss_energy(spikes);
%     spikes = ss_aggregate(spikes);
    
    %spikes = removeArt( spikes );
    
    save(filename, 'spikes', '-v7.3')
    % report detection rate
    detect_rate = length(spikes.spiketimes) / sum(spikes.info.detect.dur);
    disp( ['Detected on average ' num2str( detect_rate ) ' events per second of data '] );
    clear spikes;
end