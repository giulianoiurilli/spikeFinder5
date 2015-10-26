odorsRearranged = 1:15; %15 odors
odors = length(odorsRearranged);

excCellOdorPairs = 0;
inhCellOdorPairs = 0;
for idxExp = 1 : lunLista %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc = zeros(1,odors);
            responsivenessInh = zeros(1,odors);
            reliabilityExc = zeros(1,odors);
            reliabilityInh = zeros(1,odors);
            for idxOdor = 1:15
                %                 responsivenessExc(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == 1;
                %                 responsivenessInh(idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital == -1;
                responsivenessExc(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh(idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                %                 reliabilityExc(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                %                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc) > 0 %&& sum(reliabilityExc) > 0
                excCellOdorPairs = excCellOdorPairs + sum(responsivenessExc);
            end
            if sum(responsivenessInh) > 0 %&& sum(reliabilityInh) > 0
                inhCellOdorPairs = inhCellOdorPairs + sum(responsivenessInh);
            end
        end
    end
end

%%
church = [];
churchRad = [];
churchSniff = [];

fromRad = 360 * 7;
toRad = 360 * 19;
responseWindowSizeRad = toRad - fromRad;
edgesRad = 1:30:responseWindowSizeRad;
edgesSniff = 1:360:responseWindowSizeRad;
angleStamps = 1:responseWindowSizeRad; angleStamps = repmat(angleStamps, n_trials,1);
from = 14500;
to = 18000;
responseWindowSize = to-from;
edgesMs = 1:20:responseWindowSize;
timeStamps = 1:responseWindowSize; timeStamps = repmat(timeStamps, n_trials,1);

%%
idxCellOdorPairExc = 1;
idxCellOdorPairInh = 1;
for idxExp = 1 : lunLista %- 1
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
%                 reliabilityExc(idxO) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
%                 reliabilityInh(idxOdor) =  exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
            end
            if sum(responsivenessExc) > 0
                goodResps = [];
                goodResps = find(responsivenessExc > 0);
                for idxO = goodResps;
%                     if exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC > 0.75;
                        app = [];
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        app = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixNoWarp(:, from:to-1);
                        app = app .* timeStamps;
                        appHist = histc(app, edgesMs,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        excResponsesMs(idxCellOdorPairExc,:) = appHistMean;
                        excFFMs(idxCellOdorPairExc,:) = appHistFano;
                        
                        app = [];
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        app = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        app = app .* angleStamps;
                        appHist = histc(app, edgesRad,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        excResponsesRad(idxCellOdorPairExc,:) = appHistMean;
                        excFFRad(idxCellOdorPairExc,:) = appHistFano;
                        
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        appHist = histc(app, edgesSniff,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        excResponsesSniff(idxCellOdorPairExc,:) = appHistMean;
                        excFFSniff(idxCellOdorPairExc,:) = appHistVar;
                        
                        churchMs(idxCellOdorPairExc).spikes = logical(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixNoWarp(:, from:to-1));
                        churchRad(idxCellOdorPairExc).spikes = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        churchSniff(idxCellOdorPairExc).spikes = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        idxCellOdorPairExc = idxCellOdorPairExc + 1;
%                     end
                end
            end
            if sum(responsivenessInh) > 0
                goodResps = [];
                goodResps = find(responsivenessInh > 0);
                for idxO = goodResps;
%                     if exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC < 0.25;
                        app = [];
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        app = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixNoWarp(:, from:to-1);
                        app = app .* timeStamps;
                        appHist = histc(app, edgesMs,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        inhResponsesMs(idxCellOdorPairInh,:) = appHistMean;
                        inhFFMs(idxCellOdorPairInh,:) = appHistFano;
                        
                        app = [];
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        app = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        app = app .* angleStamps;
                        appHist = histc(app, edgesRad,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        inhResponsesRad(idxCellOdorPairInh,:) = appHistMean;
                        inhFFRad(idxCellOdorPairInh,:) = appHistFano;
                        
                        appHist = [];
                        appHistMean = [];
                        appHistVar = [];
                        appHistFano = [];
                        appHist = histc(app, edgesSniff,2);
                        appHistMean = mean(appHist);
                        appHistVar = var(appHist);
                        appHistFano = appHistVar ./ appHistMean;
                        appHistFano(isnan(appHistFano)) = 0;
                        inhResponsesSniff(idxCellOdorPairInh,:) = appHistMean;
                        inhFFSniff(idxCellOdorPairInh,:) = appHistVar;
                        
                        
                        
                        churchMsInh(idxCellOdorPairInh).spikes = logical(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixNoWarp(:, from:to-1));
                        churchRadInh(idxCellOdorPairInh).spikes = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        churchSniffInh(idxCellOdorPairInh).spikes = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrixWarp(:, fromRad:toRad-1);
                        
                        
                        idxCellOdorPairInh = idxCellOdorPairInh + 1;
%                     end
                end
            end
        end
    end
end