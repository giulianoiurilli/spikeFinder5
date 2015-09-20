% dfold = pwd;
% Lista = uipickfiles('FilterSpec', dfold, ...
%      'Prompt',    'Pick all the folders you want to analyze');



allSniffs = [];
allSniffsLength = [];


odorList = {'2,4,5-trimethylthiazol 1:10000',...
            '4,5-dimethylthiazol 1:10000',...
            '4-methylthiazol 1:10000',...
            'isopentylacetate 1:10000',...
            'isobutylacetate 1:10000',...
            '2,3-hexanedione 1:10000',...
            '2,3-butanedione 1:10000',...
            '2,4,5-trimethylthiazol 1:100',...
            '4,5-dimethylthiazol 1:100',...
            '4-methylthiazol 1:100',...
            'isopentylacetate 1:100',...
            'isobutylacetate 1:100',...
            '2,3-hexanedione 1:100',...
            '2,3-butanedione 1:100',...
            '2-phenylethanol 1:100'}; 
        
ticksLabelInh = {'-4', '-3', '-2', '-1', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'};


for idxExperiment = 1 : length(Lista)
    cartella = Lista{idxExperiment};
    %     folder1 = cartella(end-11:end-6)
    %     folder2 = cartella(end-4:end)
    %     cartella = [];
    %     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/aPCx/awake/%s/%s', folder1, folder2);
    cd(cartella)
    
    if idxExperiment == 1
        load('parameters.mat')
    end
    ticksInh = -preInhalations : postInhalations - 1;
    
    
    load('breathing.mat', 'sniffs')
    
    %Enter here the command lines
    
    
    for idxOdor = 1:odors
        for idxTrial = 1:n_trials
            sniffList = [];
            selectedSniffList = zeros(preInhalations + postInhalations, 2);
            sniffList = sniffs(idxOdor).trial(idxTrial).sniffPower;
            sniffLengthApp = diff(sniffList(:,1));
            sniffLength = [sniffLengthApp' sniffLengthApp(end)]; 
            sniffLength = ones(1,length(sniffLength))./sniffLength;
            threshold = prctile(sniffLength(sniffList(:,1) < 0), 25);
            app = sniffLength(sniffList(:,1) < 0);
            app1 = app(app <=  threshold);
            averagePowerBsl = nanmean(app1);
            stdPowerBsl = nanstd(app1);
            sniffLength = (sniffLength - averagePowerBsl) / stdPowerBsl;
            allSniffsLength = [allSniffsLength sniffLength];
            firstInhalationPostOdor = find(sniffList(:,1) > 0, 1);
            appSniffList = sniffList(firstInhalationPostOdor - preInhalations : firstInhalationPostOdor + postInhalations - 1,1);
            for i = 1:length(appSniffList)
            idxGood(i) = find(sniffList(:,1) == appSniffList(i));
            end
            experiment(idxExperiment).sniffs(idxOdor).trial(idxTrial).selectedSniffLength = sniffLength(idxGood);
        end
    end
end



xAxis = -preInhalations:postInhalations - 1;

% plot sniffing for each experiment

for idxExperiment = 1 : length(Lista)
    allSniffs = [];
    for idxOdor = 1:odors
        for idxTrial = 1:n_trials
            app = experiment(idxExperiment).sniffs(idxOdor).trial(idxTrial).selectedSniffLength;
            allSniffs = [allSniffs; app];
        end
    end
    grandAverageSniffs = nanmean(allSniffs);
    grandStdSniffs  = nanstd(allSniffs) / sqrt(size(allSniffs,1) - 1);
    figure;
    p = shadedErrorBar(xAxis, grandAverageSniffs, grandStdSniffs, 'r');
    experimentName = Lista{idxExperiment};
    title(experimentName)
    ax = gca;
    ax.XTick = ticksInh;
    ax.XTickLabel = ticksLabelInh;
    grid on
end


% plot sniffing for each odor

h = figure;
idxPlot = 1;
odorsRearranged = [1 8 2 9 3 10 4 11 5 12 6 13 7 14 15];
for idxOdor = odorsRearranged
    allSniffs = [];
    for idxExperiment = 1 : length(Lista)
        for idxTrial = 1:n_trials
            app = experiment(idxExperiment).sniffs(idxOdor).trial(idxTrial).selectedSniffLength;
            allSniffs = [allSniffs; app];
        end
    end
    grandAverageSniffs = nanmean(allSniffs);
    grandStdSniffs  = nanstd(allSniffs) / sqrt(size(allSniffs,1) - 1);
    subplot(8,2,idxPlot)
    p = shadedErrorBar(xAxis, grandAverageSniffs, grandStdSniffs, 'k');
    odorName = odorList{idxOdor};
    legend(odorName)
    ax = gca;
    ax.XTick = ticksInh;
    ax.XTickLabel = ticksLabelInh;
    set(ax,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
    
    if idxPlot == 15
        ylabel('Normalized instantaneous frequency')
        xlabel('Breathing cycle')
    end
    ylim([-1 50])
    grid on
    idxPlot = idxPlot+1;
end
set(h,'color','white', 'PaperPositionMode', 'auto');
set(gcf, 'Position', [70, 70, 800, 800]);


alls = allSniffsLength(allSniffsLength<100);

h = figure;
histogram(alls, 1000)
xlabel('Normalized instantaneous frequency')
ylabel('Number of breathing cycles')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
set(h,'color','white', 'PaperPositionMode', 'auto');

