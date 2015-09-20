%close all
%clear all

load('breathing.mat', 'breath', 'sec_on_rsp');
load('units.mat');
load('parameters.mat');


rasterTicks = [-preInhalations :0.5: postInhalations] * 2 * pi; rasterTicks(end) = [];
psthTicks = [0.5 : 2 * (preInhalations + postInhalations) + 0.5]; psthTicks(end) = [];
ciclo = {'i', 'e'}; labels = repmat(ciclo, 1, preInhalations); labels{2 * preInhalations + 1} = '0'; labels{2 * preInhalations + 2} = 'e';
labelsPost = repmat(ciclo, 1, postInhalations - 1); labels = [labels labelsPost];




edgesSpikeMatrixRad = 0:radPerMs:(preInhalations * round(2*pi, 2) + postInhalations * round(2*pi, 2)); edgesSpikeMatrixRad(1) = [];


% n_trials = size(sec_on_rsp,1);
for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
%         nameFigure = sprintf('Shank %d - Unit %d', idxShank, idxUnit);
%         h = figure('Name', nameFigure, 'NumberTitle', 'off');
        sua = shank(idxShank).spiketimesUnit{idxUnit};
        kk=1;
        for idxOdor = 1:odors   %cycles through odors
%             shank(sha).cell(s).odor(k).spikeMatrixRadNotMs = zeros(n_trials,floor(4*pi*10)+floor(8*pi*10));
            psthBreathingBins = zeros(n_trials, 2 * (preInhalations + postInhalations));
            shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRadMs = zeros(n_trials,length(edgesSpikeMatrixRad));
            shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs = zeros(n_trials,length(edgesSpikeMatrixRad));
            shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs(:,end) = [];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth = [];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl = [];
            
            for idxTrial = 1:n_trials
                respiro = breath(idxTrial,:,idxOdor);
                startOdor = sec_on_rsp(idxTrial, idxOdor);
                [alpha, spikesBinnedByInhExh] = transformSpikeTimesToSpikePhases(respiro, pre, post, fs, sua, startOdor, preInhalations, postInhalations);
                if ~isempty(spikesBinnedByInhExh)
                    psthBreathingBins(idxTrial,:) = spikesBinnedByInhExh;
                end
                alpha_trial{idxTrial} = alpha;
                shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial{idxTrial} = alpha_trial{idxTrial};
                alpha = round(alpha, 2);
                shiftedAlpha = alpha + round(preInhalations * 2*pi, 2);
                indexes = histc(shiftedAlpha, edgesSpikeMatrixRad);
                indexes(indexes > 0) = 1;
                shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRadMs(idxTrial,:) = indexes;
                shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs(idxTrial,:) = spikeDensityRad(shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRadMs(idxTrial,:), sigmaMs);
%                 alpha1 = floor(alpha*10);
%                 indexes = alpha1 + floor(4*pi*10);
%                 indexes(indexes==0) = 1;
%                 indexes(indexes < 1) = [];
%                 indexes(indexes > floor(4*pi*10)+floor(6*pi*10)) = [];
%                 shank(sha).cell(s).odor(k).spikeMatrixRadNotMs(i,indexes) = 1;
%                 shank(sha).cell(s).odor(k).sdf_trialRadNotMs(i,:) = spikeDensity(shank(sha).cell(s).odor(k).spikeMatrixRadNotMs(i,:),(pi/16 * 10)/1000);
            end
            psthBreathingBins(1,:) = [];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedPsth = psthBreathingBins;
            
            
            
%             sp1 = subplot(odors,2,kk);
%             plotSpikeRaster(alpha_trial,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-preInhalations postInhalations] * 2 * pi); %plot average psth for cell s / odor x
% 
%             set(sp1,'YTick',[])
%             set(sp1,'YColor','w')
%             if kk < odors - 1
%                 set(sp1,'XTick',[])
%                 set(sp1,'XTickLabel',[])
%             end
%             
%             if kk == odors - 1
%                 %ax = gca;
%                 set(sp1, 'XTick' , rasterTicks);
%                 set(sp1, 'XTickLabel', labels);
%             end
%             
%             kk=kk+1;
%             sp2 = subplot(odors,2,kk);
            psthBreathingBins = mean(psthBreathingBins);
            meanBsl = zeros(1, 2 * preInhalations);
            meanBsl(1:2:2*preInhalations-1) = mean(psthBreathingBins(1 : 2 : 2 * preInhalations - 1));
            meanBsl(2:2:2*preInhalations) = mean(psthBreathingBins(2 : 2 : 2 * preInhalations));
            repeatfor = floor(postInhalations / preInhalations);
            andadd = mod(2 * postInhalations, 2 * preInhalations);
            meanBsl = repmat(meanBsl, 1, 1 + repeatfor);
            meanBsl = [meanBsl meanBsl(1:andadd)];
            shank(idxShank).cell(idxUnit).odor(idxOdor).sniffBinnedBsl = meanBsl;
%             psthBreathingBins1 = psthBreathingBins - meanBsl;
%             %respAxis = 1:19;
%             bar(psthBreathingBins1,1)
%             axis tight; ylim([-2 5]);
%             if kk < odors
%                 set(sp2,'XTick',[])
%                 set(sp2,'XColor','w')
%             end
%             if kk == odors
%                 %ax = gca;
%                 set(sp2, 'XTick', psthTicks);
%                 set(sp2, 'XTickLabel', labels);
%             end
%             kk =  kk + 1;
            clear alpha_trial
        end
        clear sua
%         set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
    end
end

save('units.mat', 'shank', '-append')

                