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
responsesDig = zeros(c, odors);
responsesExcDig = zeros(c, odors);
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
                responsivenessInh300ms = zeros(1,odors);
                responsivenessInh1000ms = zeros(1,odors);
                aurocs300ms = zeros(1,odors);
                aurocs1000ms = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessInh300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc1000ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    responsivenessInh1000ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs300ms(idxO) =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1000ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                    responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                    responsivenessInh300ms(aurocs300ms>=0.35) = 0;
                    responsivenessInh1000ms(aurocs1000ms>=0.35) = 0;
                end
                responsiveness = responsivenessExc1000ms + responsivenessExc300ms + responsivenessInh300ms + responsivenessInh1000ms;
                responsivenessExc = responsivenessExc1000ms + responsivenessExc300ms;
                app = [];
                app = responsiveness>0;
                responsiveness = app;
                app = [];
                app = responsivenessExc>0;
                responsivenessExc = app;
                responsesDig(c,:) = responsiveness;
                responsesExcDig(c,:) = responsivenessExc;
                if sum(responsesDig(c,:)) > 0
                    aurocs1000msSorted = [aurocs1000msSorted ; sort(aurocs1000ms)];
                end
            end
        end
    end
end

actOdor = sum(responsesExcDig,2);



