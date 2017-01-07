function [allSdf, allGvar, cellLogAllSdfs] = collectAllExcitatorySdfs(esp, espe, odors)



%%


n_odors = length(odorsRearranged);
idxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 0.5
                    idxCell = idxCell + 1;
                    app = zeros(1,n_odors);
                    for idxOdor = 1:n_odors
                            app(1) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse300ms) == 1;
                            app(2) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                            app(3) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse2000ms) == 1;
                        end
                        app1(idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms;
                        if app1(idxO) > 0
                            idx.idxExc.idxO1(idxExp,idxO) = idx.idxExc.idxO1(idxExp,idxO) + 1;
                        end
                        if app1(idxO) < 0
                            idx.idxInh.idxO1(idxExp,idxO) = idx.idxInh.idxO1(idxExp,idxO) + 1;
                        end
                    end
                    if sum(app) > 0
                        idxCell2 = idxCell2 + 1;
                    end
                end
            end
        end
    end
end



%%
binSize = 50;
slideBy = 5;
x = slidePSTH(double(espe(1).shankNowarp(1).cell(1).odor(1).spikeMatrix(1,:)), binSize, slideBy);
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
                for idxOdor = 1:n_odors
                    idxO = idxO + 1;
                    responsiveness300ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms == 1;
                    responsiveness1000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    responsiveness2000ms = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms == 1;
                    if sum(responsiveness300ms + responsiveness1000ms + responsiveness2000ms) > 0
                        idxCellOdorPair = idxCellOdorPair + 1;

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



