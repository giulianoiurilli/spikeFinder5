clear
clc

folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');
% metti qui la cartella parent delle cartelle dei tuoi dati.
% Seleziona tutte le cartelle che vuoi analizzare overnight.


status = ones(length(folderlist)); % diventeranno tutti zero se l'analisi e' stata successful.
sysPath = 'PATH=/Users/Giuliano/miniconda2/bin:/Users/Giuliano/miniconda3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin';
idxShank = 1;
for ifolder = 1 : length(folderlist)
    if idxShank > 4
        idxShank = 1;
    end
    folderKlust = folderlist(ifolder).name;
    disp(folderKlust)
    cmdin = sprintf('%s; source activate klusta; cd %s; klusta shank%d.prm', sysPath, folderKlust, idxShank);
    [status(ifolder), ~] = system(cmdin, '-echo');
    idxShank = idxShank + 1;
end