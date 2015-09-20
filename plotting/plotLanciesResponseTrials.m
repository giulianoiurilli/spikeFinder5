clear all


load('units.mat');
load('parameters.mat');

bslWindow = floor(preInhalations * round(2*pi, 2) / radPerMs);
cycleLength = floor(round(2*pi, 2) / radPerMs);


hexc = figure;

idxCycle = 3;
odorsToUse = 1:15


excitatoryResponses = [];
excitatoryLatency = [];
inhibitoryResponses = [];
inhibitoryLatency = [];
excitatoryResponses1 = [];
inhibitoryResponses1 = [];
hexc = [];
hinh = [];
cellOdorPair = 1;
j = 1;
for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        for idxOdor = odorsToUse %1:odors
            if shank(idxShank).cell(idxUnit).odor(idxOdor).meanPeakExcitation(idxCycle) == 1;
                %excitatoryResponses(i,:) = mean(shank(sha).cell(s).odor(k).spikeMatrixRadMs);
                excitatoryResponses(:,:,cellOdorPair) = shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs;
                excitatoryLatency(cellOdorPair) = shank(idxShank).cell(idxUnit).odor(idxOdor).meanPeakLatency(idxCycle);
                cellOdorPair = cellOdorPair + 1;
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

for idxTrial = 1:n_trials
    excitatoryResponses1 = squeeze(excitatoryResponses(idxTrial, 1+(idxCycle - 2) * cycleLength  : (idxCycle + 1) * cycleLength,:));
    excitatoryResponses1 = excitatoryResponses1';
    
    
    
    excitatoryResponses1 = [excitatoryResponses1 excitatoryLatency'];
    excitatoryResponses1 = sortrows(excitatoryResponses1, size(excitatoryResponses1,2));
    excitatoryResponses1(:,end) = [];
    excitatoryResponses1(:,cycleLength) = 0.06;
    excitatoryResponses1(:,2*cycleLength) = 0.06;
    
    subplot(n_trials, 1, idxTrial)
    imagesc(excitatoryResponses1), %colorbar
    stringa = sprintf('Cycle %d - Trial %d', idxCycle, idxTrial);
    title(stringa), xlabel('Time (ms)'), ylabel('Cell-odor pairs')
    caxis([0, 0.065])
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
end


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

set(hexc,'color','white', 'PaperPositionMode', 'auto');