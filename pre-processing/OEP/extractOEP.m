function extractOEP(filename)
%File for filtering in the lfp range and subsample
%--------------------------------------------------------------------------
 
%% Parameters
lp_butter=500; %Low pass filter (Hz) (Butter)
lp=250; %Low pass filter (Hz) (Kaiser)
hp=1; %High pass filter (Hz) (Kaiser)
ord=4; %Butterworth filter order
fs=10000;
new_fs=1000; %New sampling frequency
dp=1; %Transition bandwidth (Kaiser only)
 

 
lfp_data = [];
csc_data_LPButter = [];


[B_butt,A_butt] = butter(ord,lp_butter/(fs/2));

[N,Wn,beta,ftype] = kaiserord([hp-dp hp lp lp+dp],[0 1 0],[1e-6 1 1e-6],new_fs);
B_kai = fir1(N,Wn,ftype,kaiser(N+1,beta ),'noscale');
A_kai = 1;


%% Perform operation


load(filename,'Samples');

%Filter data with Butterworth filter

csc_data_LPButter = filtfilt(B_butt, A_butt, Samples);


%Resample data



lfp_data = resampling(csc_data_LPButter,fs,new_fs,4,1000,0);




%Filter data with Kaise filter

lfp_data = filtfilt(B_kai,A_kai,lfp_data);


lfp_fs=new_fs;

%Save data
save(filename ,'lfp_data','lfp_fs', '-append');