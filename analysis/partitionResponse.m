%function [popCoupling, odorDrive] = partitionResponse(respI, idxShank, idxUnit, idxOdor, n_trials, shank)

load('units.mat');
load('parameters.mat');

for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        for idxOdor = 1:odors
            shank(idxShank).cell(idxUnit).odor(idxOdor).popCoupling = [];
            shank(idxShank).cell(idxUnit).odor(idxOdor).odorDrive = [];
            respI = [];
            
            respI = mean(shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrial_ZscoredHz, 2);
            
            respJ = [];
            respM = [];
            j = 1;
            for idxShankM = 1:4
                for idxUnitM = 1:length(shank(idxShankM).spiketimesUnit)
                    if ~(idxShankM == idxShank) && ~(idxUnitM == idxUnit)
                        respJ = mean(shank(idxShankM).cell(idxUnitM).odor(idxOdor).cycleSpikeRateResponseTrial_ZscoredHz, 2);
                        if ~isnan(sum(respJ(:)))
                            respM(:,j) = respJ;
                            j = j+1;
                        end
                    end
                end
            end
            respM = sum(respJ,2);
            A = [respM ones(n_trials,1)];
            try
                x = A\respI;
                shank(idxShank).cell(idxUnit).odor(idxOdor).popCoupling = x(1);
                shank(idxShank).cell(idxUnit).odor(idxOdor).odorDrive = x(2);
            catch
                shank(idxShank).cell(idxUnit).odor(idxOdor).popCoupling = nan;
                shank(idxShank).cell(idxUnit).odor(idxOdor).odorDrive = nan;
            end
        end
    end
end

save('units.mat', 'shank', '-append')



