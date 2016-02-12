%auroc vs lifetime sparsenes

odorsRearranged = 1:15;
odors = length(odorsRearranged);

                auroc1 = zeros(1,tot_units);
                auroc300 = zeros(1,tot_units);
                lifspars1 = zeros(1,tot_units);
                lifspars300 = zeros(1,tot_units);
                inf1 = zeros(1,tot_units);
                inf300 = zeros(1,tot_units);
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
                auroc1(idxCell1) = max(app1);
                auroc300(idxCell1) = max(app300);
                lifspars1(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).ls1s;
                lifspars300(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).ls300ms;
                inf1(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I1s;
                inf300(idxCell1) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I300ms;
            end
        end
    end
end