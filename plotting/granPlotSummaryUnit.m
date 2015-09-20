toFolder = pwd;
new_dir = 'Units figures';
toFolder = fullfile(toFolder, new_dir);
rmdir(toFolder,'s');
mkdir(toFolder)
load('units.mat');
load('parameters.mat');
for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        if ~isempty(shank(idxShank).spiketimesUnit)
            %plotSummaryUnit
            plotRastersBatch
        end
    end
end