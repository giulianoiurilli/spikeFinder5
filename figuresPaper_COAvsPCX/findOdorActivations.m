odorsRearranged = 1:15;
odors = length(odorsRearranged);

%%
cells = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 
                cells = cells + 1;
            end
        end
    end
end

%%
responsivenessExc300ms = nan * ones(cells,odors);
responsivenessInh300ms = nan * ones(cells,odors);
responsivenessExc1s = nan * ones(cells,odors);
responsivenessInh1s = nan * ones(cells,odors);
idxCell = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell = idxCell + 1;
                for idxOdor = odorsRearranged
                    responsivenessExc300ms(idxCell, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsivenessInh300ms(idxCell, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                    responsivenessExc1s(idxCell, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    responsivenessInh1s(idxCell, idxOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
                end
            end
        end
    end
end

respExc = responsivenessExc300ms + responsivenessExc1s;
respInh = responsivenessInh300ms + responsivenessInh1s;
respExc = respExc > 0;
respInh = respInh > 0;

odorExcitation = sum(respExc) ./ cells;
odorInhibition = sum(respInh) ./ cells;

%%
%compute population sparseness for delta responses
pop_sparseness300 = zeros(1,odors);
pop_sparseness1000 = zeros(1,odors);
for idxOdor = odorsRearranged
    R300ms = zeros(n_trials, cells);
    B300ms = zeros(n_trials, cells);
    A300ms = zeros(n_trials, cells);
    idxC = 0;
    for idxExp =  1:length(esp)
        for idxShank = 1:4
            for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
                if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1 
                    idxC = idxC + 1;
                    R300ms(:, idxC) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms';
                    B300ms(:, idxC) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms';
                end
            end
        end
    end
    A300ms = R300ms;% - B300ms;
    A300ms = (A300ms - min(A300ms(:))) ./ (max(A300ms(:)) - min(A300ms(:)));
    pop_sparseness300(idxOdor) = population_sparseness(A300ms);
end

for idxOdor = odorsRearranged
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
    pop_sparseness1000(idxOdor) = population_sparseness(A1000ms);
end

pop_sparseness1000 = 1 - pop_sparseness1000;
activation = pop_sparseness1000 .* odorExcitation;
                    
