function M = find_Baseline_DeltaRsp_FanoFactor_new(esp, odors, window, onlyexc)
%function [Bsl, BslAll, DeltaRspMean, DeltaRsp, DeltaRspExcSig, DeltaRspInhSig, rspMean, rspVar, ff, cv, auRoc, varG, rspFractionExc, rspFractionInh, significance] = find_Baseline_DeltaRsp_FanoFactor(esp, odors, window)

n_trials = 10;




%%
[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors, onlyexc);
%% initialize
M.SpikeCount = nan(totalSUA, 10, length(odors)); 
M.DeltaRspMean = zeros(totalSUA, length(odors)); 
M.DeltaRsp = zeros(totalSUA, 10, length(odors)); 
M.DeltaRspExcWind = zeros(totalSUA, 10, length(odors)); 
M.DeltaRspInhWind = zeros(totalSUA, 10, length(odors)); 
M.DeltaRspExcPeak = zeros(totalSUA, 10, length(odors)); 
M.DeltaRspInhPeak = zeros(totalSUA, 10, length(odors)); 
M.DeltaRspExcWindSig = zeros(totalSUA, 10, length(odors)); 
M.DeltaRspInhWindSig = zeros(totalSUA, 10, length(odors)); 
M.DeltaRspExcPeakSig = zeros(totalSUA, 10, length(odors)); 
M.DeltaRspInhPeakSig = zeros(totalSUA, 10, length(odors)); 
M.rspMean = zeros(totalSUA, length(odors)); 
M.rspVar = zeros(totalSUA, length(odors)); 
M.ff  = zeros(totalSUA, length(odors)); 
M.cv  = zeros(totalSUA, length(odors)); 
M.auRoc = nan(totalSUA, length(odors)); 
M.significance = nan(totalSUA, length(odors)); 
M.varG = nan(totalSUA, length(odors)); 
M.rspPeakFractionExc = nan(totalSUA, length(odors)); 
M.rspPeakFractionInh = nan(totalSUA, length(odors)); 
M.rspWindFractionExc = nan(totalSUA, length(odors)); 
M.rspWindFractionInh = nan(totalSUA, length(odors));
M.ls = nan(totalSUA,1);
trialDeltaExcWindSig = nan(10, length(odors)); 
trialDeltaInhWindSig = nan(10, length(odors)); 
trialDeltaExcPeakSig = nan(10, length(odors)); 
trialDeltaInhPeakSig = nan(10, length(odors)); 

%%
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    c = c + 1;
                    R1000ms = zeros(n_trials, length(odors));
                    B1000ms = zeros(n_trials, length(odors));
                    
                    idxO = 0;
                    %odorsRearranged = keepNewOrder(idxExp,:);
                    for idxOdor = odors
                        idxO = idxO + 1;
                        if window  == 300
                            R1000ms(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse300ms';
                            B1000ms(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl300ms';
                            M.auRoc(c, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC300ms;
                            M.significance(c, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse300ms;
                            %M.varG(c,idxO) = partNeuralVariance(R1000ms(:, idxO));
                        else
                            R1000ms(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms';
                            B1000ms(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
                            M.auRoc(c, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC1000ms;
                            M.significance(c, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse1000ms;
                            %M.varG(c,idxO) = partNeuralVariance(R1000ms(:, idxO));
                            M.rspPeakFractionExc(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionExc;
                            M.rspPeakFractionInh(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responsePeakFractionInh;
                            M.rspWindFractionExc(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionExc;
                            M.rspWindFractionInh(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).responseWindFractionInh;
                            trialDeltaExcPeakSig(:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeak1000ms';
                            trialDeltaInhPeakSig(:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeak1000ms';
                            trialDeltaExcWindSig(:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcWind1000ms';
                            trialDeltaInhWindSig(:,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhWind1000ms';
                            M.DeltaRspExcPeak(c,:,idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialExcPeakDelta1000ms;
                            M.DeltaInhExcPeak(c,:,idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).trialInhPeakDelta1000ms;
                            M.DeltaRspTrialWind(c,:,idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms' - esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
                        end
                    end
                    M.DeltaRspMean(c,:) = mean(R1000ms-B1000ms);
                    M.rspMean(c,:) = mean(R1000ms);
                    M.bslMean(c,:) = mean(B1000ms);
                    M.rspVar(c,:) = var(R1000ms);
                    M.RspStd = std(R1000ms);
                    M.bslVar(c,:) = var(B1000ms);
                    %                 boxWidth = 1000;
                    %                 weightingEpsilon = 1 * boxWidth/1000;
                    %                 regWeights = n_trials ./ (RspMeanAbs + weightingEpsilon) .^ 2;
                    %                 [B, stdB] = lscov(RspMeanAbs', RspVar', regWeights);
                    %                 fanoFactor(c) = B;
                    if M.rspMean(c,:) == 0
                        M.ff(c,:) = 0;
                    else M.ff(c,:) = M.rspVar(c,:) ./ M.rspMean(c,:);
                    end
                    if M.bslMean(c,:) == 0
                        M.bsl_ff(c,:) = 0;
                    else M.bsl_ff(c,:) = M.bslVar(c,:) ./ M.bslMean(c,:);
                    end
                    M.cv(c,:) = M.RspStd ./ M.rspMean(c,:);
                    M.DeltaRsp(c,:,:) = R1000ms - B1000ms;
                    M.SpikeCount(c,:,:) = R1000ms;
                    M.DeltaRspExcPeakSig(c,:,:) = trialDeltaExcPeakSig;
                    M.DeltaRspInhPeakSig(c,:,:) = trialDeltaInhPeakSig;
                    M.DeltaRspExcWindSig(c,:,:) = trialDeltaExcWindSig;
                    M.DeltaRspInhWindSig(c,:,:) = trialDeltaInhWindSig;
                    M.ls(c) = lifetime_sparseness(R1000ms);
                end
            end
        end
    end
end
%%
Bsl = zeros(1,c);
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.1
                    c = c + 1;
                    B1000ms = zeros(n_trials, length(odors));
                    idxO = 0;
                    for idxOdor = odors
                        idxO = idxO + 1;
                        B1000ms(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
                    end
                    M.Bsl(c) = mean(mean(B1000ms));
                end
            end
        end
    end
end

% %%
% BslAll = zeros(1,t);
% c = 0;
% for idxExp =  1:length(esp)
%     for idxShank = 1:4
%         if ~isempty(esp(idxExp).shank(idxShank).SUA)
%             for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
% %                 if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
%                     
%                     c = c + 1;
%                     B1000ms = zeros(n_trials, length(odors));
%                     idxO = 0;
%                     for idxOdor = odors
%                         idxO = idxO + 1;
%                         B1000ms(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
%                     end
%                     M.BslAll(c) = mean(mean(B1000ms));
%                     
% %                 end
%             end
%         end
%     end
% end
