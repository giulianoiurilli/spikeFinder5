clear all


load('units.mat');
load('parameters.mat');

bslWindow = floor((preInhalations-1) * round(2*pi, 2) / radPerMs);
cycleLength = floor(round(2*pi, 2) / radPerMs);


i = 1;
j = 1;
excitatoryResponses = [];
inhibitoryResponses = [];


for sha = 1:4
    for s = 1:length(shank(sha).spiketimesUnit)
        for k = 1:odors
            if shank(sha).cell(s).odor(k).excitation == 1;
                %excitatoryResponses(i,:) = mean(shank(sha).cell(s).odor(k).spikeMatrixRadMs);
                excitatoryResponses(i,:) = mean(shank(sha).cell(s).odor(k).sdf_trialRadMs);
                excitatoryLatency(i) = shank(sha).cell(s).odor(k).latency;
                i = i+1;
            end
            if shank(sha).cell(s).odor(k).inhibition == 1;
                %inhibitoryResponses(i,:) = mean(shank(sha).cell(s).odor(k).spikeMatrixRadMs);
                inhibitoryResponses(j,:) = mean(shank(sha).cell(s).odor(k).sdf_trialRadMs);
%                 inhibitoryLatency(j) = shank(sha).cell(s).odor(k).latency;
                j = j+1;
            end
        end
    end
end



% excitatoryResponses(:, 1:bslWindow + cycleLength) = [];
% inhibitoryResponses(:, 1:bslWindow + cycleLength) = [];
%
% excitatoryResponses1 = excitatoryResponses(:, 1:cycleLength);
% inhibitoryResponses1 = inhibitoryResponses(:, 1:cycleLength);

%excitatoryResponses(:, 1:bslWindow) = [];  %remove the baseline cycles, but the last one
% inhibitoryResponses(:, 1:bslWindow) = [];

excitatoryResponses1 = excitatoryResponses;
%excitatoryResponses1 = excitatoryResponses(:, 1:4*cycleLength);
% inhibitoryResponses1 = inhibitoryResponses(:, 1:2*cycleLength);
excitatoryResponses1 = [excitatoryResponses1 excitatoryLatency'];
excitatoryResponses1 = sortrows(excitatoryResponses1, size(excitatoryResponses1,2));
% inhibitoryResponses1 = [inhibitoryResponses1 inhibitoryLatency'];
% inhibitoryResponses1 = sortrows(inhibitoryResponses1, size(inhibitoryResponses1,2));
excitatoryResponses1(:,end) = [];
% inhibitoryResponses1(:,end) = [];

excitatoryResponses1(:,preInhalations * cycleLength) = max(max(excitatoryResponses1));
% inhibitoryResponses1(:,cycleLength) = max(max(inhibitoryResponses1));
hexc = figure; imagesc(excitatoryResponses1)
title('Excitatory responses tile the respiratory cycle'), xlabel('Time (ms)'), ylabel('Cell-odor pairs')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% set(hexc,'color','white', 'PaperPositionMode', 'auto');
% hinh = figure; imagesc(inhibitoryResponses1)
% title('Inhibitory responses tile the respiratory cycle'), xlabel('Time (ms)'), ylabel('Cell-odor pairs')
% set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
% set(hinh,'color','white', 'PaperPositionMode', 'auto');

figure; histogram(excitatoryLatency, 50)
% figure; histogram(inhibitoryLatency, 50)

