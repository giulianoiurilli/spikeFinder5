% dfold = pwd;
% List = uipickfiles('FilterSpec', dfold, ...
%     'Prompt',    'Pick all the folders you want to analyze');

startingFolder = pwd;
for idxExperiment = 1 : length(List)
    cartella = List{idxExperiment};
    cd(cartella)
    load('units.mat', 'shank');
    load('unitsNowarp.mat', 'shankNowarp');
    load('parameters.mat');
    for idxShank = 1:4
        for idxUnit = 1:length(shank(idxShank).spiketimesUnit)
            for idxOdor = 1:odors
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).peakAnalogicResponsePerCycle =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).peakLatencyPerCycle =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakLatencyHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleAnalogicResponsePerCycle =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseAnalogicHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMaxHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinSize =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinWindowResponseHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).bestPhasePoint =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).bestTimeBinResponseHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).odorDriveAllCycles =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).odorDrive;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).popCouplingAllCycles =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).popCoupling;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleAnalogicResponsePerCycleAllTrials =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrialHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).peakAnalogicResponsePerCycleAllTrials =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseTrialHz;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix =...
                    shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
                exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor). sdf_trialNoWarp= shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
                
            end
            exp(idxExperiment).shank(idxShank).cell(idxUnit).bslSpikeRate =...
                shank(idxShank).cell(idxUnit).cycleBslSpikeRateHz;
            exp(idxExperiment).shank(idxShank).cell(idxUnit).bslPeakRate =...
                shank(idxShank).cell(idxUnit).cycleBslPeakAmplitudeHz;
            exp(idxExperiment).shank(idxShank).cell(idxUnit).bslPeakLatency =...
                shank(idxShank).cell(idxUnit).cycleBslPeakLatencyMeanHz;
            exp(idxExperiment).shank(idxShank).cell(idxUnit).cycleBslSdf =...
                shank(idxShank).cell(idxUnit).cycleBslMultipleSdfHz;
            exp(idxExperiment).shank(idxShank).cell(idxUnit).baselinePhases =...
                shank(idxShank).cell(idxUnit).allBaselineSpikes;
            exp(idxExperiment).shank(idxShank).cell(idxUnit).responsePhases =...
                shank(idxShank).cell(idxUnit).allResponseSpikes;
            exp(idxExperiment).shank(idxShank).cell(idxUnit).cross =...
                shank(idxShank).cell(idxUnit).autocorrelogram;
            exp(idxExperiment).shank(idxShank).cell(idxUnit).lags =...
                shank(idxShank).cell(idxUnit).autocorrelogramLags;
        end
    end
    clearvars -except List idxExperiment cartella exp startingFolder
end

cd(startingFolder)
clearvars -except List exp 
<<<<<<< Updated upstream
save('plCoA_2conc.mat', '-v7.3')
=======
<<<<<<< HEAD
save('plCoA_conc_series.mat', '-v7.3')
=======
save('plCoA_2conc.mat', '-v7.3')
>>>>>>> origin/master
>>>>>>> Stashed changes
    