cellOdorPairExc = 0;
cellOdorPairInh = 0;
logExc = [];
logInh = [];
for idxExp = unique(cellLogExc1(:,1))'
    cartella = List{idxExp};
    cd(cartella)
    load('breathing.mat', 'sniffs');
    k = size(sniffs(1).trial);
    ripetizioni(idxExp) = k(2);
    expApp = cellLogExc1(cellLogExc1(:,1)==idxExp,:);
    for idxShank = unique(expApp(:,2))'
        shankApp = expApp(expApp(:,2)==idxShank,:);
        for idxUnit = unique(shankApp(:,3))'
            for idxOdor = odorsRearranged
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1
                    respE300 = 1;
                    else respE300 = 0;
                end
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                    respE1000 = 1;
                    else respE1000 = 0;
                end            
                if (respE300 + respE1000) > 0
                    cellOdorPairExc = cellOdorPairExc + 1;
                    newEntry = [idxExp idxShank idxUnit idxOdor];
                    logExc = [logExc; newEntry];
                end
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1
                    respI300 = 1;
                    else respI300 = 0;
                end
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1
                    respI1000 = 1;
                    else respI1000 = 0;
                end
                if (respI300 + respI1000) > 0
                    cellOdorPairInh = cellOdorPairInh + 1;
                    newEntry = [idxExp idxShank idxUnit idxOdor];
                    logInh = [logInh; newEntry];
                end
            end
        end
    end
end
data = [];
%% Significant excitatory responses
indici = -4:10;
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
        for idxTrial = 1:10
            app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
        end
        
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    [respCellOdorPairPSTHExcMn(idxEntry,:), respCellOdorPairPSTHExcSd(idxEntry,:), respCellOdorPairPSTHExcFF(idxEntry,:), respCellOdorPairPSTHExcCV(idxEntry,:)] = slidePSTH(snipCellOdorSniff, 50, 5);
    data(idxEntry).spikes = logical(snipCellOdorSniff);
end
