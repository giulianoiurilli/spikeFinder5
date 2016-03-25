function [ls, pc] = lsVsPc(esp)

n_trials = 10;

%%
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

ls = nan(c,1);
pc = nan(c,1);
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            t = t + 1;
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                ls(c) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).ls300ms;
                pc(c) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).couplingFactor;
            end
        end
    end
end