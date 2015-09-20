function plotBreathing(breath,odors, fs, pre, post, n_trials, sniffs)

%INPUTS: -


time = -pre:1/fs:post;
time(end) = [];
for idxOdor = 14%1:odors
    figure
    idxSubPlot = 1;
    for idxTrial = 1:n_trials
        subplot(n_trials,2,idxSubPlot)
        plot(time, breath(idxTrial,:,idxOdor), 'k');
        xlabel('Time (s)')
        ylabel('Breath amplitude (mV)')
        axis tight
        idxSubPlot = idxSubPlot + 1;
        subplot(n_trials,2,idxSubPlot)
        sniffata = sniffs(idxOdor).trial(idxTrial).sniffPower;
        sniffTimes = sniffata(:,1)';
        sniffPower = sniffata(:,2)';
        plot(sniffTimes, sniffPower, 'r', 'LineWidth', 2);
        xlabel('Time (s)')
        ylabel('Sniff power (mV^2 / s)')
        axis tight
        idxSubPlot = idxSubPlot + 1;   
    end
    set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    set(gcf, 'Position', [100, 100, 800, 800]);
end

end