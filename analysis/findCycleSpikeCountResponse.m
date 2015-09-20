%clear all


load('units.mat');
load('parameters.mat');



for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        binAllCyclesBsl = shank(idxShank).cell(idxUnit).cycleBslMultipleBinHz;
        %bootstrap baseline distribution
        stdCountBsl = [];
        for idxSample = 1:1000
            idxRnd = randi(size(binAllCyclesBsl,1), n_trials,1);
            appBsl = binAllCyclesBsl(idxRnd, :);
            appBsl1 = sum(appBsl,2);
            meanCountBsl(idxSample) = mean(appBsl1);
            stdCountBsl(idxSample) = std(appBsl1);
        end
        cycleCountBslStd = mean(stdCountBsl);
        cycleCountBslMean = mean(meanCountBsl);
        cycleCountBsl95 = prctile(meanCountBsl,95);
        shank(idxShank).cell(idxUnit).averageStdCycleSpikeCountBslHz = cycleCountBslStd;
        shank(idxShank).cell(idxUnit).cycleBslSpikesCountHz = [cycleCountBslMean, cycleCountBsl95];
        
        for idxOdor = 1:odors
            
            shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseDigitalHz = zeros(1, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseAnalogicHz = zeros(1, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseTrialHz = zeros(n_trials, postInhalations);
            %shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDPrime = zeros(1, postInhalations);
            
            binApp = zeros(n_trials, postInhalations * cycleLengthDeg);
            sdfAppMean = zeros(1, postInhalations * cycleLengthDeg);
            
            binApp = shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixHz(:, preInhalations * cycleLengthDeg + 1 : end);
            
            
            for idxCycle = 1:postInhalations
                
                snippet = zeros(1, cycleLengthDeg);
                
                amplitudeCountRspMean = 0;
                amplitudeCountRspStd = 0;
                
                goodTrials = 0;
                cycleCountRsp = zeros(n_trials, 1);
                
                snippet = binApp(:,(idxCycle-1) * cycleLengthDeg + 1 : idxCycle * cycleLengthDeg);

                cycleCountRsp = sum(snippet,2);
                amplitudeCountRspMean = mean(cycleCountRsp);
                amplitudeCountRspStd = std(cycleCountRsp);

                
                goodTrials = numel(find(cycleCountRsp > cycleCountBsl95));
                if  goodTrials >= floor(n_trials/2) && amplitudeCountRspMean >  cycleCountBsl95
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseDigitalHz(idxCycle) = 1;
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseAnalogicHz(idxCycle) = amplitudeCountRspMean;
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseTrialHz(:,idxCycle) = cycleCountRsp;
                else
                    if cycleCountBslMean > 1 && amplitudeCountRspMean < cycleCountBslMean/2
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseDigitalHz(idxCycle) = -1;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseAnalogicHz(idxCycle) = amplitudeCountRspMean;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseTrialHz(:,idxCycle) = cycleCountRsp;
                    else
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseDigitalHz(idxCycle) = 0;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseAnalogicHz(idxCycle) = amplitudeCountRspMean;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseTrialHz(:,idxCycle) = cycleCountRsp;  
                    end
                end
                app = [];
                app = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseTrialHz;
                shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeCountResponseTrial_ZscoredHz = (app - cycleCountBslMean)/cycleCountBslStd;
            end
        end
    end
end
                
                
save('units.mat', 'shank', '-append')     
            