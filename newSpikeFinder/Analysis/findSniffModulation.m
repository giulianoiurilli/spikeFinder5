fileToSave = 'plCoA_15_2.mat';
% esp = pcxAA.esp;
folderlist = {esp(:).filename};
startingFolder = pwd;


maxlag = 1.1;
Fs = 20000;
bin = 1;


for idxExp = 1 : length(folderlist)
    folderExp = folderlist(idxExp);
    disp(folderExp{1})
%     cd(fullfile(folderExp{1}, 'ephys'))
    cd(folderExp{1});
    load('units.mat');
    for idxShank = 1:4
        if ~isnan(shank(idxShank).SUA.clusterID{1})
            for idxUnit = 1:length(shank(idxShank).SUA.clusterID)
                spikes = [];
                spikes = shank(idxShank).SUA.spiketimesUnit{idxUnit};
                if ~isempty(spikes)
                    [cross,lags] = pxcorr(spikes,spikes, round(1000/bin), maxlag);
                    cross(lags==0) = 0;
                    c = smooth(cross./sum(cross),100,'sgolay');
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ACG = cross;
                    c = c(101:end);
                    c = detrend(c);
                    [w, f] = periodogram(c, rectwin(length(c)), length(c), Fs);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sniffModulation = w(4)/w(2);
                else
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ACG = [];
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sniffModulation = [];
                end
            end
        end
    end
end


cd(startingFolder)
save(fileToSave, 'esp', '-append')
%%
% n = 11;
% c = smooth(allACG(151+n,101:end)./sum(allACG(151+n,101:end)),100,'sgolay');
% c = detrend(c);
% figure; 
% subplot(1,2,1)
% plot(c)
% [w, f] = periodogram(c, rectwin(length(c)), length(c), Fs);
% subplot(1,2,2)
% plot(f, w)
% xlim([0 10]);
% title(w(4)/w(2))