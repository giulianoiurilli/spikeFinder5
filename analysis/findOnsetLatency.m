%%
odorsRearranged = 1:15; %15 odors
odors = length(odorsRearranged);
%%

startingFolder = pwd;
for idxExp = 1 : length(List)%-1
    cartella = List{idxExp};
    cd(cartella)
    load('unitsNowarp.mat', 'shankNowarp');
    load('breathing.mat', 'sec_on_rsp', 'sec_on_bsl')
    load('parameters.mat');
    response_window = 1;
    for idxShank = 1:4
        for idxUnit = 1:length(shankNowarp(idxShank).cell)
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                spike_matrix_app = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                startBsl = repmat(pre*1000, n_trials, 1) - (sec_on_rsp(:,idxOdor) - sec_on_bsl(:,idxOdor))*1000;
                splCountBsl = zeros(n_trials,950);
                for trialNumb = 1:n_trials
                    splCountBsl(trialNumb,:) = spike_matrix_app(trialNumb,floor(startBsl(trialNumb) + 51) : floor(pre*1000));
                end
                splCountBslMean = mean(splCountBsl);
                splCountRspMean = mean(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)));
                cumDistrBsl = []; cumDistrRsp = [];
                cumDistrBsl = cumsum(splCountBslMean);
                cumDistrRsp = cumsum(splCountRspMean);
                pvals = []; h = []; app = []; hx = [];
                for idxTime = 1:length(cumDistrBsl)
                    [hx, p] = kstest2(cumDistrBsl(1:idxTime), cumDistrRsp(1:idxTime), 'Tail', 'larger');
                    pvals(idxTime) = p;
                end
                [FDR, Q] = mafdr(pvals);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).onsetLatencyCumSum = find(hx < 0.05,1);
            end
        end
    end
end

%save('coa_15_2_2.mat', 'esp')
