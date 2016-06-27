odorsRearranged = 1:15;
[HchemicalCoa, nHchemicalCoa, odorS15Coa] = findCategorySelectivity(coa15.esp, odorsRearranged, 1);
[HchemicalPcx, nHchemicalPcx, odorS15Pcx] = findCategorySelectivity(pcx15.esp, odorsRearranged, 1);
nHchemicalCoa_2 = nHchemicalCoa(~isnan(nHchemicalCoa));
nHchemicalPcx_2 = nHchemicalPcx(~isnan(nHchemicalPcx));

odorsRearranged = 1:10;
[HvalenceCoa, nHaaCoa, odorSaaCoa] = findCategorySelectivity(coaAA.esp, odorsRearranged, 2);
[HvalencePcx, nHaaPcx, odorSaaPcx] = findCategorySelectivity(pcxAA.esp, odorsRearranged, 2);
nHaaCoa_2 = nHaaCoa(~isnan(nHaaCoa));
nHaaPcx_2 = nHaaPcx(~isnan(nHaaPcx));


%%
edges1 = 0.5:1:5.5;
figure; h1 = histogram(HchemicalCoa(HchemicalCoa>0), edges1, 'normalization', 'probability');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)
figure; h2 = histogram(HchemicalPcx(HchemicalPcx>0), edges1, 'normalization', 'probability');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)
xCoa = histcounts(nHchemicalCoa_2, 0.5:1:3.5, 'normalization', 'probability');
xPcx = histcounts(nHchemicalPcx_2, 0.5:1:3.5, 'normalization', 'probability');
figure; b1 = bar([xCoa; zeros(1,3)], 'stacked');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)
figure; b2 = bar([xPcx; zeros(1,3)], 'stacked');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)




edges1 = 0.5:1:2.5;
figure; h3 = histogram(HvalenceCoa(HvalenceCoa>0), edges1, 'normalization', 'probability');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)
figure; h4 = histogram(HvalencePcx(HvalencePcx>0), edges1, 'normalization', 'probability');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)
yCoa = histcounts(nHaaCoa_2, 0.5:1:5.5, 'normalization', 'probability');
yPcx = histcounts(nHaaPcx_2, 0.5:1:5.5, 'normalization', 'probability');
figure; b3 = bar([yCoa; zeros(1,5)], 'stacked');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)
figure; b4 = bar([yPcx; zeros(1,5)], 'stacked');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

h1.FaceColor = coaC;
h1.EdgeColor = coaC;
h2.FaceColor = pcxC;
h2.EdgeColor = pcxC;
h3.FaceColor = coaC;
h3.EdgeColor = coaC;
h4.FaceColor = pcxC; 
h4.EdgeColor = pcxC;

coaC2 = [252,146,114;
251,106,74;
239,59,44;
203,24,29;
165,15,21]/255;
pcxC2 = [189,189,189;
150,150,150;
115,115,115;
82,82,82;
37,37,37]/255;

b1(1).FaceColor = coaC2(1,:); 
b1(2).FaceColor = coaC2(2,:); 
b1(3).FaceColor = coaC2(3,:); 
b1(1).EdgeColor = coaC2(1,:); 
b1(2).EdgeColor = coaC2(2,:);
b1(3).EdgeColor = coaC2(3,:); 

b2(1).FaceColor = pcxC2(1,:);
b2(2).FaceColor = pcxC2(2,:);
b2(3).FaceColor = pcxC2(3,:);
b2(1).EdgeColor =  pcxC2(1,:);
b2(2).EdgeColor =  pcxC2(2,:);
b2(3).EdgeColor =  pcxC2(3,:);

b3(1).FaceColor =  coaC2(1,:);
b3(2).FaceColor = coaC2(2,:); 
b3(3).FaceColor =  coaC2(3,:);
b3(4).FaceColor =  coaC2(4,:);
b3(5).FaceColor = coaC2(5,:);
b3(1).EdgeColor =  coaC2(1,:);
b3(2).EdgeColor =  coaC2(2,:);
b3(3).EdgeColor =  coaC2(3,:);
b3(4).EdgeColor =  coaC2(4,:);
b3(5).EdgeColor =  coaC2(5,:);

b4(1).FaceColor =  pcxC2(1,:);
b4(2).FaceColor =  pcxC2(2,:);
b4(3).FaceColor =  pcxC2(3,:);
b4(4).FaceColor =  pcxC2(4,:);
b4(5).FaceColor = pcxC2(5,:);
b4(1).EdgeColor =  pcxC2(1,:);
b4(2).EdgeColor =  pcxC2(2,:);
b4(3).EdgeColor =  pcxC2(3,:);
b4(4).EdgeColor =  pcxC2(4,:);
b4(5).EdgeColor =  pcxC2(5,:);

%%
odorS15Coa_2 = odorS15Coa(~isnan(odorS15Coa));
odorS15Pcx_2 = odorS15Pcx(~isnan(odorS15Pcx));
odorSaaCoa_2 = odorSaaCoa(~isnan(odorSaaCoa));
odorSaaPcx_2 = odorSaaPcx(~isnan(odorSaaPcx));
figure;
hh1 = histogram(odorS15Coa_2, 0.5:1:15.5, 'normalization', 'probability');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

figure;
hh2 = histogram(odorS15Pcx_2, 0.5:1:15.5, 'normalization', 'probability');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

figure;
hh3 = histogram(odorSaaCoa_2, 0.5:1:11.5, 'normalization', 'probability');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

figure;
hh4 = histogram(odorSaaPcx_2, 0.5:1:11.5, 'normalization', 'probability');
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)


hh1.FaceColor = coaC;
hh1.EdgeColor = coaC;
hh2.FaceColor = pcxC;
hh2.EdgeColor = pcxC;
hh3.FaceColor = coaC;
hh3.EdgeColor = coaC;
hh4.FaceColor = pcxC; 
hh4.EdgeColor = pcxC;


