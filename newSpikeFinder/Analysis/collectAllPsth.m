function [allPsth, cellOdorLog] = collectAllPsth(esp, espe, odors)



%%


n_odors = length(odors);
idxCell = 0;
idxCellOdor = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    idxCell = idxCell + 1;
                    app = zeros(1,4);
                    for idxOdor = 1:n_odors
                            app(1) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms) == 1;
                            app(2) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                            app(3) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse2000ms) == 1;
                            app(4) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponseOffset) == 1;
                            if sum(app) > 0
                                idxCellOdor = idxCellOdor + 1;
                            end
                    end
                end
            end
        end
    end
end


                                
%%
binSize = 100;
slideBy = 5;
psthTemplate = slidePSTH(double(full(espe(1).shank(1).SUA.cell(1).odor(1).spikeMatrix(1,:))), binSize, slideBy);
cellOdorLog = nan(idxCellOdor,4);
allPsth = nan(idxCellOdor, size(psthTemplate,2));
idxCell = 0;
idxCellOdor = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    idxCell = idxCell + 1;
                    app = zeros(1,4);
                    for idxOdor = 1:n_odors
                        app(1) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms) == 1;
                        app(2) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        app(3) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse2000ms) == 1;
                        app(4) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponseOffset) == 1;
                        if sum(app) > 0
                            idxCellOdor = idxCellOdor + 1;                          
                            A = nan(10,size(psthTemplate,2));
                            for idxTrial = 1:10
                                A(idxTrial,:) = slidePSTH(double(full(espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:))), binSize, slideBy);
                            end
                            allPsth(idxCellOdor,:) = mean(A);
                            cellOdorLog(idxCellOdor,:) = [idxExp, idxShank, idxUnit, idxOdor];
                        end
                    end
                end
            end
        end
    end
end





