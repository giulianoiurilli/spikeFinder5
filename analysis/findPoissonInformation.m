tic
startingFolder = pwd;
%for idxExp = 1 : length(List)
for idxExp =  1:length(exp) 
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shankWarp(idxShank).cell)
            A300ms = zeros(n_trials, odors);
            A1s = zeros(n_trials, odors);
            for idxOdor = 1:odors
                A300ms(:, idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                A1s(:, idxOdor) = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
            end
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).I300ms = poissonInformation(A300ms);
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s = poissonInformation(A1s);
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms = lifetime_sparseness(median(A300ms),1,odors);
            exp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls1s = lifetime_sparseness(median(A1s),1,odors);
        end
    end
end
toc
tic
cd(startingFolder)
clearvars -except List exp
save('aPCx_aveatt_Area.mat', 'exp', '-append')
toc