
startingFolder = pwd;
for idxExp = 1 : length(esp)
    cartella = List{idxExp};
    cd(cartella)
    load('unitsNowarp.mat', 'shankNowarp');
    load('parameters.mat');
    response_window = 1;
    for idxShank = 1:4
        for idxUnit = 1:length(shankNowarp(idxShank).cell)
            for idxOdor = 1:odors
                spike_matrix_app = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix = spike_matrix_app;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf = exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
                sdf_response = mean(exp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor(pre*1000) : floor(pre*1000 + 3 * 1000)));
                [peak_sdf, idx] = max(sdf_response);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency = idx;
                lengthResp  = find(sdf_response > max(sdf_response)/2);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth = length(lengthResp);
                sdf_bsl = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor(startBsl + 51) : floor(startBsl + 51 + pre_bsl*1000));
                mean_sdf_bsl = mean(sdf_bsl(:));
                std_sdf_bsl = std(mean(sdf_bsl));
                [onset_sdf, onset_idx] = find(sdf_response >=  mean_sdf_bsl + std_sdf_bsl, 1);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency = onset_idx;
                % Here I take the first 300 ms
                response_window = 0.3;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-2)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'paired', 'off', 'mode', 'perm', 'verbose', 'off');                
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms = 0;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms = appBsl;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC300ms = findAuROC(appBsl, appRsp);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms = pvals;
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency300ms = [];
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth300ms = [];
                if pvals < 0.005
                    if (mean(a{2}) > mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms = 1;
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse300ms = -1;
                            %esp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                if pvals < 0.005 && (mean(a{2}) == mean(a{1}))
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue300ms = 1;
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodExcTrials300ms = sum(goodTrialsExc)./n_trials;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodInhTrials300ms = sum(goodTrialsInh)./n_trials;
                
                % Now I take the first 1000 ms
                response_window = 1;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-2)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'paired', 'off', 'mode', 'perm', 'verbose', 'off');
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms = 0;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms = appBsl;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms = findAuROC(appBsl, appRsp);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms = pvals;
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency1000ms = [];
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth1000ms = [];
                if pvals < 0.005
                    if (mean(a{2}) > mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms = 1;
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms = -1;
                            %esp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                if pvals < 0.005 && (mean(a{2}) == mean(a{1}))
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue1000ms = 1;
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodExcTrials1000ms = sum(goodTrialsExc)./n_trials;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodInhTrials1000ms = sum(goodTrialsInh)./n_trials;   
                
                % Now I take the first 2000 ms
                response_window = 2;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-3)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'paired', 'off', 'mode', 'perm', 'verbose', 'off');
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms = 0;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse2000ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl2000ms = appBsl;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC2000ms = findAuROC(appBsl, appRsp);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue2000ms = pvals;
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency2000ms = [];
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth2000ms = [];
                if pvals < 0.005
                    if (mean(a{2}) > mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms = 1;
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse2000ms = -1;
                            %esp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                if pvals < 0.005 && (mean(a{2}) == mean(a{1}))
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).pValue2000ms = 1;
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodExcTrials2000ms = sum(goodTrialsExc)./n_trials;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).goodInhTrials2000ms = sum(goodTrialsInh)./n_trials;
            end
        end
    end
end

cd(startingFolder)
clearvars -except List esp
save('aPCx_2conc_AreaNew.mat', 'esp')




