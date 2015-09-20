clear all
close all



fromFolders = uigetdir2;
toFolder = uigetdir('', 'Save in');


load('dig1.mat');


signal = Dig_inputs;

 
pre = 3;
post = 5;
response_window = 3;
odors = 7;
bin_size = 0.2;
fs = 20000;
thres = .5;


app=find(signal>thres);
app1=SplitVec(app,'consecutive'); %crea delle celle di segmenti soprasoglia consecutivi
app=[];
for j=1:length(app1) %per ogni segmento
    [maxvalue, maxind]=max(signal(app1{j})); %trova il picco (indice relativo all'inizio del segmento)
    app(j)=app1{j}(maxind); %e ne memorizza l'indice (relativo all'inizio della sweep) in un vettore dei timestamps degli AP nella sweep i
end

app_sec=app./fs;







for fol = 1:size(fromFolders, 2)
    cd(fromFolders{fol});
    load('spikes.mat');
    
    good = spikes.labels(find(spikes.labels(:,2) == 2));
k = 1;
r = 1;
edges = [-pre:bin_size:post];

    for s = 1: length(good)% = good       cycles through cells
        f = figure(s);
        unit_name = sprintf('cluster %d', good(s));
        title(unit_name);
        sua = spikes.spiketimes(find(spikes.assigns == good(s)));
        r = 0;
        psth{s} = zeros(length(edges),floor(length(app_sec)/odors),odors);
        
        
        for k = 1:odors   %cycles through odors
            
            j = 1;
            
            for i = k:odors:length(app_sec)     %cycles through trials
                sua_trial{j} = sua(find((sua > app_sec(i) - pre) & (sua < app_sec(i) + post))) - app_sec(i);
                %trials(j).times = double(sua_trial{j});
                j=j+1;
            end
            
            
            
            subplot(odors,1,k);
            plotSpikeRaster(sua_trial,'PlotType','vertline', 'VertSpikeHeight', .25,'XLimForCell',[-pre post]);
            xlabel('Time (s)'), ylabel('Trials');
            set(gca,'FontName','Arial','Fontsize',11,'FontWeight','normal','TickDir','out','Box','off');        
        end
    end
end
        
for s = 1: length(good)
    figure(s+1000);
    unit_name = sprintf('cluster %d', good(s));
    
    subplot(3,2,1)
    title(unit_name);
    plot_waveforms(spikes, good(s));
    subplot(3,2,2)
    plot_residuals(spikes, good(s));
    subplot(3,2,3)
    plot_detection_criterion(spikes, good(s));
    subplot(3,2,4)
    plot_isi(spikes, good(s));
    subplot(3,2,5)
    plot_stability(spikes, good(s));
    subplot(3,2,6)
    plot_distances(spikes, good(s));
end

x = inputdlg('Enter cluster numbers to save:');
clustersToSave = str2num(x{:}); 

spikes.labels(:,2) = ones(size(spikes.labels,1),1);
for i = 1:length(clustersToSave)
    spikes.labels(find(spikes.labels(:,1) == clustersToSave(i)),2) = 2;
end

cd ..

string = inputdlg('Enter name new folder:');
mkdir(string{1})
save(fullfile(toFolder, string{1}, 'spikes.mat'), 'spikes')




            
            
            
            
            
            