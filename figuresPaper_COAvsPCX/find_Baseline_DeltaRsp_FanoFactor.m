function [Bsl, DeltaRsp, ff, cv, fanoFactor] = find_Baseline_DeltaRsp_FanoFactor(esp, odors)

n_trials = 10;

%%
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end

Bsl = zeros(1,c); 
fanoFactor = zeros(1,c);
DeltaRsp = zeros(c, length(odors)); 
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
                    R1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                    B1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                end
                RspMean = mean(R1000ms - B1000ms);
                RspMeanAbs = mean(R1000ms);
                RspVar = var(R1000ms);
                RspStd = std(R1000ms);
                %DeltaRsp(c) = mean(RspMean);
                DeltaRsp(c,:) = RspMean;
                Bsl(c) = mean(mean(B1000ms));
                boxWidth = 1000;
                weightingEpsilon = 1 * boxWidth/1000;
                regWeights = n_trials ./ (RspMeanAbs + weightingEpsilon) .^ 2;
                [B, stdB] = lscov(RspMeanAbs', RspVar', regWeights);
                fanoFactor(c) = B;
                ff(c,:) = RspVar ./ RspMean;
                cv(c,:) = RspStd ./ RspMean;
            end
        end
    end
end
