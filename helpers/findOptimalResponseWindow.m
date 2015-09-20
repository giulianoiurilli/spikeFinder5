load('units.mat');
load('parameters.mat');



for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        for idxOdor = 1:odors
            
            bslApp = [];
            bslApp = shank(idxShank).cell(idxUnit).cycleBslMultipleSdfHz ;
            %bslApp = shank(idxShank).cell(idxUnit).cycleBslMultipleBin;
            rspApp = [];
            rspApp = shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(:, preInhalations * cycleLengthDeg : end);
            %rspApp = shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad;
            
            binSizes = 5:5:cycleLengthDeg;
            timePoints = 5:5:cycleLengthDeg;
            
            shank(idxShank).cell(idxUnit).odor(idxOdor).aurocAllHz = zeros(length(binSizes),length(timePoints),4);
            shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMaxHz = zeros(1,4);
            shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinWindowResponseHz = nan * ones(1,4);
            shank(idxShank).cell(idxUnit).odor(idxOdor).bestTimeBinResponseHz = nan * ones(1,4);
            for idxCycle = 1:4
                rspCycle = [];
                rspCycle = rspApp(:,(idxCycle-1) * cycleLengthDeg + 1 : idxCycle * cycleLengthDeg);
                auRoc = 0.5*ones(length(binSizes),length(timePoints));
                counterTimePoint = 1;
                for timePoint = timePoints
                    bslVect = [];
                    rspVect = [];
                    counterBinSize = 1;
                    for binSize = binSizes
                        try
                            bslVect = mean(bslApp(:, timePoint-floor(binSize/2) : timePoint+floor(binSize/2)), 2);
                            rspVect = mean(rspCycle(:, timePoint-floor(binSize/2) : timePoint+floor(binSize/2)), 2);
                            auRoc(counterBinSize, counterTimePoint) = findAuROC(bslVect, rspVect);
                            counterBinSize = counterBinSize+1;
                        catch
                            auRoc(counterBinSize, counterTimePoint) = 0.5;
                            counterBinSize = counterBinSize+1;
                        end
                    end
                    counterTimePoint = counterTimePoint + 1;
                    %                         rspVect1 = std(rspVect(:,timePoint)) .* randn(size(bslVect,1),1) + mean(rspVect(:,timePoint));  %simulate more trials
                    %                         rspVect1(rspVect1<0) = 0;
                end
                shank(idxShank).cell(idxUnit).odor(idxOdor).aurocAllHz(:,:,idxCycle) = auRoc;
                [maxValue, maxIndex] = max(auRoc(:));
                [rowAuRoc, colAuRoc] = ind2sub(size(auRoc), maxIndex);
                shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMaxHz(idxCycle) = maxValue;
                shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinWindowResponseHz(idxCycle) =  binSizes(rowAuRoc);
                shank(idxShank).cell(idxUnit).odor(idxOdor).bestTimeBinResponseHz(idxCycle) = timePoints(colAuRoc);
            end
            
            
        end
    end
end

%load('aurColormap','aurColormap')
save('units.mat', 'shank', '-append')    

