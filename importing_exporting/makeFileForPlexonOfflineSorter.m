function makeFileForPlexonOfflineSorter(option)

option =1;

load('CSC0.mat');
rawTraces = nan(32, size(Samples,2));
switch option
    case 1
        listChannels = [1 13 5 6 ...
            4 3 11 12 10 ...
            9 31 15 7 8 ...
            2 14 0 16 21 ...
            22 30 17 25 23 ...
            24 26 29 18 ...
            20 19 28 27];
        for idxCSC = 1:32
            fileToLoad = sprintf('CSC%d.mat', listChannels(idxCSC));
            load(fileToLoad)
            rawTraces(idxCSC, :) = Samples;
        end
end
maxVoltage = max(rawTraces(:));
minVoltage = min(rawTraces(:));
% save('rawData.mat', 'rawTraces', '-v7.3')
fileID = fopen('rawData.bin', 'w');
fwrite(fileID, rawTraces(:), 'int16');
fclose(fileID);
save min_max.txt minVoltage maxVoltage -ascii