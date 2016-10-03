function HPFilteredTraces = highPassFilterTraces(rawTraces, samplingRate)

tic
% spike traces filtering
HighPass = 700;
LowPass = 8000;
Wp = [ HighPass LowPass] * 2 / samplingRate; % pass band for filtering
Ws = [ 500 9950] * 2 / samplingRate; %transition zone
[N,Wn] = buttord( Wp, Ws, 3, 20); % determine filter parameters
[B,A] = butter(N,Wn); % builds filter

HPFilteredTraces = nan(size(rawTraces));
for idxChannel = 1:32
    stringa = sprintf('Filtering CSC%d...', idxChannel-1);
    disp(stringa);
    HPFilteredTraces(idxChannel,:) = filtfilt(B, A, rawTraces(idxChannel,:));
end

disp('Filtering done');
toc

end