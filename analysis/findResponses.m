%clear all


load('units.mat');
load('parameters.mat');



for idxShank = 1:4
    for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
        sdfAllCyclesBsl = shank(idxShank).cell(idxUnit).cycleBslMultiple;
        sdfCycleBslMean = mean(sdfAllCyclesBsl);
        %trova il picco nel ciclo medio della baseline
        [~, latencyPeakBsl] = max(sdfCycleBslMean);
        %prendi l'integrale della spike density nei 50 ms intorno
        %all'istante del picco per tutti i cicli baseline
        if latencyPeakBsl - 25 < 1
            amplitudePeakBsl = sum(sdfAllCyclesBsl(:,latencyPeakBsl : latencyPeakBsl + 50), 2);
        end
        if latencyPeakBsl + 24 > size(sdfAllCyclesBsl,2)
            amplitudePeakBsl = sum(sdfAllCyclesBsl(:,latencyPeakBsl - 50 : latencyPeakBsl), 2);
        end
        if latencyPeakBsl - 25 >=1 && latencyPeakBsl + 24 <= size(sdfAllCyclesBsl,2)
            amplitudePeakBsl = sum(sdfAllCyclesBsl(:,latencyPeakBsl - 25 : latencyPeakBsl + 24), 2);
        end
        %media degli integrali across baseline cycles
        amplitudePeakBslMean = mean(amplitudePeakBsl);
        amplitudePeakBslStd = std(amplitudePeakBsl);
        shank(idxShank).cell(idxUnit).cycleBslPeakAmplitude = amplitudePeakBslMean;
        shank(idxShank).cell(idxUnit).cycleBslPeakLatencyMean = latencyPeakBsl;
        %crea la distribuzione nulla dei d prime confrontando 1000 volte 5
        %cicli baseline a caso vs altri 5 cicli baseline a caso
        dPrimeNullDistr = findDPrimeNullDistribution(sdfAllCyclesBsl, latencyPeakBsl, n_trials);
        shank(idxShank).cell(idxUnit).dPrimeNullDistribution = dPrimeNullDistr;
        
        
        
        %find standard deviation of baseline 
        baseline = [];
        stdAmplitudePeakBsl = [];
        baseline = shank(idxShank).cell(idxUnit).cycleBslMultiple;
        latencyPeakBsl = shank(idxShank).cell(idxUnit).cycleBslPeakLatencyMean;
        for idxSample = 1:1000
            idxRnd = randi(size(baseline,1), n_trials,1);
            appBsl = baseline(idxRnd, :);
            if latencyPeakBsl - 25 < 1
                amplitudePeakBsl = sum(appBsl(:,latencyPeakBsl : latencyPeakBsl + 50), 2);
            end
            if latencyPeakBsl + 24 > size(appBsl,2)
                amplitudePeakBsl = sum(appBsl(:,latencyPeakBsl - 50: latencyPeakBsl), 2);
            end
            if latencyPeakBsl - 25 >= 1 && latencyPeakBsl + 24 <= size(appBsl,2)
                amplitudePeakBsl = sum(appBsl(:,latencyPeakBsl - 25: latencyPeakBsl + 24), 2);
            end
            stdAmplitudePeakBsl(idxSample) = std(amplitudePeakBsl);
        end
        shank(idxShank).cell(idxUnit).averageStdAmplitudePeakBsl = mean(stdAmplitudePeakBsl);
        
        
        % in ogni ciclo post odore trova risposte (+1: exc, 0: no, -1: inh), ampiezza media della
        % risposta, ampiezza in ogni trial e d'
        for idxOdor = 1:odors
            
            shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDigital = zeros(1, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseAnalogic = zeros(1, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial = zeros(n_trials, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDPrime = zeros(1, postInhalations);
            shank(idxShank).cell(idxUnit).odor(idxOdor).cyclepeakLatency = zeros(1, postInhalations);
            sdfApp = zeros(n_trials, postInhalations * cycleLength);
            sdfAppMean = zeros(1, postInhalations * cycleLength);
            
            sdfApp = shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialRadMs(:, preInhalations * cycleLength + 1 : end);
            sdfAppMean = mean(sdfApp);
            
            for idxCycle = 1:postInhalations
                
                snippet = zeros(1, cycleLength - 1);
                latencyPeakRspRe = 0;
                amplitudePeakRspMean = 0;
                amplitudePeakRspStd = 0;
                dPrime = 0;
                goodTrials = 0;
                amplitudePeakRsp = zeros(n_trials, 1);
                
                snippet = sdfAppMean((idxCycle-1) * cycleLength + 1 : idxCycle * (cycleLength - 1));
                [~, latencyPeakRsp] = max(snippet); 
                latencyPeakRspRe = latencyPeakRsp + (idxCycle-1) * cycleLength;
                if latencyPeakRspRe - 25 < 1
                    amplitudePeakRsp = sum(sdfApp(:,latencyPeakRspRe  : latencyPeakRspRe + 50), 2);
                end
                if latencyPeakRspRe + 24 > size(sdfApp,2)
                    amplitudePeakRsp = sum(sdfApp(:,latencyPeakRspRe - 50 : latencyPeakRspRe), 2);
                end
                
                if latencyPeakRspRe - 25 >=1 && latencyPeakRspRe + 24 <= size(sdfApp,2)
                    amplitudePeakRsp = sum(sdfApp(:,latencyPeakRspRe - 25 : latencyPeakRspRe + 24), 2);
                end
                
                amplitudePeakRspMean = mean(amplitudePeakRsp);
                amplitudePeakRspStd = std(amplitudePeakRsp);
                dPrimeRsp = (amplitudePeakRspMean - amplitudePeakBslMean) / sqrt(0.5 * (amplitudePeakRspStd + amplitudePeakBslStd));
                shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDPrime(idxCycle) = dPrimeRsp;
                
                goodTrials = numel(find(amplitudePeakRsp > amplitudePeakBslMean));
                if dPrimeRsp > prctile(dPrimeNullDistr,95) && goodTrials > floor(n_trials/2) %&& amplitudePeakRspMean >  amplitudePeakBslMean + 2 * amplitudePeakBslStd
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDigital(idxCycle) = 1;
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclepeakLatency(idxCycle) = latencyPeakRsp;
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseAnalogic(idxCycle) = amplitudePeakRspMean;
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial(:,idxCycle) = amplitudePeakRsp;
                    
                    
                else
                    if amplitudePeakBslMean > 0.02 && amplitudePeakRspMean < amplitudePeakBslMean/2
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDigital(idxCycle) = -1;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclepeakLatency(idxCycle) = latencyPeakRsp;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseAnalogic(idxCycle) = amplitudePeakRspMean;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial(:,idxCycle) = amplitudePeakRsp;
                        
                    else
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseDigital(idxCycle) = 0;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cyclepeakLatency(idxCycle) = latencyPeakRsp;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseAnalogic(idxCycle) = amplitudePeakRspMean;
                        shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial(:,idxCycle) = amplitudePeakRsp;
                        
                    end
                end
                app = [];
                app = shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial;
                shank(idxShank).cell(idxUnit).odor(idxOdor).cycleResponseTrial_Zscored = (app - meanAmplitudePeakBsl)/mean(stdAmplitudePeakBsl);
            end
        end
    end
end
                
                
save('units.mat', 'shank', '-append')            
        
        
        
        
            

            