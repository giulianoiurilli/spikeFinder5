load('parameters.mat')
folder = pwd;
%%

%odorsRearranged = [1 2 5 10 15 7 8];% pcxL
%odorsRearranged = [14 6 4 12 13 3 11 ];% pcxH
%odorsRearranged = [14 6 4 12 13 3 11 9];% pcxH8
%odorsRearranged = [6 1 3 13 12 7 5];% coaL
%odorsRearranged = [14 2 15 4 10 11 8];% coaH
%odorsRearranged = [14 2 15 4 10 11 8 9];% coaH8
%odorsRearranged = 1:15;
%odorsRearranged = [8 11 12 5 2 14 4 10]; %coa AA
odorsRearranged = [3 8 10 1 13 11 9 14]; %pcx AA

%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
%odorsRearranged = 1:10; %aveatt
%odorsRearranged = 1:7; %2conc
%odorsRearranged = [2 3 1 4 5 6 7 8 9 10 11 12 13 14 15];%concseries
%odorsRearranged = [1 2 3 4 6 7 8 9 10 11 12 13 14 15 5];
%{"TMT", "MMB", "2MB", "IAA", "PET", "BTN", "GER", "PB"};
%odorsRearranged = [1 2 3 5 6 7 9 10]; 
%odorsRearranged = [1 2 3 4 5 6 7 9 ]; 
%odorsRearranged = 1:14; %2conc

% list1 = [1 4 7 8 9 10 11 12 13 14 15 16 17 18 19];
% list2 = [1 3 4 5 8 9 10 12 13 14];
% list3 = [1 3 4 5 7 8 9 10 13 14 16 17];
% list4 = [1 7 8 9 10 11 12 13 14 16];

odors = length(odorsRearranged);
%%
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
responsiveUnitExc300ms = 0;
responsiveUnitInh300ms = 0;
responsiveUnitExc1s = 0;
responsiveUnitInh1s = 0;
cells = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxExp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                cells = cells + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessInh300ms = zeros(1,odors);
                responsivenessExc1s = zeros(1,odors);
                responsivenessInh1s = zeros(1,odors);
                idxO = 0;
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                %odorsRearranged = keepNewOrder(idxExp,:);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    %                 responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsivenessInh300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                    responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    
                    %                 responsivenessExc1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    responsivenessInh1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
                    responsivenessExc1000ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs300ms(idxO) =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                %vincolo reliability
                
                responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                responsivenessExc1s(aurocs1s<=0.75) = 0;
                responsivenessInh300ms(aurocs300ms>=0.35) = 0;
                responsivenessInh1s(aurocs1s>=0.35) = 0;
                
                if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                    responsiveUnit300ms = responsiveUnit300ms + 1;
                end
                if sum(responsivenessExc1s + responsivenessInh1s) > 0
                    responsiveUnit1s = responsiveUnit1s + 1;
                end
                if sum(responsivenessExc300ms) > 0
                    responsiveUnitExc300ms = responsiveUnitExc300ms + 1;
                end
                if sum(responsivenessInh300ms) > 0
                    responsiveUnitInh300ms = responsiveUnitInh300ms + 1;
                end
                if sum(responsivenessExc1s + responsivenessExc300ms) > 0
                    responsiveUnitExc1s = responsiveUnitExc1s + 1;
                end
                if sum(responsivenessInh1s + responsivenessInh300ms) > 0
                    responsiveUnitInh1s = responsiveUnitInh1s + 1;
                end
            end
        end
    end
end
%%
%recompute lifetime sparseness for delta responses
c = 0;
for idxExp =  1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
            c = c + 1;
            R300ms = zeros(n_trials, odors);
            B300ms = zeros(n_trials, odors);
            A300ms = zeros(n_trials, odors);
            idxO = 0;
            %odorsRearranged = keepNewOrder(idxExp,:);
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                R300ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                B300ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms';
            end
            A300ms = R300ms - B300ms;
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms = lifetime_sparseness(A300ms);
            end
        end
    end
end

c = 0;
for idxExp =  1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
            c = c + 1;
            R1000ms = zeros(n_trials, odors);
            B1000ms = zeros(n_trials, odors);
            A1000ms = zeros(n_trials, odors);
            idxO = 0;
            %odorsRearranged = keepNewOrder(idxExp,:);
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                R1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                B1000ms(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
            end
            A1000ms = R1000ms - B1000ms;
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s = lifetime_sparseness(A1000ms);
            end
        end
    end
end
%%
%compute population sparseness for delta responses
pop_sparseness300 = zeros(1,odors);
pop_sparseness1000 = zeros(1,odors);
for idxOdor = odorsRearranged
    R300ms = zeros(n_trials, cells);
    B300ms = zeros(n_trials, cells);
    A300ms = zeros(n_trials, cells);
    idxC = 0;
    for idxExp =  1:length(esp)
        for idxShank = 1:4
            for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxExp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                    idxC = idxC + 1;
                    R300ms(:, idxC) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                    B300ms(:, idxC) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms';
                end
            end
        end
    end
    A300ms = R300ms;% - B300ms;
    A300ms = (A300ms - min(A300ms(:))) ./ (max(A300ms(:)) - min(A300ms(:)));
    pop_sparseness300(idxOdor) = population_sparseness(A300ms);
end

for idxOdor = odorsRearranged
    R1000ms = zeros(n_trials, cells);
    B1000ms = zeros(n_trials, cells);
    A1000ms = zeros(n_trials, cells);
    idxC = 0;
    for idxExp =  1:length(esp)
        for idxShank = 1:4
            for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxExp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                    idxC = idxC + 1;
                    R1000ms(:, idxC) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                    B1000ms(:, idxC) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                end
            end
        end
    end
    A1000ms = R1000ms;% - B1000ms;
    A1000ms = (A1000ms - min(A1000ms(:))) ./ (max(A1000ms(:)) - min(A1000ms(:)));
    pop_sparseness1000(idxOdor) = population_sparseness(A1000ms);
end

%%
responses300 = zeros(responsiveUnit300ms, odors);
responses300MinusMean = zeros(responsiveUnit300ms, odors);
responses300AllTrials = zeros(responsiveUnit300ms, n_trials, odors);
baseline300 = zeros(responsiveUnit300ms, odors);
variance300 = zeros(responsiveUnit300ms, odors);
info300 = zeros(responsiveUnit300ms, 1);
ls300 = zeros(responsiveUnit300ms, 1); 
fanoFactor300 = zeros(responsiveUnit300ms, 1); 
cellLog300 = zeros(responsiveUnit300ms, 3);
auRoc300 = ones(responsiveUnit300ms, odors) * 0.5;
onset300 = zeros(responsiveUnit300ms, odors);
peak300 = zeros(responsiveUnit300ms, odors);
width300 = zeros(responsiveUnit300ms, odors);

responses1 = zeros(responsiveUnit1s, odors);
responses1MinusMean = zeros(responsiveUnit1s, odors);
responses1AllTrials = zeros(responsiveUnit1s, n_trials, odors);
baseline1 = zeros(responsiveUnit1s, odors);
variance1 = zeros(responsiveUnit1s, odors);
info1 = zeros(responsiveUnit1s, 1);
ls1 = zeros(responsiveUnit1s, 1);
fanoFactor1 = zeros(responsiveUnit1s, 1);
cellLog1 = zeros(responsiveUnit1s, 3);
auRoc1 = ones(responsiveUnit1s, odors) * 0.5;
onset1 = zeros(responsiveUnit1s, odors);
peak1 = zeros(responsiveUnit1s, odors);
width1 = zeros(responsiveUnit1s, odors);

responsesExc300 = zeros(responsiveUnitExc300ms, odors);
responsesExc300MinusMean = zeros(responsiveUnitExc300ms, odors);
responsesExc300MinusStd = zeros(responsiveUnitExc300ms, odors);
responsesExc300MinusCV = zeros(responsiveUnitExc300ms, odors);
baselineExc300 = zeros(responsiveUnitExc300ms, odors);
varianceExc300 = zeros(responsiveUnitExc300ms, odors);
infoExc300 = zeros(responsiveUnitExc300ms, 1);
lsExc300 = zeros(responsiveUnitExc300ms, 1); 
fanoFactorExc300 = zeros(responsiveUnitExc300ms, 1); 
cellLogExc300 = zeros(responsiveUnitExc300ms, 3);
auRocExc300 = ones(responsiveUnitExc300ms, odors) * 0.5;
onsetExc300 = zeros(responsiveUnitExc300ms, odors);
peakExc300 = zeros(responsiveUnitExc300ms, odors);
widthExc300 = zeros(responsiveUnitExc300ms, odors);
respExc300 = zeros(responsiveUnitExc300ms, odors);

responsesExc1 = zeros(responsiveUnitExc1s, odors);
responsesExc1000MinusMean = zeros(responsiveUnitExc1s, odors);
responsesExc1000MinusStd = zeros(responsiveUnitExc1s, odors);
responsesExc1000MinusCV = zeros(responsiveUnitExc1s, odors);
baselineExc1 = zeros(responsiveUnitExc1s, odors);
varianceExc1 = zeros(responsiveUnitExc1s, odors);
infoExc1 = zeros(responsiveUnitExc1s, 1);
lsExc1 = zeros(responsiveUnitExc1s, 1);
fanoFactorExc1 = zeros(responsiveUnitExc1s, 1);
cellLogExc1 = zeros(responsiveUnitExc1s, 3);
auRocExc1 = ones(responsiveUnitExc1s, odors) * 0.5;
onsetExc1 = zeros(responsiveUnitExc1s, odors);
peakExc1 = zeros(responsiveUnitExc1s, odors);
widthExc1 = zeros(responsiveUnitExc1s, odors);
respExc1 = zeros(responsiveUnitExc1s, odors);

responsesInh300 = zeros(responsiveUnitInh300ms, odors);
responsesInh300MinusMean = zeros(responsiveUnitInh300ms, odors);
baselineInh300 = zeros(responsiveUnitInh300ms, odors);
varianceInh300 = zeros(responsiveUnitInh300ms, odors);
infoInh300 = zeros(responsiveUnitInh300ms, 1);
lsInh300 = zeros(responsiveUnitInh300ms, 1); 
fanoFactorInh300 = zeros(responsiveUnitInh300ms, 1); 
cellLogInh300 = zeros(responsiveUnitInh300ms, 3);
auRocInh300 = ones(responsiveUnitInh300ms, odors) * 0.5;
respInh300 = zeros(responsiveUnitInh300ms, odors);

responsesInh1 = zeros(responsiveUnitInh1s, odors);
responses1InhMinusMean = zeros(responsiveUnitInh1s, odors);
baselineInh1 = zeros(responsiveUnitInh1s, odors);
varianceInh1 = zeros(responsiveUnitInh1s, odors);
infoInh1 = zeros(responsiveUnitInh1s, 1);
lsInh1 = zeros(responsiveUnitInh1s, 1);
fanoFactorInh1 = zeros(responsiveUnitInh1s, 1);
cellLogInh1 = zeros(responsiveUnitInh1s, 3);
auRocInh1 = ones(responsiveUnitInh1s, odors) * 0.5;
respInh1 = zeros(responsiveUnitInh1s, odors);
%%

auROCTot300ms  = 0.5 * ones(1,cells*odors);
auROCTot1s  = 0.5 * ones(1,cells*odors);
ls300msTot = zeros(1,cells);
ls1sTot = zeros(1,cells);
idxCell300 = 0;
idxCell1 = 0;
idxCellExc300 = 0;
idxCellExc1 = 0;
idxCellInh300 = 0;
idxCellInh1 = 0;
neuroneOdore = 0;
neurone = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxExp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                neurone = neurone + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessInh300ms = zeros(1,odors);
                responsivenessExc1s = zeros(1,odors);
                responsivenessInh1s = zeros(1,odors);
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                idxO = 0;
                %odorsRearranged = keepNewOrder(idxExp,:);
                for idxOdor = odorsRearranged
                    neuroneOdore = neuroneOdore + 1;
                    idxO = idxO + 1;
                    %                 responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsivenessInh300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                    responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    
                    %                 responsivenessExc1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    responsivenessInh1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
                    responsivenessExc1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs300ms(idxO) =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    auROCTot300ms(neuroneOdore) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    auROCTot1s(neuroneOdore) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                ls300msTot(neurone) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms;
                ls1sTot(neurone) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s;
                
                %vincolo reliability
                responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                responsivenessExc1s(aurocs1s<=0.75) = 0;
                responsivenessInh300ms(aurocs300ms>=0.35) = 0;
                responsivenessInh1s(aurocs1s>=0.35) = 0;
                
                if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                    idxCell300 = idxCell300 + 1;
                    idxO = 0;
                    %odorsRearranged = keepNewOrder(idxExp,:);
                    for idxOdor = odorsRearranged
                        try
                            idxO = idxO + 1;
                            responses300(idxCell300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                            responses300MinusMean(idxCell300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                                mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                            responses300AllTrials(idxCell300, :, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms -...
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms;
                            baseline300(idxCell300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                            variance300(idxCell300, idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                            auRoc300(idxCell300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                            onset300(idxCell300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency;
                            peak300(idxCell300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency;
                            width300(idxCell300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth;
                        catch
                        end
                    end
                    resp300(idxCell300,:) = responsivenessExc300ms + responsivenessInh300ms;
                    onset300(idxCell300, (responsivenessExc300ms + responsivenessInh300ms)<1) = NaN;
                    peak300(idxCell300, (responsivenessExc300ms + responsivenessInh300ms)<1) = NaN;
                    width300(idxCell300, (responsivenessExc300ms + responsivenessInh300ms)<1) = NaN;
                    In = [];
                    In = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms;
                    In = mean(In,2);
                    In = max(In);
                    if ~isempty(In)
                        info300(idxCell300) = In;
                        ls300(idxCell300) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms;
                    else
                        info300(idxCell300) = NaN;
                        ls300(idxCell300) = NaN;
                    end
                    boxWidth = 300;
                    weightingEpsilon = 1 * boxWidth/1000;
                    regWeights = n_trials ./ (responses300(idxCell300, :) + weightingEpsilon) .^ 2;
                    [B, stdB] = lscov(responses300(idxCell300, :)', variance300(idxCell300, :)', regWeights);
                    fanoFactor300(idxCell300) = B;
                    cellLog300(idxCell300,:) = [idxExp, idxShank, idxUnit];
                end
                if sum(responsivenessExc1s + responsivenessInh1s) > 0
                    idxCell1 = idxCell1 + 1;
                    idxO = 0;
                    %odorsRearranged = keepNewOrder(idxExp,:);
                    for idxOdor = odorsRearranged
                        try
                            idxO = idxO + 1;
                            responses1(idxCell1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                            responses1MinusMean(idxCell1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) - ...
                                mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                            responses1AllTrials(idxCell1, :, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                            baseline1(idxCell1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                            variance1(idxCell1, idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                            auRoc1(idxCell1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                            onset1(idxCell1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency;
                            peak1(idxCell1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency;
                            width1(idxCell1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth;
                        catch
                        end
                    end
                    resp1(idxCell1,:) = responsivenessExc1s + responsivenessInh1s;
                    onset1(idxCell1, (responsivenessExc1s + responsivenessInh1s)<1) = NaN;
                    peak1(idxCell1, (responsivenessExc1s + responsivenessInh1s)<1) = NaN;
                    width1(idxCell1, (responsivenessExc1s + responsivenessInh1s)<1) = NaN;
                    In = [];
                    In = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                    In = mean(In,2);
                    In = max(In);
                    if ~isempty(In)
                        info1(idxCell1) = In;
                        ls1(idxCell1) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s;
                    else
                        info1(idxCell1) = NaN;
                        ls1(idxCell1) = NaN;
                    end
                    %info1(idxCell1) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                    
                    boxWidth = 1000;
                    weightingEpsilon = 1 * boxWidth/1000;
                    regWeights = n_trials ./ (responses1(idxCell1, :) + weightingEpsilon) .^ 2;
                    [B, stdB] = lscov(responses1(idxCell1, :)', variance1(idxCell1, :)', regWeights);
                    fanoFactor1(idxCell1) = B;
                    cellLog1(idxCell1,:) = [idxExp, idxShank, idxUnit];
                end
                if sum(responsivenessExc300ms) > 0
                    idxCellExc300 = idxCellExc300 + 1;
                    idxO = 0;
                    %odorsRearranged = keepNewOrder(idxExp,:);
                    for idxOdor = odorsRearranged
                        try
                            idxO = idxO + 1;
                            responsesExc300(idxCellExc300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                            responsesExc300MinusMean(idxCellExc300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms - ...
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                            responsesExc300MinusStd(idxCellExc300, idxO) = std(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms - ...
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                            responsesExc300MinusCV(idxCellExc300, idxO) = responsesExc300MinusStd(idxCellExc300, idxO)./responsesExc300MinusMean(idxCellExc300, idxO);
                            baselineExc300(idxCellExc300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                            varianceExc300(idxCellExc300, idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                            auRocExc300(idxCellExc300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                            onsetExc300(idxCellExc300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency;
                            peakExc300(idxCellExc300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency;
                            widthExc300(idxCellExc300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth;
                        catch
                        end
                    end
                    respExc300(idxCellExc300,:) = responsivenessExc300ms;
                    onsetExc300(idxCellExc300, responsivenessExc300ms<1) = NaN;
                    peakExc300(idxCellExc300, responsivenessExc300ms<1) = NaN;
                    widthExc300(idxCellExc300, responsivenessExc300ms<1) = NaN;
                    In = [];
                    In = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms;
                    In = mean(In,2);
                    In = max(In);
                    if ~isempty(In)
                        infoExc300(idxCellExc300) = In;
                        lsExc300(idxCellExc300) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms;
                    else
                        infoExc300(idxCellExc300) = NaN;
                        lsExc300(idxCellExc300) = NaN;
                    end
                    weightingEpsilon = 1 * boxWidth/1000;
                    regWeights = n_trials ./ (responsesExc300(idxCellExc300, :) + weightingEpsilon) .^ 2;
                    [B, stdB] = lscov(responsesExc300(idxCellExc300, :)', varianceExc300(idxCellExc300, :)', regWeights);
                    fanoFactorExc300(idxCellExc300) = B;
                    cellLogExc300(idxCellExc300,:) = [idxExp, idxShank, idxUnit];
                end
                if sum(responsivenessExc1s + responsivenessExc300ms) > 0
                    idxCellExc1 = idxCellExc1 + 1;
                    idxO = 0;
                    %odorsRearranged = keepNewOrder(idxExp,:);
                    for idxOdor = odorsRearranged
                        try
                            idxO = idxO + 1;
                            responsesExc1(idxCellExc1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                            responsesExc1000MinusMean(idxCellExc1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms - ...
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                            responsesExc1000MinusStd(idxCellExc1, idxO) = std(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms - ...
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                            responsesExc1000MinusCV(idxCellExc1, idxO) = responsesExc1000MinusStd(idxCellExc1, idxO)./responsesExc1000MinusMean(idxCellExc1, idxO);
                            baselineExc1(idxCellExc1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                            varianceExc1(idxCellExc1, idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                            auRocExc1(idxCellExc1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                            onsetExc1(idxCellExc1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency;
                            peakExc1(idxCellExc1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency;
                            widthExc1(idxCellExc1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth;
                        catch
                        end
                    end
                    respExc1(idxCellExc1,:) = (responsivenessExc1s + responsivenessExc300ms) > 0;
                    onsetExc1(idxCellExc1, responsivenessExc1s<1) = NaN;
                    peakExc1(idxCellExc1, responsivenessExc1s<1) = NaN;
                    widthExc1(idxCellExc1, responsivenessExc1s<1) = NaN;
                    In = [];
                    In = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                    In = mean(In,2);
                    In = max(In);
                    if ~isempty(In)
                        infoExc1(idxCellExc1) = In;
                        lsExc1(idxCellExc1) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s;
                    else
                        infoExc1(idxCellExc1) = NaN;
                        lsExc1(idxCellExc1) = NaN;
                    end
                    boxWidth = 1000;
                    weightingEpsilon = 1 * boxWidth/1000;
                    regWeights = n_trials ./ (responsesExc1(idxCellExc1, :) + weightingEpsilon) .^ 2;
                    [B, stdB] = lscov(responsesExc1(idxCellExc1, :)', varianceExc1(idxCellExc1, :)', regWeights);
                    fanoFactorExc1(idxCellExc1) = B;
                    cellLogExc1(idxCellExc1,:) = [idxExp, idxShank, idxUnit];
                end
                if sum(responsivenessInh300ms) > 0
                    idxCellInh300 = idxCellInh300 + 1;
                    idxO = 0;
                    %odorsRearranged = keepNewOrder(idxExp,:);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        responsesInh300(idxCellInh300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                        responsesInh300MinusMean(idxCellInh300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                            mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                        baselineInh300(idxCellInh300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                        varianceInh300(idxCellInh300, idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                        auRocInh300(idxCellInh300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    end
                    respInh300(idxCellInh300,:) = responsivenessInh300ms;
                    In = [];
                    In = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms;
                    In = mean(In,2);
                    In = max(In);
                    if ~isempty(In)
                        infoInh300(idxCellInh300) = In;
                        lsInh300(idxCellInh300) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms;
                    else
                        infoInh300(idxCellInh300) = NaN;
                        lsInh300(idxCellInh300) = NaN;
                    end
                    boxWidth = 300;
                    weightingEpsilon = 1 * boxWidth/1000;
                    regWeights = n_trials ./ (responsesInh300(idxCellInh300, :) + weightingEpsilon) .^ 2;
                    [B, stdB] = lscov(responsesInh300(idxCellInh300, :)', varianceInh300(idxCellInh300, :)', regWeights);
                    fanoFactorInh300(idxCellInh300) = B;
                    cellLogInh300(idxCellInh300,:) = [idxExp, idxShank, idxUnit];
                end
                if sum(responsivenessInh1s + responsivenessInh300ms) > 0
                    idxCellInh1 = idxCellInh1 + 1;
                    idxO = 0;
                    %odorsRearranged = keepNewOrder(idxExp,:);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        responsesInh1(idxCellInh1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                        responsesInh1MinusMean(idxCellInh1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) - ...
                            mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                        responsesInh1AllTrials(idxCellInh1, :, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                        baselineInh1(idxCellInh1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                        varianceInh1(idxCellInh1, idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                        auRocInh1(idxCellInh1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    end
                    respInh1(idxCellInh1,:) = (responsivenessInh1s + responsivenessInh300ms)>0;
                    In = [];
                    In = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                    In = mean(In,2);
                    In = max(In);
                    if ~isempty(In)
                        infoInh1(idxCellInh1) = In;
                        lsInh1(idxCellInh1) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s;
                    else
                        infoInh1(idxCellInh1) = NaN;
                        lsInh1(idxCellInh1) = NaN;
                    end
                    boxWidth = 1000;
                    weightingEpsilon = 1 * boxWidth/1000;
                    regWeights = n_trials ./ (responsesInh1(idxCellInh1, :) + weightingEpsilon) .^ 2;
                    [B, stdB] = lscov(responsesInh1(idxCellInh1, :)', varianceInh1(idxCellInh1, :)', regWeights);
                    fanoFactorInh1(idxCellInh1) = B;
                    cellLogInh1(idxCellInh1,:) = [idxExp, idxShank, idxUnit];
                end
            end
        end
    end
end

%%
% responses300MinusMeanCoa = responses300MinusMean;
% responses300Coa = responses300;
% info300Coa = info300;
% responses300AllTrialsCoa = responses300AllTrials;
% responses1Coa = responses1;
% responses1MinusMeanCoa = responses1MinusMean;
% responses1AllTrialsCoa = responses1AllTrials;
% cellLog300Coa = cellLog300;
% cellLog1Coa = cellLog1;
% cellLog1ExcCoa = cellLogExc1;
% fanoFactor300Coa = fanoFactor300;
% fanoFactor1Coa = fanoFactor1;
% ls300Coa = ls300;
% ls1Coa = ls1;
% baseline300Coa = baseline300;
% baseline1Coa = baseline1;
% variance300Coa = variance300;
% variance1Coa = variance1;
% auRoc300Coa = auRoc300;
% auRoc1Coa = auRoc1;
% fanoFactor300Coa = fanoFactor300;
% fanoFactor1Coa = fanoFactor1;
%%
responses300MinusMean = responses300MinusMean;
responses300 = responses300;
info300 = info300;
responses300AllTrials = responses300AllTrials;
responses1 = responses1;
responses1MinusMean = responses1MinusMean;
responses1AllTrials = responses1AllTrials;
cellLog300 = cellLog300;
cellLog1 = cellLog1;
cellLogExc1 = cellLogExc1;
fanoFactor300 = fanoFactor300;
fanoFactor1 = fanoFactor1;
ls300 = ls300;
ls1 = ls1;
baseline300 = baseline300;
baseline1 = baseline1;
variance300 = variance300;
variance1 = variance1;
auRoc300 = auRoc300;
auRoc1 = auRoc1;
fanoFactor300 = fanoFactor300;
fanoFactor1 = fanoFactor1;



%%
% save('responses.mat', 'responses300MinusMean','responses300', 'info300', 'responses300AllTrials', 'responses1', 'responses1MinusMean', 'responses1AllTrials', 'cellLog300', 'cellLog1',...
%     'fanoFactor300', 'fanoFactor1', 'ls300', 'ls1', 'baseline300','baseline1', 'variance300','variance1', 'auRoc300', 'auRoc1')
% save('responsesCoaLow.mat', 'responses300MinusMeanCoa','responses300Coa', 'info300Coa', 'responses300AllTrialsCoa', 'responses1Coa', 'responses1MinusMeanCoa', 'responses1AllTrialsCoa', 'cellLog300Coa', 'cellLog1Coa','cellLog1Coa',...
%   'fanoFactor300Coa', 'fanoFactor1Coa', 'ls300Coa', 'ls1Coa', 'baseline300Coa','baseline1Coa', 'variance300Coa','variance1Coa', 'auRoc300Coa', 'auRoc1Coa', 'fanoFactor300Coa', 'fanoFactor1Coa')
save('responsesAA.mat', 'responses300MinusMean','responses300', 'info300', 'responses300AllTrials', 'responses1', 'responses1MinusMean', 'responses1AllTrials', 'cellLog300','cellLogExc1', 'cellLog1',...
   'fanoFactor300', 'fanoFactor1', 'ls300', 'ls1', 'baseline300','baseline1', 'variance300','variance1', 'auRoc300', 'auRoc1', 'fanoFactor300', 'fanoFactor1', 'auROCTot300ms', 'auROCTot1s', 'ls300msTot', 'ls1sTot', 'pop_sparseness300', 'pop_sparseness1000')
%%
cd(folder)

responses2
% %%

responses3
collectAllSdfs
cd(folder)
