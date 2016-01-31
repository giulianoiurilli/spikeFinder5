
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
DeltaRsp = zeros(1,c);
BslPCX = zeros(1,c); 
fanoFactorPCX = zeros(1,c);
DeltaRspPCX = zeros(c, length(odors)); 
ffPCX  = zeros(c, length(odors)); 
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
                %DeltaRspPCX(c) = mean(RspMeanPCX);
                DeltaRspPCX(c,:) = RspMeanPCX;
                BslPCX(c) = mean(mean(B1000ms));
                boxWidth = 1000;
                weightingEpsilon = 1 * boxWidth/1000;
                regWeights = n_trials ./ (RspMeanAbsPCX + weightingEpsilon) .^ 2;
                [B, stdB] = lscov(RspMeanAbsPCX', RspVarPCX', regWeights);
                fanoFactorPCX(c) = B;
                ffPCX(c,:) =RspVarPCX ./ RspMeanPCX;
            end
        end
    end
end
