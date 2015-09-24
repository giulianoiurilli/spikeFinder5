%% plot distribution of the best bin size
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bestBinWidth = [];
for idxExp = 1:length(List)
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
            for idxOdor = 1:odors
                app1 = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax;
                app2 = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinSize;
                app2(app1<0.75) = [];
                app2 = app2(:);
                bestBinWidth  = [bestBinWidth app2'];
            end
        end
    end
end


binSizes = 5:5:cycleLengthDeg;
figure
histogram(bestBinWidth, binSizes)
xlabel('bin width (deg)');
axis tight
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
medianBestBinWidth = median(bestBinWidth)
meanBestBinWidth = mean(bestBinWidth)