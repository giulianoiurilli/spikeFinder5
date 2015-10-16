from = 12;
to = 18;
xtime = -3:1/1000:3;
xtimeSniff = -3:1/20000:3;

useOdor = [odorsRearranged(13) odorsRearranged(14)];
figure
set(gcf,'Position',[1 5 1000 900]);
set(gcf,'Color','w')
idxPlot = 1;
p = panel();
p.pack('h',{50 50});
p(1).pack('v', {10 10 10 10 10 10 10 10 10 10});
p(2).pack('v', {10 10 10 10 10 10 10 10 10 10});

lfpTrials1 = [];
sniff1 = [];
lfpTrials1 = zscore(lfpThetaTrials(:));
lfpTrials1 = reshape(lfpTrials1,10, 30000,15);
sniff1 = zscore(breath(:));
sniff1 = reshape(sniff1,10, 600000,15);
idxCol = 1;
for idxOdor = useOdor
    for idxTrial = 1:10
        lfpResp2 = squeeze(lfpTrials1(idxTrial,from*1000:to*1000,idxOdor));
        sniff2 = squeeze(sniff1(idxTrial,from*20000:to*20000,idxOdor));
        sniff2 = downsample(sniff2,20);

        p(idxCol,idxTrial).select()
        hold on
        plot(xtime, -sniff2, 'k');
        plot(xtime, -lfpResp2, 'r');
        axis tight
        set(gca,'YTick',[])
        set(gca,'YColor','w')
        ymax = get(gca, 'YLim');
        plot([0 0], ymax, 'color', [44,162,95]/255, 'linewidth', 1);
        set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
    end
    idxCol = idxCol + 1;
end
    
p.de.margin = 4;
p.margin = [8 6 4 6];
p(2).marginleft = 30;
p.select('all');

%%
wname  = 'cmor1-1'; %I'm using a wavelet here
scales = 1:512;
ntw = 5;



idxO = 1;
odorsToUse = [1 8];
for idxOdor = odorsToUse
    A = [];
    theta = [];
    idxT = 1;
    for idxTrial = 2:9
        A(1,:) = zscore(-downsample(squeeze(breath(idxTrial,from*20000:to*20000,idxOdor)),20));
        A(2,:) = -zscore((squeeze(lfpThetaTrials(idxTrial,from*1000:to*1000,idxOdor))));
        A(3,:) = zscore(shankMua(idxShank).odor(idxOdor).sdf_trialMua(idxTrial,from*1000 :to*1000));
        x = A(1,:);
        y = A(2,:);
        z = A(3,:);
        [wcoh, wcs] = wcoher(x,y,scales,wname,'ntw',ntw);    %resp vs LFP
        theta(:,:,idxT) = angle(wcs);
        %wcoher(x,z,scales,wname,'ntw',ntw,'plot');    %resp vs MUA
        %wcoher(y,z,scales,wname,'ntw',ntw,'plot');    %LFP vs MUA
        idxT =idxT + 1;
    end
    thetaMean = [];
    thetaMean = circ_mean(theta,[],3);
    figure;
    set(gcf,'Color','w');
    imagesc(thetaMean), axis xy,
    ylim([300 400]);
    app = [];
    app = mean(thetaMean(300:400,:));
%     if mean(app(3000:5000)) < 0
%         app = -app;
%     end
    thetaGranAve(idxO,:) = app;
    idxO = idxO + 1;
end
figure;
idxSig = 1;
for idxPlot = 1:4
    subplot(4,1,idxPlot)
    hold on
    plot(thetaGranAve(idxSig,:) - mean(thetaGranAve(idxSig,2000:3000)), 'k');
    idxSig = idxSig + 1;
    plot(thetaGranAve(idxSig,:) - mean(thetaGranAve(idxSig,2000:3000)), 'r');
    idxSig = idxSig + 1;
    hold off
end
xlim([2000 6000]);
axis tight


%%
thetaMean = [];
thetaMean01 = [];
thetaMean = circ_mean(theta,[],3);
thetaMean01 = mat2gray(thetaMean);
figure;
set(gcf,'Color','w');
subplot(1,2,1)
imagesc(thetaMean), axis xy,
ylim([300 400]);
colorbar;
set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');
subplot(1,2,2)
imagesc(thetaMean01), axis xy,
ylim([300 400]);
colorbar;
set(gca,'FontName','Arial','Fontsize',10,'FontWeight','normal','TickDir','out','Box','off');

    
    