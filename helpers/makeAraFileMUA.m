startingFolder = pwd;
for idxExperiment = 1 : length(List)
    cartella = List{idxExperiment};
    cd(cartella)
    load('mua.mat');
    load('parameters.mat');
    for idxShank = 1:4
        for idxOdor = 1:odors
            muaExp(idxExperiment).shank(idxShank).odor(idxOdor).sdf_trialMua = shankMua(idxShank).odor(idxOdor).sdf_trialMua;
        end
    end
    clearvars -except List idxExperiment cartella muaExp startingFolder
end

cd(startingFolder)
clearvars -except List muaExp 
save('aPCx_2concMUA.mat', '-v7.3')

