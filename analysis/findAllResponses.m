%%
fileToSave = 'pcx_AAmix_2_2.mat';
fileToSave2 = 'pcx_AAmix_2_1.mat';
load('parameters.mat');
startingFolder = pwd;
odorsRearranged = 1:15;
% odorsRearranged = [1 7 3 15]; %coa
% odorsRearranged = [7 6 10 9]; %pcx
% odorsRearranged = [8 11 12 5 2 14 4 10]; %coa AA
% odorsRearranged = [2 12 13 1 8 3 15 5]; %pcx AA
% odorsRearranged = [7 6 13 15 3 9]; %coa Mix
%odorsRearranged = [4 6 7 9 10 11]; %pcx Mix
%odorsRearranged = [4 5 13 15 1 14 8 3 7 12 11 10 6 9 2]; %coa CS
%odorsRearranged = [14 13 12 15 1 5 3 4 2 6 8 7 9 10 11]; %pcx CS
%odorsRearranged = [6 8 5 11 12 3 2 10 14 4 7 13 15 9 1]; %coa AAmix
%odorsRearranged = [4 2 13 12 1 11 3 5 8 15 6 7 9 10 14]; %pcx AAmix



odors = length(odorsRearranged);
%%
for idxExp = 1 : length(List)
    cartella = List{idxExp};
    cd(cartella)
    load('unitsNowarp.mat', 'shankNowarp');
    response_window = 1; 
    for idxShank = 1:4
        for idxUnit = 1:length(shankNowarp(idxShank).cell)
            idxO = 0;
            R = zeros(n_trials, odors);
            B = zeros(n_trials, odors);
            X = zeros(n_trials, odors);
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                spike_matrix_app = single(shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrixNoWarp);
                espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).spikeMatrix = logical(spike_matrix_app);
                espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).sdf = shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).sdf_trialNoWarp;
                
                % Response kinetics
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
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse300ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl300ms = appBsl;
                [auroc, significant] = findAuROC(appBsl, appRsp, 1);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROC300ms = auroc;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse300ms = significant;
                
                % Now I take the first 1000 ms
                response_window = 1;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-2)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse1000ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl1000ms = appBsl;
                [auroc, significant] = findAuROC(appBsl, appRsp, 1);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROC1000ms = auroc;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse1000ms = significant;
                
                % Now I take the first 2000 ms
                response_window = 2;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-3)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+51) : floor(pre*1000 + response_window*1000)), 2)';
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse2000ms = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl2000ms = appBsl;
                [auroc, significant] = findAuROC(appBsl, appRsp, 1);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROC2000ms = auroc;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse2000ms = significant;
                
                % Now I take the first 1000 ms post-odor
                response_window = 1;
                appBsl = [];
                appRsp = [];
                appBsl = sum(spike_matrix_app(:, floor((pre-2)*1000+51) : floor((pre-1)*1000)), 2)';
                appRsp = sum(spike_matrix_app(:, floor(pre*1000+2000) : floor(pre*1000 + 2000 + response_window*1000)), 2)';
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponseOffset = appRsp;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBslOffset  = appBsl;
                [auroc, significant] = findAuROC(appBsl, appRsp, 1);
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).auROCOffset  = auroc;
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponseOffset = significant;
                
                % Find a decent number of spikes to deem a good cell
                Re = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse1000ms';
                Re = Re > 0;
                appR(idxO) = sum(Re);
                Ba = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
                Ba = Ba > 0;
                appB(idxO) = sum(Ba);
                
                R(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicResponse1000ms';
                B(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
            end
            
            % Call good cells
            appR = appR > length(Re)./2;
            appR = sum(appR);
            appB = appB > length(Ba)./2;
            appB = sum(appB);
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good = 0;
            if appR > 0 || appB > odors-1
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good = 1;
            end
            
            % Test reliability over all odors
            X = R - B;
            Xj = X(1:end-1,:); Xj = reshape(Xj, 1, size(Xj,1)*size(Xj,2));
            Xk = X(2:end,:); Xk = reshape(Xk, 1, size(Xk,1)*size(Xk,2));
            [rho, pval] = corr(Xj', Xk');
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).reliability = rho;
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).reliabilityPvalue = pval;
        end
    end
end
%%
cd(startingFolder)
clearvars -except List esp espe fileToSave fileToSave2
save(fileToSave, 'esp')
save(fileToSave2, 'espe', '-v7.3')
           
                
                
                
                
                
                
                
                
                
                
                