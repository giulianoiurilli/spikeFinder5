function findUnit(idxExp, idxShank, idxUnit, lista)

startFolder = pwd;
cartella = lista{idxExp};
cd(cartella)
plotRasters(idxShank, idxUnit)
cd(startFolder)
