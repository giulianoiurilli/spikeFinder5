clear all


load('units.mat');
load('parameters.mat');

bslWindow = floor(preInhalations * round(2*pi, 2) / radPerMs);
cycleLength = floor(round(2*pi, 2) / radPerMs);


hexc = figure; 



for idxCycle = 1:preInhalations+postInhalations
    excitatoryResponses = [];
    excitatoryLatency = [];
    inhibitoryResponses = [];
    inhibitoryLatency = [];
    excitatoryResponses1 = [];
    inhibitoryResponses1 = [];
    hexc = [];
    hinh = [];
    i = 1;
    j = 1;
    for idxShank = 1:4
        for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
            for idxOdor = 1:odors
                if shank(idxShank).cell(idxUnit).odor(idxOdor).meanPeakExcitation(idxCycle) == 1;
                    %excitatoryResponses(i,:) = mean(shank(sha).cell(s).odor(k).spikeMatrixRadMs);
                    excitatoryResponses(i,:) = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs);
                    excitatoryLatency(i) = shank(idxShank).cell(idxUnit).odor(idxOdor).meanPeakLatency(idxCycle);
                    i = i+1;
                end
%                 if shank(idxShank).cell(idxUnit).odor(k).inhibition(idxCycle) == 1;
%                     %inhibitoryResponses(i,:) = mean(shank(sha).cell(s).odor(k).spikeMatrixRadMs);
%                     inhibitoryResponses(j,:) = mean(shank(idxShank).cell(idxUnit).odor(k).sdf_trialRadMs);
%                     inhibitoryLatency(j) = shank(idxShank).cell(idxUnit).odor(k).latency{idxCycle};
%                     j = j+1;
%                 end
            end
        end
    end
    
    
    
    % excitatoryResponses(:, 1:bslWindow + cycleLength) = [];
    % inhibitoryResponses(:, 1:bslWindow + cycleLength) = [];
    %
    % excitatoryResponses1 = excitatoryResponses(:, 1:cycleLength);
    % inhibitoryResponses1 = inhibitoryResponses(:, 1:cycleLength);
    
    %excitatoryResponses(:, 1:bslWindow) = [];  %remove the baseline cycles, but the last one
    excitatoryResponses1 = excitatoryResponses(:, 1 + (idxCycle - 1) * cycleLength : idxCycle * cycleLength-1);
    excitatoryResponses1 = [excitatoryResponses1 excitatoryLatency'];
    excitatoryResponses1 = sortrows(excitatoryResponses1, size(excitatoryResponses1,2));
    excitatoryResponses1(:,end) = [];
    
    subplot(preInhalations, preInhalations, idxCycle)
    imagesc(excitatoryResponses1), colorbar
    stringa = sprintf('Cycle %d', idxCycle);
    title(stringa), xlabel('Time (ms)'), ylabel('Cell-odor pairs')
    caxis([0, 0.065])
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
    
    
    %     excitatoryResponses1(:,cycleLength:cycleLength + idxCycle) = max(max(excitatoryResponses1));
    %     inhibitoryResponses(:, 1:bslWindow) = [];
    %     inhibitoryResponses1 = inhibitoryResponses(:, 1:(2+idxCycle) * cycleLength);
    %     inhibitoryResponses1 = [inhibitoryResponses1 inhibitoryLatency'];
    %     inhibitoryResponses1 = sortrows(inhibitoryResponses1, size(inhibitoryResponses1,2));
    %     inhibitoryResponses1(:,end) = [];
    %     inhibitoryResponses1(:,cycleLength:cycleLength + idxCycle) = max(max(inhibitoryResponses1));


%     hinh = figure; imagesc(inhibitoryResponses1)
%     stringa = sprintf('Inhibitory responses tile the respiratory cycle %d', idxCycle);
%     title(stringa), xlabel('Time (ms)'), ylabel('Cell-odor pairs')
%     set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
%     set(hinh,'color','white', 'PaperPositionMode', 'auto');
    
%     figure; histogram(excitatoryLatency, 50)
%     figure; histogram(inhibitoryLatency, 50)
end
set(hexc,'color','white', 'PaperPositionMode', 'auto');