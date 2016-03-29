function [responsivenessExc300ms, responsivenessExc1000ms, responsivenessInh300ms, responsivenessInh1000ms,...
    aurocs1000ms, aurocs300ms, gVar300, gVar1000, infoOdorID, infoConcID, onsetLat, halfWidth, cellLog] = concSeriesAnalysis(esp, odors)

odorsRearranged = odors;
odors = length(odorsRearranged);

c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end

responsivenessExc300ms = nan(c,odors);
responsivenessExc1000ms = nan(c,odors);
responsivenessInh300ms = nan(c,odors);
responsivenessInh1000ms = nan(c,odors);
aurocs1000ms = nan(c,odors);
aurocs300ms =  nan(c,odors);
gVar300 = nan(c,odors);
gVar1000 = nan(c,odors);
onsetLat = nan(c,odors);
halfWidth = nan(c,odors);
cellLog = nan(c,3);
infoOdorID = nan(c,5);
infoConcID = nan(c,3);
c = 0;

for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc300ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsivenessExc1000ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    responsivenessInh300ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                    responsivenessInh1000ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
                    aurocs1000ms(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    aurocs300ms(c,idxO) =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms; 
                    gVar300(c,idxO) = partNeuralVariance(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);
                    gVar1000(c,idxO) = partNeuralVariance(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                    if ~isempty(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency)
                        onsetLat(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency;
                    end
                    if ~isempty(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth)
                        halfWidth(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth;
                    end
%                     responsivenessExc300ms(aurocs300ms<=0.75) = 0;
%                     responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                end
%                 responsivenessExc1000ms = responsivenessExc1000ms + responsivenessExc300ms;
%                 app = [];
%                 app = responsivenessExc1000ms>0;
%                 responsivenessExc1000ms = app;
%                 odorsExc1(c,:) = responsivenessExc1000ms;
%                 responsesExc1(c,:) = responsesExc1000ms;
                for idx = 1:5
                    infoOdorID(c,idx) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).concentration(idx).I1sOdor;
                end
                for idx = 1:3
                    infoConcID(c,idx) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odorClass(idx).I1sConc;
                end
                cellLog(c,:) = [idxExp idxShank idxUnit];
            end
        end
    end
end
app = responsivenessExc300ms + responsivenessExc1000ms;

onsetLat(app == 0) = nan;
halfWidth(app == 0) = nan;

