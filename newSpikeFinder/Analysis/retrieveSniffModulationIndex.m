function sniff_modulation_index = retrieveSniffModulationIndex(esp)


sniff_modulation_index = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    sniff_modulation_index = [sniff_modulation_index esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sniffModulation];
                end
            end
        end
    end
end