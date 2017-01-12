fileToSave = 'plCoA_natMix_2.mat';
esp = coaNM.esp;
folderlist = {coaNM.esp(:).filename};
startingFolder = pwd;
odorsRearranged = 1:15;
idxU = 0;
odors = length(odorsRearranged);
cellLog = [];
pre = 4;


%%
for idxExp = 1 : length(folderlist)
    folderExp = folderlist(idxExp);
    disp(folderExp{1})
    cd(fullfile(folderExp{1}, 'ephys'))
%     cd(folderExp{1});
    load('units.mat');
    response_window = 1;
    for idxShank = 1:4
        if ~isnan(shank(idxShank).SUA.clusterID{1})
            for idxUnit = 1:length(shank(idxShank).SUA.clusterID)
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    spike_matrix_app = single(shank(idxShank).SUA.spike_matrix{idxUnit}(:,:,idxOdor));
                    espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrix = logical(spike_matrix_app);
                    
                    
                    spike_matrix_Bsl1 = espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrix(:, floor((pre-2)*1000) : floor((pre-1)*1000));
                    spike_matrix_Bsl2 = espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrix(:, floor((pre-3)*1000) : floor((pre-2)*1000));
                    spike_matrix_Rsp = espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrix(:, floor(pre*1000) : floor(pre*1000 + response_window*1000));
                    bsl1SC = sum(spike_matrix_Bsl1, 2);
                    rspSC = sum(spike_matrix_Rsp, 2);
                    rspBslSC = sum(spike_matrix_Bsl2, 2);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExc1000ms = zeros(1,10);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInh1000ms = zeros(1,10);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExc1000msBsl = zeros(1,10);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInh1000msBsl = zeros(1,10);
                    segno = nan(1,10);
                    rspSign = sign(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC1000ms - 0.5);
                    edges = 0:100:1000;
                    for idxTrial = 1:10
                        %                     spikeTimesBsl = find(spike_matrix_Bsl(idxTrial,:) == 1);
                        %                     spikeTimesRsp = find(spike_matrix_Rsp(idxTrial,:) == 1);
                        %                     binnedBsl = histcounts(spikeTimesBsl, edges);
                        %                     binnedRsp = histcounts(spikeTimesRsp, edges);
                        %                     h(idxTrial) = ttest2(binnedBsl, binnedRsp);
                        %                     trialSign = sign(mean(binnedRsp) - mean(binnedBsl));
                        binnedBsl1 = slidePSTH(double(spike_matrix_Bsl1(idxTrial,:)), 50, 5);
                        binnedRsp = slidePSTH(double(spike_matrix_Rsp(idxTrial,:)), 50, 5);
                        binnedRspBsl = slidePSTH(double(spike_matrix_Bsl2(idxTrial,:)), 50, 5);
                        %                     if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000ms(idxTrial) = max(binnedRsp) > mean(binnedBsl1) + 5 * std(binnedBsl1);
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000ms(idxTrial) = min(binnedRsp) < mean(binnedBsl1) - std(binnedBsl1);
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000ms(idxTrial) = mean(binnedRsp) > mean(binnedBsl1) + 5 * std(binnedBsl1);
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000ms(idxTrial) = mean(binnedRsp) < mean(binnedBsl1) - std(binnedBsl1);
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeakDelta1000ms(idxTrial) = (max(binnedRsp) - mean(binnedBsl1)) * 20;
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeakDelta1000ms(idxTrial) = (min(binnedRsp) - mean(binnedBsl1)) * 20;
                                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000msBsl(idxTrial) = max(binnedRspBsl) > mean(binnedBsl1) + 5 * std(binnedBsl1);
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000msBsl(idxTrial) = min(binnedRspBsl) < mean(binnedBsl1) - std(binnedBsl1);
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000msBsl(idxTrial) = mean(binnedRspBsl) > mean(binnedBsl1) + 5 * std(binnedBsl1);
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000msBsl(idxTrial) = mean(binnedRspBsl) < mean(binnedBsl1) - std(binnedBsl1);
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeakDelta1000msBsl(idxTrial) = (max(binnedRspBsl) - mean(binnedBsl1)) * 20;
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeakDelta1000msBsl(idxTrial) = (min(binnedRspBsl) - mean(binnedBsl1)) * 20;
                        %                     else if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                        %                             h(idxTrial) = max(binnedRsp) < 2.5 * std(binnedBsl) + mean(binnedBsl);
                        %                         end
                        %                     end
                    end
                    bslPSTH = slidePSTH(double(spike_matrix_Bsl1), 50, 5);
                    rspPSTH = slidePSTH(double(spike_matrix_Rsp), 50, 5);
                    bslMean = mean(bslPSTH);
                    bslStd = std(bslPSTH);
                    rspMax = max(rspPSTH);
                    rspMin = min(rspPSTH);
                    a = rspMax - bslMean;
                    b = rspMin - bslMean;
                    if abs(a) - abs(b) >= 0
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponseDeltaPeakHz = a*20;
                        if rspMax > bslMean + 5 * bslStd
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponseDeltaPeak = 1;
                        else
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponseDeltaPeak = 0;
                        end
                    else
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponseDeltaPeakHz = b*20;
                        if rspMax < bslMean - 1 * bslStd
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponseDeltaPeak = -1;
                        else
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponseDeltaPeak = 0;
                        end
                    end
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionExc = sum(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000ms) / 10;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionInh = sum(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000ms) / 10;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionExc = sum(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000ms) / 10;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionInh = sum(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000ms) / 10;
                                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionExcBsl = sum(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000msBsl) / 10;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionInhBsl = sum(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000msBsl) / 10;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionExcBsl = sum(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000msBsl) / 10;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionInhBsl = sum(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000msBsl) / 10;
                    %                 if  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).responseFraction == 0 && esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                    %                     idxU = idxU + 1
                    %                     app = [idxShank, idxUnit, idxOdor];
                    %                     cellLog = [cellLog; app];
                    %                 end
                end
            end
        end
    end
end
cd(startingFolder)
save(fileToSave, 'esp', '-append')