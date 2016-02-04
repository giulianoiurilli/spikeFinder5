function [actOdor, aurocs1000msSorted] = proportionActivatingOdors(esp, odors)

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
responsesExc1 = zeros(c, odors);
c = 0;
aurocs1000msSorted = [];
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
                    aurocs300ms(idxO) =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1000ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                    responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                end
                responsivenessExc1000ms = responsivenessExc1000ms + responsivenessExc300ms;
                app = [];
                app = responsivenessExc1000ms>0;
                responsivenessExc1000ms = app;
                responsesExc1(c,:) = responsivenessExc1000ms;
                if sum(responsesExc1(c,:)) > 0
                    aurocs1000msSorted = [aurocs1000msSorted ; sort((aurocs1000ms ./ max(aurocs1000ms)))];
                end
            end
        end
    end
end

actOdor = sum(responsesExc1,2);



