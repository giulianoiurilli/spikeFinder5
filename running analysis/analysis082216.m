esp = coa15.esp;
espe = coa151.espe;
cells_to_use = [6 1 2;...
    11 4 2;...
    10 3 7;...
    5 4 8;...
    12 4 9];
for j = 1:5
    plotResponses_in(esp, espe, cells_to_use(j,1), cells_to_use(j,2), cells_to_use(j,3), coaC);
end



esp = pcx15.esp;
espe = pcx151.espe;
cells_to_use = [9 3 8;...
    8 1 2;...
    1 1 6;...
    1 3 2;...
    8 1 1];
for j = 1:5
    plotResponses_in(esp, espe, cells_to_use(j,1), cells_to_use(j,2), cells_to_use(j,3), pcxC);
end









