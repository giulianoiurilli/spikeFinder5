function raster_from_spikematriz(c,sha,s,k)

cd(c);
load('parameters.mat');
load('units.mat');
load('breathing.mat');
spikes = shank(sha).spike_matrix{s}(:,:,k);
X = breath(:,:,k);
time_ax = 0:1/20:(pre+post)*1000;
time_ax(end) = [];


figure
hold on
axis([0 (pre+post)*1000 0 n_trials])
    a=0;
    b=1;
for ii =1:n_trials
    resp = (X(ii,:)-min(X(ii,:)))./(max(X(ii,:))-min(X(ii,:)));
    plot(time_ax,resp+ii-1, 'r-')
    hold on
    s_t = [];
    s_t = find(spikes(ii,:) == 1);
    for iii = 1:length(s_t)
        line([s_t(iii) s_t(iii)], [a b])
    end
    a=a+1; b=b+1;
end
axis tight
