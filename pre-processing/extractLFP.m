function lfp_data =  extractLFP(filename)
%File for filtering in the lfp range and subsample
%--------------------------------------------------------------------------
 
%% Parameters
fs = 20000;
lp_butter=500; %Low pass filter (Hz) (Butter)
hp_delta = 1;
lp_delta = 20;
lp=300; %Low pass filter (Hz) (Kaiser)
hp=1; %High pass filter (Hz) (Kaiser)
ord=4; %Butterworth filter order
new_fs=1000; %New sampling frequency
dp=1; %Transition bandwidth (Kaiser only)
 

 
lfp_data = [];
csc_data_LPButter = [];


[B_butt,A_butt] = butter(ord,lp_butter/(fs/2));
% 
[N,Wn,beta,ftype] = kaiserord([hp-dp hp lp lp+dp],[0 1 0],[1e-6 1 1e-6],new_fs);
B_kai = fir1(N,Wn,ftype,kaiser(N+1,beta ),'noscale');
A_kai = 1;

[N1,Wn1,beta1,ftype1] = kaiserord([hp_delta-dp hp_delta lp_delta lp_delta+dp],[0 1 0],[1e-6 1 1e-6],new_fs);
B_kai_delta = fir1(N1,Wn1,ftype1,kaiser(N1+1,beta1 ),'noscale');
A_kai_delta = 1;


%[B, A] = butter(ord, [hp_delta lp_delta]/(fs/2), 'bandpass');


%% Perform operation


load(filename,'RawSamples');

%Filter data with Butterworth filter

csc_data_LPButter = filtfilt(B_butt, A_butt, RawSamples);
%csc_data_deltaLFP = filtfilt(B, A, RawSamples);




%Resample data



lfp_data = resampling(csc_data_LPButter,fs,new_fs,4,1000,0);
%lfp_data_delta = resampling(csc_data_deltaLFP,fs,new_fs,4,1000,0);




%Filter data with Kaise filter

lfp_data = filtfilt(B_kai,A_kai,lfp_data);
% lfp_data_delta = filtfilt(B_kai_delta,A_kai_delta,lfp_data);


lfp_fs=new_fs;

%Save data
%save(filename ,'lfp_data','lfp_fs', 'lfp_data_delta', '-append');