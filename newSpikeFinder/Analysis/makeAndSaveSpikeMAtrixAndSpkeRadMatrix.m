fileToSave1 = 'plCoA_15_1.mat';
fileToSave3 = 'plCoA_15_3.mat';
startingFolder = pwd;
folderlist = {esp(:).filename};
%%
preOnset = 4;
odors = 1:15;
% odors = [2:15 1]; %CS1
% odors = [6 8 5 11 12 3 2 10 14 4 7 13 15 9 1]; %coa AAmix
% odors = [4 2 13 12 1 11 3 5 8 15 6 7 9 10 14]; %pcx AAmix
n_odors = length(odors);
n_trials = 10;
%%
% folderlist = uipickfiles('FilterSpec', '/Volumes/graid', 'Output', 'struct');
%%
for idxExp = 1 : length(folderlist)
    folderExp = folderlist{idxExp};
    disp(folderExp)
%         cd(fullfile(folderExp, 'ephys'))
    cd(folderExp)
    makeParams
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
                    espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrix = sparse(logical(spike_matrix_app));
                    %                     espe(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf = shank(idxShank).SUA.sdf_trial{idxUnit};
                end
            end
        end
    end
end
%%
cd(startingFolder)
clearvars -except folderlist  espe fileToSave1 fileToSave3 odors 
save(fileToSave1, 'espe','-v7.3')
clear espe
clear fileToSave

%%

n_odors = length(odors);
fs = 20000;
preOnset = 3;
preInhalations = 3;
postInhalations = 6;
edgesSpikeMatrixRad = 0:2*pi/360:(preInhalations+postInhalations)*2*pi;
sigmaDeg = 10;
n_trials = 10;

startingFolder = pwd;
for idxExp = 1 : length(folderlist)
    folderExp = folderlist{idxExp};
    disp(folderExp)
%         cd(fullfile(folderExp, 'ephys'))
    cd(folderExp)
    load('units.mat');
    findSniffOnsets(fs, odors)
    load('breathing.mat', 'breath', 'sec_on_rsp');
    for idxShank = 1:4
        if ~isnan(shank(idxShank).SUA.clusterID{1})
            for idxUnit = 1:length(shank(idxShank).SUA.clusterID)
                sua = shank(idxShank).SUA.spiketimesUnit{idxUnit};
                idxO = 0;
                for idxOdor = odors
                    idxO = idxO + 1;
                    psthBreathingBins = zeros(n_trials, 2 * (preInhalations + postInhalations-1));
                    IEcycleLength = zeros(n_trials, 2 * (preInhalations + postInhalations-1));
                    spikeMatrixRad = zeros(n_trials,length(edgesSpikeMatrixRad));
                    %                     esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf_trialRad = zeros(n_trials,length(edgesSpikeMatrixRad));
                    %                     esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf_trialHz = zeros(n_trials,length(edgesSpikeMatrixRad));
                    %                     esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf_trialRad(:,end) = [];
                    %                     esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf_trialHz(:,end) = [];
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sniffBinnedPsth = [];
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).inh_exa_cycleLength = [];
                    for idxTrial = 1:n_trials
                        respiro = breath(idxTrial,:,idxOdor);
                        startOdor = sec_on_rsp(idxTrial, idxOdor);
                        [alpha, spikesBinnedByInhExh, piLength] = transformSpikeTimesToSpikePhases(respiro, preOnset, fs, sua, startOdor, preInhalations, postInhalations);
                        if ~isempty(spikesBinnedByInhExh)
                            psthBreathingBins(idxTrial,:) = spikesBinnedByInhExh;
                        end
                        IEcycleLength(idxTrial,:) = piLength;
                        alpha_trial{idxTrial} = alpha;
                        esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).alphaTrial{idxTrial} = alpha_trial{idxTrial};
                        alpha = round(alpha, 2);
                        shiftedAlpha = alpha + round(preInhalations * 2*pi, 2);
                        indexes = histc(shiftedAlpha, edgesSpikeMatrixRad);
                        indexes(indexes > 0) = 1;
                        spikeMatrixRad(idxTrial,:) = indexes;
                        %                         esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf_trialRad(idxTrial,:) = spikeDensityRad(spikeMatrixRad(idxTrial,:), sigmaDeg);
                        %                         %Morphing
                        %                         piLength = piLength';
                        %                         piLength = repmat(piLength, 1, 180);
                        %                         piLength = reshape(piLength', [],1);
                        %                         piLength = piLength';
                        %                         piLength = piLength / 180 * sigmaDeg; %how many seconds for sigmaDeg(usually 10 deg)
                        %                         sv = SplitVec(piLength, 'consecutive','firstval');
                        %                         sampleAt = piLength(90:180:end); %find nodes to fit with a spline
                        %                         sampleAt = [sampleAt(2) sampleAt]; %pad on left
                        %                         x1 = -90:180:length(piLength);
                        %                         xx = -90:length(piLength); xx(end) = [];
                        %                         piLengthSplined = spline(x1, sampleAt, xx);
                        %                         piLength = piLengthSplined(91:end);
                        %                         esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf_trialHz(idxTrial,:) = esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sdf_trialRad(idxTrial,:) ./ piLength;
                    end
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).spikeMatrixRad = sparse(logical(spikeMatrixRad));
                    %psthBreathingBins(1,:) = [];
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sniffBinnedPsth = psthBreathingBins;
                    esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).inh_exa_cycleLength = IEcycleLength;
                    %                     psthBreathingBins = mean(psthBreathingBins);
                    %                     meanBsl = zeros(1, 2 * preInhalations);
                    %                     meanBsl(1:2:2*preInhalations-1) = mean(psthBreathingBins(1 : 2 : 2 * preInhalations - 1));
                    %                     meanBsl(2:2:2*preInhalations) = mean(psthBreathingBins(2 : 2 : 2 * preInhalations));
                    %                     repeatfor = floor(postInhalations / preInhalations);
                    %                     andadd = mod(2 * postInhalations, 2 * preInhalations);
                    %                     meanBsl = repmat(meanBsl, 1, 1 + repeatfor);
                    %                     meanBsl = [meanBsl meanBsl(1:andadd)];
                    %                     esperimento(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxO).sniffBinnedBsl = meanBsl;
                    clear alpha_trial
                end
                clear sua
            end
        end
    end
end
cd(startingFolder)
clearvars -except esperimento fileToSave3
save(fileToSave3, 'esperimento', '-v7.3')