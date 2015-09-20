function [sniffs] = findSniffs(respiro, pre, fs)


%Trova tutte le inalazioni ed esalazioni per quell'odore in quel trial
inalazioni = respiro<0;
app_in = diff(inalazioni);
ina_on = find(app_in==1);
ina_on = ina_on + 1;
ina_on = ina_on';






%max-min per ogni ciclo
powerCycle  = zeros(length(ina_on), 1);
idxIna = 1;
while ina_on(idxIna) < ina_on(end)
    breathCycle = respiro(ina_on(idxIna) : ina_on(idxIna + 1));
    throughCycle = min(breathCycle);
    peakCycle = max(breathCycle);
    amplitudeCycle = abs(peakCycle - throughCycle);
    powerCycle(idxIna) = amplitudeCycle^2 / (length(breathCycle)/fs);
    idxIna = idxIna + 1;
end

powerCycle(idxIna) = powerCycle(idxIna - 1);
    
%trasforma in secondi 
sec_ina_on = ina_on/fs;
    
%ri-referenzia all'onset dell'odore, perchè respiro cominciava 'pre' secondi prima dell'odore 
sec_ina_on = sec_ina_on - repmat(pre,length(sec_ina_on),1);

sniffs = [sec_ina_on powerCycle];




