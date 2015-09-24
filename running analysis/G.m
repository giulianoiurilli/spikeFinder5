%% plot distribution of bsl spike rate 

k = 1;  
for idxExp = 1:length(List)
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
            bkgSpikeRate(k)  = exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
            k = k+1;
        end
    end
end

figure
histogram(bkgSpikeRate, 100)
xlabel('background firing rate (Hz)');
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
medianbkgSpikeRate = median(bkgSpikeRate)
meanbkgSpikeRate = mean(bkgSpikeRate)
prctile25bkgSpikeRate = prctile(bkgSpikeRate, 25)