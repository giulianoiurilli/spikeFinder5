function plotUnitResponses(shank, idxShank, idxUnit)


colors = [228,26,28;...
    55,126,184;...
    77,175,74;...
    152,78,163] ./ 255;
time = -4:1/1000:6;
time(1:2) = [];
figure
set(gcf,'Position',[97 91 1247 714]);
subplot(7,5,[1 2])
plot(shank(idxShank).SUA.meanWaveform{idxUnit}, 'color', colors(idxShank,:), 'linewidth', 1)
set(gca, 'XTick' , []);
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'XColor','w')
s1 = shank(idxShank).SUA.L_Ratio{idxUnit};
s2 = shank(idxShank).SUA.isolationDistance{idxUnit};
s3 = shank(idxShank).SUA.spikeSNR{idxUnit};
maxRsp = 0;
minRsp = 0;
response = nan(10,15);
for idxOdor = 1:15
    maxRsp = max([maxRsp max(mean(shank(idxShank).SUA.sdf_trial{idxUnit}(:,:,idxOdor)))]);
    minRsp = min([minRsp min(mean(shank(idxShank).SUA.sdf_trial{idxUnit}(:,:,idxOdor)))]);
    spike_matrix_app = single(shank(idxShank).SUA.spike_matrix{idxUnit}(:,:,idxOdor));
    response_window = 1;
    preOnset = 4;
    appBsl = [];
    appRsp = [];
    appBsl = sum(spike_matrix_app(:, floor((preOnset-2)*1000) : floor((preOnset-1)*1000)), 2)';
    appRsp = sum(spike_matrix_app(:, floor(preOnset*1000) : floor(preOnset*1000 + response_window*1000)), 2)';
    shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms = appRsp;
    shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms = appBsl;
    [auroc, significant] = findAuROC(appBsl, appRsp, 1);
    shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC1000ms = auroc;
    shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms = significant;
    response(:,idxOdor) = appRsp - appBsl;
end
for idxOdor = 1:15
    subplot(7,5,5+idxOdor)
    plot(time, mean(shank(idxShank).SUA.sdf_trial{idxUnit}(:,:,idxOdor)), 'color', 'k', 'linewidth', 1)
    ylim([minRsp-0.001 maxRsp+0.001])
    xlim([-4 6])
    set(gca, 'box', 'off')
    stringa = sprintf('auROC: %0.2f - significant: %d', shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC1000ms, shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms);
    title(stringa)
    for idxTrial = 1:10
        app = [];
        app = shank(idxShank).SUA.spike_matrix{idxUnit}(idxTrial,:,idxOdor);
        app1=[];
        app1 = find(app==1);
        app1 = (app1./1000) - 4;
        responses.spikes{idxTrial} = app1;
    end
    subplot(7,5,5+idxOdor+15)
    plotSpikeRaster(responses.spikes,'PlotType','vertline', 'VertSpikeHeight', 1,'XLimForCell',[-4 6]);
    set(gca, 'XTick' , []);
    set(gca, 'XTickLabel', []);
    set(gca,'YTick',[])
    set(gca,'YColor','w')
    set(gca,'XColor','w')
end
ls = lifetime_sparseness(response);
stringa = sprintf('LR: %0.2f - ID: %0.2f - SNR: %0.2f  -  LS:%0.2f', s1, s2, max(s3), ls);
title(stringa)