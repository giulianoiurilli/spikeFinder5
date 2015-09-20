function spikes = removeArt( spikes )

spike = spikes.waveforms(:,:);
index = spikes.spiketimes * spikes.params.Fs;
art =   spikes.params.maxthresh * spikes.info.detect.stds;
aux = zeros(length(spike),1);

for i=1:size(spike,1)                          %Eliminates artifacts
    if min(spike(i,:)) <= art;
        aux(i)=1;
    end
end


spike(find(aux==1),:)=[];
index(find(aux==1))=[];
clear spikes.waveforms
clear spikes.spiketimes
spikes.waveforms = spike;
spikes.spiketimes = index / spikes.params.Fs;



