FRspCOA = [rspFractioncoa15Exc;rspFractioncoaAAExc];
FRspPCX = [rspFractionpcx15Exc;rspFractionpcxAAExc];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [significancepcx15; significancepcxAA];
logSignificantPcx = logSignificantPcx(:);
fractionExcitatoryTrialsCOA = sum(FRspCOA(:) .* 10)./(10*(length(FRspCOA(:))));
fractionExcitatoryTrialsPCX = sum(FRspPCX(:) .* 10)./(10*(length(FRspPCX(:))));
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];
fractionExcitatoryTrialsCOAsig = sum(FRspCOAsig(:) .* 10)./(10*(length(FRspCOA(:))));
fractionExcitatoryTrialsPCXsig = sum(FRspPCXsig(:) .* 10)./(10*(length(FRspPCX(:))));

figure
s1 = bar(0:3, [0 fractionExcitatoryTrialsCOA 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
s2 = bar(0:3, [0 0 fractionExcitatoryTrialsPCX 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s2, .5)
hold on
bar(0:3, [0 fractionExcitatoryTrialsCOAsig 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
hold on
bar(0:3, [0 0 fractionExcitatoryTrialsPCXsig 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);

%%
FRspCOA = [rspFractioncoa15Inh;rspFractioncoaAAInh];
FRspPCX = [rspFractionpcx15Inh;rspFractionpcxAAInh];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [significancepcx15; significancepcxAA];
logSignificantPcx = logSignificantPcx(:);
fractionInhibitoryTrialsCOA = sum(FRspCOA(:) .* 10)./(10*(length(FRspCOA(:))));
fractionInhibitoryTrialsPCX = sum(FRspPCX(:) .* 10)./(10*(length(FRspPCX(:))));
FRspCOAsig = FRspCOA(:);
FRspPCXsig = FRspPCX(:);
FRspCOAsig(logSignificantCoa<1) = [];
FRspPCXsig(logSignificantPcx<1) = [];
fractionInhibitoryTrialsCOAsig = sum(FRspCOAsig(:) .* 10)./(10*(length(FRspCOA(:))));
fractionInhibitoryTrialsPCXsig = sum(FRspPCXsig(:) .* 10)./(10*(length(FRspPCX(:))));

figure
s1 = bar(0:3, [0 fractionInhibitoryTrialsCOA 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
alpha(s1, .5)
hold on
s2 = bar(0:3, [0 0 fractionInhibitoryTrialsPCX 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);
alpha(s2, .5)
hold on
bar(0:3, [0 fractionInhibitoryTrialsCOAsig 0 0], 'EdgeColor', coaC, 'FaceColor', coaC);
hold on
bar(0:3, [0 0 fractionInhibitoryTrialsPCXsig 0], 'EdgeColor', pcxC, 'FaceColor', pcxC);

%%
appCoa = [];
appPcx = [];
DeltaRspCOATrials = [DeltaRspcoaTrials15;DeltaRspcoaTrialsAA];
DeltaRspPCXTrials = [DeltaRsppcxTrials15;DeltaRsppcxTrialsAA];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantPcx = [significancepcx15; significancepcxAA];
for cCoa = 1:size(DeltaRspCOATrials,1)
    for oCoa = 1:15
        if logSignificantCoa(cCoa, oCoa) ~= 0
            appCoa = [appCoa; squeeze(DeltaRspCOATrials(cCoa,:,oCoa))];
        end
    end
end
for cPcx = 1:size(DeltaRspPCXTrials,1)
    for oPcx = 1:15
        if logSignificantPcx(cPcx, oPcx) ~= 0
            appPcx = [appPcx; squeeze(DeltaRspPCXTrials(cPcx,:,oPcx))];
        end
    end
end


minAx = min([DeltaRspCOATrials(:); DeltaRspPCXTrials(:)]);
maxAx = max([DeltaRspCOATrials(:); DeltaRspPCXTrials(:)]);
edges = minAx - 1:1: maxAx + 1;

h1 = histcounts(DeltaRspCOATrials(:), edges) ./ numel(DeltaRspCOATrials(:));
h2 = histcounts(DeltaRspPCXTrials(:), edges) ./ numel(DeltaRspPCXTrials(:));
h3 = histcounts(appCoa(:), edges) ./ numel(DeltaRspCOATrials(:));
h4 = histcounts(appPcx(:), edges) ./ numel(DeltaRspPCXTrials(:));
edges(end) = [];

figure
p1 = area(edges, h1);
p1.FaceColor = coaC;
p1.EdgeColor = coaC;
alpha(p1, 0.5)
hold on; 
p2 = area(edges, h2);
p2.FaceColor = pcxC;
p2.EdgeColor = pcxC;
alpha(p2, 0.5)
figure;
p3 = area(edges,h3);
p3.FaceColor = coaC;
p3.EdgeColor = coaC;
alpha(p3, 0.5)
hold on
p4 = area(edges,h4);
p4.FaceColor = pcxC;
p4.EdgeColor = pcxC;
alpha(p4, 0.5)
    
%%
bslCOA = [Bslcoa15';BslcoaAA'];
bslPCX = [Bslpcx15';BslpcxAA'];
logSignificantCoa = [significancecoa15; significancecoaAA];
logSignificantPcx = [significancepcx15; significancepcxAA];

bslCOAsigE = [];
bslCOAsigI = [];
for cCoa = 1:size(logSignificantCoa,1)
    appE = find(logSignificantCoa(cCoa,:)>0);
    appI = find(logSignificantCoa(cCoa,:)<0);
    if numel(appE) > 0
        bslCOAsigE = [bslCOAsigE, bslCOA(cCoa)];
    end
    if numel(appI) > 0
        bslCOAsigI = [bslCOAsigI, bslCOA(cCoa)];
    end
end

bslPCXsigE = [];
bslPCXsigI = [];
for cPcx = 1:size(logSignificantPcx,1)
    appE = find(logSignificantPcx(cPcx,:)>0);
    appI = find(logSignificantPcx(cPcx,:)<0);
    if numel(appE) > 0
        bslPCXsigE = [bslPCXsigE, bslPCX(cPcx)];
    end
    if numel(appI) > 0
        bslPCXsigI = [bslPCXsigI, bslPCX(cPcx)];
    end
end

allBsl = [Bslcoa15 BslcoaAA Bslpcx15 BslpcxAA];
maxBsl = max(allBsl);
minBsl = min(allBsl);
edges = logspace(-2,2,30);
[N1,edges] = histcounts(bslPCX, edges);
[N2,edges] = histcounts(bslCOA, edges);
[N3,edges] = histcounts(bslPCXsigE, edges);
[N4,edges] = histcounts(bslCOAsigE, edges);
[N5,edges] = histcounts(bslPCXsigI, edges);
[N6,edges] = histcounts(bslCOAsigI, edges);
N1 = N1 ./ numel(bslPCX);
N2 = N2 ./ numel(bslCOA);
N3 = N3 ./ numel(bslPCX);
N4 = N4 ./ numel(bslCOA);
N5 = N5 ./ numel(bslPCX);
N6 = N6 ./ numel(bslCOA);
edges = log10(edges(1:end-1));

figure
h1 = area(edges, N1);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, N3);
h2.FaceColor = pcxC;
h2.EdgeColor = pcxC;

figure
h1 = area(edges, N1);
h1.FaceColor = pcxC;
h1.EdgeColor = pcxC;
alpha(h1, 0.5)
hold on; 
h2 = area(edges, N5);
h2.FaceColor = pcxC;
h2.EdgeColor = pcxC;

figure
h3 = area(edges, N2);
h3.FaceColor = coaC;
h3.EdgeColor = coaC;
alpha(h3, 0.5)
hold on; 
h4 = area(edges, N4);
h4.FaceColor = coaC;
h4.EdgeColor = coaC;

figure
h3 = area(edges, N2);
h3.FaceColor = coaC;
h3.EdgeColor = coaC;
alpha(h3, 0.5)
hold on; 
h4 = area(edges, N6);
h4.FaceColor = coaC;
h4.EdgeColor = coaC;

















