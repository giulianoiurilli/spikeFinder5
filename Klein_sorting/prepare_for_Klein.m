function prepare_for_Klein(tetrodes)


for k=1:length(tetrodes)
    
    tetrode = tetrodes(k);
    pol = strcat('tetrode',num2str(tetrode),'.txt');
    channels = textread(pol,'%s');
    filename = strcat(pol(1:end-4));
    for i=1:length(channels)
        file_to_cluster = channels(i);
        disp('-----------------------------------------------------------')
        string = sprintf('Loading channel %s', file_to_cluster{1}(4:end));
        disp(string)
        sample = load (sprintf('%s',channels{i}), 'reRefFiltSamples');
        data(i,:) = sample;
        %data(i,:) = sample.reRefFiltSamples;
    end
    data = data';
    outfile = strcat(filename,'_spikesK');
    save(outfile, 'data', '-v7.3')
    clear data;
    clear channels
end


