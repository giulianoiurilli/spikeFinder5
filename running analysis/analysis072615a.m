%% PIRIFORM CORTEX
% 15
esp = pcx15.esp;
espe = pcx151.espe;
odors = 15;
idxCell1 = 0;
cellLog = [];
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                app = nan(1,15);
                for idxOdor = 1:odors
                    idxO = idxO + 1;
                    app(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms == 1;
                    aurox(idxOdor)  = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC2000ms;
                end
                if sum(app==1)
                    plotResponses(espe, idxesp, idxShank, idxUnit, pcxC, esp(idxesp).shankNowarp(idxShank).cell(idxUnit).ls1s, esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I1s, sum(app), aurox, app);
                end
            end
        end
    end
end
% AA
esp = pcxAA.esp;
espe = pcxAA1.espe;
odors = 15;
idxCell1 = 0;
cellLog = [];
for idxesp = 1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                app = nan(1,15);
                for idxOdor = 1:odors
                    idxO = idxO + 1;
                    app(idxOdor) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms == 1;
                    aurox(idxOdor)  = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC2000ms;
                end
                if sum(app==1)
                    plotResponses(espe, idxesp, idxShank, idxUnit, pcxC, esp(idxesp).shankNowarp(idxShank).cell(idxUnit).ls1s, esp(idxesp).shankNowarp(idxShank).cell(idxUnit).I1s, sum(app), aurox, app);
                end
            end
        end
    end
end
