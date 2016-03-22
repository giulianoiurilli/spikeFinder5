function aurocCat = auROCcategorization(esp, odors, nMembers)

odorsRearranged = odors;
responseCellAll = [];
idxCell1 = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                    esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [app(1:5); app(6:10)];
                    app2 = mean(app1);
                    responseCellAll(idxCell1,:,idxO) = app2;
                end
            end
        end
    end
end

%%
responseClass1 = responseCellAll(:,:,1:nMembers);
responseClass1 = reshape(responseClass1, size(responseClass1,1), size(responseClass1,2) * size(responseClass1,3));
responseClass2 = responseCellAll(:,:,nMembers+1:end);
responseClass2 = reshape(responseClass2, size(responseClass2,1), size(responseClass2,2) * size(responseClass2,3));
aurocCat = nan * ones(size(responseClass1,1),1);
for idxCell = 1:size(responseClass1,1)
    aurocCat(idxCell) = findAuROC(responseClass1(idxCell,:), responseClass2(idxCell,:), 0);
end


