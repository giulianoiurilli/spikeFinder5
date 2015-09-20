load('units.mat');
load('parameters.mat');

for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        
        allBslSpikes1 = [];
        allRspSpikes1 = [];
        allBslSpikes2 = [];
        allRspSpikes2 = [];
        allBslSpikes3 = [];
        allRspSpikes3 = [];
        for idxOdor = 1:odors
            app1 = [];
            app1 = find(shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMaxHz > 0.75);
            app2 = [];
            app2 = find(shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz(1:4) > 0);
            app3 = [];
            app3 = find(shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz(1:4) > 0);
            if (~isempty(app1) && ~isempty(app2)) || (~isempty(app1) && ~isempty(app3))
                for idxTrial = 1:n_trials
                    trialSpikes = [];
                    bslSpikes = [];
                    trialSpikes = shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial{idxTrial};
                    bslSpikes = trialSpikes(trialSpikes < 0);
                    allBslSpikes1 = [allBslSpikes1  bslSpikes];
                    allRspSpikes1 = [allRspSpikes1 trialSpikes(trialSpikes > 0)];
                end
            end
        end
        shank(idxShank).cell(idxUnit).allBaselineSpikes = [];
        shank(idxShank).cell(idxUnit).mean_phase_bsl = [];
        shank(idxShank).cell(idxUnit).var_bsl = [];
        shank(idxShank).cell(idxUnit).allBaselineSpikes = allBslSpikes1;
        shank(idxShank).cell(idxUnit).mean_phase_bsl = circ_mean(allBslSpikes1, [], 2);
        shank(idxShank).cell(idxUnit).var_bsl = circ_var(allBslSpikes1, [], [], 2);
        shank(idxShank).cell(idxUnit).allResponseSpikes = [];
        shank(idxShank).cell(idxUnit).mean_phase_rsp = [];
        shank(idxShank).cell(idxUnit).var_rsp = [];
        shank(idxShank).cell(idxUnit).allResponseSpikes = allRspSpikes1;
        shank(idxShank).cell(idxUnit).mean_phase_rsp = circ_mean(allRspSpikes1, [], 2);
        shank(idxShank).cell(idxUnit).var_rsp = circ_var(allRspSpikes1, [], [], 2);
    end
end

save('units.mat', 'shank', '-append')



