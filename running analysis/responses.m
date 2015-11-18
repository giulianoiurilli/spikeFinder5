%%
odorsRearranged = 1:15; %15 odors
%odorsRearranged = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
%odorsRearranged = [1,2,3,4,5,6,7]; %7 odors low
%odorsRearranged = [12 13 14 15 1]; %3 odors pen
%odorsRearranged = [2 3 4 5 6]; %3 odors iaa
%odorsRearranged = [7 8 9 10 11]; %3 odors etg
%odorsRearranged = [1 6 11]; %3 odors high
%odorsRearranged = [15 5 10]; %3 odors medium-high
%odorsRearranged = [14 4 9]; %3 odors medium
%odorsRearranged = [13 3 8]; %3 odors medium-low
%odorsRearranged = [12 2 7]; %3 odors low
%odorsRearranged  = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
%odorsRearranged = [1 2 3 4  6 7 8 9]; %aveatt
%odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
%odorsRearranged = [1 13 14 15]; %mixTMT


odors = length(odorsRearranged);
%%
responsiveUnit4cycles = 0;
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
cells = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            cells = cells + 1;
            responsivenessExc4cycles = zeros(1,odors);
            responsivenessInh4cycles = zeros(1,odors);
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            responsivenessExc1s = zeros(1,odors);
            responsivenessInh1s = zeros(1,odors);
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                responsivenessExc4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                responsivenessExc300ms(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessInh300ms(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                responsivenessExc1s(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                responsivenessInh1s(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
            end
            if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0 %&& (exp(idxExp).shankWarp(idxShank).cell(idxUnit).keepUnit == 1)
                responsiveUnit4cycles = responsiveUnit4cycles + 1;
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0 %&& (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                responsiveUnit300ms = responsiveUnit300ms + 1;
            end
            if sum(responsivenessExc1s + responsivenessInh1s) > 0 %&& (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                responsiveUnit1s = responsiveUnit1s + 1;
            end
        end
    end
end

%%
responses4 = zeros(responsiveUnit4cycles, odors);
responses4MinusMean = zeros(responsiveUnit4cycles, odors);
responses300 = zeros(responsiveUnit300ms, odors);
responses300MinusMean = zeros(responsiveUnit300ms, odors);
info4 = zeros(responsiveUnit4cycles, 1);
info300 = zeros(responsiveUnit300ms, 1);
responses4AllTrials = zeros(responsiveUnit4cycles, n_trials, odors);
responses300AllTrials = zeros(responsiveUnit300ms, n_trials, odors);

responses1 = zeros(responsiveUnit1s, odors);
responses1MinusMean = zeros(responsiveUnit1s, odors);
responses1AllTrials = zeros(responsiveUnit1s, n_trials, odors);
info1 = zeros(responsiveUnit1s, 1);

idxCell4 = 0;
idxCell300 = 0;
idxCell1 = 0;
for idxExp = 1: length(exp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            responsivenessExc4cycles = zeros(1,odors);
            responsivenessInh4cycles = zeros(1,odors);
            responsivenessExc300ms = zeros(1,odors);
            responsivenessInh300ms = zeros(1,odors);
            responsivenessExc1s = zeros(1,odors);
            responsivenessInh1s = zeros(1,odors);
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                responsivenessExc4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                responsivenessInh4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                responsivenessExc300ms(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                responsivenessInh300ms(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                responsivenessExc1s(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                responsivenessInh1s(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
            end
            if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0 %&& (exp(idxExp).shankWarp(idxShank).cell(idxUnit).keepUnit == 1)
                idxCell4 = idxCell4 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responses4(idxCell4, idxO) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse);
                    responses4MinusMean(idxCell4, idxO) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse) - ...
                        mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl);
                    responses4AllTrials(idxCell4, :, idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse;
                    
                end
                info4(idxCell4) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).I4Cycles;    
            end
            if sum(responsivenessExc300ms + responsivenessInh300ms) > 0  %&& (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                idxCell300 = idxCell300 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responses300(idxCell300, idxO) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                    responses300MinusMean(idxCell300, idxO) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                        mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    responses300AllTrials(idxCell300, :, idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms;
                    
                end
                info300(idxCell300) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms;   
            end
            if sum(responsivenessExc1s + responsivenessInh1s) > 0  %&& (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responses1(idxCell1, idxO) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                    responses1MinusMean(idxCell1, idxO) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) - ...
                        mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    responses1AllTrials(idxCell1, :, idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                end
            end
        end
    end
end

save('responses.mat', 'responses4MinusMean', 'responses300MinusMean','responses4', 'responses300', 'info4', 'info300', 'responses4AllTrials', 'responses300AllTrials', 'responses1', 'responses1MinusMean', 'responses1AllTrials')
