startingFolder = pwd;
%for idxExp = 1 : length(List)
for idxExp =  1:length(exp)
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            A = zeros(n_trials, odors);
            for idxOdor = 1:odors
                A300ms(:, idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                A4Cycles(:, idxOdor) = exp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse;
            end
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms = poissonInformation(A300ms);
            exp(idxExp).shankWarp(idxShank).cell(idxUnit).I4Cycles = poissonInformation(A4Cycles);
        end
    end
end
cd(startingFolder)
clearvars -except List exp
save('aPCx_2conc_Area.mat', 'exp', '-append')