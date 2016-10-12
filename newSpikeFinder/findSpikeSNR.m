function SNR_sep = findSpikeSNR(allWF, meanWF, n_channels)

deviats = bsxfun(@minus, double(allWF), meanWF);
deviats_sep = reshape(deviats, [],size(allWF,2), n_channels);
meanWavef_sep = reshape(meanWF, [],size(allWF,2), n_channels);
for idxChannel = 1:n_channels
    dev_ch = deviats_sep(:,:,idxChannel);
    noise_SD_sep(idxChannel) = nanstd(dev_ch(:));
    signal_DEV_sep(idxChannel) = range(meanWavef_sep(:,:,idxChannel));
    SNR_sep(idxChannel) = signal_DEV_sep(idxChannel) / (2*noise_SD_sep(idxChannel));
end
[~,indexBestChannel] = max(signal_DEV_sep);
SNR_sep(indexBestChannel);
