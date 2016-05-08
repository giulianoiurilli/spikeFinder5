
odorsRearranged = 1:15;
% odorsRearranged = 1:8;
% odorsRearranged = 1:4;
odors = length(odorsRearranged);
%%
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
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 
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
                    responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsivenessInh300ms(idxO) = abs(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms) == 1;
                    responsivenessExc1s(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    responsivenessInh1s(idxO) = abs(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                    if responsivenessExc300ms(idxO) + responsivenessExc1s(idxO) > 0
                        logExc = [logExc; [idxExp, idxShank, idxUnit, idxOdor]];
                    end
                    if responsivenessInh300ms(idxO) + responsivenessInh1s(idxO) > 0
                        logInh = [logInh; [idxExp, idxShank, idxUnit, idxOdor]];
                    end
                end
            end
        end
    end
end

%% Significant excitatory responses
indici = -4:10;
snipCellOdorSniff = [];
respCellOdorPairPSTHExcMn = [];
A = [];
for idxEntry = 1:size(logExc,1)
    idxExp = logExc(idxEntry,1);
    idxShank = logExc(idxEntry,2);
    idxUnit = logExc(idxEntry,3);
    idxOdor = logExc(idxEntry,4);
    cartella = List{idxExp};
    cd(cartella)
    load('breathing.mat', 'sniffs');
    A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
    snipCellOdorSniff = [];
    for idxTrial = 1:10
        onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
    end
    for idxSniff = 1:15
        app = [];
        for idxTrial = 1:10
            app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
        end
        
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    respCellOdorPairPSTHExcMn(idxEntry,:) = slidePSTH(snipCellOdorSniff, 50, 5);
end

%% Significant inhibitory responses
indici = -4:10;
snipCellOdorSniff = [];
respCellOdorPairPSTHInhMn = [];
A = [];
for idxEntry = 1:size(logInh,1)
    idxExp = logInh(idxEntry,1);
    idxShank = logInh(idxEntry,2);
    idxUnit = logInh(idxEntry,3);
    idxOdor = logInh(idxEntry,4);
    cartella = List{idxExp};
    cd(cartella)
    load('breathing.mat', 'sniffs');
    A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
    snipCellOdorSniff = [];
    for idxTrial = 1:10
        onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
    end
    for idxSniff = 1:15
        app = [];
        for idxTrial = 1:10
            app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
        end
        
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    respCellOdorPairPSTHInhMn(idxEntry,:) = slidePSTH(snipCellOdorSniff, 50, 5);
end

%%
% pcx15psthExc = respCellOdorPairPSTHExcMn;
% pcx15psthInh = respCellOdorPairPSTHInhMn;
% pcxAApsthExc = respCellOdorPairPSTHExcMn;
% pcxAApsthInh = respCellOdorPairPSTHInhMn;
% 
% coa15psthExc = respCellOdorPairPSTHExcMn;
% coa15psthInh = respCellOdorPairPSTHInhMn;
coaAApsthExc = respCellOdorPairPSTHExcMn;
coaAApsthInh = respCellOdorPairPSTHInhMn;