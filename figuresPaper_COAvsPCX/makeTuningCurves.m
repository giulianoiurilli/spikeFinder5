function [tuningCurves] = makeTuningCurves(esp, odors, tot_units)



odorsRearranged = odors;
odors = length(odorsRearranged);
tuningCurves = 0.5 * ones(tot_units, odors);
cells = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCurves(cells, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
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






