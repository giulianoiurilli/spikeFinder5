%% define all possible responses you may want to save, and then run the script.
% don't touch anything else. Don't change names nor combinations
 
saveR(1)    = 0;   %odorsRearranged = 1:15; %15 odors
saveR(2)    = 0;   %odorsRearranged = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
saveR(3)    = 0;   %odorsRearranged = [1,2,3,4,5,6,7]; %7 odors low
saveR(4)    = 1;   %odorsRearranged = [12 13 14 15 1]; %3 odors pen
saveR(5)    = 1;   %odorsRearranged = [2 3 4 5 6]; %3 odors iaa
saveR(6)    = 1;   %odorsRearranged = [7 8 9 10 11]; %3 odors etg
saveR(7)    = 1;   %odorsRearranged = [1 6 11]; %3 odors high
saveR(8)    = 1;   %odorsRearranged = [15 5 10]; %3 odors medium-high
saveR(9)    = 1;   %odorsRearranged = [14 4 9]; %3 odors medium
saveR(10)   = 1;   %odorsRearranged = [13 3 8]; %3 odors medium-low
saveR(11)   = 1;   %odorsRearranged = [12 2 7]; %3 odors low
saveR(12)   = 1;   %odorsRearranged  = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
saveR(13)   = 0;   %odorsRearranged = [1 2 3 4 5 6 7 8 9 10]; %aveatt
saveR(14)   = 0;   %odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
saveR(15)   = 0;   %odorsRearranged = [1 13 14 15]; %mixTMT
 
%% don't change
odorsRearranged(1).caz   = 1:15; %15 odors
tags(1).caz             = 'all';
odorsRearranged(2).caz   = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
tags(2).caz             = '7high';
odorsRearranged(3).caz   = [1,2,3,4,5,6,7]; %7 odors low
tags(3).caz             = 'low';
odorsRearranged(4).caz   = [12 13 14 15 1]; %3 odors pen
tags(4).caz             = 'pen';
odorsRearranged(5).caz   = [2 3 4 5 6]; %3 odors iaa
tags(5).caz             = 'iaa';
odorsRearranged(6).caz    = [7 8 9 10 11]; %3 odors etg
tags(6).caz             = 'etg';
odorsRearranged(7).caz    = [1 6 11]; %3 odors high
tags(7).caz             = '3high';
odorsRearranged(8).caz    = [15 5 10]; %3 odors medium-high
tags(8).caz             = '3mediumhigh';
odorsRearranged(9).caz    = [14 4 9]; %3 odors medium
tags(9).caz             = '3medium';
odorsRearranged(10).caz    = [13 3 8]; %3 odors medium-low
tags(10).caz            = '3mediumlow';
odorsRearranged(11).caz    = [12 2 7]; %3 odors low
tags(11).caz            = '3low';
odorsRearranged(12).caz     = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
tags(12).caz            = '15concSeries';
% {"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
odorsRearranged(13).caz    = [1 2 3 4 5 6 7 8 9 10]; %aveatt
tags(13).caz            = 'aveatt';
odorsRearranged(14).caz    = [7 11 12 13]; %aveatt mix butanedione
tags(14).caz            = 'aveattmixbutanedione';
odorsRearranged(15).caz    = [1 13 14 15]; %mixTMT
tags(15).caz            = 'aveattmixTMT';
 
 
%%
toBeSaved = find(saveR);
for idx2Save = toBeSaved
    
    odors = length(odorsRearranged(idx2Save).caz);
    %%
    responsiveUnit4cycles = 0;
    responsiveUnit300ms = 0;
    cells = 0;
    trackExperiment4 = [];
    trackExperiment300 = [];
    for idxExp = 1: length(exp) %- 1
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
                cells = cells + 1;
                responsivenessExc4cycles = zeros(1,odors);
                responsivenessInh4cycles = zeros(1,odors);
                responsivenessExc300ms = zeros(1,odors);
                responsivenessInh300ms = zeros(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged(idx2Save).caz
                    idxO = idxO + 1;
                    responsivenessExc4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                    responsivenessInh4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                    responsivenessExc300ms(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsivenessInh300ms(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                end
                if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0 && (exp(idxExp).shankWarp(idxShank).cell(idxUnit).keepUnit == 1)
                    responsiveUnit4cycles = responsiveUnit4cycles + 1;
                end
                if sum(responsivenessExc300ms + responsivenessInh300ms) > 0 && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                    responsiveUnit300ms = responsiveUnit300ms + 1;
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
    
    idxCell4 = 0;
    idxCell300 = 0;
    for idxExp = 1: length(exp) %- 1
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
                responsivenessExc4cycles = zeros(1,odors);
                responsivenessInh4cycles = zeros(1,odors);
                responsivenessExc300ms = zeros(1,odors);
                responsivenessInh300ms = zeros(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged(idx2Save).caz
                    idxO = idxO + 1;
                    responsivenessExc4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == 1;
                    responsivenessInh4cycles(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse == -1;
                    responsivenessExc300ms(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsivenessInh300ms(idxO) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                end
                if sum(responsivenessExc4cycles + responsivenessInh4cycles) > 0 && (exp(idxExp).shankWarp(idxShank).cell(idxUnit).keepUnit == 1)
                    idxCell4 = idxCell4 + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged(idx2Save).caz
                        idxO = idxO + 1;
                        responses4(idxCell4, idxO) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse);
                        trackExperiment4(idxCell4,[1,2]) = [idxExp, idxShank];
                        responses4MinusMean(idxCell4, idxO) = mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse) - ...
                            mean(exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl);
                        
                    end
                    info4(idxCell4) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).I4Cycles;
                end
                if sum(responsivenessExc300ms + responsivenessInh300ms) > 0  && (exp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                    idxCell300 = idxCell300 + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged(idx2Save).caz
                        idxO = idxO + 1;
                        responses300(idxCell300, idxO) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                        trackExperiment300(idxCell300,[1,2]) = [idxExp, idxShank];
                        responses300MinusMean(idxCell300, idxO) = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
                            mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    end
                    info300(idxCell300) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms;
                end
            end
        end
    end
    
    save(['responses_' tags(idx2Save).caz '.mat'], 'responses4MinusMean', 'responses300MinusMean','responses4', 'responses300', 'info4', 'info300','trackExperiment4','trackExperiment300')
end