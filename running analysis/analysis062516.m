%% bar plot auROC/odor
X11 = Mcoa15.auRoc;
X11(X11<0.5) = NaN;
X11(Mcoa15.significance==0) = NaN;
for j = 1:15
    app = [];
    app = X11(:,j);
    app(isnan(app)) = [];
    notnanX11(j) = numel(app);
end
X11app = X11(:,[4 9]);
X11app = X11app(:);

X12 = McoaCS.auRoc;
X12(X12<0.5) = NaN;
X12(McoaCS.significance==0) = NaN;
for j = 1:15
    app = [];
    app = X12(:,j);
    app(isnan(app)) = [];
    notnanX12(j) = numel(app);
end
X12app = X12(:,[5 10 15]);
X12app = X12app(:);

XneutCoa = [X11app; X12app];
XneutCoaNotNan = isnan(XneutCoa);
numNanNeutCoa = sum(XneutCoaNotNan);
meanNeutCoa = nanmean(XneutCoa);
semNeutCoa = nanstd(XneutCoa)./sqrt(numel(XneutCoa) - numNanNeutCoa - 1);





X13 = McoaAA.auRoc;
X13(X13<0.5) = NaN;
X13(McoaAA.significance==0) = NaN;
for j = 1:15
    app = [];
    app = X13(:,j);
    app(isnan(app)) = [];
    notnanX13(j) = numel(app);
end
X13ave = X13(:,1:5);
XaveCoa = X13ave(:);
X13ape = X13(:,6:10);
XapeCoa = X13ape(:);
XaveCoaNotNan = isnan(XaveCoa);
numNanAveCoa = sum(XaveCoaNotNan);
meanAveCoa = nanmean(XaveCoa);
semAveCoa = nanstd(XaveCoa)./sqrt(numel(XaveCoa) - numNanAveCoa - 1);
XapeCoaNotNan = isnan(XapeCoa);
numNanapeCoa = sum(XapeCoaNotNan);
meanApeCoa = nanmean(XapeCoa);
semApeCoa = nanstd(XapeCoa)./sqrt(numel(XapeCoa) - numNanapeCoa - 1);

meanX = [];
meanX = [meanNeutCoa meanAveCoa meanApeCoa];
semX = [];
semX = [semNeutCoa semAveCoa semApeCoa];


Y11 = Mpcx15.auRoc;
Y11(Y11<0.5) = NaN;
Y11(Mpcx15.significance==0) = NaN;
for j = 1:15
    app = [];
    app = Y11(:,j);
    app(isnan(app)) = [];
    notnanY11(j) = numel(app);
end
Y11app = Y11(:,[4 9]);
Y11app = Y11app(:);

Y12 = MpcxCS.auRoc;
Y12(Y12<0.5) = NaN;
Y12(MpcxCS.significance==0) = NaN;
for j = 1:15
    app = [];
    app = Y12(:,j);
    app(isnan(app)) = [];
    notnanY12(j) = numel(app);
end
Y12app = Y12(:,[5 10 15]);
Y12app = Y12app(:);

YneutPcx = [Y11app; Y12app];
YneutPcxNotNan = isnan(YneutPcx);
numNanNeutPcx = sum(YneutPcxNotNan);
meanNeutPcx = nanmean(YneutPcx);
semNeutPcx = nanstd(YneutPcx)./sqrt(numel(YneutPcx) - numNanNeutPcx - 1);





Y13 = MpcxAA.auRoc;
Y13(Y13<0.5) = NaN;
Y13(MpcxAA.significance==0) = NaN;
for j = 1:15
    app = [];
    app = Y13(:,j);
    app(isnan(app)) = [];
    notnanY13(j) = numel(app);
end
Y13ave = Y13(:,1:5);
YavePcx = Y13ave(:);
Y13ape = Y13(:,6:10);
YapePcx = Y13ape(:);
YavePcxNotNan = isnan(YavePcx);
numNanAvePcx = sum(YavePcxNotNan);
meanAvePcx = nanmean(YavePcx);
semAvePcx = nanstd(YavePcx)./sqrt(numel(YavePcx) - numNanAvePcx - 1);
YapePcxNotNan = isnan(YapePcx);
numNanapePcx = sum(YapePcxNotNan);
meanApePcx = nanmean(YapePcx);
semApePcx = nanstd(YapePcx)./sqrt(numel(YapePcx) - numNanapePcx - 1);

meanY = [];
meanY = [meanNeutPcx meanAvePcx meanApePcx];
semY = [];
semY = [semNeutPcx semAvePcx semApePcx];
%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
% meanX = reshape(meanX,5,3);
% semX = reshape(semX,5,3);
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('auROC')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
% meanY = reshape(meanY,5,3);
% semY = reshape(semY,5,3);
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('auROC')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

%% bar plot ff/odor
X11 = Mcoa15.ff;
X11(Mcoa15.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X11(:,j);
    app(isnan(app)) = [];
    notnanX11(j) = numel(app);
end
X11app = X11(:,[4 9]);
X11app = X11app(:);

X12 = McoaCS.ff;
X12(McoaCS.significance==0) = NaN;
for j = 1:15
    app = [];
    app = X12(:,j);
    app(isnan(app)) = [];
    notnanX12(j) = numel(app);
end
X12app = X12(:,[5 10 15]);
X12app = X12app(:);

XneutCoa = [X11app; X12app];
XneutCoaNotNan = isnan(XneutCoa);
numNanNeutCoa = sum(XneutCoaNotNan);
meanNeutCoa = nanmean(XneutCoa);
semNeutCoa = nanstd(XneutCoa)./sqrt(numel(XneutCoa) - numNanNeutCoa - 1);





X13 = McoaAA.ff;
X13(McoaAA.significance==0) = NaN;
for j = 1:15
    app = [];
    app = X13(:,j);
    app(isnan(app)) = [];
    notnanX13(j) = numel(app);
end
X13ave = X13(:,1:5);
XaveCoa = X13ave(:);
X13ape = X13(:,6:10);
XapeCoa = X13ape(:);
XaveCoaNotNan = isnan(XaveCoa);
numNanAveCoa = sum(XaveCoaNotNan);
meanAveCoa = nanmean(XaveCoa);
semAveCoa = nanstd(XaveCoa)./sqrt(numel(XaveCoa) - numNanAveCoa - 1);
XapeCoaNotNan = isnan(XapeCoa);
numNanapeCoa = sum(XapeCoaNotNan);
meanApeCoa = nanmean(XapeCoa);
semApeCoa = nanstd(XapeCoa)./sqrt(numel(XapeCoa) - numNanapeCoa - 1);

meanX = [];
meanX = [meanNeutCoa meanAveCoa meanApeCoa];
semX = [];
semX = [semNeutCoa semAveCoa semApeCoa];

Y11 = Mpcx15.ff;
Y11(Mpcx15.significance==0) = NaN;
for j = 1:15
    app = [];
    app = Y11(:,j);
    app(isnan(app)) = [];
    notnanY11(j) = numel(app);
end
Y11app = Y11(:,[4 9]);
Y11app = Y11app(:);

Y12 = MpcxCS.ff;
Y12(MpcxCS.significance==0) = NaN;
for j = 1:15
    app = [];
    app = Y12(:,j);
    app(isnan(app)) = [];
    notnanY12(j) = numel(app);
end
Y12app = Y12(:,[5 10 15]);
Y12app = Y12app(:);

YneutPcx = [Y11app; Y12app];
YneutPcxNotNan = isnan(YneutPcx);
numNanNeutPcx = sum(YneutPcxNotNan);
meanNeutPcx = nanmean(YneutPcx);
semNeutPcx = nanstd(YneutPcx)./sqrt(numel(YneutPcx) - numNanNeutPcx - 1);





Y13 = MpcxAA.ff;
Y13(MpcxAA.significance==0) = NaN;
for j = 1:15
    app = [];
    app = Y13(:,j);
    app(isnan(app)) = [];
    notnanY13(j) = numel(app);
end
Y13ave = Y13(:,1:5);
YavePcx = Y13ave(:);
Y13ape = Y13(:,6:10);
YapePcx = Y13ape(:);
YavePcxNotNan = isnan(YavePcx);
numNanAvePcx = sum(YavePcxNotNan);
meanAvePcx = nanmean(YavePcx);
semAvePcx = nanstd(YavePcx)./sqrt(numel(YavePcx) - numNanAvePcx - 1);
YapePcxNotNan = isnan(YapePcx);
numNanapePcx = sum(YapePcxNotNan);
meanApePcx = nanmean(YapePcx);
semApePcx = nanstd(YapePcx)./sqrt(numel(YapePcx) - numNanapePcx - 1);

meanY = [];
meanY = [meanNeutPcx meanAvePcx meanApePcx];
semY = [];
semY = [semNeutPcx semAvePcx semApePcx];
%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
% meanX = reshape(meanX,5,3);
% semX = reshape(semX,5,3);
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('FF')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
% meanY = reshape(meanY,5,3);
% semY = reshape(semY,5,3);
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('FF')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)