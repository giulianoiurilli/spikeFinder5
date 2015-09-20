% spikes = sua_trial;
% 
% edges = [sec_on_bsl(1,1) sec_off_bsl{1,1}(1,1) sec_off_bsl{1,2}(1,1) sec_off_bsl{1,3}(1,1) sec_on_rsp(1,1) sec_off_rsp{1,1}(1,1) sec_off_rsp{1,2}(1,1) sec_off_rsp{1,3}(1,1)];

% figure
% t_axis = -pre:1/fs:post; t_axis(end)=[];
% 
% plot(t_axis, breath(1,:,8))



function [alpha, spikesBinnedByInhExh, piLength] = transformSpikeTimesToSpikePhases(respiro, pre, post, fs, sua, sec_on, preInhalations, postInhalations)


% sua = shank(4).spiketimesUnit{3};
% respiro = breath(1,:,14);
% sec_on = sec_on_rsp(1, 1);

%Trova tutte le inalazioni ed esalazioni per quell'odore in quel trial
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

%ri-referenzia all'onset dell'odore, perchè respiro cominciava 'pre' secondi prima dell'odore 
sec_ina_on = sec_ina_on - repmat(pre,length(sec_ina_on),1);
sec_exa_on = sec_exa_on - repmat(pre,length(sec_exa_on),1);

%trova l'indice della prima inalazione post-odore
ina_post = sec_ina_on(sec_ina_on>0);
[indice_ina,~] = find(sec_ina_on == ina_post(1));
exa_post = sec_exa_on(sec_exa_on>0);
[indice_exa,~] = find(sec_exa_on == exa_post(1));

first_inh = sec_ina_on(indice_ina - preInhalations);
first_exh = sec_exa_on(indice_exa - preInhalations);

if first_inh < first_exh
    % crea bins per le x inalazioni + x esalazioni prima e le y inalazioni + y esalazioni dopo l'inizio
    % dell'odore
    edges_ina=[];
    edges_ina = sec_ina_on(indice_ina - preInhalations : indice_ina + postInhalations);
    edges_exa=[];
    edges_exa = sec_exa_on((indice_exa - preInhalations : indice_exa + postInhalations));
else
    edges_ina=[];
    edges_ina = sec_ina_on(indice_ina - preInhalations : indice_ina + postInhalations);
    edges_exa=[];
    edges_exa = sec_exa_on((indice_exa - preInhalations + 1 : indice_exa + postInhalations + 1));
end



%edges_exa(find(edges_exa>=0,1)) = [];
edges = [edges_ina' edges_exa'];
edges = sort(edges);

piLength = diff(edges);
if length(piLength) > 2 * (preInhalations + postInhalations)
    piLength(2 * (preInhalations + postInhalations)+1:end) = [];
end

%load spikes and re-reference to the first inhalation
sua_trial = sua(find((sua > sec_on - pre) & (sua < sec_on + post))) - sec_on;

%select spikes in the window -x inhalation +y inhalation
sua_trial1 = [];
sua_trial1 = sua_trial(sua_trial >= edges(1) & sua_trial < edges(end-1));



%binna gli spikes in ogni fase di inspirazione ed espirazione
[ap,ind] = histc(sua_trial1, edges);
if ~isempty(ap)
    aps = ap;
else
    aps = zeros(1,2 * (preInhalations + postInhalations));
end



%se non lo faccio mi da errore quando c'è un solo spike
if length(sua_trial1) == 1
    aps = aps';
end

aps = aps';


spikesBinnedByInhExh = aps(1:2 * (preInhalations + postInhalations));

% figure;
% bar_ax = 1:length(edges);
% bar(bar_ax,aps)

% sua_trial1 = [];
% sua_trial1 = sua_trial(sua_trial >= edges(1) & sua_trial <= edges(end));




cycle = 1 : 2 * (preInhalations + postInhalations);
cycle = cycle';
app1 = - preInhalations : -1;   app1 = [app1 app1];  app1 = sort(app1);
app2 = 1:postInhalations; app2 = [app2 app2]; app2 = sort(app2);
app3 = [app1 app2]; app3 = app3';
cycle = [cycle app3];


alpha = zeros(1,length(sua_trial1));
for i=1:length(sua_trial1)
    bin = ind(i);
    if bin > 2 * preInhalations %l'ottavo bin è l'ultima espirazione prima dell'odore
        xt = abs(sua_trial1(i) - edges(bin));
        l = abs(edges(bin + 1) - edges(bin));
        xf = xt * pi / l;
        if mod(bin,2) == 1
            alpha(i) = xf + (cycle(bin,2) - 1) * 2 * pi;
        else
            alpha(i) = xf + (cycle(bin,2) - 1) * 2 * pi + pi;
        end
    else
        xt = abs(sua_trial1(i) - edges(bin));
        l = abs(edges(bin + 1) - edges(bin));
        xr =  - (pi - xt * pi / l);
        if mod(bin,2) == 1
            alpha(i) = xr + (cycle(bin,2) + 1) * 2 * pi - pi;
        else
            alpha(i) = xr + (cycle(bin,2) + 1) * 2 * pi;
        end
    end
end




