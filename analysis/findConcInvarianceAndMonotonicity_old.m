function [variant, invariant, nonmonotonic, nonmonotonicSem, monotonicD, monotonicDSem, monotonicI, monotonicISem, idxCell] = findConcInvarianceAndMonotonicity_old(esp)

invariant = zeros(1,3);
variant = zeros(1,3);
nonmonotonic = zeros(1,3);
monotonicD = zeros(1,3);
monotonicI = zeros(1,3);
idxCell = 0;
cellsV = zeros(1,3);
cellsM = zeros(1,3);
xx = [];
for idxExp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell = idxCell + 1;
                for odor = 1:3
                    appOdor = zeros(1,5);
                    for iOdor = 1:5
                        idxOdor = iOdor + 5*(odor-1);
                        appOdor(iOdor) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(appOdor) == 5
                        cellsV(odor) = cellsV(odor) + 1;
                        y = nan(10,5);
                        for iOdor = 1:5
                            idxOdor = iOdor + 5*(odor-1);
                            y(:,iOdor) = (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)';
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
                            y(:,iOdor) = (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)';
                        end
                        y1 = mean(y);
                        x = 1:5;
                        a = polyfit(x,y1,1);
                        for k = 1:100
                            y2 = y1(randperm(5));
                            a2 = polyfit(x,y2,1);
                            A(k) = a2(1);
                        end
                        ci = prctile(A,[2.5 97.5]);
                        if a(1) > ci(1) && a(1)< ci(2)
                            nonmonotonic(odor) = nonmonotonic(odor) + 1;
                        end
                        if a(1) < ci(1)
                            monotonicD(odor) = monotonicD(odor) + 1;
                        end
                        if a(1) > ci(2)
                            monotonicI(odor) = monotonicI(odor) + 1;
                        end
                        
                    end
                end
            end
        end
    end
end



%%
invariant = invariant./cellsM;
variant = variant./cellsM;
nonmonotonic = nonmonotonic./cellsM;
nonmonotonicSem = sqrt(((nonmonotonic./cellsM).*(ones(1,3)-(nonmonotonic./cellsM)))./cellsM);
monotonicD = monotonicD./cellsM;
monotonicDSem = sqrt(((monotonicD./cellsM).*(ones(1,3)-(monotonicD./cellsM)))./cellsM);
monotonicI = monotonicI./cellsM;
monotonicISem = sqrt(((monotonicI./cellsM).*(ones(1,3)-(monotonicI./cellsM)))./cellsM);


