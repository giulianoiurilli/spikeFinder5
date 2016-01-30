
noiseCorrW300ms = [];
noiseCorrB300ms = [];
for idxesp = 1: length(esp) %- 1
    %odorsRearranged = keepNewOrder(idxExp,:);
    for idxShank = 1:4
        idxCell300ms = 0;
        tuningCell300ms(idxShank).shank = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                %             responsivenessExc300ms = zeros(1,odors);
                %             aurocs300ms = 0.5*ones(1,odors);
                %             idxO = 0;
                %             for idxOdor = odorsRearranged
                %                 idxO = idxO + 1;
                %                 responsivenessExc300ms(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                %                 aurocs300ms(idxO) =  esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                %             end
                %             responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                %             if sum(responsivenessExc300ms) > 0
                idxCell300ms = idxCell300ms + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCell300ms(idxShank).shank(idxCell300ms,:,idxO) = (esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms -...
                        median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms));% ./ std((esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms));
                end
                %             end
            end
        end
        if size(tuningCell300ms(idxShank).shank,1) > 1;
            tuningCell300ms(idxShank).shank = reshape(tuningCell300ms(idxShank).shank, size(tuningCell300ms(idxShank).shank,1), n_trials * odors);
            tuningCell300ms(idxShank).shank = tuningCell300ms(idxShank).shank';
            tuningCell300ms(idxShank).shank = zscore(tuningCell300ms(idxShank).shank);
            tuningCell300ms(idxShank).shank = tuningCell300ms(idxShank).shank';
            rho = [];
            rho = pdist(tuningCell300ms(idxShank).shank, 'correlation');
            rho = 1 - rho;
            noiseCorrW300ms = [noiseCorrW300ms rho];
        end 
    end
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell300ms(probe).shank,1) > 1) && (size(tuningCell300ms(next).shank,1) > 1)
                app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                noiseCorrB300ms = [noiseCorrB300ms apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                noiseCorrB300ms = [noiseCorrB300ms apppp(:)'];
            end
        end
    end
end


%%

noiseCorrW1000ms = [];
noiseCorrB1000ms = [];
for idxesp = 1: length(esp) %- 1
    %odorsRearranged = keepNewOrder(idxExp,:);
    for idxShank = 1:4
        idxCell1000ms = 0;
        tuningCell1000ms(idxShank).shank = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                %             responsivenessExc1000ms = zeros(1,odors);
                %             aurocs1000ms = 0.5*ones(1,odors);
                %             idxO = 0;
                %             for idxOdor = odorsRearranged
                %                 idxO = idxO + 1;
                %                 responsivenessExc1000ms(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                %                 aurocs1000ms(idxO) =  esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                %             end
                %             responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
                %             if sum(responsivenessExc1000ms) > 0
                idxCell1000ms = idxCell1000ms + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCell1000ms(idxShank).shank(idxCell1000ms,:,idxO) = (esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                        median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms));% ./ std(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                end
                %             end
            end
        end
        if size(tuningCell1000ms(idxShank).shank,1) > 1;
            tuningCell1000ms(idxShank).shank = reshape(tuningCell1000ms(idxShank).shank, size(tuningCell1000ms(idxShank).shank,1), n_trials * odors);
            tuningCell1000ms(idxShank).shank = tuningCell1000ms(idxShank).shank';
            tuningCell1000ms(idxShank).shank = zscore(tuningCell1000ms(idxShank).shank);
            tuningCell1000ms(idxShank).shank = tuningCell1000ms(idxShank).shank';
            rho = [];
            rho = pdist(tuningCell1000ms(idxShank).shank, 'correlation');
            rho = 1 - rho;
            noiseCorrW1000ms = [noiseCorrW1000ms rho];
        end 
    end
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
                app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                noiseCorrB1000ms = [noiseCorrB1000ms apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                noiseCorrB1000ms = [noiseCorrB1000ms apppp(:)'];
            end
        end
    end
end