% dfold = pwd;
% List = uipickfiles('FilterSpec', dfold, ...
%     'Prompt',    'Pick all the folders you want to analyze');

startingFolder = pwd;
for idxExperiment = 1 : length(List)
    cartella = List{idxExperiment};
    cd(cartella)
    load('unitsWarp.mat', 'shankWarp');
    load('unitsNowarp.mat', 'shankNowarp');
    load('parameters.mat');
    for idxShank = 1:4
        for idxUnit = 1:length(shankWarp(idxShank).cell)
            app2 = zeros(1,odors);
            for idxOdor = 1:odors
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth =...
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialHz;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle =...
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseDigitalHz;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).peakAnalogicResponsePerCycle =...
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseAnalogicHz;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatencyPerCycle =...
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakLatencyHz;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle =...
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseDigitalHz;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fullCycleAnalogicResponsePerCycle =...
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseAnalogicHz;
%                 exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax =...
%                     shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMaxHz;
%                 exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinSize =...
%                     shank(idxShank).cell(idxUnit).odor(idxOdor).bestBinWindowResponseHz;
%                 exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).bestPhasePoint =...
%                     shank(idxShank).cell(idxUnit).odor(idxOdor).bestTimeBinResponseHz;
%                 exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).odorDriveAllCycles =...
%                     shank(idxShank).cell(idxUnit).odor(idxOdor).odorDrive;
%                 exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).popCouplingAllCycles =...
%                     shank(idxShank).cell(idxUnit).odor(idxOdor).popCoupling;
%                 exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleAnalogicResponsePerCycleAllTrials =...
%                     shank(idxShank).cell(idxUnit).odor(idxOdor).cycleSpikeRateResponseTrialHz;
%                 exp(idxExperiment).shank(idxShank).cell(idxUnit).odor(idxOdor).peakAnalogicResponsePerCycleAllTrials =...
%                     shank(idxShank).cell(idxUnit).odor(idxOdor).cyclePeakResponseTrialHz;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixWarp =...
                    shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor). sdf_trialNoWarp= shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital;
                app = zeros(n_trials,1);
                app = sum(exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp(:,13000:17000),2);
                app = app/4;
                app1 = [];
                [~, app1] = find(app>0.5);
                if numel(app1) > n_trials/2
                    app2(idxOdor) = 1;
                end   
            end
            exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit = 0;
            exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).keepUnit = 0;
            if sum(app2) > floor(odors/3)
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit = 1;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).keepUnit = 1;
            end
            exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).bslSpikeRate =...
                shankWarp(idxShank).cell(idxUnit).cycleBslSpikeRateHz;
            exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).bslPeakRate =...
                shankWarp(idxShank).cell(idxUnit).cycleBslPeakAmplitudeHz;
            exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).bslPeakLatency =...
                shankWarp(idxShank).cell(idxUnit).cycleBslPeakLatencyMeanHz;
            exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).cycleBslSdf =...
                shankWarp(idxShank).cell(idxUnit).cycleBslMultipleSdfHz;
%             exp(idxExperiment).shank(idxShank).cell(idxUnit).baselinePhases =...
%                 shank(idxShank).cell(idxUnit).allBaselineSpikes;
%             exp(idxExperiment).shank(idxShank).cell(idxUnit).responsePhases =...
%                 shank(idxShank).cell(idxUnit).allResponseSpikes;
%             exp(idxExperiment).shank(idxShank).cell(idxUnit).cross =...
%                 shank(idxShank).cell(idxUnit).autocorrelogram;
%             exp(idxExperiment).shank(idxShank).cell(idxUnit).lags =...
%                 shank(idxShank).cell(idxUnit).autocorrelogramLags;
        end
    end
    clearvars -except List idxExperiment cartella exp startingFolder
end

cd(startingFolder)
clearvars -except List exp 
save('plCoA_15odors.mat', '-v7.3')

    