function M = find_Baseline_DeltaRsp_FanoFactor(esp, odors, window)
%function [Bsl, BslAll, DeltaRspMean, DeltaRsp, DeltaRspExcSig, DeltaRspInhSig, rspMean, rspVar, ff, cv, auRoc, varG, rspFractionExc, rspFractionInh, significance] = find_Baseline_DeltaRsp_FanoFactor(esp, odors, window)

n_trials = 10;

%% find good cells
c = 0;
t = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            t = t + 1;
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end

%% initialize
M.SpikeCount = nan(c, 10, length(odors)); 
M.DeltaRspMean = zeros(c, length(odors)); 
M.DeltaRsp = zeros(c, 10, length(odors)); 
M.DeltaRspExcWind = zeros(c, 10, length(odors)); 
M.DeltaRspInhWind = zeros(c, 10, length(odors)); 
M.DeltaRspExcPeak = zeros(c, 10, length(odors)); 
M.DeltaRspInhPeak = zeros(c, 10, length(odors)); 
M.DeltaRspExcWindSig = zeros(c, 10, length(odors)); 
M.DeltaRspInhWindSig = zeros(c, 10, length(odors)); 
M.DeltaRspExcPeakSig = zeros(c, 10, length(odors)); 
M.DeltaRspInhPeakSig = zeros(c, 10, length(odors)); 
M.rspMean = zeros(c, length(odors)); 
M.rspVar = zeros(c, length(odors)); 
M.ff  = zeros(c, length(odors)); 
M.cv  = zeros(c, length(odors)); 
M.auRoc = nan(c, length(odors)); 
M.significance = nan(c, length(odors)); 
M.varG = nan(c, length(odors)); 
M.rspPeakFractionExc = nan(c, length(odors)); 
M.rspPeakFractionInh = nan(c, length(odors)); 
M.rspWindFractionExc = nan(c, length(odors)); 
M.rspWindFractionInh = nan(c, length(odors));
M.ls = nan(c,1);
trialDeltaExcWindSig = nan(10, length(odors)); 
trialDeltaInhWindSig = nan(10, length(odors)); 
trialDeltaExcPeakSig = nan(10, length(odors)); 
trialDeltaInhPeakSig = nan(10, length(odors)); 

%%
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                R1000ms = zeros(n_trials, length(odors));
                B1000ms = zeros(n_trials, length(odors));
                
                idxO = 0;
                %odorsRearranged = keepNewOrder(idxExp,:);
                for idxOdor = odors
                    idxO = idxO + 1;
                    if window  == 300
                        R1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                        B1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms';
                        M.auRoc(c, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                        M.significance(c, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms;
                        %M.varG(c,idxO) = partNeuralVariance(R1000ms(:, idxO));
                    else
                        R1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                        B1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                        M.auRoc(c, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                        M.significance(c, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                        %M.varG(c,idxO) = partNeuralVariance(R1000ms(:, idxO));
                        M.rspPeakFractionExc(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).responsePeakFractionExc;
                        M.rspPeakFractionInh(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).responsePeakFractionInh;
                        M.rspWindFractionExc(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).responseWindFractionExc;
                        M.rspWindFractionInh(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).responseWindFractionInh;
                        trialDeltaExcPeakSig(:,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).trialExcPeak1000ms';
                        trialDeltaInhPeakSig(:,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).trialInhPeak1000ms';
                        trialDeltaExcWindSig(:,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).trialExcWind1000ms';
                        trialDeltaInhWindSig(:,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).trialInhWind1000ms';
                        M.DeltaRspExcPeak(c,:,idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).trialExcPeakDelta1000ms;
                        M.DeltaInhExcPeak(c,:,idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).trialInhPeakDelta1000ms;
                        M.DeltaRspTrialWind(c,:,idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms' - esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
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
%%
Bsl = zeros(1,c); 
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)  
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                B1000ms = zeros(n_trials, length(odors));
                idxO = 0;
                for idxOdor = odors
                    idxO = idxO + 1;
                    B1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                end
                M.Bsl(c) = mean(mean(B1000ms));
            end
        end
    end
end

%%
BslAll = zeros(1,t);
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            
            c = c + 1;
            B1000ms = zeros(n_trials, length(odors));
            idxO = 0;
            for idxOdor = odors
                idxO = idxO + 1;
                B1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
            end
            M.BslAll(c) = mean(mean(B1000ms));
            
        end
    end
end
