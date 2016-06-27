function [H, nH, odorS] = findCategorySelectivity(esp, odorsRearranged, opt)
idxCell1 = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
            end
        end
    end
end

H = nan(1,idxCell1);
nH = nan(1,idxCell1);
odorS = nan(1,idxCell1);

if opt == 1;
idxCell1 = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                appSigResponses = nan(1,15);
                for idxOdor = odorsRearranged
                    appSigResponses(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                end
                if sum(appSigResponses) == 1;
                    odorS(idxCell1) = find(appSigResponses==1);
                end
                appSigResponses = reshape(appSigResponses, 5, 3);
                appSigResponses = appSigResponses';
                pApp = sum(appSigResponses);
                H(idxCell1) = sum(pApp>0);
                if sum(pApp>0) == 1
                    [x, y] = find(appSigResponses>0);
                    nH(idxCell1) = numel(x);
                end
            end
        end
    end
end
end

if opt == 2;
    idxCell1 = 0;
    for idxesp = 1:length(esp)
        for idxShank = 1:4
            for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
                if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                    idxCell1 = idxCell1 + 1;
                    appSigResponses = nan(1,10);
                    for idxOdor = odorsRearranged
                        appSigResponses(1,idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(appSigResponses) == 1;
                        odorS(idxCell1) = find(appSigResponses==1);
                    end
                    appSigResponses = reshape(appSigResponses, 2, 5);
                    appSigResponses = appSigResponses';
                    pApp = sum(appSigResponses);
                    H(idxCell1) = sum(pApp>0);
                    if sum(pApp>0) == 1
                        [x, y] = find(appSigResponses>0);
                        nH(idxCell1) = numel(x);
                    end
                end
            end
        end
    end
end

                