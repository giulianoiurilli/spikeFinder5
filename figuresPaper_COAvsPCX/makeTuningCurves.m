function [tuningCurves, tuningCurvesSig, rho, rhoSig] = makeTuningCurves(esp, odors)

% esp = coa15.esp;
% odors = 1:15;

odorsRearranged = odors;
odors = length(odorsRearranged);
idxCell1 = 0;
idxCell2 = 0;


for idxesp = 1:length(esp) %
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app(idxO) = ~(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms==0); 
                end
                if sum(app) > 0
                    idxCell2 = idxCell2 + 1;
                end
            end
        end
    end
end

tuningCurves = 0.5 * ones(idxCell1, odors);
tuningCurvesSig = 0.5 * ones(idxCell2, odors);
cells = 0;
idxCell = 0;
for idxesp = 1:length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                cells = cells + 1;
                idxO = 0;
                app = [];
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    %tuningCurves(cells, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    tuningCurves(cells, idxO) = mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                        esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app(idxO) = ~(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms==0); 
                end
                if sum(app) > 0
                    idxCell = idxCell + 1;
                    tuningCurvesSig(idxCell,:) = tuningCurves(cells, :);
                end
            end
        end
    end
end

Y = [];
Z = [];
Y = pdist(tuningCurves);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurves,1));

%T = [];
%T = cluster(Z, 'maxclust', 2);
app = [];
app = [tuningCurves outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurves = app;

rho = 1-pdist(tuningCurves, 'correlation');
figure
A = squareform(rho);
clims = [-1 1];
imagesc(A, clims)
axis square
colormap(brewermap([],'*PuBuGn'))

Y = [];
Z = [];
Y = pdist(tuningCurvesSig);
Z = linkage(Y);
figure
[H, T, outperm] = dendrogram(Z, size(tuningCurvesSig,1));

%T = [];
%T = cluster(Z, 'maxclust', 2);
app = [];
app = [tuningCurvesSig outperm'];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesSig = app;

A = [];
rhoSig = 1-pdist(tuningCurvesSig, 'correlation');
figure
A = squareform(rhoSig);
clims = [-1 1];
imagesc(A, clims)
axis square
colormap(brewermap([],'*PuBuGn'))








