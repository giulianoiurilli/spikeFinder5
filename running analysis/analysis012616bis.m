odorsRearranged = 1:15;
% A = [2 1 4; 3 2 1; 3 2 2; 5 4 7; 5 4 8; 6 2 4; 7 2 1; 9 1 2; 10 2 7; 11 4 10; 14 2 1; 14 4 6];
A = [2 4 1; 3 3 3; 3 4 1; 7 3 2; 8 1 5];
    
    for j = 1:size(A,1)
        idxExp = A(j,1);
        idxShank = A(j,2);
        idxUnit = A(j,3);
        plotRasterResponse(espe,idxExp, idxShank, idxUnit, odorsRearranged)
    end
