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
            for idxTrial = 1:n_trials
                trialSpikes = [];
                bslSpikes = [];
                trialSpikes = shank(idxShank).cell(idxUnit).odor(idxOdor).alphaTrial{idxTrial};
                bslSpikes = trialSpikes(trialSpikes < 0);
                allBslSpikes1 = [allBslSpikes1  bslSpikes];
                allRspSpikes1 = [allRspSpikes1 trialSpikes(trialSpikes > 0)];
            end
        end
        
        
        allRspSpikes1(allRspSpikes1 > preInhalations*2*pi) = [];
        
        edgesBsl = -preInhalations*2*pi:2*pi:0;
        edgesRsp = 0:2*pi:postInhalations*2*pi;
        
        [~, indBsl] = histc(allBslSpikes1, edgesBsl);
        [~, indRsp] = histc(allRspSpikes1, edgesRsp);
        
        for idxCycle = 1:preInhalations
            app1 = [];
            app1 = allBslSpikes1(indBsl == idxCycle);
            app1 = app1 + (preInhalations - (idxCycle - 1))*2*pi;
            allBslSpikes2 = [allBslSpikes2 app1];
        end
        
        
        for idxCycle = 1:preInhalations
            app1 = [];
            app1 = allRspSpikes1(indRsp == idxCycle);
            app1 = app1 - (idxCycle - 1)*2*pi;
            allRspSpikes2 = [allRspSpikes2 app1];
        end
        
        
        shank(idxShank).cell(idxUnit).allBaselineSpikes = [];
        shank(idxShank).cell(idxUnit).mean_phase_bsl = [];
        shank(idxShank).cell(idxUnit).var_bsl = [];
        if ~isempty(allBslSpikes2)
            shank(idxShank).cell(idxUnit).allBaselineSpikes = allBslSpikes2;
            shank(idxShank).cell(idxUnit).mean_phase_bsl = circ_mean(allBslSpikes2, [], 2);
            shank(idxShank).cell(idxUnit).var_bsl = circ_var(allBslSpikes2, [], [], 2);
        end
        
        
        shank(idxShank).cell(idxUnit).allResponseSpikes = [];
        shank(idxShank).cell(idxUnit).mean_phase_rsp = [];
        shank(idxShank).cell(idxUnit).var_rsp = [];
        if ~isempty(allRspSpikes2)
            shank(idxShank).cell(idxUnit).allResponseSpikes = allRspSpikes2;
            shank(idxShank).cell(idxUnit).mean_phase_rsp = circ_mean(allRspSpikes2, [], 2);
            shank(idxShank).cell(idxUnit).var_rsp = circ_var(allRspSpikes2, [], [], 2);
        end
    end
end

save('units.mat', 'shank', '-append') 

