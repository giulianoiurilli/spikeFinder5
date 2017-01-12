function [H, nH, odorSingle, idxSingleClass, idxMultipleclass, n_classesCell] = findCategorySelectivity_new(esp, odorsRearranged, opt)
idxCell1 = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxesp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
                if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    idxCell1 = idxCell1 + 1;
                end
            end
        end
    end
end

H = nan(1,idxCell1);
nH = nan(1,idxCell1);
odorSingle = nan(1,idxCell1);
n_classesCell = nan(idxCell1,2);
idxSingleClass = 0;
idxMultipleclass = 0;
if opt == 1;
    idxCell1 = 0;
    for idxesp = 1:length(esp)
        for idxShank = 1:4
            if ~isempty(esp(idxesp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
                    if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                        idxCell1 = idxCell1 + 1;
                        appSigResponses = nan(1,15);
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            appSigResponses(idxO) = esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        end
                        if sum(appSigResponses) == 1
                            odorSingle(idxCell1) = find(appSigResponses==1);
                        end
                        appSigResponses = reshape(appSigResponses, 5, 3);
                        appSigResponses = appSigResponses';
                        pApp = sum(appSigResponses);
                        H(idxCell1) = sum(pApp>0);
                        if sum(pApp>0) == 1
                            [x, y] = find(appSigResponses>0);
                            nH(idxCell1) = numel(x);
                        end
                        if sum(appSigResponses(:))>1
                            class = zeros(1,5);
                            for idxClass = 1:5
                                class(idxClass) = pApp(idxClass)>1;
                            end
                            if sum(class) == 1
                                idxSingleClass = idxSingleClass + 1;
                            end
                            if sum(class) > 1
                                idxMultipleclass = idxMultipleclass + 1;
                            end
                        end
                        n_classesCell(idxCell1, :) = [sum(pApp>0) sum(appSigResponses(:))];
                    end
                end
            end
        end
    end
end




%%
if opt == 2;
    idxCell1 = 0;
    for idxesp = 1:length(esp)
        for idxShank = 1:4
            if ~isempty(esp(idxesp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
                    if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                        idxCell1 = idxCell1 + 1;
                        appSigResponses = nan(1,10);
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            appSigResponses(idxO) = esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        end
                        if sum(appSigResponses) == 1;
                            odorSingle(idxCell1) = find(appSigResponses==1);
                        end
                        appSigResponses = reshape(appSigResponses, 2, 5);
                        appSigResponses = appSigResponses';
                        pApp = sum(appSigResponses);
                        H(idxCell1) = sum(pApp>0);
                        if sum(pApp>0) == 1
                            [x, y] = find(appSigResponses>0);
                            nH(idxCell1) = numel(x);
                        end
                        if sum(appSigResponses(:))>1
                            class = zeros(1,2);
                            for idxClass = 1:2
                                class(idxClass) = pApp(idxClass)>1;
                            end
                            if sum(class) == 1
                                idxSingleClass = idxSingleClass + 1;
                            end
                            if sum(class) > 1
                                idxMultipleclass = idxMultipleclass + 1;
                            end
                        end
                        n_classesCell(idxCell1, :) = [sum(pApp>0) sum(appSigResponses(:))];
                    end
                end
            end
        end
    end
end

