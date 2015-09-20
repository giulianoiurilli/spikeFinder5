load('parameters.mat')
load('units.mat');
ante = 500; %baseline length in ms
start = 2 * 1000;
window = 1000;
dopo = 0;
n_trials = 5; %n_trials;
odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
             'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};

 

cycleLength = floor(round(2*pi, 2) / radPerMs);

ii = 1;
idxOdor = 1;
for i=1:n_trials * odors
    l=0;
    for idxShank = 1:4
        for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
            l = l + 1;
            D(i).data(l,:) =  shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRadMs(ii, 3 * cycleLength + 1 : 5 * cycleLength);
        end
    end
%     label = sprintf('reach%d', k);
%     D(i).condition = label;
    D(i).condition = odor_list{idxOdor};
    ii = ii + 1;
    if ii > n_trials
        ii = 1;
        idxOdor = idxOdor + 1;
    end
    %D(i).epochStarts = [1 ante+1 ante+1+window]; 
end

save('dataHigh.mat', 'D')