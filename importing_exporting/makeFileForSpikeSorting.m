function makeFileForSpikeSorting(folder, options, samplingRate)

% "probeType":
% (1) - A4x2-tet; (2) - Buzsaki 32L

% "singleOutputFile":
% (1) - save a single file including all channels from all shanks; (0) -
% save a single for each shank

% "formatOutputFile":
% (1) - save as .bin; (2) - save as .dat



%%
tic
cd(folder)

%% re-sort channels according to the channel map of the specific probe and

load('CSC0.mat');
rawTraces = nan(32, size(Samples,2));
if options.probeType == 1
%     listChannels = [29 18 25 26;...
%         28 27 20 19;...
%         21 22 31 16;...
%         24 23 30 17;...
%         0 15 10 9;...
%         1 14 7 8;...
%         6 5 2 13;...
%         11 12 3 4];
    
    listChannels = listChannels';
    for idxCSC = 1:32
        fileToLoad = sprintf('CSC%d.mat', listChannels(idxCSC));
        load(fileToLoad)
        rawTraces(idxCSC, :) = Samples;
    end
else if options.probeType == 2
        listChannels = [ 30 25 26 20 21 22 17 27;...
            28 16 23 31 19 18 24 29;...
            0 1 15 7 2 9 13 8;...
            6 3 14 4 10 12 11 5];
        listChannels = listChannels';
        for idxCSC = 1:32
            fileToLoad = sprintf('CSC%d.mat', listChannels(idxCSC));
            load(fileToLoad)
            rawTraces(idxCSC, :) = Samples;
        end
    end
end

%% Filtering
HPFilteredTraces = highPassFilterTraces(rawTraces, 20000);

%% Re-referencing
HPFiltered_ReReferencedTraces = reReferenceTraces(HPFilteredTraces);

%% Saving
disp('Saving...')
if options.formatOutputFile == 2
    if options.singleOutputFile == 0
        rawTraces1 = HPFiltered_ReReferencedTraces(1:8,:);
        rawTraces2 = HPFiltered_ReReferencedTraces(9:16,:);
        rawTraces3 = HPFiltered_ReReferencedTraces(17:24,:);
        rawTraces4 = HPFiltered_ReReferencedTraces(25:32,:);
        
        mkdir('shank1')
        cd('shank1');
        copyfile('/Users/Giuliano/Documents/MATLAB/spikeFinder5/importing_exporting/shank1.prm', pwd);
        fileID = fopen('shank1.dat', 'w');
        fwrite(fileID, rawTraces1(:), 'int16');
        fclose(fileID);
        cd ..
        
        mkdir('shank2')
        cd('shank2');
        copyfile('/Users/Giuliano/Documents/MATLAB/spikeFinder5/importing_exporting/shank2.prm', pwd);
        fileID = fopen('shank2.dat', 'w');
        fwrite(fileID, rawTraces2(:), 'int16');
        fclose(fileID);
        cd ..
        
        mkdir('shank3')
        cd('shank3');
        copyfile('/Users/Giuliano/Documents/MATLAB/spikeFinder5/importing_exporting/shank3.prm', pwd);
        fileID = fopen('shank3.dat', 'w');
        fwrite(fileID, rawTraces3(:), 'int16');
        fclose(fileID);
        cd ..
        
        mkdir('shank4')
        cd('shank4');
        copyfile('/Users/Giuliano/Documents/MATLAB/spikeFinder5/importing_exporting/shank4.prm', pwd);
        fileID = fopen('shank4.dat', 'w');
        fwrite(fileID, rawTraces4(:), 'int16');
        fclose(fileID);
        cd ..
    else
        fileID = fopen('ephysData.dat', 'w');
        fwrite(fileID, rawTraces(:), 'int16');
        fclose(fileID);
    end
else
    fileID = fopen('ephysData.bin', 'w');
    fwrite(fileID, HPFiltered_ReReferencedTraces(:), 'int16');
    fclose(fileID);
    maxVoltage = max(HPFiltered_ReReferencedTraces(:));
    minVoltage = min(HPFiltered_ReReferencedTraces(:));
    save min_max.txt minVoltage maxVoltage -ascii
end
disp('Done!')
toc