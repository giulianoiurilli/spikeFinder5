
startingFolder = pwd;
for idxExperiment = 1 : length(exp)
    cartella = List{idxExperiment};
    cd(cartella)
    load('unitsWarp.mat', 'shankWarp');
    load('unitsNowarp.mat', 'shankNowarp');
    load('breathing.mat', 'sec_on_rsp', 'sec_on_bsl')
    load('parameters.mat');
    for idxShank = 1:4
        for idxUnit = 1:length(shankWarp(idxShank).cell)
            for idxOdor = 1:odors
                appBsl = [];
                appRsp = [];
                % I take a window of 4 cycles
                appBsl = sum(shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad(:,5*360 + 1 : 9*360), 2);
                appRsp = sum(shankWarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixRad(:,10*360 + 1 : 14*360), 2);
                a = [];
                a = {appBsl' appRsp'};
                [t, df, pvals, surog] = statcond(a, 'mode', 'bootstrap', 'naccu', 1000);
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse = 0;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicResponse = appRsp;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesAnalogicBsl = appBsl;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).pValue4cycles = pvals;
                if pvals < 0.05
                    if (mean(a{2}) > mean(a{1})) %&& (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse = 1;
                        %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse = -1;
                            %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).goodExcTrials4cycles = sum(goodTrialsExc)./n_trials;
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).goodInhTrials4cycles = sum(goodTrialsInh)./n_trials;
                
                % Now I take the first 300 ms
                appBsl = [];
                appRsp = [];
                spike_matrix_app = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
                startBsl = repmat(pre*1000, n_trials, 1) - (sec_on_rsp(:,idxOdor) - sec_on_bsl(:,idxOdor))*1000;
                for trialNumb = 1:n_trials
                    %splCountBsl(trialNumb) = sum(spike_matrix_app(trialNumb,floor(startBsl(trialNumb) + 51) : floor(pre*1000)));
                    splCountBsl(trialNumb) = sum(spike_matrix_app(trialNumb,floor(startBsl(trialNumb) + 51) : floor(pre*1000)));
                    %average spike count in a 300 ms window during the
                    %baseline for each trial
                    splCountBsl(trialNumb) = splCountBsl(trialNumb) ./ ceil( (floor(pre*1000)-floor(startBsl(trialNumb) + 51)) / (response_window*1000) );
                end
                appBsl = splCountBsl;
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {splCountBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'mode', 'bootstrap', 'naccu', 1000);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms = 0;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms = appRsp;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms = appBsl;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms = findAuROC(appBsl, appRsp);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms = pvals;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency300ms = [];
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth300ms = [];
                if pvals < 0.05
                    if (mean(a{2}) > mean(a{1})) %&& (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms = 1;
                        %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        sdf_response = mean(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor(pre*1000) : floor(pre*1000 + 1 + 1000)));
                        [peak_sdf, idx] = max(sdf_response);
                        exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency300ms = idx;
                        lengthResp  = find(sdf_response > max(sdf_response)/2);
                        exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth300ms = length(lengthResp);
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms = -1;
                            %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodExcTrials300ms = sum(goodTrialsExc)./n_trials;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodInhTrials300ms = sum(goodTrialsInh)./n_trials;
            end
        end
    end
end

cd(startingFolder)
clearvars -except List exp
<<<<<<< HEAD
save('plCoA_concseries_Area.mat', 'exp', '-append')
=======
save('aPCx_concseries_Area.mat', 'exp', '-append')
>>>>>>> origin/master




