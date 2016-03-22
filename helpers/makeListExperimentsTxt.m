clc
fid = fopen( 'Lista Esperimenti.txt', 'wt' );
idxL = 1;
while idxL < length(List)
    esp = List{idxL};
    fprintf(fid, '%s\n', esp);
    idxL = idxL + 1;
end
fprintf(fid, '%s', esp);
fclose(fid);