load('parameters.mat')
load('units.mat');
ante = 500; %baseline length in ms
start = 2 * 1000;
window = 1000;
dopo = 0;
n_trials = 5; %n_trials;
odor_list = {'pentanal', 'methyl-butanol', 'phenetol', 'trimethyl-thiazol', 'triethylamine',...
    'exanoic', 'heptanol', 'guaiacol', 'benzothiazol', 'isoamylamine',...
    'heptanal', 'nonanol', 'cresol', 'methilthiazol', 'phenyl-ethylamine'};

 

cycleLength = floor(round(2*pi, 2) / radPerMs);

ii = 1;
k = 1;
for i=1:n_trials * odors
    l=0;
    for sha = 1:4
        for cell = 1:length(shank(sha).spike_matrix)
            l = l + 1;
            D(i).data(l,:) =  shank(sha).spike_matrix{1,cell}(ii, 2 * cycleLength + 1 : 5 * cycleLength, k);
        end
    end
%     label = sprintf('reach%d', k);
%     D(i).condition = label;
    D(i).condition = odor_list{k};
    ii = ii + 1;
    if ii > n_trials
        ii = 1;
        k = k + 1;
    end
    %D(i).epochStarts = [1 ante+1 ante+1+window]; 
end

save('dataHigh.mat', 'D')