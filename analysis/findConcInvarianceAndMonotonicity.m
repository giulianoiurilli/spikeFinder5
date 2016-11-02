%function [cellsV, cellsM, invariant, variant, nonmonotonic, monotonicD, monotonicI, xx, allData] = findConcInvarianceAndMonotonicity(esp)

% esp = coaCS.esp;

invariant = zeros(1,3);
variant = zeros(1,3);
nonmonotonic = zeros(1,3);
monotonicD = zeros(1,3);
monotonicI = zeros(1,3);
idxCell = 0;
cellsV = zeros(1,3);
cellsM = zeros(1,3);
xx = [];
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell = idxCell + 1;
                for odor = 1:3
                    for iOdor = 1:5
                        idxOdor = iOdor + 5*(odor-1);
                        allData(idxCell, iOdor, odor) =  mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)...
                            - mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    end
                    appOdor = zeros(1,5);
                    for iOdor = 1:5
                        idxOdor = iOdor + 5*(odor-1);
                        appOdor(iOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    
                    if sum(appOdor) == 5
                        cellsV(odor) = cellsV(odor) + 1;
                        y = nan(10,5);
                        for iOdor = 1:5
                            idxOdor = iOdor + 5*(odor-1);
                            y(:,iOdor) = (esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms - esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)';
                        end
                        [p, ~] = anova1(y,[],'off');
                        xx = [xx p];
                        if p >= 0.05
                            invariant(odor) = invariant(odor) + 1;
                        else
                            variant(odor) = variant(odor) + 1;
                        end
                    else if sum(appOdor) > 0 && sum(appOdor) < 5
                           variant(odor) = variant(odor) + 1;
                        end
                    end
                    if sum(appOdor) > 0
                        cellsM(odor) = cellsM(odor) + 1;
                        y = nan(10,5);
                        for iOdor = 1:5
                            idxOdor = iOdor + 5*(odor-1);
                            y(:,iOdor) = (esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms - esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)';
                        end
                        [p, table, stats] = anova1(y,[],'off');
                        comparisons = multcompare(stats, 'display', 'off');
                        comp = [comparisons(1,6) comparisons(5,6) comparisons(8,6) comparisons(10,6)];
                        est = [comparisons(1,4) comparisons(5,4) comparisons(8,4) comparisons(10,4)];
                        ind = find(comp<0.05);
                        slope = est(ind);
                        signSlopeY = sign(slope);
%                         yMean = mean(y);
%                         slopeY = diff(yMean);
%                         signSlopeY = sign(slopeY);
                        app1 = find(signSlopeY>=0);
                        app2 = find(signSlopeY<0);
                        if ~isempty(app1) && ~isempty(app2)
                            nonmonotonic(odor) = nonmonotonic(odor) + 1;
                        else if isempty(app1)
                                monotonicD(odor) = monotonicD(odor) + 1;
                            else if isempty(app2)
                                    monotonicI(odor) = monotonicI(odor) + 1;
                                end
                            end
                        end  
                    end
                end
            end
        end
    end
end
%%
invariant = invariant./cellsM*100;
variant = variant./cellsM*100;
nonmonotonic = sum(nonmonotonic)./sum(cellsM)*100
nonmonotonicSem = sqrt(((sum(nonmonotonic)./sum(cellsM)).*(1-(sum(nonmonotonic)./sum(cellsM))))./sum(cellsM))
monotonicD = sum(monotonicD)./sum(cellsM)*100
monotonicDSem = sqrt(((sum(monotonicD)./sum(cellsM)).*(1-(sum(monotonicD)./sum(cellsM))))./sum(cellsM))
monotonicI = sum(monotonicI)./sum(cellsM)*100
monotonicISem = sqrt(((sum(monotonicI)./sum(cellsM)).*(1-(sum(monotonicI)./sum(cellsM))))./sum(cellsM))
                        
                
                