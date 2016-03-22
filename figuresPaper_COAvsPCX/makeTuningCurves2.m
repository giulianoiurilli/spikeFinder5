function [auroc300, significantAuroc300, auroc1, significantAuroc1] = makeTuningCurves2(esp, odors)
odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
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
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                    esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    baselineCell1All(idxCell1,:,idxO) = app2;
                    auroc1(idxCell1, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    significance1(idxCell1, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                    auroc300(idxCell1, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    significance300(idxCell1, idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms;
                end
            end
        end
    end
end

idx = logical(abs(significance1));
significantAuroc1 = 0.5*ones(size(auroc1));
significantAuroc1(idx) = auroc1(idx);

clims = [0, 1];
figure; 
imagesc(significantAuroc1, clims); colormap(brewermap([],'*RdBu')); axis tight
title('1000 ms')

idx = logical(abs(significance300));
significantAuroc300 = 0.5*ones(size(auroc300));
significantAuroc300(idx) = auroc300(idx);

clims = [0, 1];
figure; 
imagesc(significantAuroc300, clims); colormap(brewermap([],'*RdBu')); axis tight
title('300 ms')
