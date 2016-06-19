coa153 = load('coa_15_2_3.mat');
coaAA3 = load('coa_AAmix_2_3.mat');
pcx153 = load('pcx_15_2_3.mat');
pcxAA3 = load('pcx_AAmix_2_3.mat');
%%
[sdfCoaRad15, phasePeakBslCoa15, phasePeakRspCoa15, ampPeakBslCoa15, ampPeakRspCoa15, significance300Coa15, significance1000Coa15] = findBslRspPeakPhase(coa15.esp, coa153.esperimento);
[sdfCoaRadAA, phasePeakBslCoaAA, phasePeakRspCoaAA, ampPeakBslCoaAA, ampPeakRspCoaAA, significance300CoaAA, significance1000CoaAA] = findBslRspPeakPhase(coaAA.esp, coaAA3.esperimento);
[sdfPcxRad15, phasePeakBslPcx15, phasePeakRspPcx15, ampPeakBslPcx15, ampPeakRspPcx15, significance300Pcx15, significance1000Pcx15] = findBslRspPeakPhase(pcx15.esp, pcx153.esperimento);
[sdfPcxRadAA, phasePeakBslPcxAA, phasePeakRspPcxAA, ampPeakBslPcxAA, ampPeakRspPcxAA, significance300PcxAA, significance1000PcxAA] = findBslRspPeakPhase(pcxAA.esp, pcxAA3.esperimento);

%%
sdfCoaRad = [sdfCoaRad15; sdfCoaRadAA];
sdfPcxRad = [sdfPcxRad15; sdfPcxRadAA];
significance300Coa = [significance300Coa15; significance300CoaAA];        
significance300Pcx = [significance300Pcx15; significance300PcxAA]; 
significance1000Coa = [significance1000Coa15; significance1000CoaAA];        
significance1000Pcx = [significance1000Pcx15; significance1000PcxAA]; 
allSdfCoaRad = [];
allSdfPcxRad = [];
for cCoa = 1:size(sdfCoaRad,1)
    for idxOdor = 1:15
        if significance300Coa(cCoa, idxOdor) == 1 || significance1000Coa(cCoa, idxOdor) == 1
            allSdfCoaRad = [allSdfCoaRad; sdfCoaRad(cCoa,:,idxOdor)];
        end
    end
end

for cPcx = 1:size(sdfPcxRad,1)
    for idxOdor = 1:15
        if significance300Pcx(cPcx, idxOdor) == 1 || significance1000Pcx(cPcx, idxOdor) == 1
            allSdfPcxRad = [allSdfPcxRad; sdfPcxRad(cPcx,:,idxOdor)];
        end
    end
end

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot(mean(allSdfPcxRad), '-', 'linewidth', 2, 'color', pcxC)
hold on
plot(mean(allSdfCoaRad), '-', 'linewidth', 2, 'color', coaC)
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)


%%                    
phasePeakBslCoa = [phasePeakBslCoa15; phasePeakBslCoaAA];        
phasePeakBslPcx = [phasePeakBslPcx15; phasePeakBslPcxAA];  

phasePeakRspCoa = [phasePeakRspCoa15; phasePeakRspCoaAA];        
phasePeakRspPcx = [phasePeakRspPcx15; phasePeakRspPcxAA]; 

phasePeakRspCoaSig = phasePeakRspCoa(:);
phasePeakRspPcxSig = phasePeakRspPcx(:);
phasePeakBslCoaSig = phasePeakBslCoa(:);
phasePeakBslPcxSig = phasePeakBslPcx(:);

ampPeakBslCoa = [ampPeakBslCoa15; ampPeakBslCoaAA];        
ampPeakBslPcx = [ampPeakBslPcx15; ampPeakBslPcxAA];  

ampPeakRspCoa = [ampPeakRspCoa15; ampPeakRspCoaAA];        
ampPeakRspPcx = [ampPeakRspPcx15; ampPeakRspPcxAA]; 

ampPeakRspCoaSig = ampPeakRspCoa(:)*100;
ampPeakRspPcxSig = ampPeakRspPcx(:)*100;
ampPeakBslCoaSig = ampPeakBslCoa(:)*100;
ampPeakBslPcxSig = ampPeakBslPcx(:)*100;

significance300Coa = significance300Coa(:);
significance300Pcx = significance300Pcx(:);
significance1000Coa = significance1000Coa(:);
significance1000Pcx = significance1000Pcx(:);

phasePeakBslCoaSig(significance300Coa < 1) = [];
phasePeakBslPcxSig(significance300Pcx < 1) = [];
phasePeakRspCoaSig(significance300Coa < 1) = [];
phasePeakRspPcxSig(significance300Pcx < 1) = [];

ampPeakBslCoaSig(significance300Coa < 1) = [];
ampPeakBslPcxSig(significance300Pcx < 1) = [];
ampPeakRspCoaSig(significance300Coa < 1) = [];
ampPeakRspPcxSig(significance300Pcx < 1) = [];

app = [ampPeakBslCoaSig' ampPeakRspCoaSig' ampPeakBslPcxSig' ampPeakRspPcxSig'];
maxApp = max(app);
minApp = min(app);
Xedges = -30:30:360;
Yedges = [-1 logspace(-2,1,30)]; 
% Yedges = -1:1:4;
% Yedges = [Yedges [5 maxApp]];

% Xedges1 = interp1(Xedges, 1:numel(Xedges), phasePeakRspPcxSig, 'nearest')';
% Yedges1 = interp1(Yedges, 1:numel(Yedges), ampPeakRspPcxSig, 'nearest')';
% z = accumarray([Xedges1' Yedges1'], 1, [numel(Xedges) numel(Yedges)]);


[NCoaBslSig, Xedges, Yedges] = histcounts2(phasePeakBslCoaSig, ampPeakBslCoaSig, Xedges, Yedges, 'Normalization', 'probability');
[NCoaRspSig, Xedges, Yedges] = histcounts2(phasePeakRspCoaSig, ampPeakRspCoaSig, Xedges, Yedges, 'Normalization', 'probability');
[NPcxBslSig, Xedges, Yedges] = histcounts2(phasePeakBslPcxSig, ampPeakBslPcxSig, Xedges, Yedges, 'Normalization', 'probability');
[NPcxRspSig, Xedges, Yedges] = histcounts2(phasePeakRspPcxSig, ampPeakRspPcxSig, Xedges, Yedges, 'Normalization', 'probability');

Xedges(1) = [];
Yedges(1) = [];
%%
figure
set(gcf,'Position',[653 116 1198 904]);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
subplot(2,2,1)
polarPcolor(Yedges,Xedges,NCoaBslSig)
colormap(brewermap([],'*PuBuGn'))
colormap(brewermap([],'*YlOrRd'))

shading interp;
caxis([0 0.03]);
c =colorbar;
location = 'SouthOutside';
ylabel(c,' proportion');
title('Baseline')
set(gca, 'fontname', 'avenir', 'fontsize', 14)


subplot(2,2,3)
polarPcolor(Yedges,Xedges,NCoaRspSig)
shading interp;
caxis([0 0.03]);
c =colorbar;
location = 'SouthOutside';
ylabel(c,' proportion');
title('Response')
set(gca,  'fontname', 'avenir', 'fontsize', 14)


subplot(2,2,2)
polarPcolor(Yedges,Xedges,NPcxBslSig)
shading interp;
caxis([0 0.03]);
c =colorbar;
location = 'SouthOutside';
ylabel(c,' proportion');
title('Baseline')
set(gca, 'fontname', 'avenir', 'fontsize', 14)


subplot(2,2,4)
polarPcolor(Yedges,Xedges,NPcxRspSig)
shading interp;
caxis([0 0.03]);
c =colorbar;
location = 'SouthOutside';
ylabel(c,' proportion');
title('Response')
set(gca, 'fontname', 'avenir', 'fontsize', 14)

%%
pBCoa = circ_ang2rad(phasePeakBslCoaSig(:));
pRCoa = circ_ang2rad(phasePeakRspCoaSig(:));
pRPcx = circ_ang2rad(phasePeakRspPcxSig(:));
pBPcx = circ_ang2rad(phasePeakBslPcxSig(:));

[mBCoa] = circ_median(pBCoa);
mBCoa = 360 + circ_rad2ang(mBCoa);
uBCoa = 360 + circ_rad2ang(uBCoa);
lBCoa = 360 + circ_rad2ang(lBCoa);

[mRCoa] = circ_median(pRCoa);
mRCoa = 360 + circ_rad2ang(mRCoa);
uRCoa = 360 + circ_rad2ang(uRCoa);
lRCoa = 360 + circ_rad2ang(lRCoa);

[mBPcx] = circ_median(pBPcx);
mBPcx = 360 + circ_rad2ang(mBPcx);
uBPcx = 360 + circ_rad2ang(uBPcx);
lBPcx = 360 + circ_rad2ang(lBPcx);

[mRPcx] = circ_median(pRPcx);
mRPcx = 360 + circ_rad2ang(mRPcx);
uRPcx = 360 + circ_rad2ang(uRPcx);
lRPcx = 360 + circ_rad2ang(lRPcx);

rBCoa = circ_r(pBCoa);
rRCoa = circ_r(pRCoa);
rBPcx  = circ_r(pBPcx );
rRPcx  = circ_r(pRPcx );


ralBCoa = circ_rtest(pBCoa);
ralRCoa = circ_rtest(pRCoa);
ralBPcx = circ_rtest(pBPcx);
ralRPcx = circ_rtest(pRPcx);

alpha = [pBCoa; pRCoa; pBPcx; pRPcx];
idx = ones(size(alpha));
idx(numel(pBCoa)+1:numel(pBCoa)+numel(pRCoa)) = 2;
idx(numel(pBCoa)+numel(pRCoa)+1 : numel(pBCoa)+numel(pRCoa)+numel(pBPcx)) = 3;
idx(numel(pBCoa)+numel(pRCoa)+numel(pBPcx)+1:end) = 4;
 pCMall = circ_cmtest(alpha, idx);
 pCMcoa = circ_cmtest(pBCoa, pRCoa);
 pCMpcx = circ_cmtest(pBPcx, pRPcx);
 pCMbsl = circ_cmtest(pBCoa, pBPcx);
 pCMRsp = circ_cmtest(pRCoa, pRPcx);
%%
[x,y] = pol2cart(circ_ang2rad(mBCoa), rBCoa);
figure; set(gcf,'color','white', 'PaperPositionMode', 'auto'); compass([x 0],[y 0.5])
[x,y] = pol2cart(circ_ang2rad(mRCoa), rRCoa);
figure; set(gcf,'color','white', 'PaperPositionMode', 'auto'); compass([x 0],[y 0.5])
[x,y] = pol2cart(circ_ang2rad(mBPcx), rBPcx);
figure; set(gcf,'color','white', 'PaperPositionMode', 'auto'); compass([x 0],[y 0.5])
[x,y] = pol2cart(circ_ang2rad(mRPcx), rRPcx);
figure; set(gcf,'color','white', 'PaperPositionMode', 'auto'); compass([x 0],[y 0.5])
%%
edges = -30:30:390;
h1 = histcounts(phasePeakBslCoa(:), edges) ./ numel(phasePeakBslCoa(:));
h2 = histcounts(phasePeakBslPcx(:), edges) ./ numel(phasePeakBslPcx(:));
h3 = histcounts(phasePeakRspCoa(:), edges) ./ numel(phasePeakRspCoa(:));
h4 = histcounts(phasePeakRspPcx(:), edges) ./ numel(phasePeakRspPcx(:));
h5 = histcounts(phasePeakRspCoaSig(:), edges) ./ numel(phasePeakRspCoa(:));
h6 = histcounts(phasePeakRspPcxSig(:), edges) ./ numel(phasePeakRspPcx(:));



figure
p1 = histogram(phasePeakBslCoa(:), edges, 'normalization', 'probability');
p1.FaceColor = coaC;
p1.EdgeColor = coaC;
figure
p2 = histogram(phasePeakBslPcx(:), edges, 'normalization', 'probability');
p2.FaceColor = pcxC;
p2.EdgeColor = pcxC;

figure;
% p3 = area(edges,h3);
% p3.FaceColor = coaC;
% p3.EdgeColor = coaC;
% alpha(p3, 0.5)
% hold on
p4 = histogram(phasePeakRspCoaSig(:), edges, 'normalization', 'probability');
p4.FaceColor = coaC;
p4.EdgeColor = coaC;

figure;
% p5 = area(edges,h4);
% p5.FaceColor = pcxC;
% p5.EdgeColor = pcxC;
% alpha(p5, 0.5)
% hold on
p6 = histogram(phasePeakRspPcxSig(:), edges, 'normalization', 'probability');
p6.FaceColor = pcxC;
p6.EdgeColor = pcxC;


%%
% figure
% a1 = round(phasePeakBslCoaSig(:));
% a2 = round(phasePeakRspCoaSig(:));
% b1 = round(phasePeakBslPcxSig(:));
% b2 = round(phasePeakRspPcxSig(:));
% 
% h1 = histcounts(a1, 0:360) ./ numel(a1) *100;
% h2 = histcounts(a2, 0:360) ./ numel(a2) *100;
% h3 = histcounts(b1, 0:360) ./ numel(b1) *100;
% h4 = histcounts(b2, 0:360) ./ numel(b2) *100;
% 
% N = 360;
% R = linspace(0,100,360); % proportion
% theta = linspace(0,360,360);
% Z = h2;
% figure;
% polarPcolor(R,theta,Z)




figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gcf,'Position',[109 69 1800 988]);
% subplot(2,2,1)
% rose(circ_ang2rad(phasePeakBslCoa(:)))
% % hold on
% % rose(circ_ang2rad(phasePeakRspCoa(:)))
% subplot(2,2,2)
% rose(circ_ang2rad(phasePeakBslPcx(:)))
% hold on
% rose(circ_ang2rad(phasePeakRspPcx(:)))
subplot(2,2,1)
h1 = rose(circ_ang2rad(phasePeakBslCoaSig(:)));
set(h1,'LineWidth',2,'Color',coaC)
title('Baseline')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
% x = get(h1, 'XData') ;
% y = get(h1, 'YData') ;
% p = patch(x, y, coaC) ;


subplot(2,2,3)
h2 = rose(circ_ang2rad(phasePeakRspCoaSig(:)));
set(h2,'LineWidth',2,'Color',coaC)
title('Response')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
% x = get(h2, 'XData') ;
% y = get(h2, 'YData') ;
% p = patch(x, y, coaC) ;


subplot(2,2,2)
h3 = rose(circ_ang2rad(phasePeakBslPcxSig(:)));
set(h3,'LineWidth',2,'Color',pcxC)
title('Baseline')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
% x = get(h3, 'XData') ;
% y = get(h3, 'YData') ;
% p = patch(x, y, pcxC) ;

subplot(2,2,4)
h4 = rose(circ_ang2rad(phasePeakRspPcxSig(:)));
set(h4,'LineWidth',2,'Color',pcxC)
title('Response')
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
% x = get(h4, 'XData') ;
% y = get(h4, 'YData') ;
% p = patch(x, y, pcxC) ;


