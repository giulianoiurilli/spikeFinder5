function [Bsl, DeltaRspMean, rspMean, rspVar, ff, cv, auRoc, varG, significance] = find_Baseline_DeltaRsp_FanoFactor(esp, odors, window)

n_trials = 10;

%%
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

%%
fanoFactor = zeros(1,c);
DeltaRspMean = zeros(c, length(odors)); 
rspMean = zeros(c, length(odors)); 
rspVar = zeros(c, length(odors)); 
ff  = zeros(c, length(odors)); 
cv  = zeros(c, length(odors)); 
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                R1000ms = zeros(n_trials, length(odors));
                B1000ms = zeros(n_trials, length(odors));
                A1000ms = zeros(n_trials, length(odors));
                idxO = 0;
                %odorsRearranged = keepNewOrder(idxExp,:);
                for idxOdor = odors
                    idxO = idxO + 1;
                    if window  == 300
                        R1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                        B1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms';
                        auRoc(c, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                        significance(c, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms;
                        varG(c,idxO) = partNeuralVariance(R1000ms(:, idxO));
                    else
                        R1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                        B1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                        auRoc(c, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                        significance(c, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                        varG(c,idxO) = partNeuralVariance(R1000ms(:, idxO));
                    end
                end
                DeltaRspMean(c,:) = mean(R1000ms-B1000ms);
                rspMean(c,:) = mean(R1000ms);
                rspVar(c,:) = var(R1000ms);
                RspStd = std(R1000ms);
%                 boxWidth = 1000;
%                 weightingEpsilon = 1 * boxWidth/1000;
%                 regWeights = n_trials ./ (RspMeanAbs + weightingEpsilon) .^ 2;
%                 [B, stdB] = lscov(RspMeanAbs', RspVar', regWeights);
%                 fanoFactor(c) = B;
                ff(c,:) = rspVar(c,:) ./ rspMean(c,:);
                cv(c,:) = RspStd ./ rspMean(c,:);
            end
        end
    end
end

Bsl = zeros(1,t); 
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
                Bsl(c) = mean(mean(B1000ms));
            end
        end
    end
end
