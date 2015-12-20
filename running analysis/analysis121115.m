
for idxExp = 1:8;

n_exp = find(cellLog300(:,1) == idxExp);

esperimento = cellLog300(n_exp,:);

for j = 1:length(n_exp)
    idxShank = esperimento(j,2); 
    idxUnit = esperimento(j,3); 
    plotRasterResponse(espe,idxExp, idxShank, idxUnit, odorsRearranged)
end
end