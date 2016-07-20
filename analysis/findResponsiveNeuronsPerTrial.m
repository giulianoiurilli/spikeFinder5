function [responseCell1All, fR, fRmean, fRsem]  = findResponsiveNeuronsPerTrial(esp, odors)


odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = zeros(1,10);
                    if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                        app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).trialExcPeak1000ms);
                    else
                        app = zeros(1,10);
                    end
                    responseCell1All(idxCell1,:,idxO) = app;
                end
            end
        end
    end
end
app = reshape(responseCell1All, idxCell1, 10*odors);
fR = sum(app)./idxCell1;
fRmean = mean(fR);
fRsem = std(fR) ./ sqrt(numel(fR)-1);
