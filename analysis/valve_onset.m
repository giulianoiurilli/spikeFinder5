function [dig_supra_thresh] = valve_onset(signal, thres);

dig_supra_thresh=find(signal>thres);
dig_supra_thresh1=SplitVec(dig_supra_thresh,'consecutive'); %crea delle celle di segmenti soprasoglia consecutivi
dig_supra_thresh=[];
for j=1:length(dig_supra_thresh1) %per ogni segmento
    [maxvalue, maxind]=max(signal(dig_supra_thresh1{j})); %trova il picco (indice relativo all'inizio del segmento)
    dig_supra_thresh(j)=dig_supra_thresh1{j}(maxind); %e ne memorizza l'indice (relativo all'inizio della sweep) in un vettore dei timestamps degli AP nella sweep i
end

end