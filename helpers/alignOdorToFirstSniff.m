%align stimulus window to first sniff


delay = [];
stimulusOn = zeros(n_trials, (pre+post)*newFs, odors);
for idxOdor = 1:odors   %cycles through odors
    for idxTrial = 1:10     %cycles through trials
        startOdor = delay_on(idxTrial, idxOdor);
        stimulusOn(idxTrial,pre*newFs - round(startOdor*newFs) : pre*newFs - round(startOdor*newFs) + 2*newFs,idxOdor) = 1;
        k = k+1;
    end
end

