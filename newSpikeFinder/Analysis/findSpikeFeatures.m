function [trough_to_peak_ratio, trough_to_peak_time, half_amplitude_duration] = findSpikeFeatures(wf, fs)



% wf = pcxNM.esp(4).shank(1).SUA.cell(1).meanWaveform;
% fs = 20000;



[min_wf, t] = min(wf);
spike = wf(t-15:t+15);


interp_factor = 10;
nfs = fs * interp_factor;
spike = interp(spike,interp_factor);
[v_min, t_min] = min(spike);
spike = spike / abs(v_min);
[v_max, t_max] = max(spike(t_min:end));
t_max = t_max + t_min;
[v_min, t_min] = min(spike);





%Look for pr, ppd and end slope
trough_to_peak_ratio = abs(v_min/v_max);
trough_to_peak_time = (t_max - t_min)/nfs;

hw = spike(t_min)/2; %Half width
[~, pre] = min(abs(spike(1:t_min)-hw));
pre_ = t_min - pre;
half_amplitude_duration = 2 * pre_ / nfs;

% hold on
% plot(spike)