fs = 20000;
spikes = ss_default_params(fs);
spikes = detect(data, spikes);
spikes = ss_align(spikes);
spikes = ss_kmeans(spikes);
spikes = ss_energy(spikes);
spikes = ss_aggregate(spikes);
% report detection rate
detect_rate = length(spikes.spiketimes) / sum(spikes.info.detect.dur);
disp( ['Detected on average ' num2str( detect_rate ) ' events per second of data '] );

splitmerge_tool(spikes)
