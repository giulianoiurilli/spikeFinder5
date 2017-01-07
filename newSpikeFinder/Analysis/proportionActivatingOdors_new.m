function [actOdor, supOdor, aurocs1000msSorted, aurocs300msSorted, cellLog, respOdor] = proportionActivatingOdors_new(esp, odors, onlyexc)

odorsRearranged = odors;
odors = length(odorsRearranged);
n_trials = 10;
%%
[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors, onlyexc);

%%
responsesDig = zeros(totalSUA, odors);
responsesExcDig = zeros(totalSUA, odors);
responsesInhDig = zeros(totalSUA, odors);

%%
c = 0;
u = 0;
aurocs1000msSorted = [];
aurocs300msSorted = [];
for idxExp =  1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
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
                        responsivenessExc300ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse300ms == 1;
                        responsivenessInh300ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse300ms == -1;
                        responsivenessExc1000ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse1000ms == 1;
                        responsivenessInh1000ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse1000ms == -1;
                        aurocs300ms(idxO) =  esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC300ms;
                        aurocs1000ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC1000ms;
                    end
                    responsiveness = responsivenessExc1000ms + responsivenessInh1000ms;
                    responsivenessExc = responsivenessExc1000ms;% + responsivenessExc300ms;
                    responsivenessInh = responsivenessInh1000ms;% + responsivenessExc300ms;
                    app = [];
                    app = responsiveness>0;
                    responsiveness = app;
                    app = [];
                    app = responsivenessExc>0;
                    responsivenessExc = app;
                    responsesDig(c,:) = responsiveness;
                    responsesExcDig(c,:) = responsivenessExc;
                    app = [];
                    app = responsivenessInh>0;
                    responsivenessInh = app;
                    responsesInhDig(c,:) = responsivenessInh;
                    if sum(responsesDig(c,:)) > 0
                        u = u +1;
                        aurocs1000msSorted = [aurocs1000msSorted ; sort(aurocs1000ms)];
                        aurocs300msSorted = [aurocs300msSorted ; sort(aurocs300ms)];
                        cellLog(u,:) = [idxExp, idxShank, idxUnit];
                    end
                end
            end
        end
    end
end

actOdor = sum(responsesExcDig,2);
supOdor = sum(responsesInhDig,2);
respOdor = sum(responsesDig,2);



