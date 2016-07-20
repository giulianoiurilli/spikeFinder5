%%
Mcoa15 = find_Baseline_DeltaRsp_FanoFactor(coa15.esp, odors15, 300);
McoaAA = find_Baseline_DeltaRsp_FanoFactor(coaAA.esp, odors15, 300);
Mpcx15 = find_Baseline_DeltaRsp_FanoFactor(pcx15.esp, odors15, 300);
MpcxAA = find_Baseline_DeltaRsp_FanoFactor(pcxAA.esp, odors15, 300);
McoaCS = find_Baseline_DeltaRsp_FanoFactor(coaCS.esp, odors15, 300);
MpcxCS = find_Baseline_DeltaRsp_FanoFactor(pcxCS.esp, odors15, 300);
logSignificantCoa = [Mcoa15.significance; McoaAA.significance];
logSignificantCoa = logSignificantCoa(:);
logSignificantPcx = [Mpcx15.significance; MpcxAA.significance];
logSignificantPcx = logSignificantPcx(:);


%%
ffCoa = [Mcoa15.ff; McoaAA.ff;];
ffPcx = [Mpcx15.ff; MpcxAA.ff;];

ffCoa = ffCoa(:);
ffPcx = ffPcx(:);

nNanCoa = sum((isnan(ffCoa)));
nNanPcx = sum(isnan(ffPcx));

nCoa = numel(ffCoa);
nPcx = numel(ffPcx);

ffCoaMean = nanmean(ffCoa);
ffPcxMean = nanmean(ffPcx);

ffCoaSem = nanstd(ffCoa)/sqrt(nCoa - nNanCoa -1);
ffPcxSem = nanstd(ffPcx)/sqrt(nPcx - nNanPcx - 1);
%%
ffCoaBsl = [Mcoa15.bsl_ff; McoaAA.bsl_ff;];
ffPcxBsl = [Mpcx15.bsl_ff; MpcxAA.bsl_ff;];

ffCoaBsl = ffCoaBsl(:);
ffPcxBsl = ffPcxBsl(:);

nNanCoaBsl = sum(isnan(ffCoaBsl));
nNanPcxBsl = sum(isnan(ffPcxBsl));

nCoaBsl = numel(ffCoaBsl);
nPcxBsl = numel(ffPcxBsl);

ffCoaMeanBsl = nanmean(ffCoaBsl);
ffPcxMeanBsl = nanmean(ffPcxBsl);

ffCoaSemBsl = nanstd(ffCoaBsl)/sqrt(nCoaBsl - nNanCoaBsl -1);
ffPcxSemBsl = nanstd(ffPcxBsl)/sqrt(nPcxBsl - nNanPcxBsl - 1);

%%
cc2 = [227,26,28; 227,26,28; 227,26,28; 227,26,28; 227,26,28] ./ 255;
% meanX = reshape(meanX,5,3);
% semX = reshape(semX,5,3);
errorbar_groups([ffCoaMeanBsl ffCoaMean], [ffCoaSemBsl ffCoaSem],'bar_colors', cc2, 'errorbar_colors', cc2)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('FF')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)

cc1 = [82,82,82; 82,82,82; 82,82,82; 82,82,82; 82,82,82] ./ 255;
% meanY = reshape(meanY,5,3);
% semY = reshape(semY,5,3);
errorbar_groups([ffPcxMeanBsl ffPcxMean],[ffPcxSemBsl ffPcxSem],'bar_colors', cc1, 'errorbar_colors', cc1)
set(gcf,'color','white', 'PaperPositionMode', 'auto');
title('FF')
set(gca, 'box', 'off', 'tickDir', 'out', 'XTick' , [], 'XTickLabel', [], 'fontname', 'avenir', 'fontsize', 14)
