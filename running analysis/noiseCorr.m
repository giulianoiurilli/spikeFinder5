responsiveUnit300ms = 0;
for idxesp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            responsivenessExc4Cycles = zeros(1,odors);
            responsivenessInh4Cycles = zeros(1,odors);
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            for idxOdor = 1:odors
%                 responsivenessExc300ms(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
responsivenessExc300ms(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                responsivenessInh300ms(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                responsiveUnit300ms= responsiveUnit300ms + 1;
            end
        end
    end
end

%%
noiseCorrW300ms = [];
noiseCorrB300ms = [];
for idxesp = 1: length(esp) %- 1
    for idxShank = 1:4
        idxCell4Cycles = 0;
        idxCell300ms = 0;
        tuningCell300ms(idxShank).shank = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            for idxOdor = 1:odors
%                 responsivenessExc300ms(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessExc300ms(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                responsivenessInh300ms(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
            end
            %300 ms
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                idxCell300ms = idxCell300ms + 1;
                for idxOdor = 1:odors
                    tuningCell300ms(idxShank).shank(idxCell300ms,:,idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms -...
                        esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms;
                end
            end
        end
        % sigCorr W 300ms
        if size(tuningCell300ms(idxShank).shank,1) > 1;
            tuningCell300ms(idxShank).shank = reshape(tuningCell300ms(idxShank).shank, size(tuningCell300ms(idxShank).shank,1), n_trials * odors);
            tuningCell300ms(idxShank).shank = tuningCell300ms(idxShank).shank';
            tuningCell300ms(idxShank).shank = zscore(tuningCell300ms(idxShank).shank);
            tuningCell300ms(idxShank).shank = tuningCell300ms(idxShank).shank';
            rho = [];
            rho = pdist(tuningCell300ms(idxShank).shank, 'correlation');
            rho = 1 - rho;
            noiseCorrW300ms = [noiseCorrW300ms rho];
        end 
    end
    % sigCorr B 300ms
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell300ms(probe).shank,1) > 1) && (size(tuningCell300ms(next).shank,1) > 1)
                app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                noiseCorrB300ms = [noiseCorrB300ms apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                noiseCorrB300ms = [noiseCorrB300ms apppp(:)'];
            end
        end
    end
    
end


%%
noiseCorrW300msCoa = noiseCorrW300ms;
noiseCorrB300msCoa = noiseCorrB300ms;
%%
% noiseCorrW300msPcx = noiseCorrW300ms;
% noiseCorrB300msPcx= noiseCorrB300ms;
%%
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[497 246 1102 748]);
histogram(noiseCorrW300ms,100, 'normalization', 'probability'); hold on;  histogram(noiseCorrB300ms,100, 'normalization', 'probability'); hold off
xlabel('noise correlation')
ylabel('proportion of neuron pairs (%)')
set(gca,'FontName','Arial','Fontsize',12,'FontWeight','normal','TickDir','out','Box','off');
title('noise correlation within/between - first 300 ms')

%%
save('noiseCorrelationCoaHigh.mat', 'noiseCorrW300msCoa', 'noiseCorrB300msCoa');
% save('noiseCorrelationPcxHigh.mat', 'noiseCorrW300msPcx', 'noiseCorrB300msPcx');


