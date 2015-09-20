in_trig_resp = [];
in_trig_lfp = [];
for i=1:length(inhal_on)
    in_trig_resp = [in_trig_resp; respiration(floor(inhal_on(i)*20000 - 0.1*20000) : floor(inhal_on(i)*20000 + 0.1*20000))];
    in_trig_lfp = [in_trig_lfp; lfp_data_delta(floor(inhal_on(i)*1000 - 0.1*1000) : floor(inhal_on(i)*1000 + 0.1*1000))];
end

in_trig_resp = zscore(mean(in_trig_resp));
in_trig_lfp = zscore(mean(in_trig_lfp));

figure;

plot(in_trig_resp);
hold on
plot(in_trig_lfp);