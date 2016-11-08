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
                            stdPSTH(idxOdor).cell(idxO1(idxOdor)).psth = slidingPSTHsd;
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
set(gcf,'Position',[440 604 560 194]);
time = linspace(-4,6,400);
for idxOdor = 1:n_odors
%     subplot(3,5,idxOdor)
subplot(1,6,idxOdor)
    app1 = nan(length(meanPSTH(idxOdor).cell), 400);
    app2 = nan(length(stdPSTH(idxOdor).cell), 400);
    for idxCell = 1:length(meanPSTH(idxOdor).cell)
        app1(idxCell,:) = meanPSTH(idxOdor).cell(idxCell).psth;
        app2(idxCell,:) = stdPSTH(idxOdor).cell(idxCell).psth;
        %         plot(time, app(idxCell,:)*10, 'color', singleTraceColor)
        %         hold on
    end
    shadedErrorBar(time, mean(app1)*10, mean(app2)*5,{'-', 'color', color', 'linewidth', 1.5}, 1)
    xlim([-4 6])
    ylim([0 20])
%     ylabel('Hz')
%     xlabel('s')
set(gca, 'XTick' , []);
set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca,'YTick',[])
set(gca,'YColor','w')
set(gca,'XColor','w')
end