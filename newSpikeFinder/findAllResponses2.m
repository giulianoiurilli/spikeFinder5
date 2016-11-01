fileToSave = 'aPCx_CS2_2.mat';
fileToSave2 = 'aPCx_CS2_1.mat';
startingFolder = pwd;
%%
preOnset = 4;
odors = 1:15;
n_odors = length(odors);
n_trials = 10;
%%
folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');
%%
for idxExp = 1 : length(folderlist)
    folderExp = folderlist(idxExp).name;
    disp(folderExp)
    cd(fullfile(folderExp, 'ephys'))
    makeParams
    load('units.mat');
    makeSpikeMatrix
%                                                                 if idxExp == 8
%                                                                     fixMissingTrials
%                                                                 end
    load('units.mat');
    for idxShank = 1:4
        if ~isnan(shank(idxShank).SUA.clusterID{1})
            for idxUnit = 1:length(shank(idxShank).SUA.clusterID)
                idxO = 0;
                R = zeros(n_trials, n_odors);
                B = zeros(n_trials, n_odors);
                X = zeros(n_trials, n_odors);
                for idxOdor = odors
                    idxO = idxO + 1;
                    spike_matrix_app = single(shank(idxShank).SUA.spike_matrix{idxUnit}(:,:,idxOdor));
                    espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrix = logical(spike_matrix_app);
                    espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf = shank(idxShank).SUA.sdf_trial{idxUnit};
                    
                    % Response kinetics
                    sdf_response = mean(shank(idxShank).SUA.sdf_trial{idxUnit}(:, floor(preOnset*1000) : floor(preOnset*1000 + 3 * 1000), idxOdor));
                    [peak_sdf, idx] = max(sdf_response);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).peakLatency = idx;
                    lengthResp  = find(sdf_response > max(sdf_response)/2);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).halfWidth = length(lengthResp);
                    sdf_bsl = shank(idxShank).SUA.sdf_trial{idxUnit}(:, floor((preOnset-4)*1000+1) : floor((preOnset-1)*1000), idxOdor);
                    mean_sdf_bsl = mean(sdf_bsl(:));
                    std_sdf_bsl = std(mean(sdf_bsl));
                    [onset_sdf, onset_idx] = find(sdf_response >=  mean_sdf_bsl + std_sdf_bsl, 1);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).onsetLatency = onset_idx;
                    
                    % Here I take the first 300 ms
                    response_window = 0.3;
                    appBsl = [];
                    appRsp = [];
                    appBsl = sum(spike_matrix_app(:, floor((preOnset-2)*1000) : floor((preOnset-2+response_window)*1000)), 2)';
                    appRsp = sum(spike_matrix_app(:, floor(preOnset*1000) : floor(preOnset*1000 + response_window*1000)), 2)';
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse300ms = appRsp;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl300ms = appBsl;
                    [auroc, significant] = findAuROC(appBsl, appRsp, 1);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC300ms = auroc;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse300ms = significant;
                    if AnalogicBsl300ms > 0
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).ResponseModulation300ms = ((AnalogicResponse300ms - AnalogicBsl300ms)/AnalogicBsl300ms)*100;
                    else
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).ResponseModulation300ms = 100;
                    end
                    
                    % Now I take the first 1000 ms
                    response_window = 1;
                    appBsl = [];
                    appRsp = [];
                    appBsl = sum(spike_matrix_app(:, floor((preOnset-2)*1000) : floor((preOnset-1)*1000)), 2)';
                    appRsp = sum(spike_matrix_app(:, floor(preOnset*1000) : floor(preOnset*1000 + response_window*1000)), 2)';
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms = appRsp;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms = appBsl;
                    [auroc, significant] = findAuROC(appBsl, appRsp, 1);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC1000ms = auroc;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse1000ms = significant;
                    if AnalogicBsl1000ms > 0
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).ResponseModulation1000ms = ((AnalogicResponse1000ms - AnalogicBsl1000ms)/AnalogicBsl1000ms)*100;
                    else
                        esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).ResponseModulation1000ms = 100;
                    end
                    
                    % Now I take the first 2000 ms
                    response_window = 2;
                    appBsl = [];
                    appRsp = [];
                    appBsl = sum(spike_matrix_app(:, floor((preOnset-3)*1000) : floor((preOnset-1)*1000)), 2)';
                    appRsp = sum(spike_matrix_app(:, floor(preOnset*1000) : floor(preOnset*1000 + response_window*1000)), 2)';
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse2000ms = appRsp;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl2000ms = appBsl;
                    [auroc, significant] = findAuROC(appBsl, appRsp, 1);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROC2000ms = auroc;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponse2000ms = significant;
                    
                    % Now I take the first 1000 ms post-odor
                    response_window = 1;
                    appBsl = [];
                    appRsp = [];
                    appBsl = sum(spike_matrix_app(:, floor((preOnset-2)*1000) : floor((preOnset-1)*1000)), 2)';
                    appRsp = sum(spike_matrix_app(:, floor(preOnset*1000+2000) : floor(preOnset*1000 + 2000 + response_window*1000)), 2)';
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponseOffset = appRsp;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBslOffset  = appBsl;
                    [auroc, significant] = findAuROC(appBsl, appRsp, 1);
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).auROCOffset  = auroc;
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).DigitalResponseOffset = significant;
                    
                    % Find a decent number of spikes to deem a good cell
                    Re = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms';
                    Re = Re > 0;
                    appR(idxO) = sum(Re);
                    Ba = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
                    Ba = Ba > 0;
                    appB(idxO) = sum(Ba);
                    
                    R(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicResponse1000ms';
                    B(:, idxO) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).AnalogicBsl1000ms';
                end
                
                % Call good cells
                appR = appR > length(Re)./2;
                appR = sum(appR);
                appB = appB > length(Ba)./2;
                appB = sum(appB);
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good = 0;
                if 1>0 %appR > 0 || appB > n_odors-1
                    esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good = 1;
                end
                
                % Test reliability over all n_odors
                X = R - B;
                Xj = X(1:end-1,:); Xj = reshape(Xj, 1, size(Xj,1)*size(Xj,2));
                Xk = X(2:end,:); Xk = reshape(Xk, 1, size(Xk,1)*size(Xk,2));
                [rho, pval] = corr(Xj', Xk');
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliability = rho;
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).reliabilityPvalue = pval;
                
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).spikeSNR = shank(idxShank).SUA.spikeSNR{idxUnit};
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).isolationDistance = shank(idxShank).SUA.isolationDistance{idxUnit};
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio = shank(idxShank).SUA.L_Ratio{idxUnit};
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).clusterID = shank(idxShank).SUA.clusterID{idxUnit};
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).sourceFolder = shank(idxShank).SUA.sourceFolder{idxUnit};
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).meanWaveform = shank(idxShank).SUA.meanWaveform{idxUnit};
                x = diff(shank(idxShank).SUA.spiketimesUnit{idxUnit});
                RPV = numel(find(x<2));
                RP = 0.001;
                N = numel(x + 1);
                T = shank(idxShank).SUA.spiketimesUnit{idxUnit}(end);
                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).RPviolation = rpv_contamination(N, T, RP, RPV );
            end
        else
            esp(idxExp).shank(idxShank).SUA = [];
        end
            
    end
    esp(idxExp).filename = folderExp;
end
%%
cd(startingFolder)
clearvars -except folderlist esp espe fileToSave fileToSave2
save(fileToSave, 'esp')
save(fileToSave2, 'espe','-v7.3')
save('List.mat', 'folderlist')











