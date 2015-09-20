
function plot_spikes


ciccio = 'matlabData.mat';
load(ciccio);

k=1;
keep=[];
for i=1:length(tetrodes)
    stringa = sprintf('tetrode%d_spikes.mat', i);
    load(stringa);
    keep = clustersToKeep{i};
    clusters = tetrodes_clusters{i};
    for j = keep
        unit_spikes = spikes(find(clusters==j),:);
        for i=1:4
            figure(k)
            plot(mean(unit_spikes(:,1+(i-1)*40:40+(i-1)*40))');
            k=k+1;
        end
    end
    keep=[];
end