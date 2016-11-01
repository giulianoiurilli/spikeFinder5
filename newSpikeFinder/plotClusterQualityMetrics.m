folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');

%%
snr = [];
lR = [];
iD = [];
for idxExp = 1 : length(folderlist)
    folderExp = folderlist(idxExp).name;
    disp(folderExp)
    cd(fullfile(folderExp, 'ephys'))
    load('units.mat');
    for idxShank = 1:4
        if ~isnan(shank(idxShank).SUA.clusterID{1})
            for idxUnit = 1:length(shank(idxShank).SUA.clusterID)
                snr = [snr max(shank(idxShank).SUA.spikeSNR{idxUnit})];
                lR = [lR shank(idxShank).SUA.L_Ratio{idxUnit}];
                iD = [iD shank(idxShank).SUA.isolationDistance{idxUnit}];
            end
        end
    end
end
%%
figure
subplot(2,3,4)
scatter(snr, lR)
title('SNR vs L-ratio')
subplot(2,3,5)
scatter(snr, iD)
title('SNR vs Isolation Distance')
subplot(2,3,6)
scatter(lR, iD)
title('L-ratio vs Isolation Distance')

subplot(2,3,1)
histogram(snr, 50)
title('SNR')

subplot(2,3,2)
histogram(lR, 50)
title('L-ratio')

subplot(2,3,3)
histogram(iD, 50)
title('Isolation Distance')