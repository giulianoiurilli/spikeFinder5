%auROC vs odor identity
%odorsRearranged = [8 11 12 5 2 14 4 10]; %Coa
odorsRearranged = [3 8 10 1 13 11 9 14]; %PC
odors = length(odorsRearranged);

auroc1 = zeros(tot_units, odors);
auroc300 = zeros(tot_units, odors);

idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app1(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    app300(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                end
                auroc1(idxCell1,:) = app1;
                auroc300(idxCell1,:) = app300;
            end
        end
    end
end

meanAuroc1 = ones(1,odors) * 0.75;
meanAuroc300 = ones(1,odors) * 0.75;
for idxCol = 1:odors
    col = auroc1(:,idxCol);
    col(col<0.75) = [];
    meanAuroc1(idxCol) = mean(col);
    col = auroc300(:,idxCol);
    col(col<0.75) = [];
    meanAuroc300(idxCol) = mean(col);
end