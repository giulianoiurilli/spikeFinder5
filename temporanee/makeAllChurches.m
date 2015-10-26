% dfold = pwd;
% Listone = uipickfiles('FilterSpec', dfold, ...
%     'Prompt',    'Pick all the folders you want to analyze');

aree{1} = 'aPCx_2conc_Area.mat';
aree{2} = 'plCoA_2conc_Area.mat';
aree{3} = 'aPCx_15odors_Area.mat';
aree{4} = 'plCoA_15odors_Area.mat';
aree{5} = 'aPCx_aveatt_Area.mat';
aree{6} = 'plCoA_aveAtt_Area.mat';
aree{7} = 'aPCx_concseries_Area.mat';
aree{8} = 'plCoA_concseries_Area.mat';
allChurches = [];

for idxExperimento = 1 : length(Listone)
    cartella = Listone{idxExperimento};
    %     folder1 = cartella(end-11:end-6)
    %     folder2 = cartella(end-4:end)
    %     cartella = [];
    %     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/%s/%s', folder1, folder2);
    cd(cartella)
    disp(cartella)
    fatti = sprintf('%d out of %d done.', idxExperimento, length(Listone));
    disp(fatti)
    
    load('parameters')
    load(aree{idxExperimento})
    lunLista = length(List);
    if idxExperimento == 3
        lunLista = length(List) - 1;
    end
    if idxExperimento == 4
        lunLista = length(List) - 1;
    end
    
    makeChurch;
    
    allChurches(idxExperimento).excMs = churchMs;
    allChurches(idxExperimento).excRad = churchRad;
    allChurches(idxExperimento).excSniff = churchSniff;
    allChurches(idxExperimento).inhMs = churchMsInh;
    allChurches(idxExperimento).inhRad = churchRadInh;
    allChurches(idxExperimento).inhSniff = churchSniffInh;
    
    clearvars -except Listone idxExperimento cartella allChurches aree
end
    
    
    
    