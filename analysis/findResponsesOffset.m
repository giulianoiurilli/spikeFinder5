%%
folder = pwd;
odorsRearranged = 1:15; %15 odors
odors = length(odorsRearranged);
%%

startingFolder = pwd;
for idxExp = 1 : length(List)%-1
    cartella = List{idxExp};
    cd(cartella)
    load('unitsNowarp.mat', 'shankNowarp');
    load('parameters.mat');
    %load('breathing.mat', 'sec_on_rsp', 'sec_on_bsl')
    response_window = 1;
    for idxShank = 1:4
        for idxUnit = 1:length(shankNowarp(idxShank).cell)
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                spike_matrix_app = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                
     
                
                
               
                
                response_window = 1;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-2)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+2000) : floor(pre*1000 + 2000 + response_window*1000)), 2)';
                a = [];
                a = {appBsl appRsp};
                [t, df, pvals, surog] = statcond(a, 'paired', 'off', 'mode', 'perm', 'verbose', 'off', 'naccu', 1000);
                                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse2000ms = 0;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponseOffset = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBslOffset  = appBsl;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROCOffset  = findAuROC(appBsl, appRsp);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).pValueOffset  = pvals;
                if pvals < 0.01
                    if (mean(a{2}) > mean(a{1})) 
                        esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponseOffset  = 1;
                    else
                        if (mean(a{2}) < mean(a{1}))
                            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponseOffset  = -1;
                        end
                    end
                end
                if pvals < 0.01 && (mean(a{2}) == mean(a{1}))
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).pValueOffset  = 1;
                end
            end
        end
    end
end

cd(folder)
save('pcx_AA_2_2.mat', 'esp', '-append')





                
%                 startBsl = repmat(pre*1000, n_trials, 1) - (sec_on_rsp(:,idxOdor) - sec_on_bsl(:,idxOdor))*1000;
%                 response_window = 1;
%                 splCountBsl = zeros(n_trials,response_window*1000+1);
%                 for trialNumb = 1:n_trials
%                     splCountBsl(trialNumb,:) = spike_matrix_app(trialNumb,floor(startBsl(trialNumb) + 51) : floor(startBsl(trialNumb) + 51 + response_window*1000));
%                 end
%                 splCountBslMean = mean(splCountBsl);               
%                 splCountRspMean = mean(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000+51 + response_window*1000)));
%                 cumDistrBsl = []; cumDistrRsp = [];
%                 cumDistrBsl = cumsum(splCountBslMean);
%                 cumDistrRsp = cumsum(splCountRspMean);
%                 pvals = []; h = []; app = []; hx = [];
%                 for idxTime = 1:length(cumDistrBsl)
%                     [hx, p] = kstest2(cumDistrBsl(1:idxTime), cumDistrRsp(1:idxTime), 'Tail', 'larger');
%                     pvals(idxTime) = p;
%                 end
%                 sig_p = find(pvals<0.05);
%                 if ~isempty(sig_p)
%                     [FDR, Q] = mafdr(pvals);
%                     esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).onsetLatencyCumSum = find(hx < 0.05,1);
%                 else
%                     esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).onsetLatencyCumSum = nan;
%                 end
%                
   