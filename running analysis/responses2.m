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
            %odorsRearranged = keepNewOrder(idxExp,:);
            for idxOdor = odorsRearranged
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05
                    p300 = 1;
                    else p300 = 0;
                end
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05
                    p1000 = 1;
                    else p1000 = 0;
                end
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms > 0.75
                    r300E = 1;
                    else r300E = 0;
                end
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.75
                    r1000E = 1;
                    else r1000E = 0;
                end
                if (p300 + r300E) == 2
                    respE300 = 1;
                    else respE300 = 0;
                end
                if (p1000 + r1000E) == 2
                    respE1000 = 1;
                    else respE1000 = 0;
                end                
                if (respE300 + respE1000) > 0
                    cellOdorPairExc = cellOdorPairExc + 1;
                    newEntry = [idxExp idxShank idxUnit idxOdor];
                    logExc = [logExc; newEntry];
                end
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms < 0.35
                    r300I = 1;
                    else r300I = 0;
                end
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms < 0.35
                    r1000I = 1;
                    else r1000I = 0;
                end
                if (p300 + r300I) == 2
                    respI300 = 1;
                    else respI300 = 0;
                end
                if (p1000 + r1000I) == 2
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
    R1000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
    B1000ms  = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
    rocExcR1000ms(idxEntry) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
    deltaExcR1000ms(idxEntry) = mean(R1000ms - B1000ms);
    ffExcR1000ms(idxEntry) = var(R1000ms) ./ mean(R1000ms);
    cvExcR1000ms(idxEntry) = std(R1000ms) ./ mean(R1000ms);
end

%% Significant inhibitory responses
indici = -4:10;
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
        for idxTrial = 1:10
            app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
        end
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    [respCellOdorPairPSTHInhMn(idxEntry,:), respCellOdorPairPSTHInhSd(idxEntry,:), respCellOdorPairPSTHInhFF(idxEntry,:), respCellOdorPairPSTHInhCV(idxEntry,:)] = slidePSTH(snipCellOdorSniff, 50, 5);
    R1000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
    B1000ms  = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
    rocInhR1000ms(idxEntry) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
    deltaInhR1000ms(idxEntry) = mean(R1000ms - B1000ms);
    ffInhR1000ms(idxEntry) = var(R1000ms) ./ mean(R1000ms);
    cvInhR1000ms(idxEntry) = std(R1000ms) ./ mean(R1000ms);
end


%%
cd(folder)
save('responses.mat', 'respCellOdorPairPSTHExcMn', 'respCellOdorPairPSTHExcSd', 'respCellOdorPairPSTHExcFF', 'respCellOdorPairPSTHExcCV',...
    'respCellOdorPairPSTHInhMn', 'respCellOdorPairPSTHInhSd', 'respCellOdorPairPSTHInhFF', 'respCellOdorPairPSTHInhCV', 'rocExcR1000ms', 'deltaExcR1000ms', 'ffExcR1000ms',...
    'rocInhR1000ms', 'deltaInhR1000ms', 'ffInhR1000ms', 'cvExcR1000ms', 'cvInhR1000ms', '-append')
                    