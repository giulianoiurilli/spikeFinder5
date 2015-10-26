startingFolder = pwd;
excCellOdorPairs = 0;
inhCellOdorPairs = 0;
rocTuning = [];
for idxExp = 1 : length(List) %-1
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell) 
            rocOdor = ones(1,odors) * 0.5;
            idxO = 1;
            for idxOdor = odorsRearranged 
                rocOdor(idxO) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC;
                idxO = idxO + 1;
            end
            rocTuning = [rocTuning; rocOdor];
        end
    end
end

auROCsums = sum(rocTuning,2);
app = [rocTuning auROCsums];
app = sortrows(app,size(app,2));
rocTuningSorted = app(:,1:size(rocTuning,2));

figure;

imagesc(rocTuningSorted); axis xy; colormap(brewermap([],'*RdBu')); axis tight; colorbar
Xfig = 600;
Yfig = 900;
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')
