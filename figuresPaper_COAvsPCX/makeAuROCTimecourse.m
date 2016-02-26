function [auRocTC, tracce, cellLogExcitatoryResponse] = makeAuROCTimecourse(esp, espe, odors)
%%


odorsRearranged = odors;
odors = length(odorsRearranged);
%%
cellLogExcitatoryResponse = [];
cells = 0;
for idxExp = 1: length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessExc1000ms = zeros(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc300ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsivenessExc1000ms(idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                end
                if sum(responsivenessExc1000ms + responsivenessExc300ms) > 0
                    app = [];
                    app = [idxExp, idxShank, idxUnit, idxO];
                    cellLogExcitatoryResponse = [cellLogExcitatoryResponse; app];
                end
            end
            
        end
    end
end






%%
auRocTC = 0.5*ones(size(cellLogExcitatoryResponse,1), 120);
tracce = 0.5*ones(size(cellLogExcitatoryResponse,1), 120);
ref = zeros(10, 60);
bsl = zeros(10, 60);
rsp = zeros(10, 60);
bslAuROC = 0.5*ones(1, 60);
rspAuROC = 0.5*ones(1, 60);
smoothedPSTH = [];
for idxEntry = 1:size(cellLogExcitatoryResponse,1)
    idxExp = cellLogExcitatoryResponse(idxEntry,1);
    idxShank = cellLogExcitatoryResponse(idxEntry,2);
    idxUnit = cellLogExcitatoryResponse(idxEntry,3);
    idxOdor = cellLogExcitatoryResponse(idxEntry,4);
    spikeMatrixApp = single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(:,15*1000-600+51:15*1000+300+51));
    [~,~,~,~,smoothedPSTH] = slidePSTH(spikeMatrixApp, 50, 5);
    ref = smoothedPSTH(:,1:60);
    bsl = smoothedPSTH(:,61:120);
    rsp = smoothedPSTH(:,121:180);
    for idxTimeBin = 1:size(rsp,2)
        bslAuROC(idxTimeBin) = findAuROC(ref(:,idxTimeBin), bsl(:,idxTimeBin), 0);
        rspAuROC(idxTimeBin) = findAuROC(ref(:,idxTimeBin), rsp(:,idxTimeBin), 0);
    end
    auRocTC(idxEntry,:) = [bslAuROC, rspAuROC];
    tracce(idxEntry,:) = [mean(bsl), mean(rsp)];
end









                