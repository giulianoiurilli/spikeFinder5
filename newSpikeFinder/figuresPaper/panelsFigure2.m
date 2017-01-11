FRspCOA = M15c.rspPeakFractionExc(:);
FRspPCX = M15p.rspPeakFractionExc(:);
logSignificantCoa = M15c.significance(:);
% logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = M15p.significance(:);
% logSignificantPcx = logSignificantPcx(:);
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];
FRspCOAnonsig = FRspCOA(:);
FRspPCXnonsig = FRspPCX(:);
FRspCOAnonsig(logSignificantCoa>1) = [];
FRspPCXnonsig(logSignificantPcx>1) = [];
%%
edges = -0.05:0.1:1.05;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[-1836 366 1440 378]);
subplot(1,2,1)
h = histcounts(FRspCOA(:),edges);
s1 = bar(0:0.1:1, h./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', 'none');

hold on
h1 = histcounts(FRspCOAsig(:),edges);
s2 = bar(0:0.1:1, h1./size(FRspCOA(:),1), 'EdgeColor', coaC, 'FaceColor', coaC);
xlabel('Number of Trials with a Significant Excitatory Peak') 
ylabel('Fraction of Excitatory Responses')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

subplot(1,2,2)
h = histcounts(FRspPCX(:),edges);
s3 = bar(0:0.1:1, h./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', 'none');
hold on
h1 = histcounts(FRspPCXsig(:),edges);
s4 = bar(0:0.1:1, h1./size(FRspPCX(:),1), 'EdgeColor', pcxC, 'FaceColor', pcxC);
xlabel('Number of Trials with a Significant Excitatory Peak') 
ylabel('Fraction of Excitatory Responses')
ylim([0 0.25])
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'helvetica', 'fontsize', 14)

%% bar plot fractionExc/odor
X1 = M15c.rspPeakFractionExc*10;
X1(M15c.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X1(:,j);
    app(isnan(app)) = [];
    notnanX1(j) = numel(app);
end
X1app = X1;
X1appNotnan = notnanX1;
X1mean = nanmean(X1app);
X1sem = nanstd(X1app) ./ sqrt(X1appNotnan - ones(1,15));

Y1 = M15p.rspPeakFractionExc*10;
Y1(M15p.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y1(:,j);
    app(isnan(app)) = [];
    notnanY1(j) = numel(app);
end
Y1app = Y1;
Y1appNotnan = notnanY1;
Y1mean = nanmean(Y1app);
Y1sem = nanstd(Y1app) ./ sqrt(Y1appNotnan - ones(1,15));
%%
meanX = reshape(X1mean,5,3);
semX = reshape(X1sem,5,3);
errorbar_groups(meanX,semX,'bar_colors', repmat(coaC,5,1), 'errorbar_colors', repmat(coaC,5,1))
ylabel('Number of Responses Out of 10 Trials')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'helvetica', 'fontsize', 14)


meanY = reshape(Y1mean,5,3);
semY = reshape(Y1sem,5,3);
errorbar_groups(meanY,semY,'bar_colors', repmat(pcxC,5,1), 'errorbar_colors', repmat(pcxC,5,1))
ylabel('Number of Responses Out of 10 Trials')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'helvetica', 'fontsize', 14)

%%
rsp = [];
odorTag = [];
for idx = 1:15
    rsp = [rsp; X1(~isnan(X1(:,idx)), idx)];
    odorTag = [odorTag; idx*ones(numel(X1(~isnan(X1(:,idx)), idx)), 1)];
end
[p, table] = anova1(rsp, odorTag); 
%%
rsp = [];
odorTag = [];
for idx = 1:15
    rsp = [rsp; Y1(~isnan(Y1(:,idx)), idx)];
    odorTag = [odorTag; idx*ones(numel(Y1(~isnan(Y1(:,idx)), idx)), 1)];
end
[p, table] = anova1(rsp, odorTag);  
%% bar plot spike count change/odor
X1 = M15c.DeltaRspMean;
X1(M15c.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X1(:,j);
    app(isnan(app)) = [];
    notnanX1(j) = numel(app);
end
X1app = X1;
X1appNotnan = notnanX1;
X1mean = nanmean(X1app);
X1sem = nanstd(X1app) ./ sqrt(X1appNotnan - ones(1,15));

Y1 = M15p.DeltaRspMean;
Y1(M15p.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y1(:,j);
    app(isnan(app)) = [];
    notnanY1(j) = numel(app);
end
Y1app = Y1;
Y1appNotnan = notnanY1;
Y1mean = nanmean(Y1app);
Y1sem = nanstd(Y1app) ./ sqrt(Y1appNotnan - ones(1,15));
%%
meanX = reshape(X1mean,5,3);
semX = reshape(X1sem,5,3);
errorbar_groups(meanX,semX,'bar_colors', repmat(coaC,5,1), 'errorbar_colors', repmat(coaC,5,1))
ylabel('Spike Count Change')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'helvetica', 'fontsize', 14)


meanY = reshape(Y1mean,5,3);
semY = reshape(Y1sem,5,3);
errorbar_groups(meanY,semY,'bar_colors', repmat(pcxC,5,1), 'errorbar_colors', repmat(pcxC,5,1))
ylabel('Spike Count Change')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'helvetica', 'fontsize', 14)
%%
rsp = [];
odorTag = [];
for idx = 1:15
    rsp = [rsp; X1(~isnan(X1(:,idx)), idx)];
    odorTag = [odorTag; idx*ones(numel(X1(~isnan(X1(:,idx)), idx)), 1)];
end
[p, table] = anova1(rsp, odorTag); 

%%
rsp = [];
odorTag = [];
for idx = 1:15
    rsp = [rsp; Y1(~isnan(Y1(:,idx)), idx)];
    odorTag = [odorTag; idx*ones(numel(Y1(~isnan(Y1(:,idx)), idx)), 1)];
end
[p, table] = anova1(rsp, odorTag);   
%%
[psthCoa15mono, t_vector]= retrievePSTH(coa15.esp, coa15_1.espe, 1:15);
[psthPcx15mono, t_vector] = retrievePSTH(pcx15.esp, pcx15_1.espe, 1:15);
%%
psthCoaPET = [psthCoa15mono(1).odor; psthCoa15mono(2).odor; psthCoa15mono(3).odor; psthCoa15mono(4).odor; psthCoa15mono(5).odor];
psthCoaTMT = [psthCoa15mono(6).odor; psthCoa15mono(7).odor; psthCoa15mono(8).odor; psthCoa15mono(9).odor; psthCoa15mono(10).odor];
psthCoaIAA = [psthCoa15mono(11).odor; psthCoa15mono(12).odor; psthCoa15mono(13).odor; psthCoa15mono(14).odor; psthCoa15mono(15).odor];

psthPcxPET = [psthPcx15mono(1).odor; psthPcx15mono(2).odor; psthPcx15mono(3).odor; psthPcx15mono(4).odor; psthPcx15mono(5).odor];
psthPcxTMT = [psthPcx15mono(6).odor; psthPcx15mono(7).odor; psthPcx15mono(8).odor; psthPcx15mono(9).odor; psthPcx15mono(10).odor];
psthPcxIAA = [psthPcx15mono(11).odor; psthPcx15mono(12).odor; psthPcx15mono(13).odor; psthPcx15mono(14).odor; psthPcx15mono(15).odor];
%%
figure
plot(t_vector, mean(psthCoaPET), 'linewidth', 2, 'color', [117,112,179]./255)
hold on
plot(t_vector, mean(psthCoaTMT), 'linewidth', 2, 'color', [217,95,2]./255)
hold on
plot(t_vector, mean(psthCoaIAA), 'linewidth', 2, 'color', [27,158,119]./255)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
ylim([0 20])
xlim([50 9950])
xlabel('ms')
ylabel('spikes/s')

figure
plot(t_vector, mean(psthPcxPET), 'linewidth', 2, 'color', [117,112,179]./255)
hold on
plot(t_vector, mean(psthPcxTMT), 'linewidth', 2, 'color', [217,95,2]./255)
hold on
plot(t_vector, mean(psthPcxIAA), 'linewidth', 2, 'color', [27,158,119]./255)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
ylim([0 20])
xlim([50 9950])
xlabel('ms')
ylabel('spikes/s')

%%
psthCoaPET = [psthCoa15mono(2).odor];
psthCoaTMT = [psthCoa15mono(9).odor];
psthCoaIAA = [psthCoa15mono(12).odor];

psthPcxPET = [psthPcx15mono(2).odor];
psthPcxTMT = [psthPcx15mono(9).odor];
psthPcxIAA = [psthPcx15mono(12).odor];
%%
figure
plot(t_vector, mean(psthCoaPET), 'linewidth', 2, 'color', [117,112,179]./255)
hold on
plot(t_vector, mean(psthCoaTMT), 'linewidth', 2, 'color', [217,95,2]./255)
hold on
plot(t_vector, mean(psthCoaIAA), 'linewidth', 2, 'color', [27,158,119]./255)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
ylim([0 20])
xlim([50 9950])
xlabel('ms')
ylabel('spikes/s')

figure
plot(t_vector, mean(psthPcxPET), 'linewidth', 2, 'color', [117,112,179]./255)
hold on
plot(t_vector, mean(psthPcxTMT), 'linewidth', 2, 'color', [217,95,2]./255)
hold on
plot(t_vector, mean(psthPcxIAA), 'linewidth', 2, 'color', [27,158,119]./255)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)
ylim([0 20])
xlim([50 9950])
xlabel('ms')
ylabel('spikes/s')