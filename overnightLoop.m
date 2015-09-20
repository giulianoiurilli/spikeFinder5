% dfold = '\\research.files.med.harvard.edu\Neurobio\DattaLab\Giuliano\tetrodes_data\15 odors\plCoA\awake';
% dfold = pwd;
% List = uipickfiles('FilterSpec', dfold, ...
%     'Prompt',    'Pick all the folders you want to analyze');



for ii = 1 : length(List)
    cartella = List{ii};
%     folder1 = cartella(end-11:end-6)
%     folder2 = cartella(end-4:end)
%     cartella = [];
%     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/%s/%s', folder1, folder2);
    cd(cartella)
    
    
    

    %Enter here the command lines

 parameters
    
    %clear breathing.mat
    
    
%     valveOnsetTimestamp
%     try
%         breathOnsetTimestamp
%     catch
%         disp(folder)
%     end
%     try
%     for i = 1:4
%         filename = sprintf('CSC%d.mat', shank_lfp(i));
%         extractLFP(filename);
%         load(filename);
%         exp = i;
%         odor_spectrogram_Buszsaki32L;
%     end
%     catch err
%         disp(folder)
%         disp(err.message)
%     end
    
    
    
    
load('units.mat');
provv = shank;
clear shank
for sha = 1:4
    shank(sha).spiketimesUnit = provv(sha).spiketimesUnit;
end
clear provv
save('units.mat', 'shank');
clearvars -except cartella List ii
% %

% makeShanks
makeRasters
clearvars -except cartella List ii
analysis_step1
clearvars -except cartella List ii
analysis_step2
clearvars -except cartella List ii

end

    
    