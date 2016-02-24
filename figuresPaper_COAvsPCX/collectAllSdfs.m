odorsRearranged = 1:15;
%odorsRearranged = [8 11 12 5 2 14 4 10]; %coa
%odorsRearranged = [3 8 10 1 13 11 9 14]; %pcx
odors = length(odorsRearranged);
%%
responsiveUnit = 0;
cells = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessInh300ms = zeros(1,odors);
                responsivenessExc1s = zeros(1,odors);
                responsivenessInh1s = zeros(1,odors);
                responsivenessExcOffset = zeros(1,odors);
                responsivenessInhOffset = zeros(1,odors);
                responsivenessExc2s = zeros(1,odors);
                responsivenessInh2s = zeros(1,odors);
                idxO = 0;
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                aurocsOffset = 0.5*ones(1,odors);
                aurocs2s = 0.5*ones(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessInh300ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc300ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessInh1s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    responsivenessExc1s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    responsivenessInhOffset = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValueOffset < 0.05;
                    responsivenessExcOffset = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValueOffset < 0.05;
                    responsivenessInh2s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue2000ms < 0.05;
                    responsivenessExc2s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue2000ms < 0.05;
                    aurocs300ms =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    aurocsOffset =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROCOffset;
                    aurocs2s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC2000ms;
                    
                    %vincolo reliability
                    
%                     responsivenessExc300ms(aurocs300ms<=0.75) = 0;
%                     responsivenessExc1s(aurocs1s<=0.75) = 0;
%                     responsivenessInh300ms(aurocs300ms>=0.35) = 0;
%                     responsivenessInh1s(aurocs1s>=0.35) = 0;
%                     responsivenessExcOffset(aurocsOffset<=0.75) = 0;
%                     responsivenessExc2s(aurocs2s<=0.75) = 0;
%                     responsivenessInhOffset(aurocsOffset>=0.35) = 0;
%                     responsivenessInh2s(aurocs2s>=0.35) = 0;
                    
                    if sum(responsivenessExc300ms + responsivenessExc1s + responsivenessExcOffset + responsivenessExc2s +...
                            responsivenessInh300ms + responsivenessInh1s + responsivenessInhOffset + responsivenessInh2s) > 0
                        responsiveUnit = responsiveUnit + 1;
                    end
                end
            end
        end
    end
end


%%
allSdf = zeros(responsiveUnit,29999);
cellLogAllSdfs = zeros(responsiveUnit,4);
cells = 0;
idxCellOdorPair = 0;
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                responsivenessExc300ms = zeros(1,odors);
                responsivenessInh300ms = zeros(1,odors);
                responsivenessExc1s = zeros(1,odors);
                responsivenessInh1s = zeros(1,odors);
                responsivenessExcOffset = zeros(1,odors);
                responsivenessInhOffset = zeros(1,odors);
                responsivenessExc2s = zeros(1,odors);
                responsivenessInh2s = zeros(1,odors);
                idxO = 0;
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                aurocsOffset = 0.5*ones(1,odors);
                aurocs2s = 0.5*ones(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsivenessInh300ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessExc300ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms < 0.05;
                    responsivenessInh1s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    responsivenessExc1s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms < 0.05;
                    responsivenessInhOffset = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValueOffset < 0.05;
                    responsivenessExcOffset = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValueOffset < 0.05;
                    responsivenessInh2s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue2000ms < 0.05;
                    responsivenessExc2s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue2000ms < 0.05;
                    aurocs300ms =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms;
                    aurocs1s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    aurocsOffset =  esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROCOffset;
                    aurocs2s = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC2000ms;
                    
                    %vincolo reliability
                    
                    responsivenessExc300ms(aurocs300ms<=0.75) = 0;
                    responsivenessExc1s(aurocs1s<=0.75) = 0;
                    responsivenessInh300ms(aurocs300ms>=0.35) = 0;
                    responsivenessInh1s(aurocs1s>=0.35) = 0;
                    responsivenessExcOffset(aurocsOffset<=0.75) = 0;
                    responsivenessExc2s(aurocs2s<=0.75) = 0;
                    responsivenessInhOffset(aurocsOffset>=0.35) = 0;
                    responsivenessInh2s(aurocs2s>=0.35) = 0;
                    
                    if sum(responsivenessExc300ms + responsivenessExc1s + responsivenessExcOffset + responsivenessExc2s +...
                            responsivenessInh300ms + responsivenessInh1s + responsivenessInhOffset + responsivenessInh2s) > 0
                        idxCellOdorPair = idxCellOdorPair + 1;
                        allSdf(idxCellOdorPair,:) = spikeDensity(mean(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix), 0.1);
                        cellLogAllSdfs(idxCellOdorPair,:) = [idxExp, idxShank, idxUnit, idxO];
                    end
                end
            end
        end
    end
end
%save('responsesAA.mat', 'allSdf', 'cellLogAllSdfs', '-append')



