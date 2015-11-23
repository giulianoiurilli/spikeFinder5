%%
%odorsRearranged = 1:15; %15 odors and concseries
%odorsRearranged = 1:10; %aveatt
odorsRearranged = 1:7; %2conc



odors = length(odorsRearranged);
%%
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
cells = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            cells = cells + 1;
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            responsivenessExc1s = zeros(1,odors);
            responsivenessInh1s = zeros(1,odors);
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessInh300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                responsivenessExc1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                responsivenessInh1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0 
                responsiveUnit300ms = responsiveUnit300ms + 1;
            end
            if sum(responsivenessExc1s + responsivenessInh1s) > 0 
            end
        end
    end
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


idxCell300 = 0;
idxCell1 = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            responsivenessExc1s = zeros(1,odors);
            responsivenessInh1s = zeros(1,odors);
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessInh300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                responsivenessExc1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                responsivenessInh1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0
                idxCell300 = idxCell300 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responses300(idxCell300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                    responses300MinusMean(idxCell300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                        mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    responses300AllTrials(idxCell300, :, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms;
                    baseline300(idxCell300, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    variance300(idxCell300, idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                    auRoc300(idxCell300, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                end
                info300(idxCell300) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms; 
                ls300(idxCell300) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms; 
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
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responses1(idxCell1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                    responses1MinusMean(idxCell1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) - ...
                        mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    responses1AllTrials(idxCell1, :, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                    baseline1(idxCell1, idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    variance1(idxCell1, idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                    auRoc1(idxCell1, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                info1(idxCell1) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                ls1(idxCell1) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s;
                boxWidth = 1000;
                weightingEpsilon = 1 * boxWidth/1000;
                regWeights = n_trials ./ (responses1(idxCell1, :) + weightingEpsilon) .^ 2;
                [B, stdB] = lscov(responses1(idxCell1, :)', variance1(idxCell1, :)', regWeights);
                fanoFactor1(idxCell1) = B;
                cellLog1(idxCell1,:) = [idxExp, idxShank, idxUnit];
            end
        end
    end
end

save('responsesHigh.mat', 'responses300MinusMean','responses300', 'info300', 'responses300AllTrials', 'responses1', 'responses1MinusMean', 'responses1AllTrials', 'cellLog300', 'cellLog1',...
    'fanoFactor300', 'fanoFactor1', 'ls300', 'ls1', 'baseline300','baseline1', 'variance300','variance1', 'auRoc300', 'auRoc1')
