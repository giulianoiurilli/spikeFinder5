channels = size(rawTraces,1);
meanTrace = mean(rawTraces);

rereferencedRawTraces = bsxfun(@minus, rawTraces, meanTrace);

samplingRate = 30000;

HighPass = 700;
LowPass = 8000;

Wp = [ HighPass LowPass] * 2 / samplingRate; % pass band for filtering
Ws = [ 500 9950] * 2 / samplingRate; %transition zone
[N,Wn] = buttord( Wp, Ws, 3, 20); % determine filter parameters
[B,A] = butter(N,Wn); % builds filter

filteredTraces = nan(size(rereferencedRawTraces));
for idxChannel = 1:channels
    filteredTraces(idxChannel,:) = filtfilt(B, A, rereferencedRawTraces(idxChannel,:));
end

fileID = fopen('rawData.bin', 'w');
fwrite(fileID, filteredTraces(:), 'int16');
fclose(fileID);