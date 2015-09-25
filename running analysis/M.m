%% plot responses timecourses for concentration series
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







responseProfiles1 = [];
responseProfiles2 = [];
responseProfilesZ1 = [];
responseProfilesZ2 = [];
peakLatency1 = [];
odorLog1 = [];
odorLog2 = [];
odorLog3 = [];
odorLog4 = [];
odorLog5 = [];




responseProfiles1 = responseProfiles{idxOdor1};
responseProfiles2 = responseProfiles{idxOdor2};
responseProfiles3 = responseProfiles{idxOdor3};
responseProfiles4 = responseProfiles{idxOdor4};
responseProfiles5 = responseProfiles{idxOdor5};
peakLatency1 = peakLatency{idxOdor1};
odorLog1 = unitOdorResponseLog{idxOdor1};
odorLog2 = unitOdorResponseLog{idxOdor2};
odorLog3 = unitOdorResponseLog{idxOdor3};
odorLog4 = unitOdorResponseLog{idxOdor4};
odorLog5 = unitOdorResponseLog{idxOdor5};

noSpikeUnits1 = mean(responseProfiles1,2);
noSpikeUnits2 = mean(responseProfiles2,2);
noSpikeUnits3 = mean(responseProfiles3,2);
noSpikeUnits4 = mean(responseProfiles4,2);
noSpikeUnits5 = mean(responseProfiles5,2);
noSpikeUnits = noSpikeUnits1 + noSpikeUnits2 + noSpikeUnits3 + noSpikeUnits4 + noSpikeUnits5;
responseProfiles1(noSpikeUnits<0.1,:) = [];
responseProfiles2(noSpikeUnits<0.1,:) = [];
responseProfiles3(noSpikeUnits<0.1,:) = [];
responseProfiles4(noSpikeUnits<0.1,:) = [];
responseProfiles5(noSpikeUnits<0.1,:) = [];
peakLatency1(noSpikeUnits<0.1) = [];
odorLog1(noSpikeUnits<0.1) = [];
odorLog2(noSpikeUnits<0.1) = [];
odorLog3(noSpikeUnits<0.1) = [];
odorLog4(noSpikeUnits<0.1) = [];
odorLog5(noSpikeUnits<0.1) = [];


popResponses1 = mean(responseProfiles1);
popResponses2 = mean(responseProfiles2);
popResponses3 = mean(responseProfiles3);
popResponses4 = mean(responseProfiles4);
popResponses5 = mean(responseProfiles5);

noRespUnits1 = odorLog1(:,7) == 0;
noRespUnits2 = odorLog2(:,7) == 0;
noRespUnits3 = odorLog3(:,7) == 0;
noRespUnits4 = odorLog4(:,7) == 0;
noRespUnits5 = odorLog5(:,7) == 0;
noRespUnitsApp = noRespUnits1 + noRespUnits2 +noRespUnits3 + noRespUnits4 + noRespUnits5;
noRespUnits = noRespUnitsApp == 5;
noResposiveProfiles1 = responseProfiles1(noRespUnits,:);
noResposiveProfiles2 = responseProfiles2(noRespUnits,:);
noResposiveProfiles3 = responseProfiles3(noRespUnits,:);
noResposiveProfiles4 = responseProfiles4(noRespUnits,:);
noResposiveProfiles5 = responseProfiles5(noRespUnits,:);
responseProfiles1(noRespUnits,:) = [];
responseProfiles2(noRespUnits,:) = [];
responseProfiles3(noRespUnits,:) = [];
responseProfiles4(noRespUnits,:) = [];
responseProfiles5(noRespUnits,:) = [];
peakLatency1(noRespUnits) = [];


app1 = [];
app1 = [responseProfiles1 peakLatency1'];
app1 = sortrows(app1, size(app1,2));
app1(:,end) = [];
responseProfiles1 = app1;
app1 = [];
app1 = [responseProfiles2 peakLatency1'];
app1 = sortrows(app1, size(app1,2));
app1(:,end) = [];
responseProfiles2 = app1;
app1 = [];
app1 = [responseProfiles3 peakLatency1'];
app1 = sortrows(app1, size(app1,2));
app1(:,end) = [];
responseProfiles3 = app1;
app1 = [];
app1 = [responseProfiles4 peakLatency1'];
app1 = sortrows(app1, size(app1,2));
app1(:,end) = [];
responseProfiles4 = app1;
app1 = [];
app1 = [responseProfiles5 peakLatency1'];
app1 = sortrows(app1, size(app1,2));
app1(:,end) = [];
responseProfiles5 = app1;


responseProfiles1Final = [responseProfiles1;noResposiveProfiles1];
responseProfiles1Final = responseProfiles1Final(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles2Final = [responseProfiles2;noResposiveProfiles2];
responseProfiles2Final = responseProfiles2Final(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles3Final = [responseProfiles3;noResposiveProfiles3];
responseProfiles3Final = responseProfiles3Final(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles4Final = [responseProfiles4;noResposiveProfiles4];
responseProfiles4Final = responseProfiles4Final(:,2*cycleLengthDeg:8*cycleLengthDeg);
responseProfiles5Final = [responseProfiles5;noResposiveProfiles5];
responseProfiles5Final = responseProfiles5Final(:,2*cycleLengthDeg:8*cycleLengthDeg);


popResponses1Final = popResponses1(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses1Final = smooth(popResponses1Final, 0.05, 'rloess');
popResponses2Final = popResponses2(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses2Final = smooth(popResponses2Final, 0.05, 'rloess');
popResponses3Final = popResponses3(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses3Final = smooth(popResponses3Final, 0.05, 'rloess');
popResponses4Final = popResponses4(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses4Final = smooth(popResponses4Final, 0.05, 'rloess');
popResponses5Final = popResponses5(2*cycleLengthDeg:8*cycleLengthDeg);
popResponses5Final = smooth(popResponses5Final, 0.05, 'rloess');



rpHprctile1 = prctile(responseProfiles1Final(:), 97.9);
rpLprctile1 = prctile(responseProfiles1Final(:), 0.5);
rpHprctile2 = prctile(responseProfiles2Final(:), 97.9);
rpLprctile2 = prctile(responseProfiles2Final(:), 0.5);
rpHprctile3 = prctile(responseProfiles3Final(:), 97.9);
rpLprctile3 = prctile(responseProfiles3Final(:), 0.5);
rpHprctile4 = prctile(responseProfiles4Final(:), 97.9);
rpLprctile4 = prctile(responseProfiles4Final(:), 0.5);
rpHprctile5 = prctile(responseProfiles5Final(:), 97.9);
rpLprctile5 = prctile(responseProfiles5Final(:), 0.5);
maxL = max([rpHprctile1 rpHprctile2 rpHprctile3 rpHprctile4 rpHprctile5]);
minL = min([rpLprctile1 rpLprctile2 rpLprctile3 rpLprctile4 rpLprctile5]);
clims = [minL maxL];

popResponses1FinalMax = max(popResponses1Final);
popResponses2FinalMax = max(popResponses2Final);
popResponses3FinalMax = max(popResponses3Final);
popResponses4FinalMax = max(popResponses4Final);
popResponses5FinalMax = max(popResponses5Final);
maxPop = max([popResponses1FinalMax popResponses2FinalMax popResponses3FinalMax popResponses4FinalMax popResponses5FinalMax]);



Xfig = 900;
Yfig = 800;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')

p.pack({50 50}, {20 20 20 20 20})


p(1,1).select()
imagesc(responseProfiles1Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')
stringa = sprintf('Responses of units to %s (series of increasing dilutions)', listOdors{idxOdor});
p(1).title(stringa);

p(1,2).select()
imagesc(responseProfiles2Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')

p(1,3).select()
imagesc(responseProfiles3Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')

p(1,4).select()
imagesc(responseProfiles4Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')

p(1,5).select()
imagesc(responseProfiles5Final, clims); colormap(brewermap([],'*RdBu')); axis tight %colorbar
set(findobj(gcf, 'type','axes'), 'Visible','off')

p(2,1).select()
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
p(2,1).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(2,2).select()
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
p(2,2).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(2,3).select()
xAxis = 1:6*cycleLengthDeg+1;
area(popResponses3Final, 'FaceColor',[253,192,134]/255);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxPop], 'Color', [240,59,32]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
xlabel('Respiration cycles')
ylim([0 maxPop]);
p(2,3).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(2,4).select()
xAxis = 1:6*cycleLengthDeg+1;
area(popResponses4Final, 'FaceColor',[253,192,134]/255);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxPop], 'Color', [240,59,32]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
xlabel('Respiration cycles')
ylim([0 maxPop]);
p(2,4).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p(2,5).select()
xAxis = 1:6*cycleLengthDeg+1;
area(popResponses5Final, 'FaceColor',[253,192,134]/255);
line([2*cycleLengthDeg+1 2*cycleLengthDeg+1], [0 maxPop], 'Color', [240,59,32]/255);
axis tight
xticks = [1 cycleLengthDeg 2*cycleLengthDeg 3*cycleLengthDeg 4*cycleLengthDeg 5*cycleLengthDeg];
xticklabel = {'-2', '-1', '1', '2', '3', '4'};
set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xticklabel);
set(gca,'YColor','w')
xlabel('Respiration cycles')
ylim([0 maxPop]);
p(2,5).title('Population response');
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');

p.de.margin = 2;
p.margin = [8 15 4 10];
p(1).marginbottom = 20;
for i = 1:4
    p(1,i).marginright = 10;
end
p(2).marginbottom = 20;
for i =1:4
    p(2,i).marginright = 10;
end
p.select('all');