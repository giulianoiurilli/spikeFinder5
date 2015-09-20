% exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).
% 
% smoothedPsth
% 
% peakDigitalResponsePerCycle
% 
% peakAnalogicResponsePerCycle
% 
% peakLatencyPerCycle
% 
% fullCycleDigitalResponsePerCycle
% 
% fullCycleAnalogicResponsePerCycle
% 
% aurocMax
% 
% bestBinSize
% 
% bestPhasePoint
% 
% odorDriveAllCycles
% 
% popCouplingAllCycles
% 
% fullCycleAnalogicResponsePerCycleAllTrials
% 
% peakAnalogicResponsePerCycleAllTrials
% 
% spikeMatrix
% 
% bslSpikeRate
% 
% bslPeakRate
% 
% bslPeakLatency
% 
% cycleBslSdf
%
% baselinePhases 
% 
% responsePhases 
% 
% 
% 
% 
% 
% %% plot average response timecourse for each odor
% responseProfilesApp = [];
% responseProfiles = [];
% 
% for idxOdor = 1:odors
%     responseProfilesApp = [];
%     responseProfiles = [];
%     k = 1;
%     for idxExp = 1:length(List)
%         for idxShank = 1:4
%             for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
%                 if numel(find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax > 0.75)) | sum(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle) > 0
%                     responseProfilesApp = mean(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth);
%                     %if sum(responseProfilesApp(1:preInhalations*cycleLengthDeg)) > 0
%                         responseProfiles(k,:) = responseProfilesApp;
%                         k = k+1;
%                     %end
%                 end
%                 
%             end
%         end
%     end
% %     responseProfilesDistance = pdist(responseProfiles(:,preInhalations*cycleLengthDeg+1:preInhalations*cycleLengthDeg+1+4*cycleLengthDeg), 'euclidean');
% %     responseProfilesDistance = squareform(responseProfilesDistance);
% %     Z = linkage(linkage(responseProfilesDistance));
% %     try
% %     [H,T,outperm] = dendrogram(Z);
% %     close(H)
% %     responseProfiles(end,:) = [];
% %     responseProfiles = [responseProfiles T];
% %     responseProfiles = sortrows(responseProfiles,size(responseProfiles,2));
% %     responseProfiles(:,end) = [];
% %     figure;imagesc(responseProfiles(:,2*cycleLengthDeg+1:preInhalations*cycleLengthDeg+1+4*cycleLengthDeg), [0 2])
% %     catch
%      figure;
%      subplot(2,1,1)
%      matrice = responseProfiles(:,2*cycleLengthDeg+1:preInhalations*cycleLengthDeg+1+4*cycleLengthDeg);
%      matrice = matrice./repmat(max(matrice(:,2*cycleLengthDeg+1:4*cycleLengthDeg),[],2), 1, size(matrice,2));
%      imagesc(matrice, [0 1]) 
%      subplot(2,1,2)
%      media = mean(responseProfiles(:,2*cycleLengthDeg+1:preInhalations*cycleLengthDeg+1+4*cycleLengthDeg));
%      plot(media), hold on, line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 max(mean(responseProfiles))]);      axis tight; ylim([0,1])
%      snapnow
% %     end
% end
% 
% 
% 
% %% plot responses and demixed responses of odor A vs odor B
% 
% 
% odorA = [15 15];
% odorB = [1 8];
% figure
% Xfig = 900;
% Yfig = 500;
% p = panel();
% set(gcf, 'Position',[1,5,Xfig,Yfig]);
% p.pack({1/2 1/2},{25 25 25 25});
% 
% for idxShank = 1:4
%     k = 1;
%     odorY = [];
%     rosa_demixed = [];
%     odorX = [];
%     odorX_demixed = [];
%     for idxExp = 1:length(List)
%         for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
% %                         rosa(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(15).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
% %                         rosa_demixed(k) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(15).odorDriveAllCycles;
%             app1 = []; app2 = [];
%             app1 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).fullCycleAnalogicResponsePerCycle);
%             app2 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).fullCycleAnalogicResponsePerCycle);
%             if app1 >= app2
%                 odorX(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).fullCycleAnalogicResponsePerCycle)-...
%                     exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             else
%                 odorX(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).fullCycleAnalogicResponsePerCycle) -...
%                     exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             end
%             app1 = []; app2 = [];
%             if app1 >= app2
%                 odorX_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(1)).odorDriveAllCycles);
%             else
%                 odorX_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorA(2)).odorDriveAllCycles);
%             end
%             
%             
%             app1 = []; app2 = [];
%             app1 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).fullCycleAnalogicResponsePerCycle);
%             app2 = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).fullCycleAnalogicResponsePerCycle);
%             if app1 >= app2
%                 odorY(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             else
%                 odorY(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).fullCycleAnalogicResponsePerCycle) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             end
%             app1 = []; app2 = [];
%             if app1 >= app2
%                 rosa_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(1)).odorDriveAllCycles);
%             else
%                 rosa_demixed(k) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(odorB(2)).odorDriveAllCycles);
%             end
%             k = k + 1;
%         end
%     end
%     
%     together = []; app = [];
%     app = odorY + odorX;
%     odorY(app==0) = []; odorX(app==0) = [];
%     odorY(isnan(app)) = []; odorX(isnan(app)) = [];
%     [maxvalue, idxmax] = max(odorX);
%     odorY(idxmax) = []; odorX(idxmax) = [];
%     together = [odorY; odorX];
%     maxTogether = max(together);
%     %together = together ./ repmat(maxTogether,2,1);
%     together = together';
%     p(1,idxShank).select()
%     scatter(together(:,1), together(:,2), 7,'filled');
% % %     m = sum(together(:,1) .* together(:,2))/sum(together(:,1).^2);
% % %     y = m*together(:,1);
% % %     hold on
% % %     plot(together(:,1), y, 'r')
% % %     A = together(:,1)\together(:,2);
% % %     hold on;plot(together(:,1), A*together(:,1),'g');
%     maxAx = max(together(:));
%     minAx = abs(min(together(:)));
%     limit = max([minAx maxAx]);
%     xlim([-limit limit]); ylim([-limit limit]);
%     line([0 0], [-limit limit], 'Color', 'k')
%     line([-limit limit], [0 0], 'Color', 'k')
%     axis square
%     axis off
% 
%     
%     
%     together = []; app = [];
%     app = rosa_demixed + odorX_demixed;
%     rosa_demixed(app==0) = []; odorX_demixed(app==0) = [];
%     rosa_demixed(isnan(app)) = []; odorX_demixed(isnan(app)) = [];
%     [maxvalue, idxmax] = max(odorX_demixed);
%     rosa_demixed(idxmax) = []; odorX_demixed(idxmax) = [];
%     together = [rosa_demixed; odorX_demixed];
%     maxTogether = max(together);
%     %together = together ./ repmat(maxTogether,2,1);
%     together = together';
%     p(2,idxShank).select()
%     scatter(together(:,1), together(:,2), 7,'filled');
% %     m = sum(together(:,1) .* together(:,2))/sum(together(:,1).^2);
% %     y = m*together(:,1);
% %     hold on
% %     plot(together(:,1), y, 'r')
% %     A = together(:,1)\together(:,2);
% %     hold on;plot(together(:,1), A*together(:,1),'g');
%     maxAx = max(together(:));
%     minAx = abs(min(together(:)));
%     limit = max([minAx maxAx]);
%     xlim([-limit limit]); ylim([-limit limit]);
%     line([0 0], [-limit limit], 'Color', 'k')
%     line([-limit limit], [0 0], 'Color', 'k')
%     axis square
%     axis off
%     %set(gca,'XTick',[])
% end
% 
% p.margin = [15 15 4 6];
% p.select('all');
% 
% 
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% 
% 
% 
% %% plot distribution of the best bin size
% 
% bestBinWidth = [];
% for idxExp = 1:length(List)
%     for idxShank = 1:4
%         for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
%             for idxOdor = 1:odors
%                 app1 = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax;
%                 app2 = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinSize;
%                 app2(app1<0.75) = [];
%                 app2 = app2(:);
%                 bestBinWidth  = [bestBinWidth app2'];
%             end
%         end
%     end
% end
% 
% 
% binSizes = 5:5:cycleLengthDeg;
% figure
% histogram(bestBinWidth, binSizes)
% xlabel('bin width (deg)');
% axis tight
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% medianBestBinWidth = median(bestBinWidth)
% meanBestBinWidth = mean(bestBinWidth)
% 
% 
% %% plot bsl spike rate
% 
% k = 1;  
% for idxExp = 1:length(List)
%     for idxShank = 1:4
%         for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
%             bkgSpikeRate(k)  = exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
%             k = k+1;
%         end
%     end
% end
% 
% figure
% histogram(bkgSpikeRate, 100)
% xlabel('background firing rate (Hz)');
% axis tight
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
% set(gcf,'color','white', 'PaperPositionMode', 'auto');
% medianbkgSpikeRate = median(bkgSpikeRate)
% meanbkgSpikeRate = mean(bkgSpikeRate)
% prctile25bkgSpikeRate = prctile(bkgSpikeRate, 25)



%% information vs time
% THIS IS NOT WORKING. NOT ENOUGH MEMORY.
% The best bin size seems to be 100 ms. Let's move 100ms bin by 5 ms step
% from the -2 cycle to the 10th cycle and let's calculate the information
% carried by the population for each bin. The population includes only
% units that had at least 1 aurocMax > 0.75 or a significant peak
% amplitude. Let's make 8 equipopulated bins for the responses. Let's
% consider only odors at the same concentration.

% binWidth = 100;
% odorList = 8:15;
% 
% bslActivityRemodeled =[];
% neuronActivity =[];
% idxNeuron = 1;
% for idxExp = 1:length(List)
%     for idxShank = 1:4
%         for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
%             peakResponses = [];
%             rocMax = [];
%             for idxOdor = odorList
%                 peakResponses = [peakResponses find(exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).peakDigitalResponsePerCycle > 0)];
%                 rocMax =  [rocMax find(exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).aurocMax > 0.75)];
%             end
%             if ~isempty(peakResponses) || ~isempty(rocMax)
%                 bslActivity = exp(idxExp).shank(idxShank).cell(idxNeuron).cycleBslSdf;
%                 for idxTrial = 1:n_trials
%                     v = zeros(1,cycleLengthDeg);
%                     v = v + mean(bslActivity(randi(floor(size(bslActivity,1)/n_trials)),:));
%                     bslActivityRemodeled{idxNeuron}(idxTrial, :) = v;
%                 end
%                 %                 for step = 1:5: 10*cycleLength - 105
%                 %                     airResponse(idxNeuron,:,step) = mean(bslActivityRemodeled(:,step:step + binWidth),2);
%                 %                 end
%                 idxOdor = 1;
%                 for idxOdor = odorList
%                     neuronActivity{idxNeuron}(:, :, idxOdor) = exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).smoothedPsth(:,2*cycleLengthDeg + 1: end);
%                     idxOdor = idxOdor+1;
%                 end
%                 idxNeuron = idxNeuron+1;
%             end
%         end
%     end
% end
% 
% R = [];
% bslR = [];
% oR = [];
% 
% idxPasso = 1;
% for passo = 1:5:cycleLengthDeg-binWidth
%     B = zeros(length(bslActivityRemodeled), n_trials);
%     B = zeros(1, n_trials);
%     for idxNeuron = 1:1%:length(bslActivityRemodeled)
%         v= zeros(n_trials,1);
%         v = v + mean(bslActivityRemodeled{idxNeuron}(:,passo:passo+binWidth), 2);
%         v = v';
%         B(idxNeuron,:) = v;
%     end
%     bslR{idxPasso} = B;
%     idxPasso = idxPasso+1;
% end
% 
% 
% X = [];
% R = [];
% for idxCycle = 1:postInhalations + 2
%     idxPasso = 1;
%     for passo = 1:5:cycleLengthDeg-binWidth
%         oR = zeros(length(bslActivityRemodeled), n_trials, length(odorList));
%         oR = zeros(1, n_trials, length(odorList));
%         for idxNeuron = 1:1%:length(bslActivityRemodeled)
%             v = zeros(n_trials,1,length(odorList));
%             v = v + mean(neuronActivity{idxNeuron}(:, idxCycle * passo:idxCycle * passo+binWidth, :), 2);
%             v = permute(v,[2,1,3]);
%             oR(idxNeuron,:,:) = v;
%         end
%         R = cat(3, oR, bslR{idxPasso});
%         R = binr(R, n_trials, 9, 'eqspace');
%         opts.nt = repmat(n_trials, 1, size(R,3));
%         opts.method = 'dr';
%         opts.bias = 'pt';
%         X(idxCycle,idxPasso) = information(R, opts, 'Ish');
%         idxPasso = idxPasso + 1;
%     end
% end
        
            
% X = reshape(X',1,size(X,1)*size(X,2));
% figure; plot(X)


%% data high


% odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
%     'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
%     'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};

% odor_list = { 'tmt1', 'dmt1', 'mmt1',...
%             'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};
% 
% 
% 
% cycleLength = 360;
% odorList = [8:15];
% 
% idxTrial = 1;
% idxOdor = 1;
% for idxTrialOdor=1:n_trials * length(odorList)
%     idxUnit=0;
%     for idxExp = 1:length(List)
%         for idxShank = 1:4
%             for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
%                 idxUnit = idxUnit + 1;
%                 D(idxTrialOdor).data(idxUnit,:) =  exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).spikeMatrix(idxTrial, 3*cycleLength:6*cycleLength);
%             end
%         end
%     end
% %     label = sprintf('reach%d', k);
% %     D(i).condition = label;
%     D(idxTrialOdor).condition = odor_list{idxOdor};
%     idxTrial = idxTrial + 1;
%     if idxTrial > n_trials
%         idxTrial = 1;
%         idxOdor = idxOdor + 1;
%     end
%     %D(i).epochStarts = [1 ante+1 ante+1+window]; 
% end
% 
% DataHigh(D, 'DimReduce')


% a=[];
% b=[];
% s=[];
% for m = 1:40
%     a = sum(D(m).data);
%     b = spikeDensityRad(a,10);
%     s(m,:) = b;
% end
% 
% c = []; c = mean(s(6:10,:));
% figure; plot(c)




%% SPIKE PHASE-LOCKING


idxBslUnit = 1;
idxRspUnit = 1;
for idxExp = 1:length(List)
    for idxShank = 1:4
        for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
            app1 = exp(idxExp).shank(idxShank).cell(idxNeuron).baselinePhases;
            app2 = exp(idxExp).shank(idxShank).cell(idxNeuron).responsePhases;
            if ~isempty(app1) && numel(app1) > 50 && ~isempty(app2)
                baselinePhases = app1;
                unitBslLog(idxBslUnit, :) = [idxExp idxShank idxNeuron];
                baselinePhases = radtodeg(baselinePhases);
                [N,edges] = histcounts(baselinePhases, 36, 'Normalization', 'probability');
                [peak peakbin] = max(N);
                baselinePhases = baselinePhases - (edges(peakbin) + 5);
                baselinePhases(baselinePhases<0) = baselinePhases(baselinePhases<0) + 360;
                [N,edges] = histcounts(baselinePhases, 36, 'Normalization', 'probability');
                angleBslCounts(idxBslUnit,:) = N;
                alphaMeanBsl(idxBslUnit) = circ_mean(app1, [], 2);
                alphaVarBsl(idxBslUnit) = circ_var(app1, [], [], 2);
                
                responsePhases = app2;
                responsePhases = radtodeg(responsePhases);
                [N,edges] = histcounts(responsePhases, 36, 'Normalization', 'probability');
                [peak peakbin] = max(N);
                responsePhases = responsePhases - (edges(peakbin) + 5);
                responsePhases(responsePhases<0) = responsePhases(responsePhases<0) + 360;
                [N,edges] = histcounts(responsePhases, 36, 'Normalization', 'probability');
                angleRspCounts(idxBslUnit,:) = N;
                alphaMeanRsp(idxBslUnit) = circ_mean(app2, [], 2);
                alphaVarRsp(idxBslUnit) = circ_var(app2, [], [], 2);
                 
                idxBslUnit = idxBslUnit + 1;
            end
%             if ~isempty(app2) && numel(app2) > 50
%                 responsePhases = app2;
%                 unitRspLog(idxRspUnit, :) = [idxExp idxShank idxNeuron];
%                 responsePhases = radtodeg(responsePhases);
%                 [N,edges] = histcounts(responsePhases, 36, 'Normalization', 'probability');
%                 [peak peakbin] = max(N);
%                 responsePhases = responsePhases - (edges(peakbin) + 5);
%                 responsePhases(responsePhases<0) = responsePhases(responsePhases<0) + 360;
%                 [N,edges] = histcounts(responsePhases, 36, 'Normalization', 'probability');
%                 angleRspCounts(idxRspUnit,:) = N;
%                 alphaMeanRsp(idxRspUnit) = circ_mean(app2, [], 2);
%                 alphaVarRsp(idxRspUnit) = circ_var(app2, [], [], 2);
%                 idxRspUnit = idxRspUnit + 1;
%             end
        end
    end
end

angleBslCountsMean = mean(angleBslCounts);
angleBslCountsStd = std(angleBslCounts);
shiftedangleBslCountsMean = [angleBslCountsMean(19:end) angleBslCountsMean(1:18)];
shiftedangleBslCountsStd = [angleBslCountsStd(19:end) angleBslCountsStd(1:18)];
angleRspCountsMean = mean(angleRspCounts);
angleRspCountsStd = std(angleRspCounts);
shiftedangleRspCountsMean= [angleRspCountsMean(19:end) angleRspCountsMean(1:18)];
shiftedangleRspCountsStd = [angleRspCountsStd(19:end) angleRspCountsStd(1:18)];

x = 1:length(shiftedangleBslCountsMean);


Xfig = 600;
Yfig = 800;
h = figure;
set(h,'Color','w')
set(gcf, 'Position',[1,5,Xfig,Yfig]);

p = panel();
p.pack('v', {1/3 1/3 1/3});
p(1).pack('h',{40 20 40});
p(2).pack('h', {40 20 40});
p(3).pack('h',{50 50});


p(1,1).select()
h11 = rose(alphaMeanBsl);
set(h11, 'Color', [222,45,38]/255)
titolo = sprintf('Distribution of average phase\n during baseline');
p(1,1).title(titolo);
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
p(1,3).select()
h21 = rose(alphaMeanRsp);
set(h21, 'Color', [49,130,189]/255)
titolo = sprintf('Distribution of average phase\n during response');
p(1,3).title(titolo)
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

p(1,2).select()
labels = {'baseline', 'odor'};
ba = radtodeg(alphaMeanBsl);
re = radtodeg(alphaMeanRsp);
ba(ba<0) = ba(ba<0)+360;
re(re<0) = re(re<0)+360;
my_ttest2_boxplot(ba, re, labels)


% hold on
% for ii=1:length(ba)
%     plot(1,ba(ii),'-ok',...
%         'MarkerFaceColor',[252,146,114]/255, 'MarkerSize', alphaVarBsl(ii)/max([alphaVarBsl alphaVarRsp])*5)
%     plot(2,re(ii),'-ok',...
%         'MarkerFaceColor',[158,202,225]/255, 'MarkerSize', alphaVarRsp(ii)/max([alphaVarBsl alphaVarRsp])*5)
% end
set(gca, 'xTick', [1 2]);
set(gca, 'XTickLabel', labels) ;
hold off
ylim([0 360])
set(gca,'yTick', [0 180 360]);
p(1,2).title('Average phase')

p(2,2).select()
labels = {'baseline', 'odor'};
my_ttest2_boxplot(alphaVarBsl, alphaVarRsp, labels)
set(gca,'yTick', [0 0.5 1]);
p(2,2).title('Average spread')
ylim([0 1]);
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

p(2,1).select()
violin(alphaVarBsl', 'facecolor', [252,146,114]/255,  'edgecolor', 'none', 'facealpha', 0.5);
ylim([0 1]);
set(gca,'XColor','w')
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
p(2,3).select()
violin(alphaVarRsp', 'facecolor', [158,202,225]/255,  'edgecolor', 'none', 'facealpha', 0.5);
ylim([0 1]);
set(gca,'XColor','w')
set(gca,'YColor','w')
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

p(3,1).select()
shadedErrorBar(x, shiftedangleBslCountsMean, shiftedangleBslCountsStd, {'r', 'markerfacecolor', [222,45,38]/255});
ticks = [1 36]; ticksLabel = {'0','2\pi'};
set(gca, 'XTick', ticks);
set(gca, 'XTickLabel', ticksLabel);
set(gca,'YColor','w')
xlabel('Width (rad)')
ylabel('Average frequency')
p(3,1).title('Average phase tuning - Baseline')
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

p(3,2).select()
shadedErrorBar(x, shiftedangleRspCountsMean, shiftedangleRspCountsStd, {'b', 'markerfacecolor', [49,130,189]/255});
ticks = [1 36]; ticksLabel = {'0','2\pi'};
set(gca, 'XTick', ticks);
set(gca, 'XTickLabel', ticksLabel);
set(gca,'YColor','w')
xlabel('Width (rad)')
ylabel('Average frequency')
p(3,2).title('Average phase tuning - Response')
axis tight
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

p.de.margin = 2;
p.margin = [8 10 4 10];
p(1).marginbottom = 20;
p(1,2).marginleft = 15; p(1,2).marginright = 15;
p(2,2).marginleft = 15; p(2,2).marginright = 15;
p(2,1).marginleft = 10; p(2,3).marginright = 10;
p(2).marginbottom = 20;
p(2,1).marginright = 10;
p(3,1).marginright = 10;
p.select('all');
                








% thetas = (edges(2)-edges(1))/2;
% thetas = edges(1:end-1) + thetas;
% thetas = [thetas, thetas(1)];
% h = figure;
% ind1 = [1:length(N), 1];
% p = polar(thetas,N(ind1)); hold on;
% set(p,'LineWidth', 2,'Color', [1 0 0]);





% set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');
%                 
                
 

                

        
        
        
        
        
        
        
               