  
clear all
close all

dfold = '\\research.files.med.harvard.edu\Neurobio\DattaLab\Giuliano\tetrodes_data\15 odors\plCoA\awake';
shankList = uipickfiles('FilterSpec', dfold, ...
    'Prompt',    'Pick all the folders you want to analyze');

for ii = 1 : length(shankList) %cycles through shanks
    folder = shankList{ii};
    cd(folder)
    load('spikes.mat');
    
    good = spikes.labels(find(spikes.labels(:,2) == 2));
    
    for s = 1 : length(good)% cycles through cells
        shank(ii).spiketimesUnit{s} = spikes.spiketimes(find(spikes.assigns == good(s)));
    end
        
end


folder(end-1:end)=[]; 
filename = 'units.mat';
save(fullfile(folder, filename), 'shank')