
odors = 1:15;
n_trials = 10;

%%
c = 0;
for idxExp =  1:length(pcx2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
DeltaRspPCX = zeros(1,c);
BslPCX = zeros(1,c);
c = 0;
for idxExp =  1:length(pcx2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                R1000ms = zeros(n_trials, length(odors));
                B1000ms = zeros(n_trials, length(odors));
                A1000ms = zeros(n_trials, length(odors));
                idxO = 0;
                %odorsRearranged = keepNewOrder(idxExp,:);
                for idxOdor = odors
                    idxO = idxO + 1;
                    R1000ms(:, idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                    B1000ms(:, idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                end
                RspMeanPCX = mean(R1000ms - B1000ms);
                RspMeanAbsPCX = mean(R1000ms);
                RspVarPCX = var(R1000ms);
                DeltaRspPCX(c) = mean(RspMeanPCX);
                BslPCX(c) = mean(mean(B1000ms));
                boxWidth = 1000;
                weightingEpsilon = 1 * boxWidth/1000;
                regWeights = n_trials ./ (RspMeanAbsPCX + weightingEpsilon) .^ 2;
                [B, stdB] = lscov(RspMeanAbsPCX', RspVarPCX', regWeights);
                fanoFactorPCX(c) = B;
            end
        end
    end
end
%%
c = 0;
for idxExp =  1:length(coa2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
DeltaRspCOA = zeros(1,c);
BslCOA = zeros(1,c);
c = 0;
for idxExp =  1:length(coa2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                R1000ms = zeros(n_trials, length(odors));
                B1000ms = zeros(n_trials, length(odors));
                A1000ms = zeros(n_trials, length(odors));
                idxO = 0;
                %odorsRearranged = keepNewOrder(idxExp,:);
                for idxOdor = odors
                    idxO = idxO + 1;
                    R1000ms(:, idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                    B1000ms(:, idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                end
                RspMeanCOA = mean(R1000ms - B1000ms);
                RspMeanAbsCOA = mean(R1000ms);
                RspVarCOA = var(R1000ms);
                DeltaRspCOA(c) = mean(RspMeanCOA);
                BslCOA(c) = mean(mean(B1000ms));
                boxWidth = 1000;
                weightingEpsilon = 1 * boxWidth/1000;
                regWeights = n_trials ./ (RspMeanAbsCOA + weightingEpsilon) .^ 2;
                [B, stdB] = lscov(RspMeanAbsCOA', RspVarCOA', regWeights);
                fanoFactorCOA(c) = B;
            end
        end
    end
end