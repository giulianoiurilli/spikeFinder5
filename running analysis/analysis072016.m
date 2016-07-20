[aCoa15, bCoa15, arCoa15, brCoa15] = findOdorClassCorrelations(coa15.esp, 1:15, 1);
[aPcx15, bPcx15, arPcx15, brPcx15] = findOdorClassCorrelations(pcx15.esp, 1:15, 1);
[aCoaAA, bCoaAA, arCoaAA, brCoaAA] = findOdorClassCorrelations(coaAA.esp, 1:10, 2);
[aPcxAA, bPcxAA, arPcxAA, brPcxAA] = findOdorClassCorrelations(pcxAA.esp, 1:10, 2);

%%
idx = triu(true(3,3),1);
intra15Coa = [];
for j = 1:5
    app = [];
    app = squeeze(aCoa15(:,:,j));
    intra15Coa = [intra15Coa; app(idx)];
end

idx = triu(true(3,3),1);
intra15Pcx = [];
for j = 1:5
    app = [];
    app = squeeze(aPcx15(:,:,j));
    intra15Pcx = [intra15Pcx; app(idx)];
end

inter15Coa = bCoa15(:);
inter15Pcx = bPcx15(:);

%%
idx = triu(true(3,3),1);
intra15CoaS = [];
for j = 1:5
    app = [];
    app = squeeze(arCoa15(:,:,j));
    intra15CoaS = [intra15CoaS; app(idx)];
end

idx = triu(true(3,3),1);
intra15PcxS = [];
for j = 1:5
    app = [];
    app = squeeze(arPcx15(:,:,j));
    intra15PcxS = [intra15PcxS; app(idx)];
end

inter15CoaS = brCoa15(:);
inter15PcxS = brPcx15(:);
%%
idx = triu(true(5,5),1);
intraAACoa = [];
for j = 1:2
    app = [];
    app = squeeze(aCoaAA(:,:,j));
    intraAACoa = [intraAACoa; app(idx)];
end

idx = triu(true(5,5),1);
intraAAPcx = [];
for j = 1:2
    app = [];
    app = squeeze(aPcxAA(:,:,j));
    intraAAPcx = [intraAAPcx; app(idx)];
end

interAACoa = bCoaAA(:);
interAAPcx = bPcxAA(:);

%%
idx = triu(true(5,5),1);
intraAACoaS = [];
for j = 1:2
    app = [];
    app = squeeze(arCoaAA(:,:,j));
    intraAACoaS = [intraAACoaS; app(idx)];
end

idx = triu(true(5,5),1);
intraAAPcxS = [];
for j = 1:2
    app = [];
    app = squeeze(arPcxAA(:,:,j));
    intraAAPcxS = [intraAAPcxS; app(idx)];
end

interAACoaS = brCoaAA(:);
interAAPcxS = brPcxAA(:);


%%
figure;
plot([2 4], [mean(intra15Coa(:)) mean(inter15Coa)], 's', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([8 10], [mean(intra15Pcx(:)) mean(inter15Pcx(:))], 's', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2 4], [mean(intra15Coa(:)) mean(inter15Coa(:))], [std(intra15Coa(:))./sqrt(length(intra15Coa(:))) std(inter15Coa(:))./sqrt(length(inter15Coa(:)))], 'color', coaC, 'linewidth', 1); %
hold on
errbar([8 10], [mean(intra15Pcx(:)) mean(inter15Pcx(:))], [std(intra15Pcx)./sqrt(length(intra15Pcx)) std(inter15Pcx(:))./sqrt(length(inter15Pcx(:)))], 'color', pcxC, 'linewidth', 1); 


xlim([0 13])
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
title('Chemical Classes')

%%
figure;
plot([2 4], [mean(intraAACoa(:)) mean(interAACoa)], 's', 'markersize', 10, 'markeredgecolor', coaC, 'markerfacecolor', coaC)
hold on
plot([8 10], [mean(intraAAPcx(:)) mean(interAAPcx(:))], 's', 'markersize', 10, 'markeredgecolor', pcxC, 'markerfacecolor', pcxC)
hold on
errbar([2 4], [mean(intraAACoa(:)) mean(interAACoa(:))], [std(intraAACoa(:))./sqrt(length(intraAACoa(:))) std(interAACoa(:))./sqrt(length(interAACoa(:)))], 'color', coaC, 'linewidth', 1); %
hold on
errbar([8 10], [mean(intraAAPcx(:)) mean(interAAPcx(:))], [std(intraAAPcx)./sqrt(length(intraAAPcx)) std(interAAPcx(:))./sqrt(length(interAAPcx(:)))], 'color', pcxC, 'linewidth', 1); %./sqrt(length(accuracyResponsesPcxAA(:)))


xlim([0 13])
set(gca, 'XColor', 'w', 'box','off')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
title('Valence Classes')

%%
y = [];
y = [intra15Coa; inter15Coa; intra15Pcx; inter15Pcx];
g1 = [];
g1 = [ones(numel(intra15Coa),1); 2*ones(numel(inter15Coa),1); ones(numel(intra15Pcx),1); 2*ones(numel(inter15Pcx),1)];
g2 = [];
g2 = [ones(numel(intra15Coa),1); ones(numel(inter15Coa),1); 2*ones(numel(intra15Pcx),1); 2*ones(numel(inter15Pcx),1)];
[p, table, stats] = anovan(y, {g1, g2}, 'mode', 'interaction')

%%
y = [];
y = [intraAACoa; interAACoa; intraAAPcx; interAAPcx];
g1 = [];
g1 = [ones(numel(intraAACoa),1); 2*ones(numel(interAACoa),1); ones(numel(intraAAPcx),1); 2*ones(numel(interAAPcx),1)];
g2 = [];
g2 = [ones(numel(intraAACoa),1); ones(numel(interAACoa),1); 2*ones(numel(intraAAPcx),1); 2*ones(numel(interAAPcx),1)];
[p, table, stats] = anovan(y, {g1, g2}, 'mode', 'interaction')

%%
[h, p] = ttest2(intraAACoa, interAACoa)