%% make tuning curves for PCX
odorsRearranged = 1:15;
odors = length(odorsRearranged);
tuningCurves15Pcx = 0.5 * ones(pcxR.tot_units, odors);
cells = 0;
for idxExp = 1: length(pcx2.esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(pcx2.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCurves15Pcx(cells, idxO) = pcx2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
end

Y = [];
Z = [];
Y = pdist(tuningCurves15Pcx);
Z = linkage(Y);
[H, T, outperm] = dendrogram(Z);


app = [];
app = [tuningCurves15Pcx T];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurves15Pcx = app;

%% make tuning curves for COA
odorsRearranged = 1:15;
odors = length(odorsRearranged);
tuningCurves15Coa = 0.5 * ones(coaR.tot_units, odors);
cells = 0;
for idxExp = 1: length(coa2.esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxExp).shankNowarp(idxShank).cell)
            if coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCurves15Coa(cells, idxO) = coa2.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
end

Y = [];
Z = [];
Y = pdist(tuningCurves15Coa);
Z = linkage(Y);
[H, T, outperm] = dendrogram(Z);


app = [];
app = [tuningCurves15Coa T];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurves15Coa = app;

%% find proportion of activating odors





