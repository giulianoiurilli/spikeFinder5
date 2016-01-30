%odorsRearranged = [1 2 5 10 15 7 8];% pcxL
%odorsRearranged = [14 6 4 12 13 3 11 ];% pcxH
%odorsRearranged = [14 6 4 12 13 3 11 9];% pcxH8
%odorsRearranged = [6 1 3 13 12 7 5];% coaL
%odorsRearranged = [14 2 15 4 10 11 8];% coaH
%odorsRearranged = [14 2 15 4 10 11 8 9];% coaH8


odorsRearranged = 1:15;
odors = length(odorsRearranged);
n_trials = 10;
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
responsesExc1Pcx = zeros(c, odors);
c = 0;
for idxExp =  1:length(pcx2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                responsivenessExcPcx300ms = zeros(1,odors);
                responsivenessExcPcx1000ms = zeros(1,odors);
                aurocsPcx300ms = zeros(1,odors);
                aurocsPcx1000s = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExcPcx300ms(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExcPcx1000ms(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocsPcx300ms(idxO) =  pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocsPcx1000s(idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responsivenessExcPcx300ms(aurocsPcx300ms<=0.75) = 0;
                    responsivenessExcPcx1000ms(aurocsPcx1000s<=0.75) = 0;
                end
                responsivenessExcPcx1000ms = responsivenessExcPcx1000ms + responsivenessExcPcx300ms;
                app = [];
                app = responsivenessExcPcx1000ms>0;
                responsivenessExcPcx1000ms = app;
                responsesExc1Pcx(c,:) = responsivenessExcPcx1000ms;
            end
        end
    end
end

actOdorPcx = sum(responsesExc1Pcx,2);



%%
odorsRearranged = 1:15;
odors = length(odorsRearranged);
n_trials = 10;
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
responsesExc1Coa = zeros(c, odors);
c = 0;
for idxExp =  1:length(coa2.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                responsivenessExcCoa300ms = zeros(1,odors);
                responsivenessExcCoa1000ms = zeros(1,odors);
                aurocsCoa300ms = zeros(1,odors);
                aurocsCoa1000s = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExcCoa300ms(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExcCoa1000ms(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocsCoa300ms(idxO) =  coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocsCoa1000s(idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responsivenessExcCoa300ms(aurocsCoa300ms<=0.75) = 0;
                    responsivenessExcCoa1000ms(aurocsCoa1000s<=0.75) = 0;
                end
                responsivenessExcCoa1000ms = responsivenessExcCoa1000ms + responsivenessExcCoa300ms;
                app = [];
                app = responsivenessExcCoa1000ms>0;
                responsivenessExcCoa1000ms = app;
                responsesExc1Coa(c,:) = responsivenessExcCoa1000ms;
            end
        end
    end
end

actOdorCoa = sum(responsesExc1Coa,2);

%%
odorsRearranged = [14 6 4 12 13 3 11];% pcxH
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(pcx2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
responsesExc1PcxH = zeros(c, odors);
c = 0;
for idxExp =  1:length(pcx2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                responsivenessExcPcx300ms = zeros(1,odors);
                responsivenessExcPcx1000ms = zeros(1,odors);
                aurocsPcx300ms = zeros(1,odors);
                aurocsPcx1000s = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExcPcx300ms(idxO) = pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExcPcx1000ms(idxO) = pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocsPcx300ms(idxO) =  pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocsPcx1000s(idxO) = pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responsivenessExcPcx300ms(aurocsPcx300ms<=0.75) = 0;
                    responsivenessExcPcx1000ms(aurocsPcx1000s<=0.75) = 0;
                end
                responsivenessExcPcx1000ms = responsivenessExcPcx1000ms + responsivenessExcPcx300ms;
                app = [];
                app = responsivenessExcPcx1000ms>0;
                responsivenessExcPcx1000ms = app;
                responsesExc1PcxH(c,:) = responsivenessExcPcx1000ms;
            end
        end
    end
end

actOdorPcxH = sum(responsesExc1PcxH,2);



%%
odorsRearranged = [14 2 15 4 10 11 8];% coaH
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(coa2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
responsesExc1CoaH = zeros(c, odors);
c = 0;
for idxExp =  1:length(coa2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                responsivenessExcCoa300ms = zeros(1,odors);
                responsivenessExcCoa1000ms = zeros(1,odors);
                aurocsCoa300ms = zeros(1,odors);
                aurocsCoa1000s = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExcCoa300ms(idxO) = coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExcCoa1000ms(idxO) = coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocsCoa300ms(idxO) =  coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocsCoa1000s(idxO) = coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responsivenessExcCoa300ms(aurocsCoa300ms<=0.75) = 0;
                    responsivenessExcCoa1000ms(aurocsCoa1000s<=0.75) = 0;
                end
                responsivenessExcCoa1000ms = responsivenessExcCoa1000ms + responsivenessExcCoa300ms;
                app = [];
                app = responsivenessExcCoa1000ms>0;
                responsivenessExcCoa1000ms = app;
                responsesExc1CoaH(c,:) = responsivenessExcCoa1000ms;
            end
        end
    end
end

actOdorCoaH = sum(responsesExc1CoaH,2);

%%
odorsRearranged = [1 2 5 10 15 7 8];% pcxL
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(pcx2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
responsesExc1PcxL = zeros(c, odors);
c = 0;
for idxExp =  1:length(pcx2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                responsivenessExcPcx300ms = zeros(1,odors);
                responsivenessExcPcx1000ms = zeros(1,odors);
                aurocsPcx300ms = zeros(1,odors);
                aurocsPcx1000s = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExcPcx300ms(idxO) = pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExcPcx1000ms(idxO) = pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocsPcx300ms(idxO) =  pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocsPcx1000s(idxO) = pcx2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responsivenessExcPcx300ms(aurocsPcx300ms<=0.75) = 0;
                    responsivenessExcPcx1000ms(aurocsPcx1000s<=0.75) = 0;
                end
                responsivenessExcPcx1000ms = responsivenessExcPcx1000ms + responsivenessExcPcx300ms;
                app = [];
                app = responsivenessExcPcx1000ms>0;
                responsivenessExcPcx1000ms = app;
                responsesExc1PcxL(c,:) = responsivenessExcPcx1000ms;
            end
        end
    end
end

actOdorPcxL = sum(responsesExc1PcxL,2);



%%
odorsRearranged = [6 1 3 13 12 7 5];% coaL
odors = length(odorsRearranged);
n_trials = 10;
c = 0;
for idxExp =  1:length(coa2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
responsesExc1CoaL = zeros(c, odors);
c = 0;
for idxExp =  1:length(coa2HL.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa2HL.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                responsivenessExcCoa300ms = zeros(1,odors);
                responsivenessExcCoa1000ms = zeros(1,odors);
                aurocsCoa300ms = zeros(1,odors);
                aurocsCoa1000s = zeros(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExcCoa300ms(idxO) = coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExcCoa1000ms(idxO) = coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocsCoa300ms(idxO) =  coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocsCoa1000s(idxO) = coa2HL.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responsivenessExcCoa300ms(aurocsCoa300ms<=0.75) = 0;
                    responsivenessExcCoa1000ms(aurocsCoa1000s<=0.75) = 0;
                end
                responsivenessExcCoa1000ms = responsivenessExcCoa1000ms + responsivenessExcCoa300ms;
                app = [];
                app = responsivenessExcCoa1000ms>0;
                responsivenessExcCoa1000ms = app;
                responsesExc1CoaL(c,:) = responsivenessExcCoa1000ms;
            end
        end
    end
end

actOdorCoaL = sum(responsesExc1CoaL,2);

