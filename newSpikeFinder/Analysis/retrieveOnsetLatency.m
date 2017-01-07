function [onsetLatency, hw_length] = retrieveOnsetLatency(esp, odors)





n_odors = numel(odors);
onsetLatency = [];
hw_length = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                %                 if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    app = zeros(1,n_odors);
                    for idxOdor = odors
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1 ||...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1
                            onsetLatency = [onsetLatency esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).onsetLatency];
                            hw_length = [hw_length esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).halfWidth];
                        end
                    end
                end
            end
        end
    end
end

onsetLatency(isnan(onsetLatency)) = [];
onsetLatency(onsetLatency<50) = [];
onsetLatency(onsetLatency>1000) = [];