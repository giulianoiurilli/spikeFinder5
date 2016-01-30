odorsRearranged = 1:15;
for idxExp = 1:length(esp);
    
    n_exp = find(cellLogExc1(:,1) == idxExp);
    
    esperimento = cellLogExc1(n_exp,:);
    
    for j = 1:length(n_exp)
        idxShank = esperimento(j,2);
        idxUnit = esperimento(j,3);
        plotRasterResponse(espe,idxExp, idxShank, idxUnit, odorsRearranged)
    end
end