clc
clear

%list for intan
folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');



for ifolder = 1 : length(folderlist)
    folderKlust = folderlist(ifolder).name;
    disp(folderKlust)
    cd(folderKlust)
    findPupilSweeps(15, 10)
end