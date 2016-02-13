for idxesp = 1:length(coa2.esp) %esperimenti%
    cells = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxesp).shankNowarp(idxShank).cell)
            if coa2.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                cells = cells + 1;
            end
        end
    end
    tuningCurves = [];
    tuningCurves = 0.5*ones(cells,length(odorsRearranged));
    cells = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(coa2.esp(idxesp).shankNowarp(idxShank).cell)
            if coa2.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                cells = cells + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCurves(cells, idxO) = coa2.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
            end
        end
    end
    TC.exp{idxesp} = tuningCurves;
end

%%
reps = 100;
O = TC.exp{1};
sorted_odorLists = zeros(length(coa2.esp), length(odorsRearranged));
sorted_odorLists(1,:) = 1:length(odorsRearranged);
for idxesp = 2:length(coa2.esp)
    N = [];
    N = TC.exp{idxesp};
    odorLists = zeros(reps, length(odorsRearranged));
    corrAcrossMeans = zeros(reps,1);
    for idxPerm = 1:reps
        new_list = randperm(length(odorsRearranged));
        odorLists(idxPerm,:) = new_list;
        corrAcross = zeros(reps, 5*5);
        for idxReps = 1:reps
            Ox = O(randi(size(O,1),5,1),:)';
            Ny = N(randi(size(N,1),5,1),:)';
            cc = corr(Ox,Ny);
            %mask = triu(ones(5),1);
            %cc1 = cc(mask == 1);
            corrAcross(idxReps,:) = cc(:)';
        end
        corrAcrossMeans(idxPerm) = mean(corrAcross(:));
    end
    odorLists = [odorLists corrAcrossMeans];
    odorLists = sortrows(odorLists, size(odorLists,2));
    odorLists(:,size(odorLists,2)) = [];
    newOdorList = odorLists(size(odorLists,1),:);
    sorted_odorLists(idxesp,:) = newOdorList;
    O = [O; N(:,newOdorList)];
end
    
