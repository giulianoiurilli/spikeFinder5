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
                
%                 if (p300) == 1
%                     respE300 = 1;
%                     else respE300 = 0;
%                 end
%                 if (p1000) == 1
%                     respE1000 = 1;
%                     else respE1000 = 0;
%                 end
                
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
%     if idxExp == 2
%         for idxTrial = 1:5
%             onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%         end
%     else
        for idxTrial = 1:10
            onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
        end
%     end
    for idxSniff = 1:15
%         if idxExp == 2
%             for idxTrial = 1:5
%                 app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                     15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
%             end
%         else
            for idxTrial = 1:10
                app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                    15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
            end
%         end
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
%     if idxExp == 2
%         for idxTrial = 1:5
%             onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%         end
%     else
        for idxTrial = 1:10
            onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
        end
%     end
    for idxSniff = 1:15
%         if idxExp == 2
%             for idxTrial = 1:5
%                 app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                     15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
%             end
%         else
            for idxTrial = 1:10
                app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                    15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
            end
%         end
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
% indici = -4:10;
% for idxEntry = 1:size(logExc,1)
%     idxExp = logExc(idxEntry,1);
%     idxShank = logExc(idxEntry,2);
%     idxUnit = logExc(idxEntry,3);
%     idxOdor = logExc(idxEntry,4);
%     cartella = List{idxExp};
%     cartella = cartella(end-11:end);
%     prima = '/Volumes/Tetrodes Backup1/15odors/aPCX';
%     cartella = fullfile(prima,cartella);
%     cd(cartella)
%     load('breathSniffs.mat', 'sniffs');
%     A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
%     snipCellOdorSniff = [];
%     if idxExp == 7
%         for idxTrial = 1:5
%             onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%         end
%     else
%         for idxTrial = 1:10
%             onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%         end
%     end
%     for idxSniff = 1:15
%         if idxExp == 7
%             for idxTrial = 1:5
%                 app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                     15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
%             end
%         else
%             for idxTrial = 1:10
%                 app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                     15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
%             end
%         end
%         snipCellOdorSniff(idxSniff,:) = slidePSTH(app, 50, 5);
%     end
%     respCellOdorPairPSTHExc1(idxEntry,:) = reshape(snipCellOdorSniff',1,size(snipCellOdorSniff,1) * size(snipCellOdorSniff,2));
% end

%%
% countOdorSniff = zeros(size(cellLogExc1,1),odors,15);
% for idxEntry = 1:size(cellLogExc1,1)
%     idxExp = cellLogExc1(idxEntry,1);
%     idxShank = cellLogExc1(idxEntry,2);
%     idxUnit = cellLogExc1(idxEntry,3);
%     cartella = List{idxExp};
%     cd(cartella)
%     load('breathing.mat', 'sniffs');
%     for idxOdor = 1:odors
%         A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
%         
%         if idxExp == 2
%             for idxTrial = 1:5
%                 onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%             end
%         else
%             for idxTrial = 1:10
%                 onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%             end
%         end
%         for idxSniff = 1:15
%             if idxExp == 2
%                 for idxTrial = 1:5
%                     app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                         15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
%                 end
%             else
%                 for idxTrial = 1:10
%                     app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                         15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
%                 end
%             end
%             countOdorSniff(idxEntry,idxOdor,idxSniff) = mean(sum(app,2));
%         end
%     end
% end

% %%
% countOdorSniff = zeros(cells,odors,15);
% neuron = 0;
% for idxExp = 1: length(esp) %- 1
%     cartella = List{idxExp};
%     cd(cartella)
%     load('breathing.mat', 'sniffs');
%     for idxShank = 1:4
%         for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
%             if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
%                 neuron = neuron + 1;
%                 idxO = 0;
%                 %odorsRearranged = keepNewOrder(idxExp,:);
%                 for idxOdor = odorsRearranged
%                     idxO = idxO + 1;
%                     A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
% %                     if idxExp == 2
% %                         for idxTrial = 1:5
% %                             onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
% %                         end
% %                     else
%                         for idxTrial = 1:10
%                             onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%                         end
% %                     end
%                     for idxSniff = 1:15
% %                         if idxExp == 2
% %                             for idxTrial = 1:5
% %                                 app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
% %                                     15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
% %                             end
% %                         else
%                             for idxTrial = 1:10
%                                 app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                                     15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
%                             end
% %                         end
%                         countOdorSniff(neuron,idxO,idxSniff) = mean(sum(app,2));
%                     end
%                 end
%             end
%         end
%     end
% end
% %%
%   
% for idxSniff = 1:15
%     Bapp = squeeze(countOdorSniff(:,:,idxSniff));
%     for idxRep = 1:1000
%         idxCell = randsample(size(Bapp,1), 100);
%         B = Bapp(idxCell,:);
%         B = B';
%         B = zscore(B);
%         distSniff(idxRep, idxSniff) = nanmean(pdist(B, 'correlation'));
%     end
% end
% distSniff = nanmean(distSniff);        
% distSniffNorm = (distSniff ./ nanmean(distSniff(1:4)) - 1).*100;

%%
cd(folder)
save('responses.mat', 'respCellOdorPairPSTHExcMn', 'respCellOdorPairPSTHExcSd', 'respCellOdorPairPSTHExcFF', 'respCellOdorPairPSTHExcCV',...
    'respCellOdorPairPSTHInhMn', 'respCellOdorPairPSTHInhSd', 'respCellOdorPairPSTHInhFF', 'respCellOdorPairPSTHInhCV', 'rocExcR1000ms', 'deltaExcR1000ms', 'ffExcR1000ms',...
    'rocInhR1000ms', 'deltaInhR1000ms', 'ffInhR1000ms', 'cvExcR1000ms', 'cvInhR1000ms', '-append')
                    