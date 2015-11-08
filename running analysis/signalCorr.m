responsiveUnit4Cycles = 0;
responsiveUnit300ms = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc4Cycles = zeros(1,odors);
            responsivenessInh4Cycles = zeros(1,odors);
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            for idxOdor = 1:odors
                responsivenessExc300ms(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessInh300ms(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                responsivenessExc4Cycles(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh4Cycles(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
            end
            if sum(responsivenessExc4Cycles + responsivenessInh4Cycles) > 0
                responsiveUnit4Cycles = responsiveUnit4Cycles + 1;
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                responsiveUnit300ms= responsiveUnit300ms + 1;
            end
        end
    end
end

%%
sigCorrW4Cycles = [];
sigCorrB4Cycles = [];
sigCorrW300ms = [];
sigCorrB300ms = [];
for idxExp = 1: length(exp) %- 1
    tuningCell4Cycles = [];
    for idxShank = 1:4
        idxCell4Cycles = 0;
        idxCell300ms = 0;
        tuningCell4Cycles(idxShank).shank = zeros(responsiveUnit4Cycles, odors);
        tuningCell300ms(idxShank).shank = zeros(responsiveUnit300ms, odors);
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc4Cycles = zeros(1,odors);
            responsivenessInh4Cycles = zeros(1,odors);
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            for idxOdor = 1:odors
                responsivenessExc300ms(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessInh300ms(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                responsivenessExc4Cycles(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh4Cycles(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
            end
            % 4Cycles
            if sum(responsivenessExc4Cycles + responsivenessInh4Cycles) > 0
                idxCell4Cycles = idxCell4Cycles + 1;
                for idxOdor = 1:odors
                    tuningCell4Cycles(idxShank).shank(idxCell4Cycles,idxOdor) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse) - ...
                        mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl);
                end
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                idxCell300ms = idxCell300ms + 1;
                for idxOdor = 1:odors
                    tuningCell300ms(idxShank).shank(idxCell300ms,idxOdor) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                        mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                end
            end
        end
        % sigCorr W 4Cycles
        if size(tuningCell4Cycles(idxShank).shank,1) > 1;
            tuningCell4Cycles(idxShank).shank = tuningCell4Cycles(idxShank).shank';
            tuningCell4Cycles(idxShank).shank = zscore(tuningCell4Cycles(idxShank).shank);
            tuningCell4Cycles(idxShank).shank = tuningCell4Cycles(idxShank).shank';
            rho = [];
            rho = pdist(tuningCell4Cycles(idxShank).shank, 'correlation');
            rho = 1 - rho;
            sigCorrW4Cycles = [sigCorrW4Cycles rho];
        end 
        % sigCorr W 300ms
        if size(tuningCell300ms(idxShank).shank,1) > 1;
            tuningCell300ms(idxShank).shank = tuningCell300ms(idxShank).shank';
            tuningCell300ms(idxShank).shank = zscore(tuningCell300ms(idxShank).shank);
            tuningCell300ms(idxShank).shank = tuningCell300ms(idxShank).shank';
            rho = [];
            rho = pdist(tuningCell300ms(idxShank).shank, 'correlation');
            rho = 1 - rho;
            sigCorrW300ms = [sigCorrW300ms rho];
        end 
    end
    % sigCorr B 4Cycles
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell4Cycles(probe).shank,1) >= 1) && (size(tuningCell4Cycles(next).shank,1) >= 1)
                app = corr(tuningCell4Cycles(probe).shank', tuningCell4Cycles(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                sigCorrB4Cycles = [sigCorrB4Cycles apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                sigCorrB4Cycles = [sigCorrB4Cycles apppp(:)'];
            end
        end
    end
    % sigCorr B 300ms
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell300ms(probe).shank,1) >= 1) && (size(tuningCell300ms(next).shank,1) >= 1)
                app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                sigCorrB300ms = [sigCorrB300ms apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                sigCorrB300ms = [sigCorrB300ms apppp(:)'];
            end
        end
    end
    
end

%%

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
histogram(sigCorrW4Cycles,100, 'normalization', 'probability'); hold on;  histogram(sigCorrB4Cycles,100, 'normalization', 'probability'); hold off
xlabel('noise correlation')
ylabel('proportion of neuron pairs (%)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('signal correlation within/between - first 4 cycles')

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
histogram(sigCorrW300ms,100, 'normalization', 'probability'); hold on;  histogram(sigCorrB300ms,100, 'normalization', 'probability'); hold off
xlabel('noise correlation')
ylabel('proportion of neuron pairs (%)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('signal correlation within/between - first 300 ms')

%%
save('signalCorrelation.mat', 'sigCorrW4Cycles', 'sigCorrB4Cycles', 'sigCorrW300ms', 'sigCorrB300ms');


