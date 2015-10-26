%function slidingPSTHmeanvar


useUnit = [3 3; 4 3]

varianza = [];%zeros(length(spikes),1);  %initialize
mn = [];%zeros(length(spikes),1);   %initialize
for idxCell = 1:2
    idxO = 1;
idxShank = useUnit(idxCell,1);
idxUnit = useUnit(idxCell,2);
    for idxOdor = [1 8 13];



% spikes = logical(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp);
spikes = logical(shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad);

% times = 12000:10:18000;
% alignTime = 15000;
% boxWidth = 100; %20

times = 360*5 + 180:360:360*18+180;
alignTime = 360*10;
boxWidth = 360;


time = times-alignTime;



Tstart = times - floor(boxWidth/2) + 1;
Tend = times + ceil(boxWidth/2) + 1;


csum = cumsum(single(spikes(:,Tstart(1):Tend(end)+1)), 2); % casting as single makes it faster
count = csum(:,Tend - Tstart(1)+1) - csum(:,Tstart - Tstart(1)+1);

varianza(idxCell,:, idxO) = var(count);  % var and mean are taken for all times at once (to save time)
mn(idxCell,:, idxO) = mean(count);
ff = varianza./mn;
ff(isnan(ff)) = 0;
    idxO = idxO + 1;
    end

end

%%
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[121 60 1235 738]);
subplot(2,3,1)
hold on
plot(time, mn(1,:,1), 'k')
plot(time, mn(2,:,1), 'r')
hold off
axis tight
xlabel('ms')
ylabel('spike count mean')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(2,3,2)
hold on
plot(time, mn(1,:,2), 'k')
plot(time, mn(2,:,2), 'r')
hold off
axis tight
xlabel('ms')
ylabel('spike count mean')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(2,3,3)
hold on
plot(time, mn(1,:,3), 'k')
plot(time, mn(2,:,3), 'r')
hold off
axis tight
xlabel('ms')
ylabel('spike count variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');

subplot(2,3,4)
hold on
plot(time, varianza(1,:,1), 'k')
plot(time, varianza(2,:,1), 'r')
hold off
axis tight
xlabel('ms')
ylabel('spike count variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(2,3,5)
hold on
plot(time, varianza(1,:,2), 'k')
plot(time, varianza(2,:,2), 'r')
hold off
axis tight
xlabel('ms')
ylabel('spike count variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
subplot(2,3,6)
hold on
plot(time, varianza(1,:,3), 'k')
plot(time, varianza(2,:,3), 'r')
hold off
axis tight
xlabel('ms')
ylabel('spike count variance')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');













    



% figure
% plot(time, mn, 'r')
% figure
% plot(time, varianza, 'k')
% figure
% plot(time, ff, 'b')
