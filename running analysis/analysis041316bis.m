for idxExp = 1 : length(ListPcx)
    cartella = ListPcx{idxExp};
    cd(cartella)
    espWPcx(idxExp).waveforms = retrieveWaveforms;
end
save('waveformsPcx.mat', 'espWPcx')

%% 
for idxExp = 1 : length(ListCoa)
    cartella = ListCoa{idxExp};
    cd(cartella)
    espWCoa(idxExp).waveforms = retrieveWaveforms;
end
save('waveformsCoa.mat', 'espWCoa')