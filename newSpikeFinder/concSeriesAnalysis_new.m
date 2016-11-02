
% function [responsivenessExc300ms, responsivenessExc1000ms, responsivenessInh300ms, responsivenessInh1000ms,...
%     aurocs1000ms, aurocs300ms, gVar300, gVar1000, onsetLat, halfWidth, cellLog] = concSeriesAnalysis_new(esp, odors)
odors = 1:15;
odorsRearranged = odors;
odors = length(odorsRearranged);

c = 0;
for idxExp =  1:length(esp)
    a = 0;
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    c = c + 1;
                    a = a+1;
                end
            end
        end
    end
    cellExp(idxExp) = a;
end
%%
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

for idxExp =  2:length(esp)
%     responsivenessExc300ms = [];
% responsivenessExc1000ms = [];
% responsivenessInh300ms = [];
% responsivenessInh1000ms = [];
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    c = c + 1;
                    idxO = 0;
                    for idxOdor = 1:15
                        idxO = idxO + 1;
                        responsivenessExc300ms(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                        responsivenessExc1000ms(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        responsivenessInh300ms(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms == -1;
                        responsivenessInh1000ms(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == -1;
                        aurocs1000ms(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC1000ms;
                        aurocs300ms(c,idxO) =  esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).auROC300ms;
                        if ~isempty(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).onsetLatency)
                            onsetLat(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).onsetLatency;
                        end
                        if ~isempty(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).halfWidth)
                            halfWidth(c,idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).halfWidth;
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
                    %                 for idx = 1:5
                    %                     infoOdorID(c,idx) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).concentration(idx).I1sOdor;
                    %                 end
                    %                 for idx = 1:3
                    %                     infoConcID(c,idx) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odorClass(idx).I1sConc;
                    %                 end
                    cellLog(c,:) = [idxExp idxShank idxUnit];
                end
            end
        end
    end
%     pMeanExc1000 = sum(responsivenessExc1000ms) ./ size(responsivenessExc1000ms,1);
% pSemExc1000  = sqrt((pMeanExc1000 .* (1 - pMeanExc1000)) ./ size(responsivenessExc1000ms,1));
% figure
% plot(pMeanExc1000)
% title('1000')

% pMeanExc300 = sum(responsivenessExc300ms) ./ size(responsivenessExc300ms,1);
% figure
% plot(pMeanExc300)
% title('300')
end

    pMeanExc1000 = sum(responsivenessExc1000ms) ./ size(responsivenessExc1000ms,1);
pSemExc1000  = sqrt((pMeanExc1000 .* (1 - pMeanExc1000)) ./ size(responsivenessExc1000ms,1));
figure
plot(pMeanExc1000)
title('1000')

%%
odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxExp = 2:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
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
                            app = [];
                            app = double(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor (idxOdor).AnalogicBsl1000ms);
                            app1 = [];
                            app1 = [app(1:5); app(6:10)];
                            app2 = [];
                            app2 = mean(app1);
                            baselineCell1All(idxCell1,:,idxO) = app2;
                        end
                    end
                end
            end
        end
    end
end
%%
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
% dataAll = dataAll';
% dataAll = zscore(dataAll);
% dataAll = dataAll';

rho = corr(dataAll);
figure
imagesc(rho)
axis square



