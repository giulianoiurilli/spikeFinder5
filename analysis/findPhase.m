function [ass] = findPhase(spikematrix, phases, n_trials)



ass = [];
for i = 1:n_trials
    app = spikematrix(i,:);
    t = find(app==1);
    t(t*20 > size(phases,1)) = [];
    aff = phases(floor(t*20),i)';
    ass = [ass aff];
    if isempty(ass)
        ass = nan;
    end
end