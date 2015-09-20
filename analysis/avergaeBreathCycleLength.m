sniff_length = [];
for idxExperiment = 1 : length(Lista)
    cartella = Lista{idxExperiment};
    %     folder1 = cartella(end-11:end-6)
    %     folder2 = cartella(end-4:end)
    %     cartella = [];
    %     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/%s/%s', folder1, folder2);
    cd(cartella)
    load('breathing.mat', 'interInhalationDelay')
    if size(interInhalationDelay,1) > 1
        interInhalationDelay = interInhalationDelay';
    end
    sniff_length = [sniff_length interInhalationDelay];
end
sniffLength = sniff_length(sniff_length > 0 & sniff_length < 2);
meanSniffLength = mean(sniffLength);
medianSniffLength = median(sniffLength);


h = figure;
histogram(sniffLength, 1000)
xlabel('Breathing cycle length (s)')
ylabel('Number of breathing cycles')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
set(h,'color','white', 'PaperPositionMode', 'auto');