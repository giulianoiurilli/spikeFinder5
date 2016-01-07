cellOdorPairExc = 0;
cellOdorPairInh = 0;
logExc = [];
logInh = [];
for idxExp = unique(cellLogExc1(:,1))'
    cartella = List{idxExp};
    cartella = cartella(end-11:end);
    prima = '/Volumes/Tetrodes Backup1/aveatt/plCOA';
    cartella = fullfile(prima,cartella);
    cd(cartella)
    load('breathSniffs.mat', 'sniffs');
    k = size(sniffs(1).trial);
    ripetizioni(idxExp) = k(2);
    expApp = cellLogExc1(cellLogExc1(:,1)==idxExp,:);
    for idxShank = unique(expApp(:,2))'
        shankApp = expApp(expApp(:,2)==idxShank,:);
        for idxUnit = unique(shankApp(:,3))'
            for idxOdor = 1:length(odorsRearranged)
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
                    logInh = [logExc; newEntry];
                end
            end
        end
    end
end


%%
% cattura = [];
% v = [5 1 1; 5 1 11; 5 4 1];
% for idxV = 1:3
%     for idxEntry = 1:size(logExc,1)
%         if isequal(logExc(idxEntry,1:3), v(idxV,:))
%             cattura = [cattura idxEntry];
%         end
%     end
% end
% 
% logExc(cattura,:) = [];   
%%
indici = -4:10;
for idxEntry = 1:size(logExc,1)
    idxExp = logExc(idxEntry,1);
    idxShank = logExc(idxEntry,2);
    idxUnit = logExc(idxEntry,3);
    idxOdor = logExc(idxEntry,4);
    cartella = List{idxExp};
    cartella = cartella(end-11:end);
    cartella = fullfile(prima,cartella);
    cd(cartella)
    load('breathSniffs.mat', 'sniffs');
    A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
    snipCellOdorSniff = [];
    if idxExp == 7
        for idxTrial = 1:5
            onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
        end
    else
        for idxTrial = 1:10
            onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
        end
    end
    for idxSniff = 1:15
        if idxExp == 7
            for idxTrial = 1:5
                app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                    15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
            end
        else
            for idxTrial = 1:10
                app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                    15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
            end
        end
        snipCellOdorSniff = [snipCellOdorSniff app];
    end
    respCellOdorPairPSTHExc(idxEntry,:) = slidePSTH(snipCellOdorSniff, 50, 5);
end


%%
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
countOdorSniff = zeros(size(cellLogExc1,1),10,15);
for idxEntry = 1:size(cellLogExc1,1)
    idxExp = cellLog1(idxEntry,1);
    idxShank = cellLog1(idxEntry,2);
    idxUnit = cellLog1(idxEntry,3);
    cartella = List{idxExp};
    cartella = cartella(end-11:end);
    cartella = fullfile(prima,cartella);
    cd(cartella)
    load('breathSniffs.mat', 'sniffs');
    for idxOdor = 1:odors
        A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
        
        if idxExp == 7
            for idxTrial = 1:5
                onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
            end
        else
            for idxTrial = 1:10
                onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
            end
        end
        for idxSniff = 1:15
            if idxExp == 7
                for idxTrial = 1:5
                    app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                        15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
                end
            else
                for idxTrial = 1:10
                    app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
                        15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 299);
                end
            end
            countOdorSniff(idxEntry,idxOdor,idxSniff) = mean(sum(app,2));
        end
    end
end

%%

    
for idxSniff = 1:15
    Bapp = squeeze(countOdorSniff(:,:,idxSniff));
    for idxRep = 1:1000
        idxCell = randsample(size(Bapp,1), size(Bapp,1));
        B = Bapp(idxCell,:);
        B = B';
        %B = zscore(B);
        distSniff(idxRep, idxSniff) = mean(pdist(B, 'correlation'));
    end
end
distSniff = nanmean(distSniff);        
distSniffNorm = (distSniff ./ nanmean(distSniff(1:4)) - 1).*100;

%%
% for idxExp = unique(cellLogExc1(:,1))'
%     cartella = List{idxExp};
%     cd(cartella)
%     load('breathing.mat', 'sniffs');
%     
%     expApp = cellLogExc1(cellLogExc1(:,1)==idxExp,:);   
%     for idxShank = unique(expApp(:,2))'
%         shankApp = expApp(expApp(:,2)==idxShank,:);
%         for idxUnit = unique(shankApp(:,3))'
%             for idxOdor = 1:7
%                 if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05
%                     p300 = 1;
%                     else p300 = 0;
%                 end
%                 if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05
%                     p1000 = 1;
%                     else p1000 = 0;
%                 end
%                 if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms > 0.75
%                     r300E = 1;
%                     else r300E = 0;
%                 end
%                 if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.75
%                     r1000E = 1;
%                     else r1000E = 0;
%                 end
%                 if (p300 + r300E) == 2
%                     respE300 = 1;
%                     else respE300 = 0;
%                 end
%                 if (p1000 + r1000E) == 2
%                     respE1000 = 1;
%                     else respE1000 = 0;
%                 end
%                 if (respE300 + respE1000) > 0
%                     respE = 1;
%                     else respE = 0;
%                 end
%                 if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms < 0.35
%                     r300I = 1;
%                     else r300I = 0;
%                 end
%                 if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms < 0.35
%                     r1000I = 1;
%                     else r1000I = 0;
%                 end
%                 if (p300 + r300I) == 2
%                     respI300 = 1;
%                     else respI300 = 0;
%                 end
%                 if (p1000 + r1000I) == 2
%                     respI1000 = 1;
%                     else respI1000 = 0;
%                 end
%                 if (respI300 + respI1000) > 0
%                     respI = 1;
%                     else respI = 0;
%                 end
%                 if idxExp == 7
%                     for idxTrial = 1:5
%                         onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%                     end
%                 else
%                     
%                     for idxTrial = 1:10
%                         onsets(idxTrial) = find(sniffs(idxOdor).trial(idxTrial).sniffPower(:,1) >= 0,1);
%                     end
%                 end
%                 if respE == 1
%                     A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
%                     indici = -4:10;
%                     for idxSniff = 1:15
%                         if idxExp == 7
%                             for idxTrial = 1:5
%                                 app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                                     15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 300);
%                             end
%                         else
%                             for idxTrial = 1:10
%                                 app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) :...
%                                     15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) + indici(idxSniff),1)*1000) + 300);
%                             end
%                         end
%                         snipCellOdorSniff(idxSniff,:) = slidePSTH(app, 50, 5);
%                     end
%                     respCellOdorPairPSTHExc(cellOdorPairExc,:) = reshape(snipCellOdorSniff, 1, size(snipCellOdorSniff,1) * size(snipCellOdorSniff,2));
%                 end
% %                 if respI == 1
% %                     A = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix);
% %                     indici = -4:10;
% %                     for idxSniff = 1:15
% %                         for idxTrial = 1:10
% %                             app(idxTrial,:) = A(idxTrial, 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) - indici(idxSniff),1)*1000) :...
% %                                 15000 + floor(sniffs(idxOdor).trial(idxTrial).sniffPower(onsets(idxTrial) - indici(idxSniff),1)*1000) + 300);
% %                         end
% %                         snipCellOdorSniff(idxSniff,:) = slidePSTH(app, 50, 5);
% %                     end
% %                     respCellOdorPairPSTHInh(cellOdorPairInh,:) = reshape(snipCellOdorSniff, 1, size(snipCellOdorSniff,1) * size(snipCellOdorSniff,2));
% %                 end
%             end
%         end
%     end
% end
% 
%                                 
%                         
%                     