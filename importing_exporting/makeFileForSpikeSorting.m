   function makeFileForSpikeSorting(folder, options, samplingRate)

% "probeType":
% (1) - A4x2-tet; (2) - Buzsaki 32L

% "singleOutputFile":
% (1) - save a single file including all channels from all shanks; (0) -
% save a single for each shank

% "formatOutputFile":
% (1) - save as .bin; (2) - save as .dat

% "commonReference"
% (0) - don't re-reference; (1) - common average reference; (2) - common
% median reference

% "filterOn"
% (0) - don't filter; (1) - bandpass filter for LFP[0.1 - 300] and spikes
% [700 - 8000]


%%
cd(folder)



%% re-sort channels according to the channel map of the specific probe and
% make continous data files CSCx.mat
load('CSC0.mat');
rawTraces = nan(32, size(Samples,2));
if options.probeType == 1
    listChannels = [1 13 5 6 ...
        4 3 11 12 10 ...
        9 31 15 7 8 ...
        2 14 0 16 21 ...
        22 30 17 25 23 ...
        24 26 29 18 ...
        20 19 28 27];
listChannels = listChannels';
    for idxCSC = 1:32
        fileToLoad = sprintf('CSC%d.mat', listChannels(idxCSC));
        load(fileToLoad)
        rawTraces(idxCSC, :) = Samples;
    end
else if options.probeType == 2
        listChannels = [ 30 26 21 17 27 22 20 25;...
            28 23 19 24 29 18 31 16;...
            0 15 2 13 8 9 7 1;...
            6 14 10 11 5 12 4 3];
listChannels = listChannels';
        for idxCSC = 1:32
            fileToLoad = sprintf('CSC%d.mat', listChannels(idxCSC));
            load(fileToLoad)
            rawTraces(idxCSC, :) = Samples;
        end
    end
end



%% Common Median Reference

if options.commonReference == 1
    meanTrace = mean(rawTraces);
    rawTraces = bsxfun(@minus, rawTraces, meanTrace);
else if options.commonReference == 2
        medianTrace = median(rawTraces);
        rawTraces = bsxfun(@minus, rawTraces, medianTrace);
    end
end
%% Filtering

if options.filterOn == 1
    
    % spike traces filtering
    HighPass = 700;
    LowPass = 8000;
    Wp = [ HighPass LowPass] * 2 / samplingRate; % pass band for filtering
    Ws = [ 500 9950] * 2 / samplingRate; %transition zone
    [N,Wn] = buttord( Wp, Ws, 3, 20); % determine filter parameters
    [B,A] = butter(N,Wn); % builds filter
    
    HPTraces = nan(size(rawTraces));
    for idxChannel = 1:32
        HPTraces(idxChannel,:) = filtfilt(B, A, rawTraces(idxChannel,:));
    end
    
    % LFP filtering
%     lfp_fs = 1000;
%     [b, a] = butter(4, [0.1, 300] * 2 / lfp_fs);
%     params.Fs = lfp_fs;
%     params.fpass = [0 300];
%     params.pad = 0;
%     params.tapers = [5 9];
%     
%     x = downsample(rawTraces(1,:), samplingRate/lfp_fs);
%     LFPTraces = nan(32, length(x));
%     for idxChannel = 1:32
%         x = downsample(rawTraces(idxChannel,:), samplingRate/lfp_fs);
%         x = rmlinesc(x, params);
%         LFPTraces(idxChannel,:) = filtfilt(b, a, x);
%     end
    
end



%%  Save files

for ch_num = 1:32
    if options.commonReference > 0 && options.filterOn > 0
        fname = sprintf('CSC%d.mat', ch_num-1);
        reReferencedTrace = rawTraces(ch_num, :);
        spikeTrace = HPTraces(ch_num, :);
        %lfpTrace = LFPTraces(ch_num, :);
        %save(fname, 'reReferencedTrace', 'spikeTrace', 'lfpTrace', '-v7.3', '-append');
        save(fname, 'reReferencedTrace', 'spikeTrace', '-append');
    end
    if options.commonReference > 0 && options.filterOn == 0
        fname = sprintf('CSC%d.mat', ch_num-1);
        reReferencedTrace = rawTraces(ch_num, :);
        save(fname, 'reReferencedTrace', '-append');
    end
    if options.commonReference == 0 && options.filterOn > 0
        fname = sprintf('CSC%d.mat', ch_num-1);
        spikeTrace = HPTraces(ch_num, :);
%         lfpTrace = LFPTraces(ch_num, :);
        %save(fname, 'spikeTrace', 'lfpTrace', '-v7.3', '-append');
        save(fname, 'spikeTrace',  '-append');
    end
end



if options.formatOutputFile == 2
    if options.singleOutputFile == 0
        rawTraces1 = rawTraces(1:8,:);
        rawTraces2 = rawTraces(9:16,:);
        rawTraces3 = rawTraces(17:24,:);
        rawTraces4 = rawTraces(25:32,:);
        
        fileID = fopen('rawData1.dat', 'w');
        fwrite(fileID, rawTraces1(:), 'int16');
        fclose(fileID);
        fileID = fopen('rawData2.dat', 'w');
        fwrite(fileID, rawTraces2(:), 'int16');
        fclose(fileID);
        fileID = fopen('rawData3.dat', 'w');
        fwrite(fileID, rawTraces3(:), 'int16');
        fclose(fileID);
        fileID = fopen('rawData4.dat', 'w');
        fwrite(fileID, rawTraces4(:), 'int16');
        fclose(fileID);
    else
        fileID = fopen('rawData.dat', 'w');
        fwrite(fileID, rawTraces(:), 'int16');
        fclose(fileID);
    end
else
    fileID = fopen('rawData.bin', 'w');
    fwrite(fileID, HPTraces(:), 'int16');
    fclose(fileID);
    maxVoltage = max(HPTraces(:));
    minVoltage = min(HPTraces(:));
    save min_max.txt minVoltage maxVoltage -ascii
end