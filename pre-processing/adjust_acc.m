function adjust_acc

ciccio= 'matlabData.mat';
load(ciccio);


HighPass = .01;
LowPass = 20;



Flt = [HighPass LowPass];

FilterOrder = 2;



fs = 5000;

% Set butterworths filter properties
[B, A] = butter(FilterOrder, [(Flt(1) / fs) (Flt(2) / fs)]);

for i=1:3
    stringa = sprintf('ACC%d.mat', i);
    load(stringa);
    %up_Acc_Samples = (Acc_Samples - mean(Acc_Samples)) / std(Acc_Samples);
    filt_Acc_Samples(i,:) = filtfilt(B, A, Acc_Samples);
end

t_acc = (0:4*length(filt_Acc_Samples));

stringa=sprintf('save %s -append filt_Acc_Samples t_acc', ciccio);
eval(stringa);






