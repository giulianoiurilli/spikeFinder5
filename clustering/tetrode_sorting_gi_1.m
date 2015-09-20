function tetrode_sorting_gi(tetrodes)


%Main file for sorting spikes on tetrodes. Use a Split-and-Merge
%Expectation-Maximization algorithm to automatically cluster spikes.
% For reference see Tolias et al., 2007.
%Spikes are assumed to be concatenations of 4 waveforms (from the 4
%channels of each tetrode)


%% Get ready
%clear all;
close all;

hold off
tetrodes_clusters=[];
cluster_indexes=[];
clustersToKeep=[];


filename = 'matlabData.mat';
load(filename);

%% Parameters

tf = sr/1000;                                                               %conversion factor to tranform timestamps in milliseconds

fsmem_alg=1;                                                                %Set  to 1 to use fsmem algorithm, 0 otherwise
if fsmem_alg
    trainingSetSize=inf;
    calc_index=1;                                                           %Calculate cluster quality indexes? (1=yes, 0=no)
else
    trainingSetSize=100000;                                                 %Size of data subset for performing clustering (if data is too large)
    calc_index=0;
end

%N.B. The next two parameters are not used by the fsmem algorithm
th_tetrodes=[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01];                      %Thresholds for stopping the spliiting step (small th --> lots of clusters) N.B. Also depends on the amount of data (normal value 0.01)

%N.B. One different threshold per tetrode might be necessary
ltol=0.01;                                                                  %Threshold for the convergence of the gaussian fitting step (normal value 0.01)

cth=0;                                                                   %Ratio of points to be considered artefacts, set to 0 not to exclude any spike (normal value 0.025 (outermost 5% is excluded in fsmem) or lower)
testSetSize=0.1;                                                            %Size of test set for BIC index (fsmem only) (e.g. 0.1=10%)

secondClustering=1;

choosePCA = 1; %features(1);
chooseICA = 0; %features(2);
chooseWavelet = 0;  %features(3); to implement uig

pcc=3;                                                                      %Number of principal components to be employed (normal value = 3)
n_ica = 10;                                                                 %Number of independent components to be employed (normal value = 10-12)
n_coeff = 3;                                                                %Number of wavelet coefficients to be employed (normal value = 3)


plot_clusters=1;                                                            %Set to one to plot clusters
isTetrode=1;

max_t=100;                                                                  % in ms
edges=0:1:max_t;                                                            %Bins (in ms) for plotting ISI distributions

cols_sp=['-k';'-r';'-b';'-m';'-c';'-g';'-r';'-b';'-k';'-m';'-c';'-g';'-r';'-b';'-k';'-m';'-c';'-g';'-r';'-b';'-k';'-m';'-c';'-g'];
cols_pc=['.k';'.r';'.b';'.m';'.c';'.g';'.r';'.b';'.k';'.m';'.c';'.g';'.r';'.b';'.k';'.m';'.c';'.g';'.r';'.b';'.k';'.m';'.c';'.g'];

%% Analyze step


for i=1:length(tetrodes)
    tetrode = tetrodes(i);
    th=th_tetrodes(i);
    ts=Timestamps;
    filename_tetrode = sprintf('tetrode%d_spikes.mat', tetrode);
    load(filename_tetrode)
    
    appSpikes=[];
    
    L=-Inf;
    while L<=0
        if ~fsmem_alg
            [clusters,k,pc,L,D] = SortSpikes(spikes,trainingSetSize,pcc,cth,th,ltol,calc_index,isTetrode); %Sort step
        else
            %Prepare test set, to be kept unchanged across multiple runs of the smem algorithm
            if isTetrode
                testSet=randperm(size(spikes,1));
                testSet=testSet(1:round(size(spikes,1)*testSetSize));
            else
                testSet=randperm(size(spikes,1));
                testSet=testSet(1:round(size(spikes,1)*testSetSize));
            end
            
            if choosePCA
                [clusters,k,pc,L,D,BIC,cont] = cluster_fsmem_PCA(spikes,trainingSetSize,pcc,cth,th,ltol,calc_index,isTetrode,testSet);
                
            elseif chooseICA
                [clusters,k,pc,L,D,BIC,cont,ica2plot] = cluster_fsmem_ICA(spikes,trainingSetSize,pcc,cth,th,ltol,calc_index,isTetrode,testSet,n_ica);

            else chooseWavelet
                [clusters,k,pc,L,D,BIC,cont] = SortSpikes_fsmem_WAV(spikes,trainingSetSize,n_coeff,cth,th,ltol,calc_index,isTetrode,testSet);
            end
        end
        %clusters: vector with the index of the cluster each spikes belongs to (0: artefact cluster)
        %k: number of clusters (+ artefact clusters if present)
        %pc: principal components
        %L: log-likelihood value (the higher it is, the better clustering is)
        %D: Davies-Bouldin's index, useful if clusters were computed on a subset of all spikes (log-likelihood was not computed on the whole data set)
        %Notes:
        %D is not computed (I didn't have the code available, but it can be easily added)
        %BIC: the lower, the better
        %cont: This is the sum of false positives and false negatives per cluster, it must be lower than 0.05, or a cluster must be discarded
    end
    
    if plot_clusters                                                        %Plot results for each channel

        for j=0:k
            app=[];
            app=find(clusters==j);
            figure(j + 10);
            appSpikes(:,:)=spikes;
            cha = size(appSpikes,2)/4;
            for z=1:4                                
                subplot(2,2,z);
                new_appSpikes = appSpikes(app, 1+(z-1)*cha : cha+(z-1)*cha);
                plot(new_appSpikes', 'Color', [0.8 0.8 0.8]);
                hold on
                plot(mean(new_appSpikes), cols_sp(j+1,:),'LineWidth',2);
                unit = sprintf('Unit %d, channel %d', j, z);
                title(unit)     
            end
                       
            if choosePCA 
                figure(1);
                
                subplot(1,pcc,1);
                plot(pc(app,1),pc(app,2),cols_pc(j+1,:)); xlabel('PC1'),ylabel('PC2'), axis square, grid on; title('Principal components')
                hold on;
                subplot(1,pcc,2);
                plot(pc(app,1),pc(app,3),cols_pc(j+1,:)); xlabel('PC1'),ylabel('PC3'), axis square, grid on; title('Principal components')
                hold on;
                subplot(1,pcc,3);
                plot(pc(app,2),pc(app,3),cols_pc(j+1,:)); ylabel('PC3'),xlabel('PC2'), axis square
                hold on; grid on; title('Principal components')
                
                
                
                %             elseif ~choosePCA
                %                 figure(2);
                %                 plot(pc(app,ica2plot(1)),pc(app,ica2plot(2)),cols_pc(j+1,:));
                %                 hold on; grid on; title('Projection on the first 2 indipendent components')
                %
                %
                %             else
                %                 subplot(1,pcc,1);
                %                 plot(pc(app,1),pc(app,2),cols_pc(j+1,:)); xlabel('Coeff1'),ylabel('Coeff2'), axis square, grid on; title('Wavelet coefficients')
                %                 hold on;
                %                 subplot(1,pcc,2);
                %                 plot(pc(app,1),pc(app,3),cols_pc(j+1,:)); xlabel('Coeff1'),ylabel('Coeff3'), axis square, grid on; title('Wavelet coefficients')
                %                 hold on;
                %                 subplot(1,pcc,3);
                %                 plot(pc(app,2),pc(app,3),cols_pc(j+1,:)); ylabel('Coeff3'),xlabel('Coeff2'), axis square
                %                 hold on; grid on; title('Wavelet coefficients')
            end
            
            
            %Quality indexes
            
                IsDis(j+1) = IsolationDistance(pc, app);
                if size(pc(app,:),1) > size(pc(app,:),2)
                    L_ratio(j+1) = L_Ratio(pc, app);                    
                else
                    L_ratio(j+1) = 0;
                end
                % IsDis(j)= 0;
           
            
            
            if j>0 && length(app)> 4
                ts_=ts(app)/tf;
                
                %ISI
                isi=diff(ts_);
                n=histc(isi,edges);
                tot_spikes(j) = sum(n);
                n=n./tot_spikes(j);
                violating(j)=n(1) + n(2);
                figure(j+20);
                subplot(2,1,1);
                bar(edges,n,cols_pc(j+1,2));
                xlabel('Time (ms)');
                xlim([edges(1)-100 edges(end)]);
                unit = sprintf('Unit %d, ISI distribution\n', j);
                title(unit);
                
                
                %Spiking Auto-correlogram
                cross_fire=zeros(1,max_t+1);
                %ts_=ts_/20;
                for ks=1:length(ts_)
                    app1=ts_-ts_(ks);
                    app1=app1(app1<=max_t);
                    app1=app1(app1>0);
                    app1=app1+1;
                    if ~isempty(app1)
                        cross_fire(round(app1))=cross_fire(round(app1))+1;
                    end
                end
                cross_fire=cross_fire/length(ts_);
                subplot(2,1,2);
                bar(edges,cross_fire,cols_pc(j+1,2));
                xlabel('Time (ms)');
                xlim([edges(1)-100 edges(end)]);
                unit = sprintf('Unit %d, Autocorrelogram', j);
                title(unit);               
            else violating =NaN;
            end
        end
        
        
        %if length(tetrodesToAnalyze)>1
        %pause();
        %close all;
        %end
        %stringa1 = 'BIC: ';
        
        L_ratio(1)=[];
        IsDis(1)=[];
        
        stringa='False negative+positive indexes | L-ratio | Isolation Distance | Spikes in violation zone:';
        for j=1:length(cont)
            stringa=sprintf('%s\n Cluster %d: %d | %d | %d | %d/%d',stringa,j,cont(j), L_ratio(j), IsDis(j), violating(j), tot_spikes(j));
        end
        
        stringa=sprintf('%s\n Insert clusters to be kept (between []):\n',stringa);
        options.Resize='on';
        options.WindowStyle='normal';
        clustersToKeep{i}=str2num(cell2mat(inputdlg(stringa,'Cluster selection',1,{'[]'},options)));
        close all;        
    end
    
    if secondClustering
        clusters2=[];
        clustersToKeep2=[];
        for k=clustersToKeep{i}
            orClust=find(clusters==k);
            appSpikes=spikes(orClust,:);
            if isTetrode
                testSet=randperm(size(appSpikes,1));
                testSet=testSet(1:round(size(appSpikes,1)*testSetSize));
            else
                testSet=randperm(size(appSpikes,1));
                testSet=testSet(1:round(size(appSpikes,1)*testSetSize));
            end
            [clusters2_app,k2,pc,L,D,BIC,cont] = cluster_fsmem_PCA(appSpikes,trainingSetSize,pcc,cth,th,ltol,calc_index,isTetrode,testSet);
            clusters2{k}=clusters2_app;
            
            for j=1:k2
                app=[];
                app=find(clusters2{k}==j);                
                figure(j + 100);
                for z=1:4
                    subplot(2,2,z);
                    new_appSpikes = appSpikes(app, 1+(z-1)*cha : cha+(z-1)*cha);
                    plot(new_appSpikes', 'Color', [0.8 0.8 0.8])
                    hold on
                    plot(mean(new_appSpikes), cols_sp(j+1,:),'LineWidth',2);
                    unit = sprintf('Unit %d, channel %d', j, z);
                    title(unit)
                    hold off
                    set(gca,'FontName','Arial','Fontsize',11, 'FontWeight', 'normal','Box','off')
                    axis off
                end
                set(gcf,'color','white', 'PaperPositionMode', 'auto');
                
                if choosePCA 
                    figure(2);
                    subplot(1,pcc,1);
                    plot(pc(app,1),pc(app,2),cols_pc(j+1,:)); xlabel('PC1'),ylabel('PC2'), axis square; title('Principal components')
                    hold on;                    
                    set(gca,'FontName','Arial','Fontsize',11, 'FontWeight', 'normal','Box','off','TickDir','out')     
                    subplot(1,pcc,2);
                    plot(pc(app,1),pc(app,3),cols_pc(j+1,:)); xlabel('PC1'),ylabel('PC3'), axis square; title('Principal components')
                    hold on;
                    set(gca,'FontName','Arial','Fontsize',11, 'FontWeight', 'normal','Box','off','TickDir','out')
                    subplot(1,pcc,3);
                    plot(pc(app,2),pc(app,3),cols_pc(j+1,:)); ylabel('PC3'),xlabel('PC2'), axis square
                    hold on;  title('Principal components')
                    set(gca,'FontName','Arial','Fontsize',11, 'FontWeight', 'normal','Box','off','TickDir','out')
                end
                set(gcf,'color','white', 'PaperPositionMode', 'auto');
                
                %Quality indexes
                
                IsDis(j+1) = IsolationDistance(pc, app);
                if size(pc(app,:),1) > size(pc(app,:),2)
                    L_ratio(j+1) = L_Ratio(pc, app);
                else
                    L_ratio(j+1) = 0;
                end
                
                
                if j>0
                    ts_=ts(app)/20;
                    
                    %ISI
                    isi=diff(ts_);
                    n=histc(isi,edges);
                    tot_spikes(j) = sum(n);
                    n=n./tot_spikes(j);
                    violating(j)=n(1) + n(2);
                    figure(j + 200);
                    subplot(2,1,1);
                    bar(edges,n,cols_pc(j+1,2));
                    xlabel('Time (ms)');
                    xlim([edges(1)-100 edges(end)]);
                    unit = sprintf('Unit %d, ISI distribution\n', j);
                    title(unit);
                    set(gca,'FontName','Arial','Fontsize',11, 'FontWeight', 'normal','Box','off','TickDir','out')
                   
                    
                    %Spiking Auto-correlogram
                    cross_fire=zeros(1,max_t+1);
                    for ks=1:length(ts_)
                        app1=ts_-ts_(ks);
                        app1=app1(app1<=max_t);
                        app1=app1(app1>0);
                        app1=app1+1;
                        if ~isempty(app1)
                            cross_fire(round(app1))=cross_fire(round(app1))+1;
                        end
                    end
                    cross_fire=cross_fire/length(ts_);
                    subplot(2,1,2);
                    bar(edges,cross_fire,cols_pc(j+1,2));
                    xlabel('Time (ms)');
                    xlim([edges(1)-100 edges(end)]);
                    unit = sprintf('Unit %d, Autocorrelogram', j);
                    title(unit);
                    set(gca,'FontName','Arial','Fontsize',11, 'FontWeight', 'normal','Box','off','TickDir','out')
                end
               
            end
            
            stringa = sprintf('BIC: %d', BIC);
            stringa='False negative+positive indexes | L-ratio | Isolation Distance | Spikes in violation zone:';
            for j=1:length(cont)
                stringa=sprintf('%s\n Cluster %d: %d | %d | %d | %d/%d',stringa,j,cont(j), L_ratio(j), IsDis(j), violating(j), tot_spikes(j));
            end
            stringa=sprintf('%s\n Insert clusters to be kept (between []):\n',stringa);
            options.Resize='on';
            options.WindowStyle='normal';
            clustersToKeep2{k}=str2num(cell2mat(inputdlg(stringa,'Cluster selection',1,{'[]'},options)));
            close all;
        end
        
        clusters_new=zeros(size(clusters));
        index=0;
        for k=clustersToKeep{i}
            app=find(clusters==k);
            for j=clustersToKeep2{k}
                index=index+1;
                app1=find(clusters2{k}==j);
                clusters_new(app(app1))=index;
            end
        end
        clusters=clusters_new;
        clustersToKeep{i}=1:index;
        
    end
    
    tetrodes_clusters{i}=clusters;
    if fsmem_alg
        clusters_indexes(i).BIC=BIC;
        clusters_indexes(i).cont=cont;
    else
        cluster_indexes=[];
    end
    
    %Save data
    stringa=sprintf('save %s -append tetrodes_clusters cluster_indexes clustersToKeep pc',filename_tetrode);
    eval(stringa);
end