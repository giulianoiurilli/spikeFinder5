function [inhal_on, exhal_on, respiration] = respirationFilter(ADC);


fs = 20000;
respiration = ADC;

[B, A] = butter(2, [1 20]/(fs/2), 'bandpass');
respiration = filtfilt(B, A, respiration);
%respiration = detrend(respiration);
%respiration = smooth(respiration, fs*0.2);


% resp = diff(sign(respiration));
% inhal_on = find(resp>0);
% indx_down = find(resp<0);

avg_respiration = mean(respiration);
std_respiration = std(respiration);
ups = respiration>(avg_respiration + 0.1*std_respiration);
inhalations = respiration<0;
exhalations = respiration>0;

%app_inh = diff(ups);
app_inh = diff(inhalations);
inhal_on = find(app_inh==1);
inhal_on = inhal_on + 1;
inhal_on = inhal_on';

app_exh = diff(exhalations);
exhal_on = find(app_exh==1);
exhal_on = exhal_on + 1;
exhal_on = exhal_on';



%cubicRespiration   = sgolayfilt(respiration, 3, 2901);


end