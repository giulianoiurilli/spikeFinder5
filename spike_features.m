function [pr,ppd, deltaT] = spike_features(spike,fs)
%[pr,ppd,slop] = spike_features(spike,fs)
%Upsampling
interp_factor=10;
nfs=fs*interp_factor;
spike=interp(spike,interp_factor);
[v_min, t_min]=min(spike);
spike=spike/abs(v_min);
[v_max, t_max]=max(spike(t_min:end));
[v_min, t_min]=min(spike);





%Look for pr, ppd and end slope
pr=abs(v_min/v_max);
ppd=abs(t_max)/nfs;
app=gradient(spike);
%slop=app(round(t_max + 0.5e-3 * nfs));
deltaT = t_max - t_min;

% Look for hwa
% hw=spike(t_min)/2; %Half width
% [app pre]=min(abs(spike(1:t_min)-hw));
% pre=t_min-pre;
% [app post_]=min(abs(spike(max_point+1:end)-hw));
% had=(post_+pre_)/fs*1000;
