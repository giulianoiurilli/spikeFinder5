

lista = [];
odors = 1:15;
for k = 1:150
    app = odors;
    list = [];
    for j = 1:4
        idx = randperm(size(app,2));
        app = app(idx);
        list = [list app(1:3)];
        app = app(4:end);
    end
    list = [list app];
    lista(k,:) = list;
end
nullDistCoa = nan(150,5);
for idxRep = 1:150
    [HchemicalCoa1, nHchemicalCoa1, odorS15Coa1, idxSingleClass15Coa1, idxMultipleclass15Coa1, n_classesCell15Coa1] = findCategorySelectivity_new(coa15.esp, lista(idxRep,:), 1);
    [HchemicalPcx1, nHchemicalPcx1, odorS15Pcx1, idxSingleClass15Pcx1, idxMultipleclass15Pcx1, n_classesCell15Pcx1] = findCategorySelectivity_new(pcx15.esp, lista(idxRep,:), 1);
    edges1 = 0.5:1:5.5;
    app2Coa = n_classesCell15Coa1(:,1);
    app2Coa(app2Coa==0) = [];
    nullDistCoa(idxRep,:) = histcounts(app2Coa,  edges1, 'normalization', 'probability');
    app2Pcx = n_classesCell15Pcx1(:,1);
    app2Pcx(app2Pcx==0) = [];
    nullDistPcx(idxRep,:) = histcounts(app2Pcx,  edges1, 'normalization', 'probability');
end

mean_nullDistCoa = mean(nullDistCoa);
mean_nullDistPcx = mean(nullDistPcx);
sem_nullDistCoa = std(nullDistCoa)./sqrt((size(nullDistCoa,1))-1);
sem_nullDistPcx = std(nullDistPcx)./sqrt((size(nullDistPcx,1))-1);

odorsRearranged = 1:15;
[HchemicalCoa, nHchemicalCoa, odorS15Coa, idxSingleClass15Coa, idxMultipleclass15Coa, n_classesCell15Coa] = findCategorySelectivity_new(coa15.esp, odorsRearranged, 1);
[HchemicalPcx, nHchemicalPcx, odorS15Pcx, idxSingleClass15Pcx, idxMultipleclass15Pcx, n_classesCell15Pcx] = findCategorySelectivity_new(pcx15.esp, odorsRearranged, 1);




%%
n_comb = nchoosek(10,5)/2;
odorsRearranged2Coa = nan*ones(n_comb,10);
odorsRearranged2Pcx = nan*ones(n_comb,10);
combinations = combnk(1:10, 5);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = [4     6     7     9    10     1     2     3     5     8];
odorsRearrangedPcx =  [4     6     7     9    10     1     2     3     5     8];

for idxRep = 1:n_comb
[HvalenceCoa1, nHaaCoa1, odorSaaCoa1, idxSingleClassaaCoa1, idxMultipleclassaaCoa1, n_classesCellaaCoa1] = findCategorySelectivity_new(coaAA.esp, combinations(idxRep,:), 2);
[HvalencePcx1, nHaaPcx1, odorSaaPcx1, idxSingleClassaaPcx1, idxMultipleclassaaPcx1, n_classesCellaaPcx1] = findCategorySelectivity_new(pcxAA.esp, combinations(idxRep,:), 2);
edges1 = 0.5:1:2.5;
app1aaCoa = n_classesCellaaCoa1(:,1);
app1aaCoa(app1aaCoa==0) = [];
app1aaPcx = n_classesCellaaPcx1(:,1);
app1aaPcx(app1aaPcx==0) = [];
nullDistaaCoa(idxRep,:) = histcounts(app1aaCoa,  edges1, 'normalization', 'probability');
nullDistaaPcx(idxRep,:) = histcounts(app1aaPcx,  edges1, 'normalization', 'probability');
end
mean_nullDistaaCoa = mean(nullDistaaCoa);
mean_nullDistaaPcx = mean(nullDistaaPcx);
sem_nullDistaaCoa = std(nullDistaaCoa)./sqrt((size(nullDistaaCoa,1))-1);
sem_nullDistaaPcx = std(nullDistaaPcx)./sqrt((size(nullDistaaPcx,1))-1);
[HvalenceCoa, nHaaCoa, odorSaaCoa, idxSingleClassaaCoa, idxMultipleclassaaCoa, n_classesCellaaCoa] = findCategorySelectivity_new(coaAA.esp, odorsRearrangedCoa, 2);
[HvalencePcx, nHaaPcx, odorSaaPcx, idxSingleClassaaPcx, idxMultipleclassaaPcx, n_classesCellaaPcx] = findCategorySelectivity_new(pcxAA.esp, odorsRearrangedPcx, 2);



%%
edges1 = 0.5:1:5.5;

app1 = n_classesCell15Coa(:,1);
app1(app1==0) = [];
figure; h1 = histogram(app1, edges1, 'normalization', 'probability');
ylim([0 1])
ylabel('Fraction of Activated Neurons')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)

app2 = n_classesCell15Pcx(:,1);
app2(app2==0) = [];
figure; h2 = histogram(app2, edges1, 'normalization', 'probability');
ylabel('Fraction of Activated Neurons')
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)

h1.FaceColor = coaC;
h1.EdgeColor = [1 1 1];
h1.FaceAlpha = 1;
h2.FaceColor = pcxC;
h2.EdgeColor = [1 1 1];
h2.FaceAlpha = 1;
%%
mean_trueDistCoa = histcounts(app1, edges1, 'normalization', 'probability');
figure
plot(mean_trueDistCoa)
hold on
plot(mean_nullDistCoa)


mean_trueDistPcx = histcounts(app2, edges1, 'normalization', 'probability');
figure
plot(mean_trueDistPcx)
hold on
plot(mean_nullDistPcx)
%%
edges1 = 0.5:1:5.5;

app1 = n_classesCell15Coa(:,1);
app1(app1==0) = [];
h1 = histcounts(app1, edges1);
ph1 = h1./sum(h1);
semh1 = sqrt(ph1.*(1-ph1)./sum(h1));
figure
barwitherr(semh1, ph1, 'EdgeColor', coaC, 'FaceColor', coaC)
ylim([0 1])
ylabel('Fraction of Activated Neurons')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)

app2 = n_classesCell15Pcx(:,1);
app2(app2==0) = [];
h2 = histcounts(app2, edges1);
ph2 = h2./sum(h2);
semh2 = sqrt(ph2.*(1-ph2)./sum(h2));
figure
barwitherr(semh2, ph2, 'EdgeColor', pcxC, 'FaceColor', pcxC)
ylabel('Fraction of Activated Neurons')
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)


%%
p = ranksum(app1, app2)
%%
x = histcounts(app1, edges1);
y = histcounts(app2, edges1);

prop_test([x(1) y(1)], [sum(x) sum(y)], 0)
%%
edges1 = 0.5:1:2.5;

app1 = n_classesCellaaCoa(:,1);
app1(app1==0) = [];
figure; h3 = histogram(app1, edges1, 'normalization', 'probability');
ylabel('Fraction of Activated Neurons')
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)

app2 = n_classesCellaaPcx(:,1);
app2(app2==0) = [];
figure; h4 = histogram(app2, edges1, 'normalization', 'probability');
ylabel('Fraction of Activated Neurons')
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)

h3.FaceColor = coaC;
h3.EdgeColor = [1 1 1];
h3.FaceAlpha = 1;
h4.FaceColor = pcxC;
h4.EdgeColor = [1 1 1];
h4.FaceAlpha = 1;
%%
edges1 = 0.5:1:2.5;
app1 = n_classesCellaaCoa(:,1);
app1(app1==0) = [];
h1 = histcounts(app1, edges1);
ph1 = h1./sum(h1);
semh1 = sqrt(ph1.*(1-ph1)./sum(h1));
figure
barwitherr(semh1, ph1, 'EdgeColor', coaC, 'FaceColor', coaC)
ylim([0 1])
ylabel('Fraction of Activated Neurons')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)

app2 = n_classesCellaaPcx(:,1);
app2(app2==0) = [];
h2 = histcounts(app2, edges1);
ph2 = h2./sum(h2);
semh2 = sqrt(ph2.*(1-ph2)./sum(h2));
figure
barwitherr(semh2, ph2, 'EdgeColor', pcxC, 'FaceColor', pcxC)
ylabel('Fraction of Activated Neurons')
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)
%%
x = histcounts(app1, edges1);
y = histcounts(app2, edges1);

prop_test([x(1) y(1)], [sum(x) sum(y)], 0)
%%
mean_trueDistaaCoa = histcounts(app1, edges1, 'normalization', 'probability');
figure
plot(mean_trueDistaaCoa)
hold on
plot(mean_nullDistaaCoa)


mean_trueDistaaPcx = histcounts(app2, edges1, 'normalization', 'probability');
figure
plot(mean_trueDistaaPcx)
hold on
plot(mean_nullDistaaPcx)
%%
p = ranksum(app1, app2)
%%
for idx = 1:5
    edges = 0.5:15.5;
    app = n_classesCell15Coa(:,1);
    app1 = app==idx;
    app2 = n_classesCell15Coa(app1,2);
    figure
    h = histogram(app2,'normalization', 'probability', 'FaceAlpha', 1);
    h.EdgeColor = 'k';
    h.FaceColor = 'k';
    ylim([0 1])
    xlim([0 16])
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)
    
    
    app = n_classesCell15Pcx(:,1);
    app1 = app==idx;
    app2 = n_classesCell15Pcx(app1,2);
    figure
    h = histogram(app2,'normalization', 'probability', 'FaceAlpha', 1);
    h.EdgeColor = 'k';
    h.FaceColor = 'k';
    ylim([0 1])
    xlim([0 16])
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)
end

for idx = 1:2
    edges = 0.5:10.5;
    app = n_classesCellaaCoa(:,1);
    app1 = app==idx;
    app2 = n_classesCellaaCoa(app1,2);
    figure
    h = histogram(app2,'normalization', 'probability', 'FaceAlpha', 1);
    h.EdgeColor = 'k';
    h.FaceColor = 'k';
    ylim([0 1])
    xlim([0 11])
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)
    
    app = n_classesCellaaPcx(:,1);
    app1 = app==idx;
    app2 = n_classesCellaaPcx(app1,2);
    figure
    h = histogram(app2,'normalization', 'probability', 'FaceAlpha', 1);
    h.EdgeColor = 'k';
    h.FaceColor = 'k';
    ylim([0 1])
    xlim([0 11])
    set(gcf,'color','white', 'PaperPositionMode', 'auto');
    set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)
end

%%
figure
tot = idxSingleClass15Coa + idxMultipleclass15Coa;
p1 = idxSingleClass15Coa./tot;
p2 = idxMultipleclass15Coa./tot;
semp1 = sqrt(p1.*(1-p1)./tot);
semp2 = sqrt(p2.*(1-p2)./tot);
barwitherr([semp1 semp2], [p1 p2], 'EdgeColor', coaC, 'FaceColor', coaC)
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)

figure
tot = idxSingleClass15Pcx + idxMultipleclass15Pcx;
p1 = idxSingleClass15Pcx./tot;
p2 = idxMultipleclass15Pcx./tot;
semp1 = sqrt(p1.*(1-p1)./tot);
semp2 = sqrt(p2.*(1-p2)./tot);
barwitherr([semp1 semp2], [p1 p2], 'EdgeColor', pcxC, 'FaceColor', pcxC)
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)

figure
tot = idxSingleClassaaCoa + idxMultipleclassaaCoa;
p1 = idxSingleClassaaCoa./tot;
p2 = idxMultipleclassaaCoa./tot;
semp1 = sqrt(p1.*(1-p1)./tot);
semp2 = sqrt(p2.*(1-p2)./tot);
barwitherr([semp1 semp2], [p1 p2], 'EdgeColor', coaC, 'FaceColor', coaC)
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',   'fontname', 'helvetica', 'fontsize', 14)

figure
tot = idxSingleClassaaPcx + idxMultipleclassaaPcx;
p1 = idxSingleClassaaPcx./tot;
p2 = idxMultipleclassaaPcx./tot;
semp1 = sqrt(p1.*(1-p1)./tot);
semp2 = sqrt(p2.*(1-p2)./tot);
barwitherr([semp1 semp2], [p1 p2], 'EdgeColor', pcxC, 'FaceColor', pcxC)
ylim([0 1])
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out',  'fontname', 'helvetica', 'fontsize', 14)