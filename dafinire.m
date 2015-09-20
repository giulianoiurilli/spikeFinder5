spikes = sua_trial;

edges = [sec_on_bsl(1,1) sec_off_bsl{1,1}(1,1) sec_off_bsl{1,2}(1,1) sec_off_bsl{1,3}(1,1) sec_on_rsp(1,1) sec_off_rsp{1,1}(1,1) sec_off_rsp{1,2}(1,1) sec_off_rsp{1,3}(1,1)];

figure
t_axis = -pre:1/fs:post; t_axis(end)=[];

plot(t_axis, breath(1,:,1))

respiro = breath(1,:,2);
breath(1,pre*fs + 1,1)  %inizio prima inalazione

inalazioni = respiro<0;
esalazioni = respiro>0;
app_in = diff(inalazioni);
ina_on = find(app_in==1);
ina_on = ina_on + 1;
ina_on = ina_on';

app_ex = diff(esalazioni);
exa_on = find(app_ex==1);
exa_on = exa_on + 1;
exa_on = exa_on';

%trasforma in secondi
sec_ina_on = ina_on/fs;
sec_exa_on = exa_on/fs;

%ri-referenzia allo 0
sec_ina_on = sec_ina_on - repmat(pre,length(sec_ina_on),1);
sec_exa_on = sec_exa_on - repmat(pre,length(sec_exa_on),1);

%trova l'indice della prima inalazione post-odore
ina_post = sec_ina_on(sec_ina_on>0);
[indice,~] = find(sec_ina_on == ina_post(1));

% crea bins per le 4 inalazioni + 4 esalazioni prima e le 5 inalazioni + 5 esalazioni dopo l'inizio
% dell'odore
edges=[];
for idx = indice-4:indice+4
    edges = [edges sec_ina_on(idx) sec_exa_on(idx)];
end

sua = shank(4).spiketimesUnit{3};
sua_trial = sua(find((sua > sec_on_rsp(1,2) - pre) & (sua < sec_on_rsp(1,2) + post))) - sec_on_rsp(1,2);
[aps,ind] = histc(sua_trial, edges);
figure;
bar_ax = 1:18;
bar(bar_ax,aps)

sua_trial1 = [];
sua_trial1 = sua_trial(sua_trial >= edges(1) & sua_trial <= edges(end));

k = [1 -4; 2 -4; 3 -3; 4 -3; 5 -2; 6 -2; 7 -1; 8 -1; 9 1; 10 1; 11 2; 12 2; 13 3; 14 3; 15 4; 16 4; 17 5; 18 5];
for i=1:length(sua_trial1)
    ciclo = ind(i);
    sua_trial1(i) = sua_trial1(i) - edges(ciclo);
    
    re_spike(i) = k(i,2) * (sua_trial1(i) * pi / (edges(ciclo+1) - edges(ciclo)));
end




