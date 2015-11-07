
startingFolder = pwd;
for idxExperiment = 1 : length(List)
    cartella = List{idxExperiment};
    cd(cartella)
    load('unitsWarp.mat', 'shankWarp');
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
                    if (mean(a{2}) > mean(a{1})) && (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).fourCyclesDigitalResponse = 1;
                        %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                    else
                        if (mean(a{2}) < mean(a{1})) && (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
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
                exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).goodTrials4cycles = goodTrials./n_trials;
                
                % Now I take the first 300 ms
                appBsl = [];
                appRsp = [];
                spike_matrix_app = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
                startBsl = repmat(pre*1000, n_trials, 1) - (sec_on_rsp(:,idxOdor) - sec_on_bsl(:,idxOdor))*1000;
                for trialNumb = 1:n_trials
                    splCountBsl(trialNumb) = sum(spike_matrix_app(trialNumb,floor(startBsl(trialNumb) + 51) : floor(pre*1000)));
                    splCountBsl(trialNumb) = splCountBsl(trialNumb)./floor((floor(pre*1000)-floor(startBsl(trialNumb) + 51))/(response_window*1000));
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
                if pvals < 0.05
                    if (mean(a{2}) > mean(a{1})) && (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300Ms = 1;
                        %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                    else
                        if (mean(a{2}) < mean(a{1})) && (exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300Ms = -1;
                            %exp(idxExperiment).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodTrials300ms = goodTrials./n_trials;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency300ms = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency;
                exp(idxExperiment).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth300ms = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth;
            end
        end
    end
end

cd(startingFolder)
clearvars -except List exp
save('aPCx_aveatt_Area.mat', 'exp', '-append')




