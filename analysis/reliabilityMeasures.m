fileToSave = 'pcx_AAmix_2_2.mat';
load('parameters.mat');
startingFolder = pwd;
odorsRearranged = 1:15;
idxU = 0;
odors = length(odorsRearranged);
cellLog = [];
%%
for idxEsp = 1 : length(esp)
    response_window = 1; 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxEsp).shankNowarp(idxShank).cell)
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                spike_matrix_Bsl = single(espe(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(:, floor((pre-2)*1000+51) : floor((pre-1)*1000 + 50)));
                spike_matrix_Rsp = single(espe(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000 + 50)));
                bslSC = sum(spike_matrix_Bsl, 2);
                rspSC = sum(spike_matrix_Rsp, 2);
                hExc = zeros(1,10);
                hInh = zeros(1,10);
                segno = nan(1,10);
                rspSign = sign(esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms - 0.5);
                edges = 0:100:1000;
                for idxTrial = 1:10
                    %                     spikeTimesBsl = find(spike_matrix_Bsl(idxTrial,:) == 1);
                    %                     spikeTimesRsp = find(spike_matrix_Rsp(idxTrial,:) == 1);
                    %                     binnedBsl = histcounts(spikeTimesBsl, edges);
                    %                     binnedRsp = histcounts(spikeTimesRsp, edges);
                    %                     h(idxTrial) = ttest2(binnedBsl, binnedRsp);
                    %                     trialSign = sign(mean(binnedRsp) - mean(binnedBsl));
                    binnedBsl = slidePSTH(spike_matrix_Bsl(idxTrial,:), 50, 5);
                    binnedRsp = slidePSTH(spike_matrix_Rsp(idxTrial,:), 50, 5);
%                     if esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        hExc(idxTrial) = max(binnedRsp) > mean(binnedBsl) + 4 * std(binnedBsl);
                        hInh(idxTrial) = min(binnedRsp) < mean(binnedBsl) - 2 * std(binnedBsl) ;
%                     else if esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
%                             h(idxTrial) = max(binnedRsp) < 2.5 * std(binnedBsl) + mean(binnedBsl);
%                         end
%                     end
                end
                bslPSTH = slidePSTH(spike_matrix_Bsl, 50, 5);
                rspPSTH = slidePSTH(spike_matrix_Rsp, 50, 5);
                bslMean = mean(bslPSTH);
                bslStd = std(bslPSTH);
                rspMax = max(rspPSTH);
                rspMin = min(rspPSTH);
                a = rspMax - bslMean; 
                b = rspMin - bslMean;
                if abs(a) - abs(b) >= 0
                   esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponseDeltaPeakHz = a*20;
                   if rspMax > bslMean + 4 * bslStd
                       esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponseDeltaPeak = 1;
                   else
                       esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponseDeltaPeak = 0;
                   end
                else
                   esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponseDeltaPeakHz = b*20;
                   if rspMax < bslMean - 2 * bslStd
                       esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponseDeltaPeak = -1;
                   else
                       esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponseDeltaPeak = 0;
                   end
                end
                esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).responseFractionExc = sum(hExc) / 10;
                esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).responseFractionInh = sum(hInh) / 10;
                esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).trialConsistency = [];
%                 if  esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).responseFraction == 0 && esp(idxEsp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
%                     idxU = idxU + 1
%                     app = [idxShank, idxUnit, idxOdor];
%                     cellLog = [cellLog; app];
%                 end
            end
        end
    end
end

save(fileToSave, 'esp', '-append')