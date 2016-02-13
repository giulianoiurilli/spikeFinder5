function [tuningCurves] = makeTuningCurves(esp, odors)


odorsRearranged = odors;
odors = length(odorsRearranged);
idxCell1 = 0;

esperimenti = [3:8, 12:13, 15];
for idxesp = esperimenti%1:length(esp) %
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                end
            end
        end
    end
end

tuningCurves = 0.5 * ones(idxCell1, odors);
cells = 0;
for idxesp = esperimenti%1:length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                cells = cells + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCurves(cells, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
end

Y = [];
Z = [];
Y = pdist(tuningCurves);
Z = linkage(Y);
[H, T, outperm] = dendrogram(Z);


app = [];
app = [tuningCurves T];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurves = app;






