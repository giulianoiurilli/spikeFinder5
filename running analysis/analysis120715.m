
odorToUse = [2 3 4 5;...
    7 8 9 10;...
    12 13 14 15];
idxArea = 2;
% y = [];
% odorFactor = [];
% concFactor = [];
% areaFactor = [];
for idxUse = 1:3
    appResp = [];
    %appResp = auRocExc300(:,odorToUse(idxUse,:));
    appResp = auRocExc300(:,odorToUse(idxUse,:));
    appResponsive = [];
    %appResponsive = respExc300(:,odorToUse(idxUse,:));
    appResponsive = respExc300(:,odorToUse(idxUse,:));
    appResp(appResponsive == 0) = NaN;
    for idxLevel = 1:4
        yApp = [];
        yApp = appResp(~isnan(appResp(:, idxLevel)),idxLevel)';
        y = [y yApp];
        odorFactor = [odorFactor repmat(idxUse, 1, length(yApp))];
        concFactor = [concFactor repmat(idxLevel, 1, length(yApp))];
        areaFactor = [areaFactor repmat(idxArea, 1, length(yApp))];
    end
end
%%

M  = [y' areaFactor' odorFactor' concFactor'];
%%
[pvals, tbl, stats] = anovan(y, {areaFactor odorFactor concFactor}, 'model', 'full', 'nested', [0,0,0; 0,0,0; 0,1,0], 'random', [2, 3],  'varnames', {'Area' 'Odor' 'Concentration'});
%%
results = multcompare(stats,'Dimension',[1,3])
%%
[pvals, tbl, stats] = anovan(y, {areaFactor odorFactor concFactor}, 'model', 'full', 'random', [2, 3],  'varnames', {'Area' 'Odor' 'Concentration'});
results = multcompare(stats,'Dimension',[1,3])