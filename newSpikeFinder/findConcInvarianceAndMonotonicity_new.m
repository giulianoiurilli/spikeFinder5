function [variant, invariant, nonmonotonic, nonmonotonicSem, monotonicD, monotonicDSem, monotonicI, monotonicISem, cellLogInv, allCells] = findConcInvarianceAndMonotonicity_new(esp)

invariant = zeros(1,3);
variant = zeros(1,3);
nonmonotonic = zeros(1,3);
monotonicD = zeros(1,3);
monotonicI = zeros(1,3);
idxCell = 0;
cellsV = zeros(1,3);
cellsM = zeros(1,3);
cellLogInv = [];
xx = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    idxCell = idxCell + 1;
                    for odor = 1:3
                        appOdor = zeros(1,5);
                        for iOdor = 1:5
                            idxOdor = iOdor + 5*(odor-1);
                            appOdor(iOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        end
                        variantOdor = 1;
                        if sum(appOdor) > 0
                            cellsM(1,odor) = cellsM(1,odor) + 1;
                        end
                        if sum(appOdor) == 5
                            
                            y = nan(10,5);
                            for iOdor = 1:5
                                idxOdor = iOdor + 5*(odor-1);
                                y(:,iOdor) = (esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)';
                            end
                            [p, ~] = anova1(y,[],'off');
                            xx = [xx p];
                            if p >= 0.05
                                invariant(odor) = invariant(odor) + 1;
                                cellLogInv = [cellLogInv; [idxExp, idxShank, idxUnit]];
                                variantOdor = 0;
                            else
                                variant(odor) = variant(odor) + 1;
                                variantOdor = 1;
                            end
                        end
                        if sum(appOdor) > 0 && sum(appOdor) < 5
                            variant(odor) = variant(odor) + 1;
                            variantOdor = 1;
                        end
                        if  sum(appOdor) > 0 && variantOdor == 1
                            y = nan(10,5);
                            for iOdor = 1:5
                                idxOdor = iOdor + 5*(odor-1);
                                y(:,iOdor) = (esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)';
                            end
                            y1 = mean(y);
                            x = 1:5;
                            a = polyfit(x,y1,1);
                            for idxPerm = 1:500
                                y2 = y1(randperm(5));
                                a2 = polyfit(x,y2,1);
                                A(idxPerm) = a2(1);
                            end
                            ci = prctile(A,[2.5 97.5]);
                            if a(1) >= ci(1) && a(1) <= ci(2)
                                nonmonotonic(odor) = nonmonotonic(odor) + 1;
                            end
                            if a(1) < ci(1)
                                monotonicD(odor) = monotonicD(odor) + 1;
                            end
                            if a(1) > ci(2)
                                monotonicI(odor) = monotonicI(odor) + 1;
                            end
                            
                            %                             %right way to do it
                            %                                                         [p, table, stats] = anova1(y,[],'off');
                            %                                                         comparisons = multcompare(stats, 'display','off');
                            %                                                         comp = [comparisons(1,6) comparisons(5,6) comparisons(8,6) comparisons(10,6)];
                            %                                                         est = [comparisons(1,4) comparisons(5,4) comparisons(8,4) comparisons(10,4)];
                            %                                                         ind = find(comp<0.05);
                            %                                                         slope = -est(ind);
                            %                                                         signSlopeY = sign(slope);
                            %                                                         yMean = mean(y);
                            %
                            %                                                         %                         slopeY = diff(yMean);
                            %                                                         %                         signSlopeY = sign(slopeY);
                            %                                                         app1 = find(signSlopeY>=0);
                            %                                                         app2 = find(signSlopeY<0);
                            %                                                         if isempty(app1) && isempty(app2)
                            %                                                             nonmonotonic(odor) = nonmonotonic(odor) + 1;
                            %                                                         else if isempty(app1)
                            %                                                                 monotonicD(odor) = monotonicD(odor) + 1;
                            %                                                             else if isempty(app2)
                            %                                                                     monotonicI(odor) = monotonicI(odor) + 1;
                            %                                                                 end
                            %                                                             end
                            %                                                         end
                        end
                    end
                end
            end
        end
    end
end
%%
allCells = cellsM;
invariant = invariant./allCells;
variant = variant./allCells; %1 - invariant;
nonmonotonic = nonmonotonic./allCells;
nonmonotonicSem = sqrt(((nonmonotonic./allCells).*(ones(1,3)-(nonmonotonic./allCells)))./allCells);
monotonicD = monotonicD./allCells;
monotonicDSem = sqrt(((monotonicD./allCells).*(ones(1,3)-(monotonicD./allCells)))./allCells);
monotonicI = monotonicI./allCells;
monotonicISem = sqrt(((monotonicI./allCells).*(ones(1,3)-(monotonicI./allCells)))./allCells);


