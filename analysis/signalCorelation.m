% sigCorrW300ms = [];
% sigCorrB300ms = [];
% for idxesp = list2%1: length(esp) %- 1
%     for idxShank = 1:4
%         idxCell300ms = 0;
%         tuningCell300ms(idxShank).shank = [];
%         for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
%             responsivenessExc300ms = zeros(1,odors);
%             aurocs300ms = 0.5*ones(1,odors);
%             idxO = 0;
%             for idxOdor = odorsRearranged
%                 idxO = idxO + 1;
%                 responsivenessExc300ms(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
%                 aurocs300ms(idxO) =  esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
%             end
%             responsivenessExc300ms(aurocs300ms<=0.75) = 0;
% %             if sum(responsivenessExc300ms) > 0
%                 idxCell300ms = idxCell300ms + 1;
%                 idxO = 0;
%                 for idxOdor = odorsRearranged
%                     idxO = idxO + 1;
%                     if aurocs300ms(idxO) >= 0.75 || aurocs300ms(idxO) <= 0.35
%                     tuningCell300ms(idxShank).shank(idxCell300ms,idxO) = median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
%                         mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
%                     else
%                         tuningCell300ms(idxShank).shank(idxCell300ms,idxO) = 0;
%                     end
%                 end
% %             end
%         end
%         if size(tuningCell300ms(idxShank).shank,1) > 1;
%             app = [];
%             app = tuningCell300ms(idxShank).shank;
%             app = app';
%             app = zscore(app);
%             app = app';
%             rho = [];
%             rho = pdist(app, 'correlation');
%             rho = 1 - rho;
%             sigCorrW300ms = [sigCorrW300ms rho];
%         end
%     end
%     for probe = 1:3
%         for next = probe+1 : 4
%             if (size(tuningCell300ms(probe).shank,1) > 1) && (size(tuningCell300ms(next).shank,1) > 1)
%                 app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
%                 index = find(triu(ones(size(app))));
%                 appp = app(index);
%                 apppp = appp(~isnan(appp));
%                 sigCorrB300ms = [sigCorrB300ms apppp(:)'];
%                 clear app
%                 clear appp
%                 clear apppp
%                 clear index
%             else
%                 apppp = [];
%                 sigCorrB300ms = [sigCorrB300ms apppp(:)'];
%             end
%         end
%     end  
% end
% 
% 
% %%
% sigCorrW1000ms = [];
% sigCorrB1000ms = [];
% for idxesp = list2%1: length(esp) %- 1
%     for idxShank = 1:4
%         idxCell1000ms = 0;
%         tuningCell1000ms(idxShank).shank = [];
%         for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
%             responsivenessExc1000ms = zeros(1,odors);
%             aurocs1s = 0.5*ones(1,odors);
%             idxO = 0;
%             for idxOdor = odorsRearranged
%                 idxO = idxO + 1;
%                 responsivenessExc1000ms(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
%                 aurocs1000ms(idxO) =  esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
%             end
%             responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
% %             if sum(responsivenessExc1000ms) > 0
%                 idxCell1000ms = idxCell1000ms + 1;
%                 idxO = 0;
%                 for idxOdor = odorsRearranged
%                     idxO = idxO + 1;
%                     if aurocs1000ms(idxO) >= 0.75 || aurocs1000ms(idxO) <= 0.35
%                         tuningCell1000ms(idxShank).shank(idxCell1000ms,idxO) = median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) - ...
%                             mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
%                     else
%                         tuningCell1000ms(idxShank).shank(idxCell1000ms,idxO) = 0;
%                     end
%                 end
% %             end
%         end
%         if size(tuningCell1000ms(idxShank).shank,1) > 1;
%             app = [];
%             app = tuningCell1000ms(idxShank).shank;
%             app = app';
%             app = zscore(app);
%             app = app';
%             rho = [];
%             rho = pdist(app, 'correlation');
%             rho = 1 - rho;
%             sigCorrW1000ms = [sigCorrW1000ms rho];
%         end
%     end
%     for probe = 1:3
%         for next = probe+1 : 4
%             if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
%                 app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
%                 index = find(triu(ones(size(app))));
%                 appp = app(index);
%                 apppp = appp(~isnan(appp));
%                 sigCorrB1000ms = [sigCorrB1000ms apppp(:)'];
%                 clear app
%                 clear appp
%                 clear apppp
%                 clear index
%             else
%                 apppp = [];
%                 sigCorrB1000ms = [sigCorrB1000ms apppp(:)'];
%             end
%         end
%     end  
% end

%%
sigCorrW300ms = [];
sigCorrB300ms = [];
for idxesp = 1: length(esp) %- 1
    %odorsRearranged = keepNewOrder(idxesp,:);
    for idxShank = 1:4
        idxCell300ms = 0;
        tuningCell300ms(idxShank).shank = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 %&& esp(idxesp).shankNowarp(idxShank).cell(idxUnit).isReliable == 1
                responsivenessExc300ms = zeros(1,odors);
                aurocs300ms = 0.5*ones(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessExc300ms(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    aurocs300ms(idxO) =  esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                end
                responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                %             if sum(responsivenessExc300ms) > 0
                idxCell300ms = idxCell300ms + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCell300ms(idxShank).shank(idxCell300ms,idxO) = median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms);% - median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                end
                %             end
            end
        end
        if size(tuningCell300ms(idxShank).shank,1) > 1;
            app = [];
            app = tuningCell300ms(idxShank).shank;
            app = app';
            app = zscore(app);
            app = app';
            rho = [];
            rho = pdist(app, 'correlation');
            rho = 1 - rho;
            sigCorrW300ms = [sigCorrW300ms rho];
        end
    end
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell300ms(probe).shank,1) > 1) && (size(tuningCell300ms(next).shank,1) > 1)
                app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                sigCorrB300ms = [sigCorrB300ms apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                sigCorrB300ms = [sigCorrB300ms apppp(:)'];
            end
        end
    end  
end


%%
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

% sigCorrW300ms = [];
% sigCorrB300ms = [];
% for idxesp = list2%1: length(esp) %- 1
%     for idxShank = 1:4
%         idxCell300ms = 0;
%         tuningCell300ms(idxShank).shank = [];
%         for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
%             responsivenessExc300ms = zeros(1,odors);
%             aurocs300ms = 0.5*ones(1,odors);
%             idxO = 0;
%             for idxOdor = odorsRearranged
%                 idxO = idxO + 1;
%                 responsivenessExc300ms(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
%                 aurocs300ms(idxO) =  esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
%             end
%             responsivenessExc300ms(aurocs300ms<=0.75) = 0;
% %             if sum(responsivenessExc300ms) > 0
%                 idxCell300ms = idxCell300ms + 1;
%                 idxO = 0;
%                 for idxOdor = odorsRearranged
%                     idxO = idxO + 1;
%                     if aurocs300ms(idxO) >= 0.75 || aurocs300ms(idxO) <= 0.35
%                     tuningCell300ms(idxShank).shank(idxCell300ms,idxO) = median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms) - ...
%                         mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
%                     else
%                         tuningCell300ms(idxShank).shank(idxCell300ms,idxO) = 0;
%                     end
%                 end
% %             end
%         end
%         if size(tuningCell300ms(idxShank).shank,1) > 1;
%             app = [];
%             app = tuningCell300ms(idxShank).shank;
%             app = app';
%             app = zscore(app);
%             app = app';
%             rho = [];
%             rho = pdist(app, 'correlation');
%             rho = 1 - rho;
%             sigCorrW300ms = [sigCorrW300ms rho];
%         end
%     end
%     for probe = 1:3
%         for next = probe+1 : 4
%             if (size(tuningCell300ms(probe).shank,1) > 1) && (size(tuningCell300ms(next).shank,1) > 1)
%                 app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
%                 index = find(triu(ones(size(app))));
%                 appp = app(index);
%                 apppp = appp(~isnan(appp));
%                 sigCorrB300ms = [sigCorrB300ms apppp(:)'];
%                 clear app
%                 clear appp
%                 clear apppp
%                 clear index
%             else
%                 apppp = [];
%                 sigCorrB300ms = [sigCorrB300ms apppp(:)'];
%             end
%         end
%     end  
% end
% 
% 
% %%
% sigCorrW1000ms = [];
% sigCorrB1000ms = [];
% for idxesp = list2%1: length(esp) %- 1
%     for idxShank = 1:4
%         idxCell1000ms = 0;
%         tuningCell1000ms(idxShank).shank = [];
%         for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
%             responsivenessExc1000ms = zeros(1,odors);
%             aurocs1s = 0.5*ones(1,odors);
%             idxO = 0;
%             for idxOdor = odorsRearranged
%                 idxO = idxO + 1;
%                 responsivenessExc1000ms(idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
%                 aurocs1000ms(idxO) =  esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
%             end
%             responsivenessExc1000ms(aurocs1000ms<=0.75) = 0;
% %             if sum(responsivenessExc1000ms) > 0
%                 idxCell1000ms = idxCell1000ms + 1;
%                 idxO = 0;
%                 for idxOdor = odorsRearranged
%                     idxO = idxO + 1;
%                     if aurocs1000ms(idxO) >= 0.75 || aurocs1000ms(idxO) <= 0.35
%                         tuningCell1000ms(idxShank).shank(idxCell1000ms,idxO) = median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) - ...
%                             mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
%                     else
%                         tuningCell1000ms(idxShank).shank(idxCell1000ms,idxO) = 0;
%                     end
%                 end
% %             end
%         end
%         if size(tuningCell1000ms(idxShank).shank,1) > 1;
%             app = [];
%             app = tuningCell1000ms(idxShank).shank;
%             app = app';
%             app = zscore(app);
%             app = app';
%             rho = [];
%             rho = pdist(app, 'correlation');
%             rho = 1 - rho;
%             sigCorrW1000ms = [sigCorrW1000ms rho];
%         end
%     end
%     for probe = 1:3
%         for next = probe+1 : 4
%             if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
%                 app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
%                 index = find(triu(ones(size(app))));
%                 appp = app(index);
%                 apppp = appp(~isnan(appp));
%                 sigCorrB1000ms = [sigCorrB1000ms apppp(:)'];
%                 clear app
%                 clear appp
%                 clear apppp
%                 clear index
%             else
%                 apppp = [];
%                 sigCorrB1000ms = [sigCorrB1000ms apppp(:)'];
%             end
%         end
%     end  
% end

%% BASELINE

sigCorrWBSL1000ms = [];
sigCorrBBSL1000ms = [];
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
                    tuningCell1000ms(idxShank).shank(idxCell1000ms,idxO) = median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);%  - median(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
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
            sigCorrWBSL1000ms = [sigCorrWBSL1000ms rho];
        end
    end
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
                app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                sigCorrBBSL1000ms = [sigCorrBBSL1000ms apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                sigCorrBBSL1000ms = [sigCorrBBSL1000ms apppp(:)'];
            end
        end
    end  
end

