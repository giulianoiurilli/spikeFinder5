nCb3Apcx = [];
nCw3Apcx = [];
nCb4Apcx = [];
nCw4Apcx = [];

sCb3Apcx = [];
sCw3Apcx = [];
sCb4Apcx = [];
sCw4Apcx = [];
%%
nCb3Apcx = [nCb3Apcx noiseCorrB300ms];
nCw3Apcx = [nCw3Apcx noiseCorrW300ms];
nCb4Apcx = [nCb4Apcx noiseCorrB4Cycles];
nCw4Apcx = [nCw4Apcx noiseCorrW4Cycles];

sCb3Apcx = [sCb3Apcx sigCorrB300ms];
sCw3Apcx = [sCw3Apcx sigCorrW300ms];
sCb4Apcx = [sCb4Apcx sigCorrB4Cycles];
sCw4Apcx = [sCw4Apcx sigCorrW4Cycles];

%%
nCb3Plcoa = [];
nCw3Plcoa  = [];
nCb4Plcoa  = [];
nCw4Plcoa  = [];

sCb3Plcoa  = [];
sCw3Plcoa  = [];
sCb4Plcoa  = [];
sCw4Plcoa  = [];

%%
nCb3Plcoa = [nCb3Plcoa noiseCorrB300ms];
nCw3Plcoa  = [nCw3Plcoa noiseCorrW300ms];
nCb4Plcoa  = [nCb4Plcoa noiseCorrB4Cycles];
nCw4Plcoa  = [nCw4Plcoa noiseCorrW4Cycles];

sCb3Plcoa  = [sCb3Plcoa sigCorrB300ms];
sCw3Plcoa  = [sCw3Plcoa sigCorrW300ms];
sCb4Plcoa  = [sCb4Plcoa sigCorrB4Cycles];
sCw4Plcoa  = [sCw4Plcoa sigCorrW4Cycles];

%%
nCb3ApcxZ = fisherZTransform(nCb3Apcx);
nCw3ApcxZ = fisherZTransform(nCw3Apcx);
nCb4ApcxZ = fisherZTransform(nCb4Apcx);
nCw4ApcxZ = fisherZTransform(nCw4Apcx);

sCb3ApcxZ = fisherZTransform(sCb3Apcx);
sCw3ApcxZ = fisherZTransform(sCw3Apcx);
sCb4ApcxZ = fisherZTransform(sCb4Apcx);
sCw4ApcxZ = fisherZTransform(sCw4Apcx);
%%
nCb3PlcoaZ = fisherZTransform(nCb3Plcoa);
nCw3PlcoaZ  = fisherZTransform(nCw3Plcoa);
nCb4PlcoaZ  = fisherZTransform(nCb4Plcoa);
nCw4PlcoaZ  = fisherZTransform(nCw4Plcoa);

sCb3PlcoaZ  = fisherZTransform(sCb3Plcoa);
sCw3PlcoaZ  = fisherZTransform(sCw3Plcoa);
sCb4PlcoaZ  = fisherZTransform(sCb4Plcoa);
sCw4PlcoaZ  = fisherZTransform(sCw4Plcoa);

%%
[h, p] = ttest2(nCw3ApcxZ, nCw3PlcoaZ)
[h, p] = ttest2(sCw3ApcxZ, sCw3PlcoaZ)
[h, p] = ttest2(nCw4ApcxZ, nCw4PlcoaZ)
[h, p] = ttest2();
%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
p = panel();
p.pack('h',{50 50});

apcxNCmedian = [nanmean(nCw3Apcx) nanmean(nCb3Apcx)];
apcxNCsem = [nanstd(nCw3Apcx)./sqrt(length(nCw3Apcx) - 1) nanmean(nCb3Apcx)./sqrt(length(nCb3Apcx) - 1)];
apcxNC25 = [prctile(nCw3Apcx,25) prctile(nCb3Apcx,25)];
apcxNC75 = [prctile(nCw3Apcx,75) prctile(nCb3Apcx,75)];

apcxSCmedian = [nanmean(sCw3Apcx) nanmean(sCb3Apcx)];
apcxSCsem = [nanstd(sCw3Apcx)./sqrt(length(sCw3Apcx) - 1) nanstd(sCb3Apcx)./sqrt(length(sCb3Apcx) - 1)];
apcxSC25 = [prctile(sCw3Apcx,25) prctile(sCb3Apcx,25)];
apcxSC75 = [prctile(sCw3Apcx,75) prctile(sCb3Apcx,75)];

plcoaNCmedian = [nanmean(nCw3Plcoa) nanmean(nCb3Plcoa)];
plcoaNCsem = [nanstd(nCw3Plcoa)./sqrt(length(nCw3Plcoa) - 1) nanstd(nCb3Plcoa)./sqrt(length(nCb3Plcoa) - 1)];
plcoaNC25 = [prctile(nCw3Plcoa,25) prctile(nCb3Plcoa,25)];
plcoaNC75 = [prctile(nCw3Plcoa,75) prctile(nCb3Plcoa,75)];

plcoaSCmedian = [nanmean(sCw3Plcoa) nanmean(sCb3Plcoa)];
plcoaSCsem = [nanstd(sCw3Plcoa)./sqrt(length(sCw3Plcoa) - 1) nanstd(sCb3Plcoa)./sqrt(length(sCb3Plcoa) - 1)];
plcoaSC25 = [prctile(sCw3Plcoa,25) prctile(sCb3Plcoa,25)];
plcoaSC75 = [prctile(sCw3Plcoa,75) prctile(sCb3Plcoa,75)];

xAxi = 1:2;
p(1).select();
hold on
errorbar(xAxi, apcxNCmedian , apcxNCsem, 'o-')
errorbar(xAxi, plcoaNCmedian , plcoaNCsem, 'o-')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p(1).title('noise correlation among units in the same probe shank - first 300 ms');

p(2).select();
hold on
errorbar(xAxi, apcxSCmedian , apcxSCsem, 'o-')
errorbar(xAxi, plcoaSCmedian , plcoaSCsem, 'o-')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p(2).title('signal correlation among units in the same probe shank - first 300 ms');

%p.de.margin = 1;
p.margin = [20 10 10 10];
p(1).marginleft= 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
p = panel();
p.pack('h',{50 50});

apcxNCmedian = [nanmean(nCw4Apcx) nanmean(nCb4Apcx)];
apcxNCsem = [nanstd(nCw4Apcx)./sqrt(length(nCw4Apcx) - 1) nanmean(nCb3Apcx)./sqrt(length(nCb3Apcx) - 1)];
apcxNC25 = [prctile(nCw4Apcx,25) prctile(nCb4Apcx,25)];
apcxNC75 = [prctile(nCw4Apcx,75) prctile(nCb4Apcx,75)];

apcxSCmedian = [nanmean(sCw4Apcx) nanmean(sCb4Apcx)];
apcxSCsem = [nanstd(sCw4Apcx)./sqrt(length(sCw4Apcx) - 1) nanstd(sCb3Apcx)./sqrt(length(sCb3Apcx) - 1)];
apcxSC25 = [prctile(sCw4Apcx,25) prctile(sCb4Apcx,25)];
apcxSC75 = [prctile(sCw4Apcx,75) prctile(sCb4Apcx,75)];

plcoaNCmedian = [nanmean(nCw4Plcoa) nanmean(nCb4Plcoa)];
plcoaNCsem = [nanstd(nCw4Plcoa)./sqrt(length(nCw4Plcoa) - 1) nanstd(nCb3Plcoa)./sqrt(length(nCb3Plcoa) - 1)];
plcoaNC25 = [prctile(nCw4Plcoa,25) prctile(nCb4Plcoa,25)];
plcoaNC75 = [prctile(nCw4Plcoa,75) prctile(nCb4Plcoa,75)];

plcoaSCmedian = [nanmean(sCw4Plcoa) nanmean(sCb4Plcoa)];
plcoaSCsem = [nanstd(sCw4Plcoa)./sqrt(length(sCw4Plcoa) - 1) nanstd(sCb3Plcoa)./sqrt(length(sCb3Plcoa) - 1)];
plcoaSC25 = [prctile(sCw4Plcoa,25) prctile(sCb4Plcoa,25)];
plcoaSC75 = [prctile(sCw4Plcoa,75) prctile(sCb4Plcoa,75)];

xAxi = 1:2;
p(1).select();
hold on
errorbar(xAxi, apcxNCmedian , apcxNCsem, 'o-')
errorbar(xAxi, plcoaNCmedian , plcoaNCsem, 'o-')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p(1).title('noise correlation among units in the same probe shank - 1 s');

p(2).select();
hold on
errorbar(xAxi, apcxSCmedian , apcxSCsem, 'o-')
errorbar(xAxi, plcoaSCmedian , plcoaSCsem, 'o-')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p(2).title('signal correlation among units in the same probe shank - 1 s');

%p.de.margin = 1;
p.margin = [20 10 10 10];
p(1).marginleft= 10;
p(2).marginleft = 30;
%p(3).marginleft = 10;
p.select('all');































