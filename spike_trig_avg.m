
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

for k=1:1
acc_app = acc_smooth(k,1:25:end);
index=1;
for j=1:length(app)
    if app(j)>pre && (length(acc_app)-app(j))>post
        spikeWaveforms(index,:)=acc_app(app(j)-pre:app(j)+post);
        spikeWaveforms(index,:)= spikeWaveforms(index,:) - mean(spikeWaveforms(index,:));
        index=index+1;
    end
end

appSpikes=spikeWaveforms';

pcc =3;
pc=[];
[pc_ch,eigvec,sv] = runpca(appSpikes);
pc_ch=pc_ch(1:pcc,:);



clear spikeWaveforms
end

figure,plot([-pre:post],spikeWaveforms)
    
    
