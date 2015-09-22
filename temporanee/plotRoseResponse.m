idxOdor1 = 15;
responseProfiles1 = [];
responseProfilesZ1 = [];
peakLatency1 = [];
popResponse1 = [];
odorLog1 = [];
responseProfiles1 = responseProfiles{idxOdor1};
responseProfilesZ1 = responseProfilesZ{idxOdor1};
peakLatency1 = peakLatency{idxOdor1};
odorLog1 = unitOdorResponseLog{idxOdor1};
noSpikeUnits1 = mean(responseProfiles1,2);
noSpikeUnits = noSpikeUnits1;
responseProfiles1(noSpikeUnits<0.1,:) = [];
responseProfilesZ1(noSpikeUnits<0.1,:) = [];
peakLatency1(noSpikeUnits<0.1) = [];
odorLog1(noSpikeUnits<0.1,:) = [];
noRespUnits1 = odorLog1(:,7) == 0;
noRespUnits = noRespUnits1;

responseProfiles1(noRespUnits,:) = [];
responseProfilesZ1(noRespUnits,:) = [];
peakLatency1(noRespUnits) = [];
odorLog1(noRespUnits,:) = [];
popResponses1 = mean(responseProfiles1);
idxExc1 = find(odorLog1(:,5) == 1);
excResponses1 =  responseProfiles1(idxExc1, :);
idxInh1 = find(odorLog1(:,6) == 1);
inhResponses1 =  responseProfiles1(idxInh1, :);
peakLatency1(~(odorLog1(:,5) == 1)) = 1000;
app1 = [];
app1 = [responseProfilesZ1 peakLatency1'];
app1 = sortrows(app1, size(app1,2));
app1(:,end) = [];
responseProfilesZ1 = app1;
app3 = [];
app3 = [odorLog1 peakLatency1'];
app3 = sortrows(app3, size(app3,2));
app3(:,end) = [];
odorLog1 = app3;
responseProfiles1Final = excResponses1(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles1FinalMean = mean(responseProfiles1Final);
responseProfiles1FinalMean = smooth(responseProfiles1FinalMean, 0.05, 'rloess');
popResponses1Final = popResponses1(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses1Final = smooth(popResponses1Final, 0.05, 'rloess');
responseProfilesZ1Final = responseProfilesZ1(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfilesZ1Final95prctile = prctile(responseProfilesZ1Final(:), 97.9);
responseProfilesZ1Final2prctile = prctile(responseProfilesZ1Final(:), 0.5);
maxL = responseProfilesZ1Final95prctile;
minL = responseProfilesZ1Final2prctile;
clims = [minL maxL];
responseProfiles1FinalMeanMax = max(responseProfiles1FinalMean);
maxMean = responseProfiles1FinalMeanMax;
popResponses1FinalMax = max(popResponses1Final);
maxPop = popResponses1FinalMax;



Xfig = 450;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')

p.pack('v',{1/3 1/3 1/3})

p(1).select()
imagesc(responseProfilesZ1Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')
p(1).title('Responses of units responding to phenylethanol 1:100');


p(2).select()
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
p(2).title('Average of responsive neurons');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(3).select()
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
p(3).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p.de.margin = 2;
p.margin = [8 15 4 10];
p(1).marginbottom = 20;
p(2).marginbottom = 20;
p.select('all');