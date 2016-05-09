coa153 = load('coa_15_2_3.mat');
coaAA3 = load('coa_AAmix_2_3.mat');
pcx153 = load('pcx_15_2_3.mat');
pcxAA3 = load('pcx_AAmix_2_3.mat');
%%
[phasePeakBslCoa15, phasePeakRspCoa15, significanceCoa15] = findBslRspPeakPhase(coa15.esp, coa153.esperimento);
[phasePeakBslCoaAA, phasePeakRspCoaAA, significanceCoaAA] = findBslRspPeakPhase(coaAA.esp, coaAA3.esperimento);
[phasePeakBslPcx15, phasePeakRspPcx15, significancePcx15] = findBslRspPeakPhase(pcx15.esp, pcx153.esperimento);
[phasePeakBslPcxAA, phasePeakRspPcxAA, significancePcxAA] = findBslRspPeakPhase(pcxAA.esp, pcxAA3.esperimento);
                    
                    
phasePeakBslCoa = [phasePeakBslCoa15'; phasePeakBslCoaAA'];        
phasePeakBslPcx = [phasePeakBslPcx15'; phasePeakBslPcxAA'];  

phasePeakRspCoa = [phasePeakRspCoa15; phasePeakRspCoaAA];        
phasePeakRspPcx = [phasePeakRspPcx15; phasePeakRspPcxAA]; 

significanceCoa = [significanceCoa15; significanceCoaAA];        
significancePcx = [significancePcx15; significancePcxAA]; 



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
figure
rose(circ_ang2rad(phasePeakBslCoa))
figure
rose(circ_ang2rad(phasePeakBslPcx))

figure
rose(circ_ang2rad(phasePeakRspCoa(:)))
figure
rose(circ_ang2rad(phasePeakRspPcx(:)))

phasePeakRspCoaSig = phasePeakRspCoa(:);
phasePeakRspPcxSig = phasePeakRspPcx(:);
significanceCoa = significanceCoa(:);
significancePcx = significancePcx(:);
phasePeakRspCoaSig(significanceCoa < 1) = [];
phasePeakRspPcxSig(significancePcx < 1) = [];
figure
rose(circ_ang2rad(phasePeakRspCoaSig(:)))
figure
rose(circ_ang2rad(phasePeakRspPcxSig(:)))