signal = Dig_inputs;

%Parameters
pre=100; 
post=100; 




figure
plot(signal)
grid on;
axis tight;



h=helpdlg('Select threshold for spikes','Threshold spikes');
uiwait(h);
[x, thres]=ginput(1);
app=find(signal>thres);
app1=SplitVec(app,'consecutive'); %crea delle celle di segmenti soprasoglia consecutivi
app=[];
for j=1:length(app1) %per ogni segmento
    [maxvalue, maxind]=max(signal(app1{j})); %trova il picco (indice relativo all'inizio del segmento)
    app(j)=app1{j}(maxind); %e ne memorizza l'indice (relativo all'inizio della sweep) in un vettore dei timestamps degli AP nella sweep i
end

app_sec=app./20000;

sua = spikes.spiketimes(find(spikes.assigns == 1));
for i = 1:7:length(app_sec)
sua_trial{i} = sua(find((sua > app_sec(i) - 5) & (sua < app_sec(i) + 5))) - app_sec(i);
end
edges = [-5:.05:5];


figure(1)
psth = zeros(1,length(edges));
for j = 1:length(app_sec)
psth = psth + histc(double(sua_trial{j}), edges);
end
bar(edges, psth);
xlim([-1.1 1])
xlabel('Time (sec)')
ylabel('# of spikes')

figure(2)
plotSpikeRaster(sua_trial,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[-1 1]);

