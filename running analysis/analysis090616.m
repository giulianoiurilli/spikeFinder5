[accuracyResponses2CoaAAaaTrueNoDecorr, weightsCoa] = l_svmClassifyValence(coaAA.esp, 1:10, 5, 1);
[accuracyResponses2PcxAAaaTrueNoDecorr, weightsPcx] = l_svmClassifyValence(pcxAA.esp, 1:10, 5, 1);

[aurocBetweenValenceCoa, aurocBetweenValenceSigCoa, auRocValenceCoa, cellLogValenceCoa] = valenceAnalysis(coaAA.esp);
[aurocBetweenValencePcx, aurocBetweenValenceSigPcx, auRocValencePcx, cellLogValencePcx] = valenceAnalysis(pcxAA.esp);

auRocValenceCoa = [auRocValenceCoa aurocBetweenValenceCoa];
auRocValenceCoa = sortrows(auRocValenceCoa, size(auRocValenceCoa,2));
auRocValenceCoa(:,end) = [];
auRocValencePcx = [auRocValencePcx aurocBetweenValencePcx];
auRocValencePcx = sortrows(auRocValencePcx, size(auRocValencePcx,2));
auRocValencePcx(:,end) = [];

figure
clims = [0 1];
imagesc(auRocValenceCoa, clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])
figure
clims = [0 1];
imagesc(auRocValencePcx, clims); colormap(brewermap([],'*RdBu')); axis tight
set(gca,'XTick',[])
set(gca,'XTickLabel',[])
set(gca,'YTick',[])
set(gca,'YTickLabel',[])

figure;
plot(flipud(aurocBetweenValenceCoa), weightsCoa, 'or')
axis square
[rhoCoa, pCoa] = corr(flipud(aurocBetweenValenceCoa), weightsCoa)

figure;
plot(flipud(aurocBetweenValencePcx), weightsPcx, 'ok')
axis square
[rhoPcx, pPcx] = corr(flipud(aurocBetweenValencePcx), weightsPcx)

%%
accuracyResponses2CoaAAaaTrueNoDecorr1 = l_svmClassifyValence(coaAA.esp, 1:10, abs(aurocBetweenValenceCoa - 0.5), 2);
accuracyResponses2PcxAAaaTrueNoDecorr1 = l_svmClassifyValence(pcxAA.esp, 1:10, abs(aurocBetweenValencePcx - 0.5), 2);

accuracyResponses2CoaAAaaTrueNoDecorr2 = l_svmClassifyValence(coaAA.esp, 1:10, abs(weightsCoa), 2);
accuracyResponses2PcxAAaaTrueNoDecorr2 = l_svmClassifyValence(pcxAA.esp, 1:10, abs(weightsPcx), 2);



figure
plot(mean(accuracyResponses2CoaAAaaTrueNoDecorr1), '-r')
hold on
plot(mean(accuracyResponses2PcxAAaaTrueNoDecorr1), '-k')
figure
plot(mean(accuracyResponses2CoaAAaaTrueNoDecorr2), '-r')
hold on
plot(mean(accuracyResponses2PcxAAaaTrueNoDecorr2), '-k')

figure
plot(diff(mean(accuracyResponses2CoaAAaaTrueNoDecorr1)), ':r')
hold on
plot(diff(mean(accuracyResponses2PcxAAaaTrueNoDecorr1)), ':k')
hold on
plot(diff(mean(accuracyResponses2CoaAAaaTrueNoDecorr2)), '-r')
hold on
plot(diff(mean(accuracyResponses2PcxAAaaTrueNoDecorr2)), '-k')