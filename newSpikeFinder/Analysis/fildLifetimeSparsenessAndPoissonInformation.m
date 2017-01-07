fileToSave = 'plCoA_15_2.mat';
folderlist = {esp(:).filename};
startingFolder = pwd;

odors = 15;
n_trials = 10;

for idxExp =  1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                A300ms = zeros(n_trials, odors);
                A1s = zeros(n_trials, odors);
                idxO = 0;
                for idxOdor = 1:odors
                    idxO = idxO + 1;
                    A300ms(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                    A1s(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                    
                    A300ms(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse300ms' - esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl300ms';
                    A1s(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms' - esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                end
%                 esp(idxExp).shank(idxShank).SUA.cell(idxUnit).I300ms = poissonInformation(A300ms);
%                 esp(idxExp).shank(idxShank).SUA.cell(idxUnit).I1s = poissonInformation(A1s);
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls300ms = lifetime_sparseness(A300ms);
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).ls1s = lifetime_sparseness(A1s);
            end
        end
    end
end

cd(startingFolder)
save(fileToSave, 'esp', '-append')