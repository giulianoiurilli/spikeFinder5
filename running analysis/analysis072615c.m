coaW15 = load('waveformsCoa15.mat'); %15 odors
coaWAA = load('waveformsCoaAA.mat'); %aversive&appetitive&mixtures
coaWCS = load('waveformsCoaCS.mat'); %concentration series

pcxW15 = load('waveformsPcx15.mat');
pcxWAA = load('waveformsPcxAA.mat');
pcxWCS = load('waveformsPcxCS.mat');

%%
esp = coa15.esp;
espW = coaW15.espW;
idxCell1 = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                snrAllChannelsCoa(idxCell1) = espW(idxesp).waveforms{1,idxShank}.unit{1,idxUnit}.SNR.SNR_allCatChannels;
                snrBestChannelCoa(idxCell1) = espW(idxesp).waveforms{1,idxShank}.unit{1,idxUnit}.SNR.SNR_bestChannel;
                info1Coa(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end
esp = coaAA.esp;
espW = coaWAA.espW;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                snrAllChannelsCoa(idxCell1) = espW(idxesp).waveforms{1,idxShank}.unit{1,idxUnit}.SNR.SNR_allCatChannels;
                snrBestChannelCoa(idxCell1) = espW(idxesp).waveforms{1,idxShank}.unit{1,idxUnit}.SNR.SNR_bestChannel;
                info1Coa(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end

%%
esp = pcx15.esp;
espW = pcxW15.espW;
idxCell1 = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                snrAllChannelsPcx(idxCell1) = espW(idxesp).waveforms{1,idxShank}.unit{1,idxUnit}.SNR.SNR_allCatChannels;
                snrBestChannelPcx(idxCell1) = espW(idxesp).waveforms{1,idxShank}.unit{1,idxUnit}.SNR.SNR_bestChannel;
                info1Pcx(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end
esp = pcxAA.esp;
espW = pcxWAA.espW;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                snrAllChannelsPcx(idxCell1) = espW(idxesp).waveforms{1,idxShank}.unit{1,idxUnit}.SNR.SNR_allCatChannels;
                snrBestChannelPcx(idxCell1) = espW(idxesp).waveforms{1,idxShank}.unit{1,idxUnit}.SNR.SNR_bestChannel;
                info1Pcx(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I1s;
            end
        end
    end
end

%%
figure
plot(snrBestChannelPcx, info1Pcx, 'o', 'MarkerSize', 5, 'MarkerFaceColor', pcxC, 'MarkerEdgeColor', pcxC)
hold on
plot(snrBestChannelCoa, info1Coa, 'o', 'MarkerSize', 5, 'MarkerFaceColor', coaC, 'MarkerEdgeColor', coaC)
axis square
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)
hold on
x = 0:0.1:20;
y = 0.08*x + 0.506;
plot(x,y, '-', 'LineWidth', 1, 'color', pcxC)
hold on
y = 0.06*x + 0.512;
plot(x,y, '-', 'LineWidth', 1, 'color', coaC)


%%
fitlm(snrBestChannelPcx, info1Pcx)
fitlm(snrBestChannelCoa, info1Coa)