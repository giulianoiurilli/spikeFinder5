%% Responsive neurons in Piriform Cortex - High Concentration
% 
cellLogTot = [];
cellLog300App = cellLogExc300;
cellLog1App = cellLogExc1;
for idxRow300 = size(cellLogExc300,1)
            v1 = [];
            v2 = [];
            v1 = cellLogExc300(idxRow300,:);
            for idxRow1 = 1:size(cellLogExc1,1)
                checkEq(idxRow1) = isequal(v1, cellLogExc1);
            end
            cellLog1App(checkEq,:) = [];
end
                
cellLogTot =  [cellLog300App; cellLog1App]; 
cellLogTot = sortrows(cellLogTot,1);

    





for idxExp = unique(cellLogTot(:,1))'
    
    %n_exp = find(cellLog300(:,1) == idxExp);
    esperimento = [];
    esperimento = cellLogTot(cellLogTot(:,1)==idxExp,:);
    esperimento = sortrows(esperimento,2);
    idxEsp = 0;
    for idxShank = unique(esperimento(:,2))'
        sonda = esperimento(esperimento(:,2) == idxShank,:);
        if size(sonda,1) > 1
            sonda = sortrows(sonda,3);
        else sonda = sonda;
        end
        for idxUnit = unique(sonda(:,3))'
            plotRasterResponse(espe,idxExp, idxShank, idxUnit, odorsRearranged)
        end
    end
end

