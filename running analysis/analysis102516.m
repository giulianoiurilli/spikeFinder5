clims = [0 1];
figure
subplot(1,3,1)
imagesc(aurocs1000ms(:,1:5), clims); colormap(brewermap([],'*RdBu')); axis tight
subplot(1,3,2)
imagesc(aurocs1000ms(:,6:10), clims); colormap(brewermap([],'*RdBu')); axis tight
subplot(1,3,3)
imagesc(aurocs1000ms(:,11:15), clims); colormap(brewermap([],'*RdBu')); axis tight

clims = [0 1];
figure
subplot(1,3,1)
imagesc(aurocs300ms(:,1:5), clims); colormap(brewermap([],'*RdBu')); axis tight
subplot(1,3,2)
imagesc(aurocs300ms(:,6:10), clims); colormap(brewermap([],'*RdBu')); axis tight
subplot(1,3,3)
imagesc(aurocs300ms(:,11:15), clims); colormap(brewermap([],'*RdBu')); axis tight



pMeanExc1000 = sum(responsivenessExc1000ms) ./ size(responsivenessExc1000ms,1);
pSemExc1000  = sqrt((pMeanExc1000 .* (1 - pMeanExc1000)) ./ size(responsivenessExc1000ms,1));
figure
plot(pMeanExc1000)
title('1000')

pMeanExc300 = sum(responsivenessExc300ms) ./ size(responsivenessExc300ms,1);
figure
plot(pMeanExc300)
title('300')
