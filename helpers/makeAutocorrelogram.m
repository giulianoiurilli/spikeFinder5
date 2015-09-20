load('units.mat');
load('parameters.mat');


maxlag = 0.5;
bin = 10;
for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        shank(idxShank).cell(idxUnit).autocorrelogram = [];
        shank(idxShank).cell(idxUnit).autocorrelogramLags = [];
        spikes = [];
        spikes = shank(idxShank).spiketimesUnit{idxUnit};
        if ~isempty(spikes)
            [cross,lags] = pxcorr(spikes,spikes, round(1000/bin), maxlag);
            cross(lags==0) = 0;
            shank(idxShank).cell(idxUnit).autocorrelogram = cross;
            shank(idxShank).cell(idxUnit).autocorrelogramLags = lags;
        end
    end
end

save('units.mat', 'shank', '-append')  










% figure
% bb = bar(lags*1000,cross,1.0); 
% xlim([-5,5])
% set(bb,'FaceColor',[0 0 0 ],'EdgeColor',[0 0 0])
% axis tight



        
        