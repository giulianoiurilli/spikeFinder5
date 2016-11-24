function [ls, cellLog] = findLifetimeSparseness2(esp, odors)

%% find good cells
c = 0;
t = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            t = t + 1;
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end
%%
ls = nan(c,1);
cellLog = nan(c,3);


n_odors = numel(odors);
cells = 0;
idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                idxO = 0;
                app = [];
                response = nan(10,n_odors);
                for idxOdor = odors
                    idxO = idxO + 1;
                    response(:,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                end
                ls(cells) = lifetime_sparseness(response);
                cellLog(cells,:) = [idxExp, idxShank, idxUnit];
            end
        end
    end
end
