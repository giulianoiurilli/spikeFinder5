function make_NTT(tetrodes)

% This is useful for viewing and re-clustering spikes with SpikeSort (Neurlaynx). Make sure that each waveform is 32 samples long 


for i=1:length(tetrodes)
    
    tetrode = tetrodes(i);
    filename_tetrode = sprintf('tetrode%d_spikes.mat', tetrode);
    load(filename_tetrode)


data =spikes';
Waveforms = reshape(data, size(data,1)/4, 4,  size(data,2));
CellNumbers = double(tetrodes_clusters{i});
pre = round(size(data,1)/3);
post = round(size(data,1)*2/3);

Timestamps = index;

TT =i;
Mat2NlxTT(['TT' num2str(TT) '.ntt'], 0, 1, 1, length(Timestamps), [1 0 1 0 1 0], Timestamps, CellNumbers, Waveforms);


end