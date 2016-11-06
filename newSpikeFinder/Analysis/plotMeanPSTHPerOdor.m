function meanPSTH = plotMeanPSTHPerOdor(esp, odors, color)


[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors);

%%

for idxOdor = 1:odors
    for idxO = 1:totalResponsiveNeuronPerOdor(idxOdor)
        meanPSTH(idxOdor).cell(idxO).psth = nan(1,400);
    end
end

n_odors = length(odors);
idxO1 = zeros(1,n_odors);
for idxExp = 1:length(esp)
    cd(fullfile((esp(idxExp).filename), 'ephys'))
    load('units.mat')
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    for idxOdor = odors
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                            idxO1(idxOdor) = idxO1(idxOdor) + 1;
                            app = shank(idxShank).SUA.spike_matrix{idxUnit}(:,:,idxOdor);
                            [slidingPSTHmn, slidingPSTHsd, slidingPSTHFF, slidingPSTHCV, slidingPSTH] = slidePSTH(app, 100, 25);
                            meanPSTH(idxOdor).cell(idxO1(idxOdor)).psth = slidingPSTHmn;
                        end
                    end
                end
            end
        end
    end
end

singleTraceColor = [189,189,189]./255;
figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
time = linspace(-4,6,400);
for idxOdor = 1:n_odors
    subplot(3,5,idxOdor)
    app = nan(length(meanPSTH(idxOdor).cell), 400);
    for idxCell = 1:length(meanPSTH(idxOdor).cell)
        app(idxCell,:) = meanPSTH(idxOdor).cell(idxCell).psth;
        %         plot(time, app(idxCell,:)*10, 'color', singleTraceColor)
        %         hold on
    end
    plot(time, mean(app)*10, 'color', color, 'linewidth', 1)
    xlim([-4 6])
    ylim([0 20])
    ylabel('Hz')
    xlabel('s')
end