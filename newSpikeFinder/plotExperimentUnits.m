

%%
close all

load('units.mat')

for idxShank = 1:4
    if ~isnan(shank(idxShank).SUA.clusterID{1})
        for idxUnit = 1:length(shank(idxShank).SUA.sdf_trial)
            data = shank;
            plotUnitResponses(data,idxShank, idxUnit)
        end
    end
end
    