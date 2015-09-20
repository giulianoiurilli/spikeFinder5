%clear all

        % crea una collezione di tutti i cicli pre-odore


load('units.mat');
load('parameters.mat');



for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        sdfCycleBsl = zeros(n_trials * preInhalations * odors, cycleLengthDeg);
        binCycleBsl = zeros(n_trials * preInhalations * odors, cycleLengthDeg);

        cycleCounter = 1;
        for idxOdor = 1:odors
            sdfApp = zeros(n_trials, (preInhalations + postInhalations) * cycleLengthDeg);
            sdfAppBsl = zeros(n_trials, preInhalations * cycleLengthDeg);
            sdfApp = shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz;
            sdfAppBsl = sdfApp(:, 1 : preInhalations * cycleLengthDeg);
            binApp = zeros(n_trials, (preInhalations + postInhalations) * cycleLengthDeg);
            binAppBsl = zeros(n_trials, preInhalations * cycleLengthDeg);
            binApp = shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad;
            binAppBsl = binApp(:, 1 : preInhalations * cycleLengthDeg);
            for idxCycle = 1:preInhalations
                sdfCycleBsl((cycleCounter - 1) * n_trials + 1 : cycleCounter*n_trials,:) = sdfAppBsl(:, (idxCycle-1) * cycleLengthDeg + 1 : idxCycle * cycleLengthDeg);
                binCycleBsl((cycleCounter - 1) * n_trials + 1 : cycleCounter*n_trials,:) = binAppBsl(:, (idxCycle-1) * cycleLengthDeg + 1 : idxCycle * cycleLengthDeg);
                cycleCounter = cycleCounter + 1;
            end
        end
        shank(idxShank).cell(idxUnit).cycleBslMultipleSdfHz = sdfCycleBsl;
        shank(idxShank).cell(idxUnit).cycleBslMultipleBin = binCycleBsl;
        
    end
end

save('units.mat', 'shank', '-append')   