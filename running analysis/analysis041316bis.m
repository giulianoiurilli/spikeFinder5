save(fullfile('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/2conc','aggregateExpLists_CoA_Pcx_072616.mat'),'ListPcx', 'ListCoa')
clearvars -except ListPcx ListCoa
%%
for idxExp = 1 : length(ListPcx)
    cartella = ListPcx{idxExp};
    cd(cartella)
    espWPcx(idxExp).waveforms = retrieveWaveforms; %waveforms (solo quelle buone) per ogni unità, per ogni shank,per questo esperimento
end
save('waveformsPcx.mat', 'espWPcx')

%% 
for idxExp = 1 : length(ListCoa)
    cartella = ListCoa{idxExp};
    cd(cartella)
    espWCoa(idxExp).waveforms = retrieveWaveforms;
end
save('waveformsCoa.mat', 'espWCoa')