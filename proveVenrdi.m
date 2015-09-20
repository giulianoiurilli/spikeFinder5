selectedSignalVectorT_app = zscore(selectedSignalVectorT');
selectedSignalVectorT = selectedSignalVectorT_app';
aa = [1 4 7 10 13 2 5 8 11 14 3 6 9 12 15]; 
selectedSignalVectorT(end+1,:) = aa;
app = selectedSignalVectorT';
app = sortrows(app, size(app,2));
selectedSignalVectorT = app';
selectedSignalVectorT(end,:) = [];
X = selectedSignalVectorT;







mappedX = tsne(X);

figure; scatter(mappedX(:,1), mappedX(:,2), 'o');

sim_tuning1 = pdist(mappedX);

squared_simTuning1 = squareform(sim_tuning1);

Z = linkage(squared_simTuning1);
h=figure('Name','Categorization1', 'NumberTitle','off');
dendrogram(Z)
c = cophenet(Z,squared_simTuning1)

T = cluster(Z,'maxclust',15);


hidx = cluster(Z,'criterion','distance','cutoff',.05);
figure
for i = 1:max(hidx)
clust = find(hidx==i);
scatter(mappedX(clust,1),mappedX(clust,2));
hold on
end

figure
for i = 1:size(cursor_info,2)

    plot(best_tuning(cursor_info(i).DataIndex,:));
    hold on
end
    

for k=1:max(hidx)
figure
ccc = find(hidx==k);

for i = 1:numel(ccc)

    plot(selectedSignalVectorT(ccc(i),:));
    hold on
end
end







for k=1:max(hidx)
figure
ccc = find(hidx==k);
for i = 1:numel(ccc)
xx(i,:)=(selectedSignalVectorT(ccc(i),:));
end
xxx = mean(xx);
plot(xxx)
clear xx
end



[coeff,score,latent]=pca(selectedSignalVectorT);
figure
imagesc(coeff)
    