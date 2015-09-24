% SPIKE PHASE-LOCKING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

idxBslUnit = 1;
idxRspUnit = 1;
for idxExp = 1:length(List)
    for idxShank = 1:4
        for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
            app1 = exp(idxExp).shank(idxShank).cell(idxNeuron).baselinePhases;
            app2 = exp(idxExp).shank(idxShank).cell(idxNeuron).responsePhases;
            if ~isempty(app1) && numel(app1) > 50 && ~isempty(app2)
                baselinePhases = app1;
                unitAngleLog(idxBslUnit, :) = [idxExp idxShank idxNeuron];
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