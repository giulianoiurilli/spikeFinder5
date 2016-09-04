% save(fullfile('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/2conc','aggregateExpLists_CoA_Pcx_072616.mat'),'ListPcx', 'ListCoa')
% clearvars -except ListPcx ListCoa
%%
for idxExp = 1 : length(listpcx15)
    cartella = listpcx15{idxExp};
    cd(cartella)
    espW(idxExp).waveforms = retrieveWaveforms_toCalculateSNR_PP; %waveforms (solo quelle buone) per ogni unità, per ogni shank,per questo esperimento
end
save(fullfile('/Volumes/Tetrodes Backup1/March/all','waveformsPcx15.mat'), 'espW')
save(fullfile('/Volumes/Tetrodes Backup1/March/all','listPcx15.mat'), 'listpcx15')
%%
for idxExp = 1 : length(listpcxAA)
    cartella = listpcxAA{idxExp};
    cd(cartella)
    espW(idxExp).waveforms = retrieveWaveforms_toCalculateSNR_PP; %waveforms (solo quelle buone) per ogni unità, per ogni shank,per questo esperimento
end
save(fullfile('/Volumes/Tetrodes Backup1/March/all','waveformsPcxAA.mat'), 'espW')
save(fullfile('/Volumes/Tetrodes Backup1/March/all','listPcxAA.mat'), 'listpcxAA')
%%
for idxExp = 1 : length(listpcxCS)
    cartella = listpcxCS{idxExp};
    cd(cartella)
    espW(idxExp).waveforms = retrieveWaveforms_toCalculateSNR_PP; %waveforms (solo quelle buone) per ogni unità, per ogni shank,per questo esperimento
end
save(fullfile('/Volumes/Tetrodes Backup1/March/all','waveformsPcxCS.mat'), 'espW')
save(fullfile('/Volumes/Tetrodes Backup1/March/all','listPcxCS.mat'), 'listpcxCS')
%% 
for idxExp = 1 : length(listcoa15)
    cartella = listcoa15{idxExp};
    cd(cartella)
    espW(idxExp).waveforms = retrieveWaveforms_toCalculateSNR_PP;
end
save(fullfile('/Volumes/Tetrodes Backup1/March/all','waveformsCoa15.mat'), 'espW')
save(fullfile('/Volumes/Tetrodes Backup1/March/all','listCoa15.mat'), 'listcoa15')
%% 
for idxExp = 1 : length(listcoaAA)
    cartella = listcoaAA{idxExp};
    cd(cartella)
    espW(idxExp).waveforms = retrieveWaveforms_toCalculateSNR_PP;
end
save(fullfile('/Volumes/Tetrodes Backup1/March/all','waveformsCoaAA.mat'), 'espW')
save(fullfile('/Volumes/Tetrodes Backup1/March/all','listCoaAA.mat'), 'listcoaAA')
%% 
for idxExp = 1 : length(listcoaCS)
    cartella = listcoaCS{idxExp};
    cd(cartella)
    espW(idxExp).waveforms = retrieveWaveforms_toCalculateSNR_PP;
end
save(fullfile('/Volumes/Tetrodes Backup1/March/all','waveformsCoaCS.mat'), 'espW')
save(fullfile('/Volumes/Tetrodes Backup1/March/all','listCoaCS.mat'), 'listcoaCS')