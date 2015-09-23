

for idxExperiment = 2 : length(List)
    cartella = List{idxExperiment};
    cd(cartella)
    disp(cartella)
    fatti = sprintf('%d out of %d done.', idxExperiment, length(List));
    disp(fatti)
    
    load('matlabData.mat')
    load('tetrodes.mat')
    
    %prepare_for_Klein(tetrodes)
    disp('running... klein')
    klein(tetrodes)
    disp('running... makeRastersMua')
    makeRastersMua
    
    clearvars -except List cartella
end
