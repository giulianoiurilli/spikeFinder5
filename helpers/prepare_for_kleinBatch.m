

for idxExperiment = 1 : length(List)
    cartella = List{idxExperiment};
    cd(cartella)
    disp(cartella)
    fatti = sprintf('%d out of %d done.', idxExperiment, length(List));
    disp(fatti)
    
    load('matlabData.mat')
    
    prepare_for_Klein(tetrodes)
    
    clearvars -except List cartella
end
