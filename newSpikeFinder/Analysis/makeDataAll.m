function [responseCell1All, responseCell1Mean] = makeDataAll(esp, odors)


[totalSUA, totalResponsiveSUA, totalResponsiveNeuronPerOdor] = findNumberOfSua(esp, odors);

odorsRearranged = odors;
odors = length(odorsRearranged);
responseCell1Mean = nan(totalResponsiveSUA, odors);
responseCell1All = nan(totalResponsiveSUA, 5, odors);
idxCell1 = 0;
appIdxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        %resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell1 = idxCell1 + 1;
                        idxO = 0;
                        for idxOdor = 1:15
                            idxO = idxO + 1;
                            app = [];
                            app = double(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                            app1 = [];
                            app1 = [app(1:5); app(6:10)];
                            app2 = [];
                            app2 = mean(app1);
                            responseCell1Mean(idxCell1, idxO) = mean(app);
                            responseCell1All(idxCell1,:,idxO) = app2;
                        end
                    end
                end
            end
        end
    end
end