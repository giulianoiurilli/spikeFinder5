function reReference(tetrodes)

%Re-reference to the mean of all channels


%load('matlabData.mat');

%csc_data=zeros(n_traces, n_samples);
csc_data=[];
j = 0;
i = 0;
channels = [];
ch_names = [];

for k=1:length(tetrodes)
    tetrode = tetrodes(k);
    % LOAD TETRODE CHANNELS
    pol = strcat('tetrode',num2str(tetrode),'.txt');
    channels = textread(pol,'%s');
    
    for i=1:length(channels)
        file_to_cluster = channels(i);
        disp('-----------------------------------------------------------')
        string = sprintf('Loading channel %s', file_to_cluster{1}(4:end));
        disp(string)
        sample = load (sprintf('%s',channels{i}));
        csc_data(i + j,:) = single(sample.FiltSamples1);
    end
    j = j + i;
    ch_names = [ch_names channels];
    clear channels;
end

ch_names = ch_names(:);
ch_names = ch_names';


csc_median=median(csc_data);
for i=1:length(ch_names(:))
    disp('-----------------------------------------------------------')
    string = sprintf('Re-referencing channel %d', str2num(ch_names{i}(4:end)));
    disp(string)
    csc_data(i,:)=csc_data(i,:)-csc_median;
    fname = sprintf('CSC%d.mat', str2num(ch_names{i}(4:end)));    %Save data
    reRefFiltSamples = csc_data(i,:);
    save(fname, 'reRefFiltSamples', '-append','-v7.3');
end
disp('Done!')
clear csc_mean;



