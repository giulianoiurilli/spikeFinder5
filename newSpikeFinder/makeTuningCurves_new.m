function [tuningCurves, tuningCurvesSig, rho, rhoSig] = makeTuningCurves_new(esp, odors)

% esp = pcx15.esp;
% odors = 1:15;

odorsRearranged = odors;
odors = length(odorsRearranged);
idxCell1 = 0;
idxCell2 = 0;


for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    idxCell1 = idxCell1 + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        app(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(app) > 0
                        idxCell2 = idxCell2 + 1;
                    end
                end
            end
        end
    end
end
%%
tuningCurves = 0.5 * ones(idxCell1, odors);
tuningCurvesSig = 0.5 * ones(idxCell2, odors);
cells = 0;
idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    cells = cells + 1;
                    idxO = 0;
                    app = [];
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        tuningCurves(cells, idxO) = mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) -...
                            mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                        app(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(app) > 0
                        idxCell = idxCell + 1;
                        tuningCurvesSig(idxCell,:) = tuningCurves(cells, :);
                    end
                end
            end
        end
    end
end
%%
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








