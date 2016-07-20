function [allSdf, allGvar, cellLogAllSdfs] = collectAllExcitatorySdfs(esp, espe, odors)



%%
%odorsRearranged = 1:15;
%odorsRearranged = [8 11 12 5 2 14 4 10]; %coa
%odorsRearranged = [3 8 10 1 13 11 9 14]; %pcx
odorsRearranged = odors;
odors = length(odorsRearranged);

%%
responsiveUnit = 0;
cells = 0;
for idxExp = 1: length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                responsiveness300ms = nan*ones(1,odors);
                responsiveness1000ms = nan*ones(1,odors);
                responsiveness2000ms = nan*ones(1,odors);
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsiveness300ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsiveness1000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    responsiveness2000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms == 1;
                    if sum(responsiveness300ms + responsiveness1000ms + responsiveness2000ms) > 0
                        responsiveUnit = responsiveUnit + 1;
                    end
                end
            end
        end
    end
end


%%
gW = 0.8; %gaussian width for convolution (in seconds)
binSize = 100;
slideBy = 5;
x = slidePSTH(double(espe(1).shankNowarp(1).cell(1).odor(1).spikeMatrix(1,:)), binSize, slideBy);
allSdf = nan*ones(responsiveUnit,size(x,2));
allGvar = nan*ones(responsiveUnit,size(x,2));
cellLogAllSdfs = nan*ones(responsiveUnit,4);
cells = 0;
idxCellOdorPair = 0;
for idxExp = 1: length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
                responsiveness300ms = nan*ones(1,odors);
                responsiveness1000ms = nan*ones(1,odors);
                responsiveness2000ms = nan*ones(1,odors);
                responsivenessOffset = nan*ones(1,odors);
                idxO = 0;
                aurocs300ms = 0.5*ones(1,odors);
                aurocs1s = 0.5*ones(1,odors);
                aurocsOffset = 0.5*ones(1,odors);
                aurocs2s = 0.5*ones(1,odors);
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    responsiveness300ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsiveness1000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    responsiveness2000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms == 1;
                    if sum(responsiveness300ms + responsiveness1000ms + responsiveness2000ms) > 0
                        idxCellOdorPair = idxCellOdorPair + 1;
                        %allSdf(idxCellOdorPair,:) = spikeDensity(mean(single(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix)), gW);
                        A = nan(10,size(x,2));
                        for idxTrial = 1:10
                            A(idxTrial,:) = slidePSTH(double(espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,:)), binSize, slideBy);
                        end
                        allSdf(idxCellOdorPair,:) = mean(A);
%                         for idxBin = 1:size(A,2)
%                             allGvar(idxCellOdorPair,idxBin) = partNeuralVariance(A(:,idxBin));
%                         end
                        cellLogAllSdfs(idxCellOdorPair,:) = [idxExp, idxShank, idxUnit, idxO];
                    end
                end
            end
        end
    end
end

%save('sdf15.mat', 'allSdf', 'cellLogAllSdfs', '-append')



