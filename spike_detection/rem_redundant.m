function rem_redundant


% Remove spikes that occur at the same time (within a given submillisecond
% window) across more than a tetrode. Useful for removing artifacts. 

ciccio = 'matlabData.mat';
load(ciccio);

maxDelay = 500;



for i=1:length(tetrodes)
    stringa = sprintf('tetrode%d_spikes.mat', i);
    load(stringa);
    index_spikes{i} = index;
    app_spikes{i} = spikes;
end





index_spikes_flagged = index_spikes;



flag = 0;
for i=1:length(tetrodes)
    app_tetrodes=[];
    for j=1:length(index_spikes{i})
        app_tetrodes=tetrodes(find(tetrodes~=i));
        for k=app_tetrodes
            app1=find(abs((index_spikes{k}-index_spikes{i}(j)))<=maxDelay);
            if ~isempty(app1)
                flag = flag + 1;
            end
        end
        if flag > 0
            index_spikes_flagged{i}(j) = 0;
            flag=0;
        end
    end
end

app1 =[];
app2 =[];

for i=1:length(tetrodes)
    index_spikes{i}(find(index_spikes_flagged{i}==0))=[];
    app_spikes{i}(find(index_spikes_flagged{i}==0),:)=[];
    index=[];
    spikes=[];
    index = index_spikes{i};
    spikes = app_spikes{i};
    stringa = sprintf('tetrode%d_spikes.mat', i);
    string=sprintf('save %s -append index spikes', stringa);
    eval(string);
end




    
    
    
    

