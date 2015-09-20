%clear all


load('units.mat');
load('parameters.mat');



for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        sdfAllCyclesBsl = shank(idxShank).cell(idxUnit).cycleBslMultipleSdfHz;
        sdfCycleBslMean = mean(sdfAllCyclesBsl);
        %trova il picco nel ciclo medio della baseline
        [~, latencyPeakBsl] = max(sdfCycleBslMean);

        %prendi l'integrale della spike density nei 50 ms intorno
        %all'istante del picco per tutti i cicli baseline; crea una
        %distribuzione mediante Montecarlo
        meanAmplitudePeakBsl = zeros(1,1000);
        for idxSample = 1:1000
            idxRnd = randi(size(sdfAllCyclesBsl,1), n_trials,1);
            appBsl = sdfAllCyclesBsl(idxRnd, :);
            if latencyPeakBsl - 25 < 1
                amplitudePeakBsl = mean(appBsl(:,latencyPeakBsl : latencyPeakBsl + 50), 2);
            end
            if latencyPeakBsl + 24 > size(appBsl,2)
                amplitudePeakBsl = mean(appBsl(:,latencyPeakBsl - 50: latencyPeakBsl), 2);
            end
            if latencyPeakBsl - 25 >= 1 && latencyPeakBsl + 24 <= size(appBsl,2)
                amplitudePeakBsl = mean(appBsl(:,latencyPeakBsl - 25: latencyPeakBsl + 24), 2);
            end
            meanAmplitudePeakBsl(idxSample) = mean(amplitudePeakBsl);
            stdAmplitudePeakBsl(idxSample) = std(amplitudePeakBsl);
        end

        amplitudePeakBslStd = std(meanAmplitudePeakBsl);
        amplitudePeakBslMean = mean(meanAmplitudePeakBsl);
        amplitudePeakBsl95 = prctile(meanAmplitudePeakBsl, 95);
        shank(idxShank).cell(idxUnit).cycleBslPeakAmplitudeHz = [amplitudePeakBslMean, amplitudePeakBsl95];
        shank(idxShank).cell(idxUnit).cycleBslPeakLatencyMeanHz = latencyPeakBsl;
        
        
        % in ogni ciclo post odore trova risposte (+1: exc, 0: no, -1: inh), ampiezza media della
        % risposta, ampiezza in ogni trial e d'
        for idxOdor = 1:odors
            
            shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz = zeros(1, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz = zeros(1, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseTrialHz = zeros(n_trials, postInhalations);
            %shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDPrime = zeros(1, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakLatencyHz = zeros(1, postInhalations);
            sdfApp = zeros(n_trials, postInhalations * cycleLengthDeg);
            sdfAppMean = zeros(1, postInhalations * cycleLengthDeg);
            
            sdfApp = shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz(:, preInhalations * cycleLengthDeg + 1 : end);
            sdfAppMean = mean(sdfApp);
            
            for idxCycle = 1:postInhalations
                
                snippet = zeros(1, cycleLengthDeg);
                latencyPeakRspRe = 0;
                amplitudePeakRspMean = 0;
                amplitudePeakRspStd = 0;
                goodTrials = 0;
                amplitudePeakRsp = zeros(n_trials, 1);
                
                snippet = sdfAppMean((idxCycle-1) * cycleLengthDeg + 1 : idxCycle * cycleLengthDeg);
                [~, latencyPeakRsp] = max(snippet); 
                latencyPeakRspRe = latencyPeakRsp + (idxCycle-1) * cycleLengthDeg;
                if latencyPeakRspRe - 25 < 1
                    amplitudePeakRsp = mean(sdfApp(:,latencyPeakRspRe  : latencyPeakRspRe + 50), 2);
                end
                if latencyPeakRspRe + 24 > size(sdfApp,2)
                    amplitudePeakRsp = mean(sdfApp(:,latencyPeakRspRe - 50 : latencyPeakRspRe), 2);
                end
                
                if latencyPeakRspRe - 25 >=1 && latencyPeakRspRe + 24 <= size(sdfApp,2)
                    amplitudePeakRsp = mean(sdfApp(:,latencyPeakRspRe - 25 : latencyPeakRspRe + 24), 2);
                end
                
                amplitudePeakRspMean = mean(amplitudePeakRsp);
                amplitudePeakRspStd = std(amplitudePeakRsp);
                %dPrimeRsp = (amplitudePeakRspMean - amplitudePeakBslMean) / sqrt(0.5 * (amplitudePeakRspStd + amplitudePeakBslStd));
                %shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDPrime(idxCycle) = dPrimeRsp;
                
                goodTrials = numel(find(amplitudePeakRsp > amplitudePeakBsl95));
                if  goodTrials >= 4 && amplitudePeakRspMean >  amplitudePeakBsl95
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz(idxCycle) = 1;
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakLatencyHz(idxCycle) = latencyPeakRsp;
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz(idxCycle) = amplitudePeakRspMean;
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseTrialHz(:,idxCycle) = amplitudePeakRsp;
                    
                    
                else
                    if amplitudePeakBslMean > 0.02 && amplitudePeakRspMean < amplitudePeakBslMean/2
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz(idxCycle) = -1;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakLatencyHz(idxCycle) = latencyPeakRsp;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz(idxCycle) = amplitudePeakRspMean;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseTrialHz(:,idxCycle) = amplitudePeakRsp;
                        
                    else
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz(idxCycle) = 0;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakLatencyHz(idxCycle) = latencyPeakRsp;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz(idxCycle) = amplitudePeakRspMean;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseTrialHz(:,idxCycle) = amplitudePeakRsp;
                        
                    end
                end
                app = [];
                app = shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseTrialHz;
                shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseTrial_ZscoredHz = (app - amplitudePeakBslMean)/amplitudePeakBslStd;
            end
        end
    end
end
                
                
save('units.mat', 'shank', '-append')            
        
        
        
        
            

            