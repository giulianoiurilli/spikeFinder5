
load('units.mat');
load('parameters.mat');

for sha = 1:4
    for s = 1:length(shank(sha).spiketimesUnit)
        nameFigure = sprintf('Shank %d - Unit %d - sdf', sha, s);
        h = figure('Name', nameFigure, 'NumberTitle', 'off');
        for k = 1:odors 
            sp = subplot(odors,1,k);
            sdfMean = mean(shank(sha).cell(s).odor(k).sdf_trial);
            sdfMeanBsl = sdfMean(1:floor(4*pi*10));
            sdfMeanOdor = sdfMean;
            sdfMeanOdor(1:floor(4*pi*10)) = 0;
            hold on
            area(sdfMeanBsl, 'FaceColor', 'y')
            area(sdfMeanOdor, 'FaceColor','r')
            axis tight
            ylim([0 0.4])
            xlim([1 floor(2*4*pi*10)])
            set(sp,'XTick',[])
            set(sp,'XTickLabel',[])
            set(sp,'YTick',[])
            set(sp,'YTickLabel',[])
            hold off
        end
        set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
end
            