%% extract auroc for excitatory responses and cycle spike counts for inhibitory responses
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for idxOdor = 1:odors
    idxNeuron = 1;
    unitOdorResponseLog{idxOdor} = [];
    for idxExp = 1:length(List)
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
                app1 = [];
                app1 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax(1) > 0.75);
                app2 = [];
                app2 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1) > 0);
                app3 = [];
                app3 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1) > 0);
                app4 = [];
                app4 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax < 0.4);
                app6 = [];
                app6 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1) < 0);
              
                exc = 0;
                if (~isempty(app1) && ~isempty(app2)) || (~isempty(app1) && ~isempty(app3))
                    exc = 1;
                end
                inh = 0;
                if ~isempty(app6) 
                    inh = 1;
                end
                responseAuroc = [];
                responseAuroc = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax(1);
                responseInh = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleAnalogicResponsePerCycle(1);
                unitOdorResponseLog{idxOdor}(idxNeuron, :) = [idxExp idxShank idxUnit responseAuroc responseInh exc inh];
                idxNeuron = idxNeuron+1;
            end
        end
    end
end