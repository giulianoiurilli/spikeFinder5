function [corrAcross, corrSame] = tuningCorrelationAcrossAndWithinMice(esp, odorsRearranged)

%listOdors = sorted_odorLists;
corrAcross = zeros(1000, nchoosek(length(esp),2));   
for idxRep = 1:1000
    tuningCurvesAcross = 0.5 * ones(length(esp), length(odorsRearranged));
    cells = 0;
    for idxesp = 1:length(esp) %- 1
        j = 0;
        while j == 0
            idxShank = floor(randi(4));
            n_units  = length(esp(idxesp).shankNowarp(idxShank).cell);
            idxUnit = floor(randi(n_units));
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                j = 1;
                cells = cells + 1;
                idxO = 0;
                %odorsRearranged = listOdors(idxesp,:);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCurvesAcross(cells, idxO) = mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                end
            end
        end
    end
    corrApp = triu(corr(tuningCurvesAcross'), 1);
    corrApp = corrApp(:);
    corrApp(corrApp==0) = [];
    corrAcross(idxRep,:) = corrApp';
end
corrAcross = corrAcross(:);



%%
odors = length(odorsRearranged);
sigCorrW1000ms = [];
sigCorrB1000ms = [];
for idxesp = 1: length(esp) %- 1
    %odorsRearranged = keepNewOrder(idxesp,:);
    for idxShank = 1:4
        idxCell1000ms = 0;
        tuningCell1000ms(idxShank).shank = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                responsivenessExc1000ms = zeros(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc1000ms(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    aurocs1000ms(idxO) =  esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                end
                responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                %             if sum(responsivenessExc1000ms) > 0
                idxCell1000ms = idxCell1000ms + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCell1000ms(idxShank).shank(idxCell1000ms,idxO) = median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);%  - median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                end
                %end
            end
        end
        if size(tuningCell1000ms(idxShank).shank,1) > 1;
            app = [];
            app = tuningCell1000ms(idxShank).shank;
            app = app';
            app = zscore(app);
            app = app';
            rho = [];
            rho = pdist(app, 'correlation');
            rho = 1 - rho;
            sigCorrW1000ms = [sigCorrW1000ms rho];
        end
    end
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
                app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                sigCorrB1000ms = [sigCorrB1000ms apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                sigCorrB1000ms = [sigCorrB1000ms apppp(:)'];
            end
        end
    end  
end
corrSame = [sigCorrW1000ms sigCorrB1000ms]; 
corrSame = corrSame';

% corrSame = zeros(1000, length(esp));
% for idxRep = 1:1000
%     for idxesp = 1:length(esp) %- 1
%         tuningCurvesSame = 0.5 * ones(2, length(odorsRearranged));
%         j = 0;
%         cells = 0;
%         idxShank = randi(4,1,2);
%         while j < 2
%             n_units  = length(esp(idxesp).shankNowarp(idxShank(j+1)).cell);
%             listUnits = 1:n_units;
%             idxUnit = randsample(listUnits,1);
%             listUnits(idxUnit) = [];
%             if esp(idxesp).shankNowarp(idxShank(j+1)).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
%                 j = j + 1;
%                 cells = cells + 1;
%                 idxO = 0;
%                 %odorsRearranged = listOdors(idxesp,:);
%                 for idxOdor = odorsRearranged
%                     idxO = idxO + 1;
%                     tuningCurvesSame(cells, idxO) = esp(idxesp).shankNowarp(idxShank(j)).cell(idxUnit).odor(idxOdor).auROC1000ms;
%                 end
%             end
%         end
%         corrApp = corr(tuningCurvesSame');
%         corrSame(idxRep, idxesp) = corrApp(2);
%     end
% end
% corrSame = corrSame(:);