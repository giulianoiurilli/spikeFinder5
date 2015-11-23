load('parameters.mat')
%load('breathing.mat', 'sec_on_rsp', 'sec_on_bsl')
load('unitsNowarp.mat')

for idxShank = 1:4
    for idxUnit = 1:length(shankNowarp(idxShank).cell)
        for idxOdor = 1:odors
            spike_matrix_app = single(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp);
            startBsl = repmat(pre*1000, n_trials, 1) - (sec_on_rsp(:,idxOdor) - sec_on_bsl(:,idxOdor))*1000;
            for trialNumb = 1:n_trials
                splCountBsl(trialNumb) = sum(spike_matrix_app(trialNumb,floor(startBsl(trialNumb) + 51) : floor(pre*1000)));
                splCountBsl(trialNumb) = splCountBsl(trialNumb)./floor((floor(pre*1000)-floor(startBsl(trialNumb) + 51))/(response_window*1000));
            end
            a = {splCountBsl sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)'};
            [t, df, pvals, surog] = statcond(a, 'mode', 'bootstrap', 'naccu', 1000);
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital = 0;
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespAnalogic = [];
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeRateResp = [];
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency = [];
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth = [];
            shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency = [];
            if pvals < 0.05
                sdf_response = [];
                sdf_bsl = [];
                lengthResp = [];
                if (mean(a{2}) > mean(a{1})) && mean(a{2})./(response_window - 0.051) >= min_firingResp
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital = 1;
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespAnalogic = a{2}';
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeRateResp = a{2}'./(response_window - 0.051);
                    sdf_response = mean(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor(pre*1000) : floor(pre*1000 + 1 + 1000)));
                    [peak_sdf, idx] = max(sdf_response);
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency = idx;
                    lengthResp  = find(sdf_response > max(sdf_response)/2);
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth = length(lengthResp);
                    sdf_bsl = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp(:, floor(startBsl + 51) : floor(startBsl + 51 + pre_bsl*1000));
                    mean_sdf_bsl = mean(sdf_bsl(:));
                    std_sdf_bsl = std(mean(sdf_bsl));
                    [onset_sdf, onset_idx] = find(sdf_response >=  mean_sdf_bsl + std_sdf_bsl, 1);
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency = onset_idx;
                else
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).peakLatency = NaN;
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).halfWidth = NaN;
                    shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).onsetLatency = NaN;
                    if mean(a{2}) < mean(a{1})
                        shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital = -1;
                        shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespAnalogic = a{2}';
                        shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeRateResp = a{2}'./(response_window - 0.051);
                    end
                end
                
                shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespAnalogic = a{2}';
                shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeRateResp = a{2}'./(response_window - 0.051);
            else
                shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespDigital = 0;
                shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeCountRespAnalogic = a{2}';
                shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeRateResp = a{2}'./(response_window - 0.051);
            end
        end
    end
end

save('unitsNowarp.mat', 'shankNowarp', '-append')


