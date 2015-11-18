
startingFolder = pwd;
for idxExperiment = 1 : length(exp)
    cartella = List{idxExperiment};
    cd(cartella)
    load('unitsNowarp.mat', 'shankNowarp');
    load('parameters.mat');
    response_window = 1;
    for idxShank = 1:4
        for idxUnit = 1:length(shankNowarp(idxShank).cell)
            for idxOdor = 1:odors
                % Now I take the first 1000 ms
                response_window = 1;
                appBsl = [];
                appRsp = [];
                spike_matrix_app = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;

                appBsl = sum(spike_matrix_app(:, floor((pre-2)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'mode', 'bootstrap', 'naccu', 1000);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms = 0;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms = appRsp;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms = appBsl;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms = findAuROC(appBsl, appRsp);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms = pvals;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency1000ms = [];
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth1000ms = [];
                if pvals < 0.05
                    if (mean(a{2}) > mean(a{1})) %&& (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms = 1;
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms = -1;
                            %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodExcTrials1000ms = sum(goodTrialsExc)./n_trials;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodInhTrials1000ms = sum(goodTrialsInh)./n_trials;
                
                                % Now I take the first 2000 ms
                                response_window = 2;
                appBsl = [];
                appRsp = [];
                spike_matrix_app = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;

                appBsl = sum(spike_matrix_app(:, floor((pre-3)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'mode', 'bootstrap', 'naccu', 1000);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms = 0;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse2000ms = appRsp;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl2000ms = appBsl;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC2000ms = findAuROC(appBsl, appRsp);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue2000ms = pvals;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency2000ms = [];
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth2000ms = [];
                if pvals < 0.05
                    if (mean(a{2}) > mean(a{1})) %&& (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms = 1;
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms = -1;
                            %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodExcTrials2000ms = sum(goodTrialsExc)./n_trials;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodInhTrials2000ms = sum(goodTrialsInh)./n_trials;
            end
        end
    end
end

cd(startingFolder)
clearvars -except List exp
save('aPCx_15odors_Area.mat', 'exp', '-append')




