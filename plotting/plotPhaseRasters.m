%close all
%clear all

%load('breathing.mat');
load('units.mat');
load('parameters.mat');

bslWindow = floor(preInhalations * round(2*pi, 2) / radPerMs);
rasterTicks = [-preInhalations :0.5: postInhalations] * 2 * pi; rasterTicks(end) = [];
psthTicks = [0.5 : 2 * (preInhalations + postInhalations) + 0.5]; psthTicks(end) = [];
sdfTicks = [0 : floor(pi/radPerMs) : (preInhalations + postInhalations) * round(2*pi, 2) / radPerMs]; sdfTicks(end) = [];
ciclo = {'i', 'e'}; labels = repmat(ciclo, 1, preInhalations); labels{2 * preInhalations + 1} = '0'; labels{2 * preInhalations + 2} = 'e';
labelsPost = repmat(ciclo, 1, postInhalations - 1); labels = [labels labelsPost];
cycleLength = round(2*pi, 2) / radPerMs;



% n_trials = size(sec_on_rsp,1);
for sha = 1:4
    for s = 1:length(shank(sha).spiketimesUnit)
        nameFigure = sprintf('Shank %d - Unit %d - Rasters and PSTHs', sha, s);
        h = figure('Name', nameFigure, 'NumberTitle', 'off');
        kk=1;
        for k = 1:odors
            
% raster plots
            sp1 = subplot(odors,3,kk);
            plotSpikeRaster(shank(sha).cell(s).odor(k).alphaTrial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',...
                [-preInhalations postInhalations] * 2 * pi); %plot average psth for cell s / odor x
            
            set(sp1,'YTick',[])
            set(sp1,'YColor','w')
            if kk < 3*odors-2
                set(sp1,'XTick',[])
                set(sp1,'XTickLabel',[])
            end
            
            if kk == 3*odors-2
                %ax = gca;
                set(sp1, 'XTick' , rasterTicks);
                set(sp1, 'XTickLabel', labels);
            end
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

% psth            
            kk=kk+1;
            sp2 = subplot(odors,3,kk);
            psthBreathingBins = mean(shank(sha).cell(s).odor(k).sniffBinnedPsth);
            psthBreathingBins1 = psthBreathingBins - shank(sha).cell(s).odor(k).sniffBinnedBsl;
            %respAxis = 1:19;
            bar(psthBreathingBins1,1)
            axis tight; ylim([-2 5]);
            if kk < 3*odors-1
                set(sp2,'XTick',[])
                set(sp2,'XColor','w')
                set(sp1,'YTick',[])
                set(sp1,'YColor','w')
            end
            if kk == 3*odors-1
                %ax = gca;
                set(sp2, 'XTick', psthTicks);
                set(sp2, 'XTickLabel', labels);
            end
            kk =  kk + 1;
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
            
% spike density functions
            sp3 = subplot(odors,3,kk);
            sdfMean = mean(shank(sha).cell(s).odor(k).sdf_trialRadMs);
            sdfMeanBsl = sdfMean(1:bslWindow);
            sdfMeanOdor = sdfMean;
            sdfMeanOdor(1:floor(bslWindow)) = 0;
            hold on
            area(sdfMeanBsl, 'FaceColor', 'y')
            area(sdfMeanOdor, 'FaceColor','r')
            axis tight
            ylim([0 0.04])
            %xlim([0 2 * bslWindow - 1])
            %hold off
            if kk < 3*odors
                set(sp3,'XTick',[])
                set(sp3,'XTickLabel',[])
                set(sp3,'YTick',[])
                set(sp3,'YTickLabel',[])
            end
            if kk == 3*odors
                set(sp3,'YTick',[])
                set(sp3,'YTickLabel',[])
                set(sp3, 'XTick', sdfTicks);
                set(sp3, 'XTickLabel', labels);
            end
            %
            kk = kk + 1;
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
            
% response timecourse
            rspAverageTrace = zeros(5,cycleLength);
            baselineAverageTrace = zeros(1,cycleLength);
            baselineAverageTrace = mean(shank(idxShank).cell(idxUnit).cycleBslMultiple);
            for idxCycle = 1:4
                rspAverageTrace(idxCycle, :) = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs(:,(idxCycle-1) * cycleLength + 1 : idxCycle * cycleLength));
            end
            radAxis = 1:cicleLength;
            sp4 = plot(radAxis, baselineAverageTrace, 'k', 'LineWidth', 2);
            hold on
            plot(radAxis, rspAverageTrace, 'LineWidth', 2)
            
            radTick = [0 314];
            radLabels=['0';'2p'];
            set(sp4,'xticklabel',radLabels,'fontname','symbol');            
        end
% dPrime tuning for the first 4 cycles
            dPrimeBaselineTheshold = prctile(shank(idxShank).cell(idxUnit).dPrimeNullDistribution, 95);
            dPrimeResponse = zeros(odors, 5);
            for idxOdor = 1:odor
                dPrimeResponse(idxOdor,:) = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDPrime(1:5);
            end
            dPrimeResponse = dPrimeResponse';
% signal correlation across trials and cycles

            for idxOdor = 1:odors
                app = [];
                appCycle = [];
                app = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial;
                for idxCycle = 1:10
                    appCycle = app(:,idxCycle)';
                    bigMatrix(idxOdor, 1 + (idxCycle-1)*n_trials : idxCycle*n_trials) = appCycle;
                end
            end
            distanceMatrix = pdist(bigMatrix);
            distanceMatrix = squareform(distanceMatrix);
            imagesc(distanceMatrix)
            axis square, axis off, colorbar
            
% latency for each odor in each cycle
for idxOdor = 1:odors
    appLatency = [];
    appRsp = [];
    appLatency = shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakLatency;
    appRsp = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDigital;
    appLatency(appRsp<1) = 0;
    bar(appLatency)
    axis tight
    ylim([0 300])
end
    
    
            
            
                
            
        set(gcf, 'Position', [100, 100, 800, 800]);
    end
end

