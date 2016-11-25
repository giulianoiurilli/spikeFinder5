function reduceBreathingSignal(ADC, Dig_inputs, samplingRate)




onsets = valve_onset(Dig_inputs, 0.5);
inizio = onsets - 4*samplingRate +1;
fine = onsets + 6*samplingRate;
indici = zeros(size(Dig_inputs));
window_size = fine(1) - inizio(1) + 1;
for i = 1:length(onsets)
    indici(inizio(i):fine(i)) = ones(1,window_size);
end
indici = logical(indici);

ADC = ADC(indici);
save('breathSignal.mat', 'ADC');