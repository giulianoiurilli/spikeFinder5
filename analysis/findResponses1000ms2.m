%%
%odorsRearranged = 1:15; %15 odors
odorsRearranged = [8, 9, 10, 11, 12, 13, 14]; %7 odors high
%odorsRearranged = [1,2,3,4,5,6,7]; %7 odors low
%odorsRearranged = [12 13 14 15 1]; %3 odors pen
%odorsRearranged = [2 3 4 5 6]; %3 odors iaa
%odorsRearranged = [7 8 9 10 11]; %3 odors etg
%odorsRearranged = [1 6 11]; %3 odors high
%odorsRearranged = [15 5 10]; %3 odors medium-high
%odorsRearranged = [14 4 9]; %3 odors medium
%odorsRearranged = [13 3 8]; %3 odors medium-low
%odorsRearranged = [12 2 7]; %3 odors low
%odorsRearranged  = [12 13 14 15 1 2 3 4 5 6 7 8 9 10 11];
%{"TMT", "MMB", "2MB", "2PT", "IAA", "PET", "BTN", "GER", "PB", "URI", "G&B", "B&P", "T&B", "TMM", "TMB"};
%odorsRearranged = [1 2 3 4 5  6 7 8 9 10]; %aveatt
%odorsRearranged = [7 11 12 13]; %aveatt mix butanedione
%odorsRearranged = [1 13 14 15]; %mixTMT

%%

startingFolder = pwd;
for idxExp = 1 : length(exp)
    cartella = List{idxExp};
    cd(cartella)
    load('unitsNowarp.mat', 'shankNowarp');
    load('parameters.mat');
    response_window = 1;
    for idxShank = 1:4
        for idxUnit = 1:length(shankNowarp(idxShank).cell)
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                spike_matrix_app = single(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp);
                espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrix = spike_matrix_app;
                espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).sdf = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
                sdf_response = mean(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor(pre*1000) : floor(pre*1000 + 3 * 1000)));
                [peak_sdf, idx] = max(sdf_response);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).peakLatency = idx;
                lengthResp  = find(sdf_response > max(sdf_response)/2);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).halfWidth = length(lengthResp);
                
                sdf_bsl = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor((pre-4)*1000+51) : floor((pre-1)*1000));
                mean_sdf_bsl = mean(sdf_bsl(:));
                std_sdf_bsl = std(mean(sdf_bsl));
                [onset_sdf, onset_idx] = find(sdf_response >=  mean_sdf_bsl + std_sdf_bsl, 1);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).onsetLatency = onset_idx;
                % Here I take the first 300 ms
                response_window = 0.3;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-2)*1000+51) : floor((pre-2+response_window)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'paired', 'off', 'mode', 'perm', 'verbose', 'off','naccu', 1000);                
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse300ms = 0;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse300ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl300ms = appBsl;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROC300ms = findAuROC(appBsl, appRsp);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).pValue300ms = pvals;
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency300ms = [];
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth300ms = [];
                if pvals < 0.05
                    if (mean(a{2}) > mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse300ms = 1;
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse300ms = -1;
                            %esp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                if pvals < 0.05 && (mean(a{2}) == mean(a{1}))
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).pValue300ms = 1;
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).goodExcTrials300ms = sum(goodTrialsExc)./n_trials;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).goodInhTrials300ms = sum(goodTrialsInh)./n_trials;
                
                % Now I take the first 1000 ms
                response_window = 1;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-2)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'paired', 'off', 'mode', 'perm', 'verbose', 'off','naccu', 1000);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse1000ms = 0;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse1000ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl1000ms = appBsl;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROC1000ms = findAuROC(appBsl, appRsp);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).pValue1000ms = pvals;
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency1000ms = [];
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth1000ms = [];
                if pvals < 0.01
                    if (mean(a{2}) > mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse1000ms = 1;
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse1000ms = -1;
                            %esp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                if pvals < 0.01 && (mean(a{2}) == mean(a{1}))
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).pValue1000ms = 1;
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).goodExcTrials1000ms = sum(goodTrialsExc)./n_trials;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).goodInhTrials1000ms = sum(goodTrialsInh)./n_trials;   
                
                % Now I take the first 2000 ms
                response_window = 2;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-3)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'paired', 'off', 'mode', 'perm', 'verbose', 'off', 'naccu', 1000);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse2000ms = 0;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse2000ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl2000ms = appBsl;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROC2000ms = findAuROC(appBsl, appRsp);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).pValue2000ms = pvals;
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency2000ms = [];
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth2000ms = [];
                if pvals < 0.01
                    if (mean(a{2}) > mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse2000ms = 1;
                    else
                        if (mean(a{2}) < mean(a{1})) %&& (esp(idxExp).shankNowarp(idxShank).cell(idxUnit).keepUnit == 1)
                            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse2000ms = -1;
                            %esp(idxExp).shankWarp(idxShank).cell(idxUnit).odor(idxOdor).auROC4cycles = findAuROC(appBsl, appRsp);
                        end
                    end
                end
                if pvals < 0.01 && (mean(a{2}) == mean(a{1}))
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).pValue2000ms = 1;
                end
                meanBsl = mean(appBsl);
                stdBsl = std(appBsl);
                goodTrialsExc = appRsp > (meanBsl + 2*stdBsl);
                goodTrialsInh = appRsp < (meanBsl - stdBsl);
                goodTrials = sum(goodTrialsExc + goodTrialsInh);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).goodExcTrials2000ms = sum(goodTrialsExc)./n_trials;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).goodInhTrials2000ms = sum(goodTrialsInh)./n_trials;
            end
        end
    end
end

cd(startingFolder)
clearvars -except List esp espe 

save('aPCx_2conc_AreaNew1High.mat', 'espe', '-v7.3')
save('aPCx_2conc_AreaNew2High.mat', 'esp')




