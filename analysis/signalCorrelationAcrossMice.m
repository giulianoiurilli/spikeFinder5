function [D300, D1000] = signalCorrelationAcrossMice(esp, odors)

D300 = [];
D1000 = [];

for idxShank = 1:4
    idxCell = 0;
    A300MUA = nan*ones(length(odors),length(esp));
    A1000MUA = nan*ones(length(odors),length(esp));
    for idxesp = 1: length(esp)
        A300 = nan*ones(1,length(odors));
        A1000 = nan*ones(1,length(odors));
        auroc300 = zeros(1,length(odors));
        auroc1000 = zeros(1,length(odors));
        auroc300S = zeros(1,length(odors));
        auroc1000S = zeros(1,length(odors));
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell = idxCell + 1;
                idxO = 0;  
                for idxOdor = odors
                    idxO = idxO + 1;
                    A300(idxCell,idxO) = trimmean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms,50)- trimmean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms,50);
                    A1000(idxCell,idxO) = trimmean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms,50)- trimmean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms,50);
                    auroc300(idxCell,idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    auroc1000(idxCell,idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    auroc300S(idxCell,idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    auroc1000S(idxCell,idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                end
                A300(idxCell,auroc300S(idxCell,:) == 0) = 0;
                A1000(idxCell,auroc1000S(idxCell,:) == 0) = 0;
                A300(idxCell,:) = (A300(idxCell,:) - min(A300(idxCell,:))) ./ (max(A300(idxCell,:)) - min(A300(idxCell,:)));
                A1000(idxCell,:) = (A1000(idxCell,:) - min(A1000(idxCell,:))) ./ (max(A1000(idxCell,:)) - min(A1000(idxCell,:)));
            end
        end
        A300MUA(:,idxesp) = nanmean(A300,1)';
        A1000MUA(:,idxesp) = nanmean(A1000,1)';
%         A300MUA(:,idxesp) = nansum(auroc300,1)'./ size(auroc300,1);
%         A1000MUA(:,idxesp) = nansum(auroc1000,1)' ./ size(auroc1000,1);
    end
    app = isnan(A1000MUA);
    A1000MUAnotNan = A1000MUA(~app);
    A1000MUAnotNan = reshape(A1000MUAnotNan,numel(odors), length(A1000MUAnotNan)/numel(odors));
    app = isnan(A300MUA);
    A300MUAnotNan = A300MUA(~app);
    A300MUAnotNan = reshape(A300MUAnotNan,numel(odors), length(A300MUAnotNan)/numel(odors));
    D300{idxShank} = 1-pdist(A300MUAnotNan, 'spearman');
    D1000{idxShank} = 1-pdist(A1000MUAnotNan, 'spearman');
end