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
bin_size = 0.01;
fs = 20000;
%fsTTL = 5000;
thres = .5;






app=find(signal>thres);
app1=SplitVec(app,'consecutive'); %crea delle celle di segmenti soprasoglia consecutivi
app=[];
for j=1:length(app1) %per ogni segmento
    [maxvalue, maxind]=max(signal(app1{j})); %trova il picco (indice relativo all'inizio del segmento)
    app(j)=app1{j}(maxind); %e ne memorizza l'indice (relativo all'inizio della sweep) in un vettore dei timestamps degli AP nella sweep i
end

%app(end-1:end) = [];

app_sec=app./fs;

edges = [0:bin_size:app_sec(end)+30];
% sigma = 0.1;
% edges1=[-3*sigma:bin_size:3*sigma];
% kernel = normpdf(edges1,0,sigma);
% kernel = kernel*bin_size;


opts.threshold.permutations_percentile = 95;
opts.threshold.number_of_permutations = 20;
opts.threshold.method = 'circularshift';
opts.Patterns.method = 'ICA';
opts.Patterns.number_of_iterations = 200;


k = 1;
for fol = 1:size(fromFolders, 2)
    cd(fromFolders{fol})
    load('spikes.mat')
    
    good = spikes.labels(find(spikes.labels(:,2) == 2));

    for s = 1: length(good)% = good       cycles through cells on that shank
        sua{k} = spikes.spiketimes(find(spikes.assigns == good(s)));
        psth(k,:) = histc(sua{k},edges)';
        %z_psth(k,:) = (psth(k,:) - mean(psth(k,:))) ./ std(psth(k,:));
%         density(k,:) = conv(psth(k,:),kernel);
%         center = ceil(length(edges1)/2);
%         density1(k,:)=density(k,center:length(edges) + center-1);
%         z_density(k,:) = (density1(k,:) - mean(density1(k,:))) ./ std(density1(k,:));
        k=k+1;
    end
    
end

%assemblies = assembly_patterns(z_density, opts);
%activities = assembly_activity(assemblies, psth);
[assemblies, corrMatrix] = assembly_patterns(psth, opts);
activities = assembly_activity(assemblies, psth);
figure,
for i = 1:size(activities,1)
    subplot(size(activities,1),1,i)
    plot(edges,activities(i,:))
end


h = figure;
for i = 1:size(assemblies,2)
    subplot(size(assemblies,2),1,i), stem(assemblies(:,i))
end
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('AssembliesMembers.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


for ass = 1:size(assemblies,2)
    h = figure;
    m=1;
    for k = 1:odors
        j = 1;
        for i = k:odors:length(app_sec)
            assembly_trial(j,:) = activities(ass,round(app_sec(i)-pre).*(1/bin_size):round(app_sec(i)+post).*(1/bin_size));
            areaBaselineTrial(j) = sum(assembly_trial(j, 1 : pre./bin_size));
            areaResponseTrial(j) = sum(assembly_trial(j, pre./bin_size + 1 : (response_window + pre) ./ bin_size));
            j = j+1;
        end
        assembly_response{ass}(k,:) = mean(assembly_trial,1);
        meanBaselineAssemblyTrial{ass}(k) =  mean(areaBaselineTrial);
        meanResponseAssemblyTrial{ass}(k) =  mean(areaResponseTrial);
        responsiveAssemblyOdorPair{ass}(k,1) = ttest2(areaResponseTrial, areaBaselineTrial, 'Tail', 'right');
        responsiveAssemblyOdorPair{ass}(k,2) = ttest2(areaResponseTrial, areaBaselineTrial, 'Tail', 'left');
        subplot(odors,1,k)
        plot([-pre:bin_size:post],assembly_response{ass}(k,:)), axis tight
    end
    set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal','Box','off','TickDir','out', 'YDir','normal');
    set(h,'color','white', 'PaperPositionMode', 'auto');
    stringa_fig=sprintf('ResponsesAssembly%d.eps', ass);
    saveas(h,fullfile(toFolder,stringa_fig),'epsc')
end

filename = sprintf('assembly.mat');
save(fullfile(toFolder, filename), 'signal', 'corrMatrix', 'ass', 'assemblies', 'activities', 'assembly_trial', 'assembly_response', 'meanBaselineAssemblyTrial', 'meanResponseAssemblyTrial', 'responsiveAssemblyOdorPair',...
    'bin_size', 'pre', 'post', 'response_window')

cd ..








