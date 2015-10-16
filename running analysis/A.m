% extract response timecourse for each odor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

totUnits = 0;
responsiveUnits = 0;
for idxOdor = 1:odors
    idxNeuron = 1;
    responseProfiles{idxOdor} = [];
    responseProfilesZ{idxOdor} = [];
    peakLatency{idxOdor} = [];
    unitOdorResponseLog{idxOdor} = [];
    for idxExp = 1:length(List)
        for idxShank = 1:4
            for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
                app1 = [];
                app1 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax > 0.75);
                app2 = [];
                app2 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1:4) > 0);
                app3 = [];
                app3 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1:4) > 0);
                app4 = [];
                app4 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax < 0.4);
                %app5 = [];
                %app5 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1:4) < 0);
                app6 = [];
                app6 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1:4) < 0);
                exc = 0;
                totUnits = totUnits+1;
                if (~isempty(app1) && ~isempty(app2)) || (~isempty(app1) && ~isempty(app3))
                    exc = 1;
                    responsiveUnits = responsiveUnits + 1;
                end
                inh = 0;
                if ~isempty(app4)
                    inh = 1;
                end
                responseProfiles{idxOdor}(idxNeuron,:) = mean(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth);
%                 if std(responseProfiles{idxOdor}(idxNeuron,1:preInhalations*cycleLengthDeg)) > 0
%                     responseProfilesZ{idxOdor}(idxNeuron,:) = (responseProfiles{idxOdor}(idxNeuron,:) - mean(responseProfiles{idxOdor}(idxNeuron,1:preInhalations*cycleLengthDeg))) /...
%                         std(responseProfiles{idxOdor}(idxNeuron,1:preInhalations*cycleLengthDeg));
%                 else
                    responseProfilesZ{idxOdor}(idxNeuron,:) = responseProfiles{idxOdor}(idxNeuron,:);
%                 end
                app7 = [];
                %app7= exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakLatencyPerCycle(1:4);
                app7= exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakLatencyPerCycle(1);
                app8 = [];
                app8 = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakAnalogicResponsePerCycle(1:4);
                [~, maxI] = max(app8);
                %peakLatency{idxOdor}(idxNeuron) = app7(maxI) + (maxI-1)*cycleLengthDeg;
                peakLatency{idxOdor}(idxNeuron) = app7;
                unitOdorResponseLog{idxOdor}(idxNeuron, :) = [idxExp idxShank idxUnit idxOdor exc inh exc+inh];
                idxNeuron = idxNeuron+1;
            end
        end
    end
end