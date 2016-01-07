bigFolder = '/Volumes/Tetrodes Backup1/conc_series/plCOA';  
for idxExp = 1:length(List)
        stringa = List{idxExp};
        cd(stringa)
        load('breathing.mat', 'sniffs');
        subStringa = stringa(end-11:end);
        destination = fullfile(bigFolder,subStringa);
        folder = mkdir(destination);
        final = fullfile(destination,'breathSniffs.mat');
        save(final, 'sniffs')
end
clear all

