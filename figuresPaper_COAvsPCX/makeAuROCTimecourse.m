function [auRocTC, cellLogExcitatoryResponse] = makeAuROCTimecourse(esp, espe, odors)
%%


odorsRearranged = odors;
odors = length(odorsRearranged);
%%


responsiveUnitExc1s = 0;
cellLogExcitatoryResponse = [];
cells = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessExc1000ms = zeros(1,odors);
                idxO = 0;
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc300ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc1000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs300ms =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    %vincolo reliability
                    responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                    responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                    if responsivenessExc1000ms + responsivenessExc300ms > 0
                        app = [];
                        app = [idxExp, idxShank, idxUnit, idxO];
                        cellLogExcitatoryResponse = [cellLogExcitatoryResponse; app];
                    end
                end
                
            end
        end
    end
end





%%
auRocTC = 0.5*ones(size(cellLogExcitatoryResponse,1), 60);
for idxEntry = 1:size(cellLogExcitatoryResponse,1)
    idxExp = cellLogExcitatoryResponse(idxEntry,1);
    idxShank = cellLogExcitatoryResponse(idxEntry,2);
    idxUnit = cellLogExcitatoryResponse(idxEntry,3);
    idxOdor = cellLogExcitatoryResponse(idxEntry,4);
    spikeMatrixApp = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(:,15*1000-600+51:15*1000+300+51));
    smoothedPSTH = [];
    [~,~,~,~,smoothedPSTH] = slidePSTH(spikeMatrixApp, 50, 5);
    bsl = smoothedPSTH(:,1:60);
    rsp = smoothedPSTH(:,61:180);
    for idxTimeBin = 1:size(rsp,2)
        bslAuROC(idxTimeBin) = findAuROC(bsl(idxTimeBin), bsl(idxTimeBin));
        rspAuROC(idxTimeBin) = findAuROC(bsl(idxTimeBin), rsp(idxTimeBin));
    end
    auRocTC(idxEntry,:) = [bslAuROC, rspAuROC];
end









                