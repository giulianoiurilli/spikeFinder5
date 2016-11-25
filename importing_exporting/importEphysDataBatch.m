clc
clear

%list for intan
folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');

thisFolder = pwd;

% for ifolder = 1 : length(folderlist)
for ifolder = 1 : length(old_folderlist)
    
    
    cd(thisFolder)
    newFolder = sprintf('folder_%d', ifolder);
    folderOnGraid = fullfile(thisFolder, 'fromServer', newFolder);
    mkdir(folderOnGraid);
    new_folderlist(ifolder).name = folderOnGraid;
    
    %     folderKlust = folderlist(ifolder).name;
    folderKlust = old_folderlist(ifolder).name;
    disp(folderKlust)
    cd(folderKlust)
    
    %     tic
    %     extractDataFromIntan_multi3(folderKlust);
    %     disp('Importing done')
    %     toc
    
    folder = pwd;
    options.probeType = 2;
    options.singleOutputFile = 0;
    options.formatOutputFile = 2;
    samplingRate = 20000;
    
    %     makeFileForSpikeSorting(folder, options, samplingRate);
    makeFileForSpikeSorting_v2(folder, options, samplingRate, folderOnGraid);
end

status = ones(length(folderlist)); % diventeranno tutti zero se l'analisi e' stata successful.
sysPath = 'PATH=/Users/Giuliano/miniconda2/bin:/Users/Giuliano/miniconda3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin';

for ifolder = 1 : length(new_folderlist)
    for idxShank = 1:4
        folderShank = sprintf('shank%d', idxShank);
        folderKlust = fullfile(new_folderlist(ifolder).name, folderShank);
        disp(folderKlust)
        cmdin = sprintf('%s; source activate klusta; cd %s; klusta shank%d.prm', sysPath, folderKlust, idxShank);
        [status(ifolder), ~] = system(cmdin, '-echo');
    end
end



