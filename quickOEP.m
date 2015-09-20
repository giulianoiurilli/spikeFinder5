
load('dig1.mat');
signal = Dig_inputs;
toFolder = uigetdir('', 'Save in');
odors = 1;
pre = 3;
post = 5;
response_window = 3;
thres = .5;


app=find(signal>thres);
app1=SplitVec(app,'consecutive'); %crea delle celle di segmenti soprasoglia consecutivi
app=[];
for j=1:length(app1) %per ogni segmento
    [maxvalue, maxind]=max(signal(app1{j})); %trova il picco (indice relativo all'inizio del segmento)
    app(j)=app1{j}(maxind); %e ne memorizza l'indice (relativo all'inizio della sweep) in un vettore dei timestamps degli AP nella sweep i
end

app_sec=app./fs;


for exp = shank_lfp
    
    stringa = sprintf('CSC%d.mat', exp);
    load(stringa, 'lfp_data', 'lfp_fs')
    Fs = lfp_fs;
        
    for i = 1:floor(length(app_sec))     %cycles through trials
        lfp_data1(i,:) = lfp_data((app_sec(i) - pre) * Fs + 1 : (app_sec(i) + post) * Fs);
    end
    
    stringa_fig=sprintf('oep_site%d.eps', exp);
    h=figure('Name',stringa_fig, 'NumberTitle','off');
    oep = mean(lfp_data1,1);
    plot(oep)    
    set(h,'color','white', 'PaperPositionMode', 'auto');  
    saveas(h,fullfile(toFolder,stringa_fig),'epsc')
    
end

