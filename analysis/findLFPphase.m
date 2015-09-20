
for k = 1:odors
    X = lfp_data1(:,:,k);
    y = hilbert(X');
    sigphase(:,:,k) = angle(y);
end