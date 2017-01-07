odorsRearranged = 1:15;
[HchemicalCoa, nHchemicalCoa, odorS15Coa, idxSingleClass15Coa, idxMultipleclass15Coa, n_classesCell15Coa] = findCategorySelectivity_new(coa15.esp, odorsRearranged, 1);
[HchemicalPcx, nHchemicalPcx, odorS15Pcx, idxSingleClass15Pcx, idxMultipleclass15Pcx, n_classesCell15Pcx] = findCategorySelectivity_new(pcx15.esp, odorsRearranged, 1);


odorsRearranged = 1:10;
[HvalenceCoa, nHaaCoa, odorSaaCoa, idxSingleClassaaCoa, idxMultipleclassaaCoa, n_classesCellaaCoa] = findCategorySelectivity_new(coaAA.esp, odorsRearranged, 2);
[HvalencePcx, nHaaPcx, odorSaaPcx, idxSingleClassaaPcx, idxMultipleclassaaPcx, n_classesCellaaPcx] = findCategorySelectivity_new(pcxAA.esp, odorsRearranged, 2);
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
[h,p, chi2stat,df] = prop_test(X , N, correct)
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