
odorsRearranged = 1:15;
odors = length(odorsRearranged);
esp = pcx15.esp;
espe = pcx15_1.espe;
folderlist = {esp(:).filename};

lratio = 5;
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
responsiveUnitExc300ms = 0;
responsiveUnitInh300ms = 0;
responsiveUnitExc1s = 0;
responsiveUnitInh1s = 0;
cells = 0;
logExc = [];
logInh = [];
for idxExp = 1: length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    cells = cells + 1;
                    responsivenessExc300ms = zeros(1,odors);
                    responsivenessInh300ms = zeros(1,odors);
                    responsivenessExc1s = zeros(1,odors);
                    responsivenessInh1s = zeros(1,odors);
                    idxO = 0;
                    aurocs300ms = 0.5*ones(1,odors);
                    aurocs1s = 0.5*ones(1,odors);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        responsivenessExc300ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                        responsivenessExc1s(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        if responsivenessExc300ms(idxO) + responsivenessExc1s(idxO) > 0
                            logExc = [logExc; [idxExp, idxShank, idxUnit, idxOdor]];
                        end
                    end
                end
            end
        end
    end
end

%% Significant excitatory responses
indici = -3:5;
snipCellOdorSniff = [];
respCellOdorPairPSTHExcMnPcx1 = [];
A = [];
for idxEntry = 1:size(logExc,1)
    idxExp = logExc(idxEntry,1);
    idxShank = logExc(idxEntry,2);
    idxUnit = logExc(idxEntry,3);
    idxOdor = logExc(idxEntry,4);
    cartella = folderlist{idxExp};
    cd(cartella)
    load('breathing.mat', 'sniffs');
    A = single(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
    snipCellOdorSniff = [];
    for idxTrial = 1:10
        onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffOnsets(:,1) >= 0,1);
    end
    for idxSniff = 1:8
        app = [];
        for idxTrial = 1:10
            app(idxTrial,:) = A(idxTrial, 4000 + floor(sniffs(idxOdor).trial(idxTrial).sniffOnsets(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                4000 + floor(sniffs(idxOdor).trial(idxTrial).sniffOnsets(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
        end
        
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    respCellOdorPairPSTHExcMnPcx1(idxEntry,:) = slidePSTH(snipCellOdorSniff, 50, 5);
end
%%

odorsRearranged = 1:13;
odors = length(odorsRearranged);
esp = pcxNM.esp;
espe = pcxNM_1.espe;
folderlist = {esp(:).filename};

lratio = 5;
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
responsiveUnitExc300ms = 0;
responsiveUnitInh300ms = 0;
responsiveUnitExc1s = 0;
responsiveUnitInh1s = 0;
cells = 0;
logExc = [];
logInh = [];
for idxExp = 1: length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    cells = cells + 1;
                    responsivenessExc300ms = zeros(1,odors);
                    responsivenessInh300ms = zeros(1,odors);
                    responsivenessExc1s = zeros(1,odors);
                    responsivenessInh1s = zeros(1,odors);
                    idxO = 0;
                    aurocs300ms = 0.5*ones(1,odors);
                    aurocs1s = 0.5*ones(1,odors);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        responsivenessExc300ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                        responsivenessExc1s(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        if responsivenessExc300ms(idxO) + responsivenessExc1s(idxO) > 0
                            logExc = [logExc; [idxExp, idxShank, idxUnit, idxOdor]];
                        end
                    end
                end
            end
        end
    end
end

%% Significant excitatory responses
indici = -3:5;
snipCellOdorSniff = [];
respCellOdorPairPSTHExcMnPcx2 = [];
A = [];
for idxEntry = 1:size(logExc,1)
    idxExp = logExc(idxEntry,1);
    idxShank = logExc(idxEntry,2);
    idxUnit = logExc(idxEntry,3);
    idxOdor = logExc(idxEntry,4);
    cartella = folderlist{idxExp};
            cd(fullfile(cartella, 'ephys'))
%     cd(cartella)
    load('breathing.mat', 'sniffs');
    A = single(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
    snipCellOdorSniff = [];
    for idxTrial = 1:10
        onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffOnsets(:,1) >= 0,1);
    end
    for idxSniff = 1:8
        app = [];
        for idxTrial = 1:10
            app(idxTrial,:) = A(idxTrial, 4000 + floor(sniffs(idxOdor).trial(idxTrial).sniffOnsets(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                4000 + floor(sniffs(idxOdor).trial(idxTrial).sniffOnsets(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
        end
        
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    respCellOdorPairPSTHExcMnPcx2(idxEntry,:) = slidePSTH(snipCellOdorSniff, 50, 5);
end
% %%
% figure
% plot(mean(respCellOdorPairPSTHExcMn2))

%%
figure
plot(mean([respCellOdorPairPSTHExcMnPcx1; respCellOdorPairPSTHExcMnPcx2])*20, 'color', pcxC, 'linewidth', 1)
%%
odorsRearranged = 1:15;
odors = length(odorsRearranged);
esp = coa15.esp;
espe = coa15_1.espe;

folderlist = {esp(:).filename};

lratio = 5;
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
responsiveUnitExc300ms = 0;
responsiveUnitInh300ms = 0;
responsiveUnitExc1s = 0;
responsiveUnitInh1s = 0;
cells = 0;
logExc = [];
logInh = [];
for idxExp = 1: length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    cells = cells + 1;
                    responsivenessExc300ms = zeros(1,odors);
                    responsivenessInh300ms = zeros(1,odors);
                    responsivenessExc1s = zeros(1,odors);
                    responsivenessInh1s = zeros(1,odors);
                    idxO = 0;
                    aurocs300ms = 0.5*ones(1,odors);
                    aurocs1s = 0.5*ones(1,odors);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        responsivenessExc300ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                        responsivenessExc1s(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        if responsivenessExc300ms(idxO) + responsivenessExc1s(idxO) > 0
                            logExc = [logExc; [idxExp, idxShank, idxUnit, idxOdor]];
                        end
                    end
                end
            end
        end
    end
end

%% Significant excitatory responses
indici = -3:5;
snipCellOdorSniff = [];
respCellOdorPairPSTHExcMnCoa1 = [];
A = [];
for idxEntry = 1:size(logExc,1)
    idxExp = logExc(idxEntry,1);
    idxShank = logExc(idxEntry,2);
    idxUnit = logExc(idxEntry,3);
    idxOdor = logExc(idxEntry,4);
    cartella = folderlist{idxExp};
    cd(cartella)
    load('breathing.mat', 'sniffs');
    A = single(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
    snipCellOdorSniff = [];
    for idxTrial = 1:10
        onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffOnsets(:,1) >= 0,1);
    end
    for idxSniff = 1:8
        app = [];
        for idxTrial = 1:10
            app(idxTrial,:) = A(idxTrial, 3900 + floor(sniffs(idxOdor).trial(idxTrial).sniffOnsets(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                3900 + floor(sniffs(idxOdor).trial(idxTrial).sniffOnsets(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
        end
        
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    respCellOdorPairPSTHExcMnCoa1(idxEntry,:) = slidePSTH(snipCellOdorSniff, 50, 5);
end
%%

odorsRearranged = 1:13;
odors = length(odorsRearranged);
esp = coaNM.esp;
espe = coaNM_1.espe;
folderlist = {esp(:).filename};

lratio = 5;
responsiveUnit300ms = 0;
responsiveUnit1s = 0;
responsiveUnitExc300ms = 0;
responsiveUnitInh300ms = 0;
responsiveUnitExc1s = 0;
responsiveUnitInh1s = 0;
cells = 0;
logExc = [];
logInh = [];
for idxExp = 1: length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    cells = cells + 1;
                    responsivenessExc300ms = zeros(1,odors);
                    responsivenessInh300ms = zeros(1,odors);
                    responsivenessExc1s = zeros(1,odors);
                    responsivenessInh1s = zeros(1,odors);
                    idxO = 0;
                    aurocs300ms = 0.5*ones(1,odors);
                    aurocs1s = 0.5*ones(1,odors);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        responsivenessExc300ms(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                        responsivenessExc1s(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        if responsivenessExc300ms(idxO) + responsivenessExc1s(idxO) > 0
                            logExc = [logExc; [idxExp, idxShank, idxUnit, idxOdor]];
                        end
                    end
                end
            end
        end
    end
end

%% Significant excitatory responses
indici = -3:5;
snipCellOdorSniff = [];
respCellOdorPairPSTHExcMnCoa2 = [];
A = [];
for idxEntry = 1:size(logExc,1)
    idxExp = logExc(idxEntry,1);
    idxShank = logExc(idxEntry,2);
    idxUnit = logExc(idxEntry,3);
    idxOdor = logExc(idxEntry,4);
    cartella = folderlist{idxExp};
            cd(fullfile(cartella, 'ephys'))
%     cd(cartella)
    load('breathing.mat', 'sniffs');
    A = single(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
    snipCellOdorSniff = [];
    for idxTrial = 1:10
        onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffOnsets(:,1) >= 0,1);
    end
    for idxSniff = 1:8
        app = [];
        for idxTrial = 1:10
            app(idxTrial,:) = A(idxTrial, 3900 + floor(sniffs(idxOdor).trial(idxTrial).sniffOnsets(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                3900 + floor(sniffs(idxOdor).trial(idxTrial).sniffOnsets(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
        end
        
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    respCellOdorPairPSTHExcMnCoa2(idxEntry,:) = slidePSTH(snipCellOdorSniff, 50, 5);
end





hold on
plot(mean([respCellOdorPairPSTHExcMnCoa1; respCellOdorPairPSTHExcMnCoa2]*20), 'color', coaC, 'linewidth', 1)
% plot(mean([respCellOdorPairPSTHExcMnCoa1; respCellOdorPairPSTHExcMnCoa2; respCellOdorPairPSTHExcMnPcx1(1:130,:)]), 'color', coaC, 'linewidth', 1)