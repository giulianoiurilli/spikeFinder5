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
% make continous data files CSCx.mat
load('CSC0.mat');
rawTraces = nan(32, size(Samples,2));
if options.probeType == 1
    listChannels = 
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

%% Filtering
HPFilteredTraces = highPassFilterTraces(rawTraces);
HPFiltered_ReReferencedTraces = reReferenceTraces(HPFilteredTraces);

disp('Saving...')
if options.formatOutputFile == 2
    if options.singleOutputFile == 0
        rawTraces1 = HPFiltered_ReReferencedTraces(1:8,:);
        rawTraces2 = HPFiltered_ReReferencedTraces(9:16,:);
        rawTraces3 = HPFiltered_ReReferencedTraces(17:24,:);
        rawTraces4 = HPFiltered_ReReferencedTraces(25:32,:);
        
        fileID = fopen('shank1.dat', 'w');
        fwrite(fileID, rawTraces1(:), 'int16');
        fclose(fileID);
        fileID = fopen('shank2.dat', 'w');
        fwrite(fileID, rawTraces2(:), 'int16');
        fclose(fileID);
        fileID = fopen('shank3.dat', 'w');
        fwrite(fileID, rawTraces3(:), 'int16');
        fclose(fileID);
        fileID = fopen('shank4.dat', 'w');
        fwrite(fileID, rawTraces4(:), 'int16');
        fclose(fileID);
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