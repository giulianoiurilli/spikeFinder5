function [pop_sparseness1000] = findPopulationSparseness(esp, odors)

odorsRearranged = odors;
odors = length(odorsRearranged);



idxCell1 = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                end
            end
        end
    end
end
%%
cells = idxCell1;
n_trials = 10;
idxO = 0;
for idxOdor = odorsRearranged
    idxO = idxO + 1;
    R1000ms = zeros(n_trials, cells);
    B1000ms = zeros(n_trials, cells);
    A1000ms = zeros(n_trials, cells);
    idxC = 0;
    for idxExp =  1:length(esp)
        for idxShank = 1:4
            for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                    idxC = idxC + 1;
                    R1000ms(:, idxC) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                    B1000ms(:, idxC) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                end
            end
        end
    end
    A1000ms = R1000ms;% - B1000ms;
    A1000ms = (A1000ms - min(A1000ms(:))) ./ (max(A1000ms(:)) - min(A1000ms(:)));
    pop_sparseness1000(idxO) = population_sparseness(A1000ms);
end