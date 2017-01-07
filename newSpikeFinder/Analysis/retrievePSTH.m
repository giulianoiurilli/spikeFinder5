function [psth, t_vector] = retrievePSTH(esp, espe, odors)

bin_size = 100;

n_odors = numel(odors);

k = zeros(1:n_odors);
idxO = 0;
for idxOdor = odors
    idxO = idxO + 1;
    app = [];
    for idxExp = 1:length(esp)
        for idxShank = 1:4
            if ~isempty(esp(idxExp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                    if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                        if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1 ||...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1 ||...
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse2000ms == 1 ||...
                            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponseOffset == 1;
                            spikesVect = double(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix));
                            [slidingPSTHmn, slidingPSTHsd, slidingPSTHFF, slidingPSTHCV, slidingPSTH, t_vector] = slidePSTH(spikesVect, bin_size, 5);
                            app = [app; slidingPSTHmn*(1000/bin_size)];
                        end
                    end
                end
            end
        end
    end
    psth(idxO).odor = app;
end
                        
