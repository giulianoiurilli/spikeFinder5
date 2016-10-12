clc
clear

%list for intan
folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');



for ifolder = 1 : length(folderlist)
    folderKlust = folderlist(ifolder).name;
    disp(folderKlust)
    cd(folderKlust)
    tic
    extractDataFromIntan_multi3(folderKlust);
    disp('Importing done')
    toc
    
    folder = pwd;
    options.probeType = 2;
    options.singleOutputFile = 0;
    options.formatOutputFile = 2;
    samplingRate = 20000;
    
    makeFileForSpikeSorting(folder, options, samplingRate);
end




