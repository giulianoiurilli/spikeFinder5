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
X11appNotnan = notnanX11([4 9]);
X11mean = nanmean(X11app);
X11sem = nanstd(X11app) ./ sqrt(X11appNotnan - ones(1,2));

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
X12appNotnan = notnanX12([5 10 15]);
X12mean = nanmean(X12app);
X12sem = nanstd(X12app) ./ sqrt(X12appNotnan - ones(1,3));

X13 = McoaAA.auRoc;
X13(X13<0.5) = NaN;
X13(McoaAA.significance==0) = NaN;
for j = 1:15
    app = [];
    app = X13(:,j);
    app(isnan(app)) = [];
    notnanX13(j) = numel(app);
end
X13app = X13(:,1:10);
X13appNotnan = notnanX13(1:10);
X13mean = nanmean(X13app);
X13sem = nanstd(X13app) ./ sqrt(X13appNotnan - ones(1,10));


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
Y11appNotnan = notnanY11([4 9]);
Y11mean = nanmean(Y11app);
Y11sem = nanstd(Y11app) ./ sqrt(Y11appNotnan - ones(1,2));


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
Y12appNotnan = notnanY12([5 10 15]);
Y12mean = nanmean(Y12app);
Y12sem = nanstd(Y12app) ./ sqrt(Y12appNotnan - ones(1,3));

Y13 = MpcxAA.auRoc;
Y13(Y13<0.5) = NaN;
Y13(MpcxAA.significance==0) = NaN;
for j = 1:15
    app = [];
    app = Y13(:,j);
    app(isnan(app)) = [];
    notnanY13(j) = numel(app);
end
Y13app = Y13(:,1:10);
Y13appNotnan = notnanY13(1:10);
Y13mean = nanmean(Y13app);
Y13sem = nanstd(Y13app) ./ sqrt(Y13appNotnan - ones(1,10));

meanX = [X11mean X12mean X13mean];
meanY = [Y11mean Y12mean Y13mean];
semX = [X11sem X12sem X13sem];
semY = [Y11sem Y12sem Y13sem];
%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
meanX = reshape(meanX,5,3);
semX = reshape(semX,5,3);
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('auROC')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
meanY = reshape(meanY,5,3);
semY = reshape(semY,5,3);
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('auROC')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)




%% bar plot deltaRsp/odor
X11 = Mcoa15.DeltaRspMean;
X11(Mcoa15.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X11(:,j);
    app(isnan(app)) = [];
    notnanX11(j) = numel(app);
end
X11app = X11(:,[4 9]);
X11appNotnan = notnanX11([4 9]);
X11mean = nanmean(X11app);
X11sem = nanstd(X11app) ./ sqrt(X11appNotnan - ones(1,2));

X12 = McoaCS.DeltaRspMean;
X12(McoaCS.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X12(:,j);
    app(isnan(app)) = [];
    notnanX12(j) = numel(app);
end
X12app = X12(:,[5 10 15]);
X12appNotnan = notnanX12([5 10 15]);
X12mean = nanmean(X12app);
X12sem = nanstd(X12app) ./ sqrt(X12appNotnan - ones(1,3));

X13 = McoaAA.DeltaRspMean;
X13(McoaAA.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X13(:,j);
    app(isnan(app)) = [];
    notnanX13(j) = numel(app);
end
X13app = X13(:,1:10);
X13appNotnan = notnanX13(1:10);
X13mean = nanmean(X13app);
X13sem = nanstd(X13app) ./ sqrt(X13appNotnan - ones(1,10));


Y11 = Mpcx15.DeltaRspMean;
Y11(Mpcx15.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y11(:,j);
    app(isnan(app)) = [];
    notnanY11(j) = numel(app);
end
Y11app = Y11(:,[4 9]);
Y11appNotnan = notnanY11([4 9]);
Y11mean = nanmean(Y11app);
Y11sem = nanstd(Y11app) ./ sqrt(Y11appNotnan - ones(1,2));


Y12 = MpcxCS.DeltaRspMean;
Y12(MpcxCS.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y12(:,j);
    app(isnan(app)) = [];
    notnanY12(j) = numel(app);
end
Y12app = Y12(:,[5 10 15]);
Y12appNotnan = notnanY12([5 10 15]);
Y12mean = nanmean(Y12app);
Y12sem = nanstd(Y12app) ./ sqrt(Y12appNotnan - ones(1,3));

Y13 = MpcxAA.DeltaRspMean;
Y13(MpcxAA.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y13(:,j);
    app(isnan(app)) = [];
    notnanY13(j) = numel(app);
end
Y13app = Y13(:,1:10);
Y13appNotnan = notnanY13(1:10);
Y13mean = nanmean(Y13app);
Y13sem = nanstd(Y13app) ./ sqrt(Y13appNotnan - ones(1,10));

meanX = [X11mean X12mean X13mean];
meanY = [Y11mean Y12mean Y13mean];
semX = [X11sem X12sem X13sem];
semY = [Y11sem Y12sem Y13sem];
%%
notnanX11_1 = X11app(~isnan(X11app(:,1)),1);
notnanX11_2 = X11app(~isnan(X11app(:,2)),2);

notnanX12_1 = X12app(~isnan(X12app(:,1)),1);
notnanX12_2 = X12app(~isnan(X12app(:,2)),2);
notnanX12_3 = X12app(~isnan(X12app(:,3)),3);

notnanX13_1 = X13app(~isnan(X13app(:,1)),1);
notnanX13_2 = X13app(~isnan(X13app(:,2)),2);
notnanX13_3 = X13app(~isnan(X13app(:,3)),3);
notnanX13_4 = X13app(~isnan(X13app(:,4)),4);
notnanX13_5 = X13app(~isnan(X13app(:,5)),5);
notnanX13_6 = X13app(~isnan(X13app(:,6)),6);
notnanX13_7 = X13app(~isnan(X13app(:,7)),7);
notnanX13_8 = X13app(~isnan(X13app(:,8)),8);
notnanX13_9 = X13app(~isnan(X13app(:,9)),9);
notnanX13_10 = X13app(~isnan(X13app(:,10)),10);

dataX = [notnanX11_1; notnanX11_2; notnanX12_1; notnanX12_2; notnanX12_3; notnanX13_1; notnanX13_2; notnanX13_3; notnanX13_4; notnanX13_5; notnanX13_6; notnanX13_7; notnanX13_8; notnanX13_9; notnanX13_10];

gOdor1 = [ones(1,numel(notnanX11_1)),... 
    2*ones(1,numel(notnanX11_2)),...
    3*ones(1,numel(notnanX12_1)),...
    4*ones(1,numel(notnanX12_2)),...
    5*ones(1,numel(notnanX12_3)),...
    6*ones(1,numel(notnanX13_1)),...
    7*ones(1,numel(notnanX13_2)),...
    8*ones(1,numel(notnanX13_3)),...
    9*ones(1,numel(notnanX13_4)),...
    10*ones(1,numel(notnanX13_5)),...
    11*ones(1,numel(notnanX13_6)),...
    12*ones(1,numel(notnanX13_7)),...
    13*ones(1,numel(notnanX13_8)),...
    14*ones(1,numel(notnanX13_9)),...
    15*ones(1,numel(notnanX13_10))];
gValence1 = [ones(1,numel(notnanX11_1)+numel(notnanX11_2)+numel(notnanX12_1)+numel(notnanX12_2)+numel(notnanX12_3)),...
    2*ones(1,numel(notnanX13_1)+numel(notnanX13_2)+numel(notnanX13_3)+numel(notnanX13_4)+numel(notnanX13_5)),...
    3*ones(1,numel(notnanX13_6)+numel(notnanX13_7)+numel(notnanX13_8)+numel(notnanX13_9)+numel(notnanX13_10))];


notnanY11_1 = Y11app(~isnan(Y11app(:,1)),1);
notnanY11_2 = Y11app(~isnan(Y11app(:,2)),2);

notnanY12_1 = Y12app(~isnan(Y12app(:,1)),1);
notnanY12_2 = Y12app(~isnan(Y12app(:,2)),2);
notnanY12_3 = Y12app(~isnan(Y12app(:,3)),3);

notnanY13_1 = Y13app(~isnan(Y13app(:,1)),1);
notnanY13_2 = Y13app(~isnan(Y13app(:,2)),2);
notnanY13_3 = Y13app(~isnan(Y13app(:,3)),3);
notnanY13_4 = Y13app(~isnan(Y13app(:,4)),4);
notnanY13_5 = Y13app(~isnan(Y13app(:,5)),5);
notnanY13_6 = Y13app(~isnan(Y13app(:,6)),6);
notnanY13_7 = Y13app(~isnan(Y13app(:,7)),7);
notnanY13_8 = Y13app(~isnan(Y13app(:,8)),8);
notnanY13_9 = Y13app(~isnan(Y13app(:,9)),9);
notnanY13_10 = Y13app(~isnan(Y13app(:,10)),10);

dataY = [notnanY11_1; notnanY11_2; notnanY12_1; notnanY12_2; notnanY12_3; notnanY13_1; notnanY13_2; notnanY13_3; notnanY13_4; notnanY13_5; notnanY13_6; notnanY13_7; notnanY13_8; notnanY13_9; notnanY13_10];
gOdor2 = [ones(1,numel(notnanY11_1)),... 
    2*ones(1,numel(notnanY11_2)),...
    3*ones(1,numel(notnanY12_1)),...
    4*ones(1,numel(notnanY12_2)),...
    5*ones(1,numel(notnanY12_3)),...
    6*ones(1,numel(notnanY13_1)),...
    7*ones(1,numel(notnanY13_2)),...
    8*ones(1,numel(notnanY13_3)),...
    9*ones(1,numel(notnanY13_4)),...
    10*ones(1,numel(notnanY13_5)),...
    11*ones(1,numel(notnanY13_6)),...
    12*ones(1,numel(notnanY13_7)),...
    13*ones(1,numel(notnanY13_8)),...
    14*ones(1,numel(notnanY13_9)),...
    15*ones(1,numel(notnanY13_10))];
gValence2 = [ones(1,numel(notnanY11_1)+numel(notnanY11_2)+numel(notnanY12_1)+numel(notnanY12_2)+numel(notnanY12_3)),...
    2*ones(1,numel(notnanY13_1)+numel(notnanY13_2)+numel(notnanY13_3)+numel(notnanY13_4)+numel(notnanY13_5)),...
    3*ones(1,numel(notnanY13_6)+numel(notnanY13_7)+numel(notnanY13_8)+numel(notnanY13_9)+numel(notnanY13_10))];

gOdor = [gOdor1, gOdor2];
gValence = [gValence1, gValence2];
gArea = [ones(1,numel(dataX)), 2*ones(1,numel(dataY))];

p = anovan([dataX', dataY'], {gOdor, gValence, gArea})
%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
meanX = reshape(meanX,5,3);
semX = reshape(semX,5,3);
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('deltaR')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
meanY = reshape(meanY,5,3);
semY = reshape(semY,5,3);
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('deltaR')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)


%% bar plot fractionExc/odor
X11 = Mcoa15.rspPeakFractionExc*10;
X11(Mcoa15.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X11(:,j);
    app(isnan(app)) = [];
    notnanX11(j) = numel(app);
end
X11app = X11(:,[4 9]);
X11appNotnan = notnanX11([4 9]);
X11mean = nanmean(X11app);
X11sem = nanstd(X11app) ./ sqrt(X11appNotnan - ones(1,2));

X12 = McoaCS.rspPeakFractionExc*10;
X12(McoaCS.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X12(:,j);
    app(isnan(app)) = [];
    notnanX12(j) = numel(app);
end
X12app = X12(:,[5 10 15]);
X12appNotnan = notnanX12([5 10 15]);
X12mean = nanmean(X12app);
X12sem = nanstd(X12app) ./ sqrt(X12appNotnan - ones(1,3));

X13 = McoaAA.rspPeakFractionExc*10;
X13(McoaAA.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X13(:,j);
    app(isnan(app)) = [];
    notnanX13(j) = numel(app);
end
X13app = X13(:,1:10);
X13appNotnan = notnanX13(1:10);
X13mean = nanmean(X13app);
X13sem = nanstd(X13app) ./ sqrt(X13appNotnan - ones(1,10));


Y11 = Mpcx15.rspPeakFractionExc*10;
Y11(Mpcx15.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y11(:,j);
    app(isnan(app)) = [];
    notnanY11(j) = numel(app);
end
Y11app = Y11(:,[4 9]);
Y11appNotnan = notnanY11([4 9]);
Y11mean = nanmean(Y11app);
Y11sem = nanstd(Y11app) ./ sqrt(Y11appNotnan - ones(1,2));


Y12 = MpcxCS.rspPeakFractionExc*10;
Y12(MpcxCS.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y12(:,j);
    app(isnan(app)) = [];
    notnanY12(j) = numel(app);
end
Y12app = Y12(:,[5 10 15]);
Y12appNotnan = notnanY12([5 10 15]);
Y12mean = nanmean(Y12app);
Y12sem = nanstd(Y12app) ./ sqrt(Y12appNotnan - ones(1,3));

Y13 = MpcxAA.rspPeakFractionExc*10;
Y13(MpcxAA.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y13(:,j);
    app(isnan(app)) = [];
    notnanY13(j) = numel(app);
end
Y13app = Y13(:,1:10);
Y13appNotnan = notnanY13(1:10);
Y13mean = nanmean(Y13app);
Y13sem = nanstd(Y13app) ./ sqrt(Y13appNotnan - ones(1,10));

meanX = [X11mean X12mean X13mean];
meanY = [Y11mean Y12mean Y13mean];
semX = [X11sem X12sem X13sem];
semY = [Y11sem Y12sem Y13sem];




notnanX11_1 = X11app(~isnan(X11app(:,1)),1);
notnanX11_2 = X11app(~isnan(X11app(:,2)),2);

notnanX12_1 = X12app(~isnan(X12app(:,1)),1);
notnanX12_2 = X12app(~isnan(X12app(:,2)),2);
notnanX12_3 = X12app(~isnan(X12app(:,3)),3);

notnanX13_1 = X13app(~isnan(X13app(:,1)),1);
notnanX13_2 = X13app(~isnan(X13app(:,2)),2);
notnanX13_3 = X13app(~isnan(X13app(:,3)),3);
notnanX13_4 = X13app(~isnan(X13app(:,4)),4);
notnanX13_5 = X13app(~isnan(X13app(:,5)),5);
notnanX13_6 = X13app(~isnan(X13app(:,6)),6);
notnanX13_7 = X13app(~isnan(X13app(:,7)),7);
notnanX13_8 = X13app(~isnan(X13app(:,8)),8);
notnanX13_9 = X13app(~isnan(X13app(:,9)),9);
notnanX13_10 = X13app(~isnan(X13app(:,10)),10);

dataX = [notnanX11_1; notnanX11_2; notnanX12_1; notnanX12_2; notnanX12_3; notnanX13_1; notnanX13_2; notnanX13_3; notnanX13_4; notnanX13_5; notnanX13_6; notnanX13_7; notnanX13_8; notnanX13_9; notnanX13_10];

gOdor1 = [ones(1,numel(notnanX11_1)),... 
    2*ones(1,numel(notnanX11_2)),...
    3*ones(1,numel(notnanX12_1)),...
    4*ones(1,numel(notnanX12_2)),...
    5*ones(1,numel(notnanX12_3)),...
    6*ones(1,numel(notnanX13_1)),...
    7*ones(1,numel(notnanX13_2)),...
    8*ones(1,numel(notnanX13_3)),...
    9*ones(1,numel(notnanX13_4)),...
    10*ones(1,numel(notnanX13_5)),...
    11*ones(1,numel(notnanX13_6)),...
    12*ones(1,numel(notnanX13_7)),...
    13*ones(1,numel(notnanX13_8)),...
    14*ones(1,numel(notnanX13_9)),...
    15*ones(1,numel(notnanX13_10))];
gValence1 = [ones(1,numel(notnanX11_1)+numel(notnanX11_2)+numel(notnanX12_1)+numel(notnanX12_2)+numel(notnanX12_3)),...
    2*ones(1,numel(notnanX13_1)+numel(notnanX13_2)+numel(notnanX13_3)+numel(notnanX13_4)+numel(notnanX13_5)),...
    3*ones(1,numel(notnanX13_6)+numel(notnanX13_7)+numel(notnanX13_8)+numel(notnanX13_9)+numel(notnanX13_10))];


notnanY11_1 = Y11app(~isnan(Y11app(:,1)),1);
notnanY11_2 = Y11app(~isnan(Y11app(:,2)),2);

notnanY12_1 = Y12app(~isnan(Y12app(:,1)),1);
notnanY12_2 = Y12app(~isnan(Y12app(:,2)),2);
notnanY12_3 = Y12app(~isnan(Y12app(:,3)),3);

notnanY13_1 = Y13app(~isnan(Y13app(:,1)),1);
notnanY13_2 = Y13app(~isnan(Y13app(:,2)),2);
notnanY13_3 = Y13app(~isnan(Y13app(:,3)),3);
notnanY13_4 = Y13app(~isnan(Y13app(:,4)),4);
notnanY13_5 = Y13app(~isnan(Y13app(:,5)),5);
notnanY13_6 = Y13app(~isnan(Y13app(:,6)),6);
notnanY13_7 = Y13app(~isnan(Y13app(:,7)),7);
notnanY13_8 = Y13app(~isnan(Y13app(:,8)),8);
notnanY13_9 = Y13app(~isnan(Y13app(:,9)),9);
notnanY13_10 = Y13app(~isnan(Y13app(:,10)),10);

dataY = [notnanY11_1; notnanY11_2; notnanY12_1; notnanY12_2; notnanY12_3; notnanY13_1; notnanY13_2; notnanY13_3; notnanY13_4; notnanY13_5; notnanY13_6; notnanY13_7; notnanY13_8; notnanY13_9; notnanY13_10];
gOdor2 = [ones(1,numel(notnanY11_1)),... 
    2*ones(1,numel(notnanY11_2)),...
    3*ones(1,numel(notnanY12_1)),...
    4*ones(1,numel(notnanY12_2)),...
    5*ones(1,numel(notnanY12_3)),...
    6*ones(1,numel(notnanY13_1)),...
    7*ones(1,numel(notnanY13_2)),...
    8*ones(1,numel(notnanY13_3)),...
    9*ones(1,numel(notnanY13_4)),...
    10*ones(1,numel(notnanY13_5)),...
    11*ones(1,numel(notnanY13_6)),...
    12*ones(1,numel(notnanY13_7)),...
    13*ones(1,numel(notnanY13_8)),...
    14*ones(1,numel(notnanY13_9)),...
    15*ones(1,numel(notnanY13_10))];
gValence2 = [ones(1,numel(notnanY11_1)+numel(notnanY11_2)+numel(notnanY12_1)+numel(notnanY12_2)+numel(notnanY12_3)),...
    2*ones(1,numel(notnanY13_1)+numel(notnanY13_2)+numel(notnanY13_3)+numel(notnanY13_4)+numel(notnanY13_5)),...
    3*ones(1,numel(notnanY13_6)+numel(notnanY13_7)+numel(notnanY13_8)+numel(notnanY13_9)+numel(notnanY13_10))];

gOdor = [gOdor1, gOdor2];
gValence = [gValence1, gValence2];
gArea = [ones(1,numel(dataX)), 2*ones(1,numel(dataY))];

p = anovan([dataX', dataY'], {gOdor, gValence, gArea})
%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
meanX = reshape(meanX,5,3);
semX = reshape(semX,5,3);
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('fExc')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
meanY = reshape(meanY,5,3);
semY = reshape(semY,5,3);
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('fExc')
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
X11appNotnan = notnanX11([4 9]);
X11mean = nanmean(X11app);
X11sem = nanstd(X11app) ./ sqrt(X11appNotnan - ones(1,2));

X12 = McoaCS.ff;
X12(McoaCS.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X12(:,j);
    app(isnan(app)) = [];
    notnanX12(j) = numel(app);
end
X12app = X12(:,[5 10 15]);
X12appNotnan = notnanX12([5 10 15]);
X12mean = nanmean(X12app);
X12sem = nanstd(X12app) ./ sqrt(X12appNotnan - ones(1,3));

X13 = McoaAA.ff;
X13(McoaAA.significance<1) = NaN;
for j = 1:15
    app = [];
    app = X13(:,j);
    app(isnan(app)) = [];
    notnanX13(j) = numel(app);
end
X13app = X13(:,1:10);
X13appNotnan = notnanX13(1:10);
X13mean = nanmean(X13app);
X13sem = nanstd(X13app) ./ sqrt(X13appNotnan - ones(1,10));


Y11 = Mpcx15.ff;
Y11(Mpcx15.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y11(:,j);
    app(isnan(app)) = [];
    notnanY11(j) = numel(app);
end
Y11app = Y11(:,[4 9]);
Y11appNotnan = notnanY11([4 9]);
Y11mean = nanmean(Y11app);
Y11sem = nanstd(Y11app) ./ sqrt(Y11appNotnan - ones(1,2));


Y12 = MpcxCS.ff;
Y12(MpcxCS.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y12(:,j);
    app(isnan(app)) = [];
    notnanY12(j) = numel(app);
end
Y12app = Y12(:,[5 10 15]);
Y12appNotnan = notnanY12([5 10 15]);
Y12mean = nanmean(Y12app);
Y12sem = nanstd(Y12app) ./ sqrt(Y12appNotnan - ones(1,3));

Y13 = MpcxAA.ff;
Y13(MpcxAA.significance<1) = NaN;
for j = 1:15
    app = [];
    app = Y13(:,j);
    app(isnan(app)) = [];
    notnanY13(j) = numel(app);
end
Y13app = Y13(:,1:10);
Y13appNotnan = notnanY13(1:10);
Y13mean = nanmean(Y13app);
Y13sem = nanstd(Y13app) ./ sqrt(Y13appNotnan - ones(1,10));

meanX = [X11mean X12mean X13mean];
meanY = [Y11mean Y12mean Y13mean];
semX = [X11sem X12sem X13sem];
semY = [Y11sem Y12sem Y13sem];

%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
meanX = reshape(meanX,5,3);
semX = reshape(semX,5,3);
errorbar_groups(meanX,semX,'bar_colors', cc2, 'errorbar_colors', cc2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('ff')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
meanY = reshape(meanY,5,3);
semY = reshape(semY,5,3);
errorbar_groups(meanY,semY,'bar_colors', cc1, 'errorbar_colors', cc1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('ff')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)


   