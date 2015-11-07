%odors = 7;
responsiveUnit = 1;
modifiedList = [1 2 3 4 6 8];
for idxExp = 1: length(List) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            reliabilityExc = zeros(1,odors);
            reliabilityInh = zeros(1,odors);
            for idxOdor = 1:odors
                %                 responsivenessExc(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 responsivenessInh(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == -1;
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                %                 reliabilityExc(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                %                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc + responsivenessInh) > 0
                responsiveUnit = responsiveUnit + 1;
            end
        end
    end
end

%%
modifiedList = [1 2 3 4 6 8];
rhoShank = [];
rhoFisherTransfShank = [];
rhoSimAll = [];
for idxExp = 1: length(List) %- 1
    for idxShank = 1:4
        idxCell = 0;
        tuningCell = [];
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            reliabilityExc = zeros(1,odors);
            reliabilityInh = zeros(1,odors);
            for idxOdor = 1:odors
                %                 responsivenessExc(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 responsivenessInh(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == -1;
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                %                 reliabilityExc(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                %                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc + responsivenessInh) > 0
                idxCell = idxCell + 1;
                for idxOdor = 1:odors
                    tuningCell(idxCell,idxOdor) = sum(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse(1:4));
                end
            end
        end
        if size(tuningCell,1) > 1;
            tuningCell = tuningCell';
            tuningCell = zscore(tuningCell);
            tuningCell = tuningCell';
            %rho = pdist(tuningCell, 'spearman');
            rho = pdist(tuningCell, 'correlation');
            rho = 1 - rho;
%             figure; imagesc(tuningCell)
%             figure; plot(rho, 'o')
            rhoFisherTransf = atanh(rho);
            rhoShank = [rhoShank rho];
            rhoFisherTransfShank = [rhoFisherTransfShank rhoFisherTransf];
            tuningCellSim = zeros(size(tuningCell,1), odors);
            rep = 50;
            rhoSimRep = zeros(rep,length(rho));
            for idxRep = 1:rep
                for idxC = 1:size(tuningCell,1)
                    idx = randperm(odors);
                    tuningCellSim(idxC,:) = tuningCell(idxC,idx);
                end
                rhoSim = pdist(tuningCellSim, 'correlation');
                rhoSim = 1 - rhoSim;
                rhoSimRep(idxRep,:) = rhoSim;
            end
            rhoSimAll = [rhoSimAll; rhoSimRep(:)];
        end     
    end
end

%%
figure; 
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);

subplot(1,2,1)
violin(rhoShank', 'facecolor', [252,146,114]/255,  'edgecolor', 'none', 'facealpha', 0.5);
ylim([-1 1]);
set(gca,'XColor','w')
%set(gca,'YColor','w')
title('Spearman signal correlation within shanks - Real data')
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

subplot(1,2,2)
violin(rhoSimAll, 'facecolor', [189,189,189]/255,  'edgecolor', 'none', 'facealpha', 0.5);
ylim([-1 1]);
set(gca,'XColor','w')
%set(gca,'YColor','w')
title('Spearman signal correlation within shanks - Shuffled data')
set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');

