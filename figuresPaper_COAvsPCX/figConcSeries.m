odorsRearranged = [2 3 1 4 5 6 7 8 9 10 11 12 13 14 15];%concseries


% psCoa = findPopulationSparseness(coa2HL.esp, odorsRearranged);







% psPcx = findPopulationSparseness(pcx2HL.esp, odorsRearranged);


%% Odor 1
%odorsRearranged = [2 3 1 4 5];
odorsRearranged = [3 1 2 5 4];
[odorsExc1Coa, responsesExc1Coa, cellLogExc1Coa] = concSeriesAnalysis(coaCS2.esp, odorsRearranged);
[odorsExc1Pcx, responsesExc1Pcx, cellLogExc1Pcx] = concSeriesAnalysis(pcxCS2.esp, odorsRearranged);


meanPCoa = mean(odorsExc1Coa);
meanPPcx = mean(odorsExc1Pcx);
semPCoa = sqrt(meanPCoa .* (1-meanPCoa) ./ size(odorsExc1Coa,1));
semPPcx = sqrt(meanPPcx .* (1-meanPPcx) ./ size(odorsExc1Pcx,1));

% responsesExc1Coa = responsesExc1Coa';
% responsesExc1Coa = zscore(responsesExc1Coa);
% responsesExc1Coa = responsesExc1Coa';
% responsesExc1Pcx = responsesExc1Pcx';
% responsesExc1Pcx = zscore(responsesExc1Pcx);
% responsesExc1Pcx = responsesExc1Pcx';
responsesExc1Coa = responsesExc1Coa';
responsesExc1Coa = (responsesExc1Coa - repmat(min(responsesExc1Coa), size(responsesExc1Coa,1),1))./ repmat(max(responsesExc1Coa) - min(responsesExc1Coa), size(responsesExc1Coa,1),1);
responsesExc1Coa = responsesExc1Coa';
responsesExc1Pcx = responsesExc1Pcx';
responsesExc1Pcx = (responsesExc1Pcx - repmat(min(responsesExc1Pcx), size(responsesExc1Pcx,1),1))./ repmat(max(responsesExc1Pcx) - min(responsesExc1Pcx), size(responsesExc1Pcx,1),1);
responsesExc1Pcx = responsesExc1Pcx';

meanRCoa = mean(responsesExc1Coa);
semRCoa = std(responsesExc1Coa)./sqrt(size(responsesExc1Coa,1));
meanRPcx = mean(responsesExc1Pcx);
semRPcx = std(responsesExc1Pcx)./sqrt(size(responsesExc1Pcx,1));

figure
plot([1 4 7 10 13], meanPCoa, 'ro-', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 5 8 11 14], meanPPcx, 'ko-', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 4 7 10 13], meanPCoa, semPCoa, 'r', 'linewidth', 2); 
hold on
errbar([2 5 8 11 14], meanPPcx, semPPcx, 'k', 'linewidth', 2); 

figure
plot([1 4 7 10 13], meanRCoa, 'ro-', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 5 8 11 14], meanRPcx, 'ko-', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 4 7 10 13], meanRCoa, semRCoa, 'r', 'linewidth', 2); 
hold on
errbar([2 5 8 11 14], meanRPcx, semRPcx, 'k', 'linewidth', 2); 

%% Odor 2
%odorsRearranged = [6 7 8 9 10];
odorsRearranged = [7 8 9 6 10];

[odorsExc1Coa, responsesExc1Coa, cellLogExc1Coa] = concSeriesAnalysis(coaCS2.esp, odorsRearranged);
[odorsExc1Pcx, responsesExc1Pcx, cellLogExc1Pcx] = concSeriesAnalysis(pcxCS2.esp, odorsRearranged);


meanPCoa = mean(odorsExc1Coa);
meanPPcx = mean(odorsExc1Pcx);
semPCoa = sqrt(meanPCoa .* (1-meanPCoa) ./ size(odorsExc1Coa,1));
semPPcx = sqrt(meanPPcx .* (1-meanPPcx) ./ size(odorsExc1Pcx,1));
% responsesExc1Coa = responsesExc1Coa';
% responsesExc1Coa = zscore(responsesExc1Coa);
% responsesExc1Coa = responsesExc1Coa';
% responsesExc1Pcx = responsesExc1Pcx';
% responsesExc1Pcx = zscore(responsesExc1Pcx);
% responsesExc1Pcx = responsesExc1Pcx';
responsesExc1Coa = responsesExc1Coa';
responsesExc1Coa = (responsesExc1Coa - repmat(min(responsesExc1Coa), size(responsesExc1Coa,1),1))./ repmat(max(responsesExc1Coa) - min(responsesExc1Coa), size(responsesExc1Coa,1),1);
responsesExc1Coa = responsesExc1Coa';
responsesExc1Pcx = responsesExc1Pcx';
responsesExc1Pcx = (responsesExc1Pcx - repmat(min(responsesExc1Pcx), size(responsesExc1Pcx,1),1))./ repmat(max(responsesExc1Pcx) - min(responsesExc1Pcx), size(responsesExc1Pcx,1),1);
responsesExc1Pcx = responsesExc1Pcx';

meanRCoa = mean(responsesExc1Coa);
semRCoa = std(responsesExc1Coa)./sqrt(size(responsesExc1Coa,1));
meanRPcx = mean(responsesExc1Pcx);
semRPcx = std(responsesExc1Pcx)./sqrt(size(responsesExc1Pcx,1));

figure
plot([1 4 7 10 13], meanPCoa, 'ro-', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 5 8 11 14], meanPPcx, 'ko-', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 4 7 10 13], meanPCoa, semPCoa, 'r', 'linewidth', 2); 
hold on
errbar([2 5 8 11 14], meanPPcx, semPPcx, 'k', 'linewidth', 2); 

figure
plot([1 4 7 10 13], meanRCoa, 'ro-', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 5 8 11 14], meanRPcx, 'ko-', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 4 7 10 13], meanRCoa, semRCoa, 'r', 'linewidth', 2); 
hold on
errbar([2 5 8 11 14], meanRPcx, semRPcx, 'k', 'linewidth', 2); 

%% Odor 3
odorsRearranged = [11 12 13 14 15];
[odorsExc1Coa, responsesExc1Coa, cellLogExc1Coa] = concSeriesAnalysis(coaCS2.esp, odorsRearranged);
[odorsExc1Pcx, responsesExc1Pcx, cellLogExc1Pcx] = concSeriesAnalysis(pcxCS2.esp, odorsRearranged);


meanPCoa = mean(odorsExc1Coa);
meanPPcx = mean(odorsExc1Pcx);
semPCoa = sqrt(meanPCoa .* (1-meanPCoa) ./ size(odorsExc1Coa,1));
semPPcx = sqrt(meanPPcx .* (1-meanPPcx) ./ size(odorsExc1Pcx,1));

% responsesExc1Coa = responsesExc1Coa';
% responsesExc1Coa = zscore(responsesExc1Coa);
% responsesExc1Coa = responsesExc1Coa';
% responsesExc1Pcx = responsesExc1Pcx';
% responsesExc1Pcx = zscore(responsesExc1Pcx);
% responsesExc1Pcx = responsesExc1Pcx';
responsesExc1Coa = responsesExc1Coa';
responsesExc1Coa = (responsesExc1Coa - repmat(min(responsesExc1Coa), size(responsesExc1Coa,1),1))./ repmat(max(responsesExc1Coa) - min(responsesExc1Coa), size(responsesExc1Coa,1),1);
responsesExc1Coa = responsesExc1Coa';
responsesExc1Pcx = responsesExc1Pcx';
responsesExc1Pcx = (responsesExc1Pcx - repmat(min(responsesExc1Pcx), size(responsesExc1Pcx,1),1))./ repmat(max(responsesExc1Pcx) - min(responsesExc1Pcx), size(responsesExc1Pcx,1),1);
responsesExc1Pcx = responsesExc1Pcx';

meanRCoa = mean(responsesExc1Coa);
semRCoa = std(responsesExc1Coa)./sqrt(size(responsesExc1Coa,1));
meanRPcx = mean(responsesExc1Pcx);
semRPcx = std(responsesExc1Pcx)./sqrt(size(responsesExc1Pcx,1));

figure
plot([1 4 7 10 13], meanPCoa, 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 5 8 11 14], meanPPcx, 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 4 7 10 13], meanPCoa, semPCoa, 'r', 'linewidth', 2); 
hold on
errbar([2 5 8 11 14], meanPPcx, semPPcx, 'k', 'linewidth', 2); 

figure
plot([1 4 7 10 13], meanRCoa, 'ro', 'markersize', 10, 'markeredgecolor', 'r', 'markerfacecolor', 'r')
hold on
plot([2 5 8 11 14], meanRPcx, 'ko', 'markersize', 10, 'markeredgecolor', 'k', 'markerfacecolor', 'k')
hold on
errbar([1 4 7 10 13], meanRCoa, semRCoa, 'r', 'linewidth', 2); 
hold on
errbar([2 5 8 11 14], meanRPcx, semRPcx, 'k', 'linewidth', 2); 