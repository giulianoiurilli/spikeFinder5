function [odorsExc1, responsesExc1, cellLogExc1] = concSeriesAnalysis(esp, odors)

odorsRearranged = odors;
odors = length(odorsRearranged);
n_trials = 10;
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
odorsExc1 = zeros(c, odors);
responsesExc1 = zeros(c, odors);
cellLogExc1 = zeros(c, 3);
c = 0;

for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessExc1000ms = zeros(1,odors);
                aurocs300ms = zeros(1,odors);
                aurocs1000s = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc1000ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs1000ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    aurocs300ms(idxO) =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms; 
                    responsesExc1000ms(idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms - esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                    responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                end
                responsivenessExc1000ms = responsivenessExc1000ms + responsivenessExc300ms;
                app = [];
                app = responsivenessExc1000ms>0;
                responsivenessExc1000ms = app;
                odorsExc1(c,:) = responsivenessExc1000ms;
                responsesExc1(c,:) = responsesExc1000ms;
                cellLogExc1(c,:) = [idxExp idxShank idxUnit];
            end
        end
    end
end