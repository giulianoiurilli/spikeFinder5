%clear all


load('unitsWarp.mat');
load('parameters.mat');



for idxShank = 1:4
    for idxUnit = 1:length(shankWarp(idxShank).cell)
        binAllCyclesBsl = shankWarp(idxShank).cell(idxUnit).cycleBslMultipleSdfHz;
        %bootstrap baseline distribution
        stdCountBsl = [];
        for idxSample = 1:1000
            idxRnd = randi(size(binAllCyclesBsl,1), n_trials,1);
            appBsl = binAllCyclesBsl(idxRnd, :);
            appBsl1 = mean(appBsl,2);
            meanCountBsl(idxSample) = mean(appBsl1);
            stdCountBsl(idxSample) = std(appBsl1);
        end
        cycleCountBslStd = mean(stdCountBsl);
        cycleCountBslMean = mean(meanCountBsl);
        cycleCountBsl95 = prctile(meanCountBsl,95);
        shankWarp(idxShank).cell(idxUnit).averageStdCycleSpikeRateBslHz = cycleCountBslStd;
        shankWarp(idxShank).cell(idxUnit).cycleBslSpikeRateHz = [cycleCountBslMean, cycleCountBsl95];
        
        for idxOdor = 1:odors
            
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz = zeros(1, postInhalations);
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseAnalogicHz = zeros(1, postInhalations);
            shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrialHz = zeros(n_trials, postInhalations);
            %shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDPrime = zeros(1, postInhalations);
            
            binApp = zeros(n_trials, postInhalations * cycleLengthDeg);
            sdfAppMean = zeros(1, postInhalations * cycleLengthDeg);
            
            binApp = shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(:, preInhalations * cycleLengthDeg + 1 : end);
            
            
            for idxCycle = 1:postInhalations
                
                snippet = zeros(1, cycleLengthDeg);
                
                amplitudeCountRspMean = 0;
                amplitudeCountRspStd = 0;
                
                goodTrials = 0;
                cycleCountRsp = zeros(n_trials, 1);
                
                snippet = binApp(:,(idxCycle-1) * cycleLengthDeg + 1 : idxCycle * cycleLengthDeg);

                cycleCountRsp = mean(snippet,2);
                amplitudeCountRspMean = mean(cycleCountRsp);
                amplitudeCountRspStd = std(cycleCountRsp);

                
                goodTrials = numel(find(cycleCountRsp > cycleCountBsl95));
                if  goodTrials >= 3 && amplitudeCountRspMean >  cycleCountBsl95
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz(idxCycle) = 1;
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseAnalogicHz(idxCycle) = amplitudeCountRspMean;
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrialHz(:,idxCycle) = cycleCountRsp;
                else
                    if cycleCountBslMean > 1 && amplitudeCountRspMean < cycleCountBslMean/2
                        shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz(idxCycle) = -1;
                        shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseAnalogicHz(idxCycle) = amplitudeCountRspMean;
                        shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrialHz(:,idxCycle) = cycleCountRsp;
                    else
                        shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz(idxCycle) = 0;
                        shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseAnalogicHz(idxCycle) = amplitudeCountRspMean;
                        shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrialHz(:,idxCycle) = cycleCountRsp;  
                    end
                end
                app = [];
                app = shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrialHz;
                shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrial_ZscoredHz = (app - cycleCountBslMean)/cycleCountBslStd;
            end
        end
    end
end
                
                
save('unitsWarp.mat', 'shankWarp', '-append')     
            