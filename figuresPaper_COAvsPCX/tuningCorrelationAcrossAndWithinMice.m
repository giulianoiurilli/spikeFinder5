function [corrAcross, corrSame] = tuningCorrelationAcrossAndWithinMice(esp, odorsRearranged)

corrAcross = zeros(1000, nchoosek(length(esp),2));   
for idxRep = 1:1000
tuningCurvesAcross = 0.5 * ones(length(esp), length(odorsRearranged));
cells = 0;

for idxesp = 1:length(esp) %- 1
    j = 0;
    while j == 0
        idxShank = floor(randi(4));
        n_units  = length(esp(idxesp).shankNowarp(idxShank).cell);
        idxUnit = floor(randi(n_units));
           if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                j = 1;
                cells = cells + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCurvesAcross(cells, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
           end
    end
end
corrApp = triu(corr(tuningCurvesAcross'), 1);
corrApp = corrApp(:);
corrApp(corrApp==0) = [];
corrAcross(idxRep,:) = corrApp';
end
corrAcross = corrAcross(:);


corrSame = zeros(1000, length(esp));
for idxRep = 1:1000
for idxesp = 1:length(esp) %- 1
    tuningCurvesSame = 0.5 * ones(2, length(odorsRearranged));
    j = 0;
    cells = 0;
    while j < 2
        idxShank = floor(randi(4));
        n_units  = length(esp(idxesp).shankNowarp(idxShank).cell);
        listUnits = 1:n_units;
        idxUnit = randsample(listUnits,1);
        listUnits(idxUnit) = [];
           if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                j = j + 1;
                cells = cells + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCurvesSame(cells, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
           end
    end  
    corrApp = corr(tuningCurvesSame');
    corrSame(idxRep, idxesp) = corrApp(2);
end
end
corrSame = corrSame(:);