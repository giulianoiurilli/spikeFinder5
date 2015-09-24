%% plot responses timecourses by pairs of concentrations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idxOdor1 = 2;
idxOdor2 = 9;

responseProfiles1 = [];
responseProfiles2 = [];
responseProfilesZ1 = [];
responseProfilesZ2 = [];
peakLatency1 = [];
peakLatency2 = [];
popResponse1 = [];
popResponse2 = [];
odorLog1 = [];
odorLog2 = [];


responseProfiles1 = responseProfiles{idxOdor1};
responseProfilesZ1 = responseProfilesZ{idxOdor1};
peakLatency1 = peakLatency{idxOdor1};
odorLog1 = unitOdorResponseLog{idxOdor1};

responseProfiles2 = responseProfiles{idxOdor2};
responseProfilesZ2 = responseProfilesZ{idxOdor2};
peakLatency2 = peakLatency{idxOdor2};
odorLog2 = unitOdorResponseLog{idxOdor2};

noSpikeUnits1 = mean(responseProfiles1,2);
noSpikeUnits2 = mean(responseProfiles2,2);
noSpikeUnits = noSpikeUnits1 + noSpikeUnits2;
responseProfiles1(noSpikeUnits<0.1,:) = [];
responseProfiles2(noSpikeUnits<0.1,:) = [];
responseProfilesZ1(noSpikeUnits<0.1,:) = [];
responseProfilesZ2(noSpikeUnits<0.1,:) = [];
peakLatency1(noSpikeUnits<0.1) = [];
peakLatency2(noSpikeUnits<0.1) = [];
odorLog1(noSpikeUnits<0.1,:) = [];
odorLog2(noSpikeUnits<0.1,:) = [];
popResponses1 = mean(responseProfiles1);
popResponses2 = mean(responseProfiles2);
noRespUnits1 = odorLog1(:,7) == 0;
noRespUnits2 = odorLog2(:,7) == 0;
noRespUnitsApp = noRespUnits1 + noRespUnits2;
noRespUnits = noRespUnitsApp == 2;
responseProfiles1(noRespUnits,:) = [];
responseProfiles2(noRespUnits,:) = [];
responseProfilesZ1(noRespUnits,:) = [];
responseProfilesZ2(noRespUnits,:) = [];
peakLatency1(noRespUnits) = [];
peakLatency2(noRespUnits) = [];
odorLog1(noRespUnits,:) = [];
odorLog2(noRespUnits,:) = [];

idxExc1 = find(odorLog1(:,5) == 1);
excResponses1 =  responseProfiles1(idxExc1, :);
idxExc2 = find(odorLog2(:,5) == 1);
excResponses2 = responseProfiles2(idxExc2, :);
idxInh1 = find(odorLog1(:,6) == 1);
inhResponses1 =  responseProfiles1(idxInh1, :);
idxInh2 = find(odorLog2(:,6) == 1);
inhResponses2 = responseProfiles2(idxInh2, :);
peakLatency1(~(odorLog1(:,5) == 1)) = 1000;
peakLatency2(~(odorLog2(:,5) == 1)) = 1000;


if numel(idxExc1) > numel(idxExc2)
    app1 = [];
    app1 = [responseProfilesZ1 peakLatency1'];
    app1 = sortrows(app1, size(app1,2));
    app1(:,end) = [];
    responseProfilesZ1 = app1;
    app2 = [];
    app2 = [responseProfilesZ2 peakLatency1'];
    app2 = sortrows(app2, size(app2,2));
    app2(:,end) = [];
    responseProfilesZ2 = app2;
    app3 = [];
    app3 = [odorLog1 peakLatency1'];
    app3 = sortrows(app3, size(app3,2));
    app3(:,end) = [];
    odorLog1 = app3;
    app4 = [];
    app4 = [odorLog2 peakLatency1'];
    app4 = sortrows(app4, size(app4,2));
    app4(:,end) = [];
    odorLog2 = app4;
else
    app1 = [];
    app1 = [responseProfilesZ1 peakLatency2'];
    app1 = sortrows(app1, size(app1,2));
    app1(:,end) = [];
    responseProfilesZ1 = app1;
    app2 = [];
    app2 = [responseProfilesZ2 peakLatency2'];
    app2 = sortrows(app2, size(app2,2));
    app2(:,end) = [];
    responseProfilesZ2 = app2;
    app3 = [];
    app3 = [odorLog1 peakLatency2'];
    app3 = sortrows(app3, size(app3,2));
    app3(:,end) = [];
    odorLog1 = app3;
    app4 = [];
    app4 = [odorLog2 peakLatency2'];
    app4 = sortrows(app4, size(app4,2));
    app4(:,end) = [];
    odorLog2 = app4;
end


responseProfiles1Final = excResponses1(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles1FinalMean = mean(responseProfiles1Final);
responseProfiles1FinalMean = smooth(responseProfiles1FinalMean, 0.05, 'rloess');
responseProfiles2Final = excResponses2(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles2FinalMean = mean(responseProfiles2Final);
responseProfiles2FinalMean = smooth(responseProfiles2FinalMean, 0.05, 'rloess');
% responseProfiles1FinalIn = inhResponses1(:,2*cycleLengthDeg:8*cycleLengthDeg);
% responseProfiles1FinalMeanIn = mean(responseProfiles1FinalIn);
% responseProfiles1FinalMeanIn = smooth(responseProfiles1FinalMeanIn, 0.05, 'rloess');
% responseProfiles2FinalIn = inhResponses2(:,2*cycleLengthDeg:8*cycleLengthDeg);
% responseProfiles2FinalMeanIn = mean(responseProfiles2FinalIn);
% responseProfiles2FinalMeanIn = smooth(responseProfiles2FinalMeanIn, 0.05, 'rloess');
popResponses1Final = popResponses1(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses1Final = smooth(popResponses1Final, 0.05, 'rloess');
popResponses2Final = popResponses2(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses2Final = smooth(popResponses2Final, 0.05, 'rloess');
responseProfilesZ1Final = responseProfilesZ1(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfilesZ2Final = responseProfilesZ2(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfilesZ1Final95prctile = prctile(responseProfilesZ1Final(:), 97.9);
responseProfilesZ2Final95prctile = prctile(responseProfilesZ2Final(:), 97.9);
responseProfilesZ1Final2prctile = prctile(responseProfilesZ1Final(:), 0.5);
responseProfilesZ2Final2prctile = prctile(responseProfilesZ2Final(:), 0.5);
if responseProfilesZ1Final95prctile >= responseProfilesZ2Final95prctile
    maxL = responseProfilesZ1Final95prctile;
else
    maxL = responseProfilesZ2Final95prctile;
end

if responseProfilesZ1Final2prctile <= responseProfilesZ2Final2prctile
    minL = responseProfilesZ1Final2prctile;
else
    minL = responseProfilesZ2Final2prctile;
end
clims = [minL maxL];

responseProfiles1FinalMeanMax = max(responseProfiles1FinalMean);
responseProfiles2FinalMeanMax = max(responseProfiles2FinalMean);
if responseProfiles1FinalMeanMax >= responseProfiles2FinalMeanMax
    maxMean = responseProfiles1FinalMeanMax;
else
    maxMean = responseProfiles2FinalMeanMax;
end
% responseProfiles1FinalMeanMaxIn = max(responseProfiles1FinalMeanIn);
% responseProfiles2FinalMeanMaxIn = max(responseProfiles2FinalMeanIn);
% if responseProfiles1FinalMeanMaxIn >= responseProfiles2FinalMeanMaxIn
%     maxMeanIn = responseProfiles1FinalMeanMaxIn;
% else
%     maxMeanIn = responseProfiles2FinalMeanMaxIn;
% end


popResponses1FinalMax = max(popResponses1Final);
popResponses2FinalMax = max(popResponses2Final);
if popResponses1FinalMax > popResponses2FinalMax
    maxPop = popResponses1FinalMax;
else
    maxPop = popResponses2FinalMax;
end


Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')

p.pack({1/3 1/3 1/3}, {50 50})

p(1,1).select()
imagesc(responseProfilesZ1Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')
p(1).title('Responses of units responding to butanedione 1:10000 (left) and-or 1:100 (right)');

p(1,2).select()
imagesc(responseProfilesZ2Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')
%p(1,2).title('TMT 1:100');

p(2,1).select()
xAxis = 1:6*cycleLengthDeg+1;
hold on
for i = 1:size(responseProfiles1Final,1)
    plot(xAxis, responseProfiles1Final(i,:), 'Color', [224,236,244]/255);
end
plot(xAxis, responseProfiles1FinalMean, 'Color', [158,188,218]/255, 'LineWidth', 3);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxMean], 'Color', [136,86,167]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
%xlabel('Respiration cycles')
ylim([-0.1 maxMean]);
p(2,1).title('Average of responsive neurons');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(2,2).select()
xAxis = 1:6*cycleLengthDeg+1;
hold on
for i = 1:size(responseProfiles2Final,1)
    plot(xAxis, responseProfiles2Final, 'Color', [224,236,244]/255);
end
plot(xAxis, responseProfiles2FinalMean, 'Color', [158,188,218]/255, 'LineWidth', 3);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxMean], 'Color', [136,86,167]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
%xlabel('Respiration cycles')
p(2,2).title('Average of responsive neurons');
ylim([-0.1 maxMean]);
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

% p(3,1).select()
% xAxis = 1:6*cycleLengthDeg+1;
% hold on
% for i = 1:size(responseProfiles1FinalIn,1)
%     plot(xAxis, responseProfiles1FinalIn(i,:), 'Color', [231,225,239]/255);
% end
% plot(xAxis, responseProfiles1FinalMeanIn, 'Color', [201,148,199]/255, 'LineWidth', 3);
% line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxMeanIn], 'Color', [136,86,167]/255);
% axis tight
% xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
% xticklabel = {'-2', '-1', '1', '2', '3', '4'};
% set(gca, 'XTick', xticks);
% set(gca, 'XTickLabel', xticklabel);
% set(gca,'YColor','w')
% xlabel('Respiration cycles')
% ylim([-0.1 maxMeanIn]);
% p(3,1).title('Inhibitory responses');
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
% 
% p(3,2).select()
% xAxis = 1:6*cycleLengthDeg+1;
% hold on
% for i = 1:size(responseProfiles2FinalIn,1)
%     plot(xAxis, responseProfiles2FinalIn, 'Color', [231,225,239]/255);
% end
% plot(xAxis, responseProfiles2FinalMeanIn, 'Color', [201,148,199]/255, 'LineWidth', 3);
% line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxMeanIn], 'Color', [136,86,167]/255);
% axis tight
% xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
% xticklabel = {'-2', '-1', '1', '2', '3', '4'};
% set(gca, 'XTick', xticks);
% set(gca, 'XTickLabel', xticklabel);
% set(gca,'YColor','w')
% xlabel('Respiration cycles')
% p(3,2).title('Inhibitory responses');
% ylim([-0.1 maxMeanIn]);
% set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');


p(3,1).select()
xAxis = 1:6*cycleLengthDeg+1;
area(popResponses1Final, 'FaceColor',[253,192,134]/255);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxPop], 'Color', [240,59,32]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
xlabel('Respiration cycles')
ylim([0 maxPop]);
p(3,1).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(3,2).select()
xAxis = 1:6*cycleLengthDeg+1;
area(popResponses2Final, 'FaceColor',[253,192,134]/255);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxPop], 'Color', [240,59,32]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
xlabel('Respiration cycles')
ylim([0 maxPop]);
p(3,2).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p.de.margin = 2;
p.margin = [8 15 4 10];
p(1).marginbottom = 20;
p(1,1).marginright = 10;
p(1,1).de.marginright = 2;
p(1,2).de.marginright = 2;
p(2).marginbottom = 20;
p(2,1).marginright = 10;
%p(3).marginbottom = 20;
p(3,1).marginright = 10;
%p(4,1).marginright = 10;
p.select('all');