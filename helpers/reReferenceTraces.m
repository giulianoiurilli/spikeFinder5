function HPFiltered_ReReferencedTraces = reReferenceTraces(HPFilteredTraces)

tic
HPFiltered_ReReferencedTraces = nan(size(HPFilteredTraces));
for idxShank = 1:4
    stringa = sprintf('Re-referencing shank %d', idxShank);
    disp(stringa);
    app = HPFilteredTraces;
    appToReReference = app(1 + (idxShank-1)*8 : 8 + (idxShank-1)*8, :);
    app(1 + (idxShank-1)*8 : 8 + (idxShank-1)*8, :) = [];
    medianTrace = median(app);
    HPFiltered_ReReferencedTraces(1 + (idxShank-1)*8 : 8 + (idxShank-1)*8, :) = bsxfun(@minus, appToReReference, medianTrace);
end
disp('Re-referencing done.')
toc

end