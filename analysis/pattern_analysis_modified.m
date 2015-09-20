% modified for 2PT



toFolder = pwd;
new_dir = 'Classification_buttami2';
toFolder = fullfile(toFolder, new_dir);
mkdir(toFolder)
filename = sprintf('val_analysis_classification-plcoa.mat');
fileSave = fullfile(toFolder, filename);


%parameters;



ind = [1 2 3 5 6 7 8 9 10];

% folder = List{1};
% cd(folder);
% load('units.mat');
% pop_activity = populatioPatternTrials;
    unit = 1;
for ii = 1 : length(List)
    folder = List{ii};
    cd(folder)
%     cartella = List{ii};
%     folder1 = cartella(end-11:end-6)
%     folder2 = cartella(end-4:end)
%     cartella = [];
%     cartella = sprintf('/Volumes/Neurobio/DattaLab/Giuliano/tetrodes_data/15 odors/plCoA/awake/%s/%s', folder1, folder2);
%     cd(cartella)
    load('units.mat');
    load('parameters.mat');
    clear populationPattern populatioPatternTrials

    for sha=1:4
        for s=1:length(shank(sha).spike_matrix)
            for k=1:9 %odors
                r = ind(k);
                spike_matrix_app = shank(sha).spike_matrix{s}(:,:,r);
                bsl_mean(unit,k) = mean(sum(spike_matrix_app(:,1:pre_bsl*1000),2));
                %if bsl_mean/bin_size < 3
                bsl_var(unit,k) = var(sum(spike_matrix_app(:,1:pre_bsl*1000),2));
                rsp_mean(unit,k) = mean(sum(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000),2));
                rsp_var(unit,k) = var(sum(spike_matrix_app(:,pre*1000:pre*1000+response_window*1000),2));
                d_prime(unit, k) =  (rsp_mean(unit,k) - bsl_mean(unit,k))./sqrt(0.5*(rsp_var(unit,k)+bsl_var(unit,k)));
                d_prime(isnan(d_prime)) = 0;
                position(unit) = sha;
                app_psth = shank(sha).psth{s}(:,:,k);
                app_base = mean(app_psth(1:pre/bin_size,:));
                app_base1 = app_psth(1:pre/bin_size,:);
                app_response = app_psth(pre/bin_size+1:pre/bin_size+1+response_window/bin_size,:);
                app_delta_response = app_response - repmat(app_base, size(app_response,1),1);
                for whichBin = 1: response_window./bin_size %pre/bin_size;
                    populationPatternTrial{whichBin}(unit,:,k) = app_response(whichBin,:);%app_response(whichBin,:)app_base1(whichBin,:);%app_delta_response(whichBin,:); %;%app_psth(whichBin,:)
                end
                %end
            end
            unit = unit + 1;
        end
    end
end


%Get the response over the full response window
pop_activity_full = [];
pop_activity_full = populationPatternTrial{1};
for whichBin = 2:length(populationPatternTrial)
    pop_activity_full = pop_activity_full + populationPatternTrial{whichBin};
end



%Select the first 100 best units based on their aggregate discriminant skills

%best = 50;
app = [];
col1=[];
col2=[];
tuning = squeeze(mean(pop_activity_full,2));
app = tuning;
%app(app<0) = 0;
app(isnan(app)) = 0;
ls = lifetime_sparseness(app, size(app,1), size(app,2));
ls(isnan(ls)) = 0;
app = [];
col1 = 1:size(d_prime,1);
app1 = d_prime;
%app1(abs(app1)<1)  = 0;
%app1(app1 < 0) = 0;
col2 = sum(abs(app1),2);
%col2 = ls'; 
%col2 = col2 .* ls';
% col2 = sum(abs(d_prime),2);
app = [col1' col2];
dprime_rank = sortrows(app,2);
dprime_rank = flipud(dprime_rank);
best_populationPatternTrial{whichBin} = [];
for whichBin = 1:length(populationPatternTrial)
    best_populationPatternTrial{whichBin} = populationPatternTrial{whichBin}(dprime_rank(1:best,1),:,:);
end
best_pop_activity_full = [];
best_pop_activity_full = best_populationPatternTrial{1};
for whichBin = 2:length(best_populationPatternTrial)
    best_pop_activity_full = best_pop_activity_full + best_populationPatternTrial{whichBin};
end

best_tuning = [];
best_tuning = squeeze(mean(best_pop_activity_full,2));%d_prime(dprime_rank(1:best,1), :); %
h=figure('Name','Tuning functions - best', 'NumberTitle','off');
imagesc(best_tuning)
colormap(b2r(min(best_tuning(:)), max(best_tuning(:))))
set(findobj(gcf, 'type','axes'), 'Visible','off')
ylabel('Units')
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('Tuning functions - dprime - best.eps');
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


save(fileSave, 'pop_activity_full', 'populationPatternTrial', 'best_pop_activity_full', 'best_populationPatternTrial', 'ls', 'd_prime', 'dprime_rank', 'bsl_mean', 'bsl_var', 'rsp_mean', 'rsp_var', 'best_tuning')


%% single odors classification, full response window

classes = 'single odors, full response';
dataAll = best_pop_activity_full;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
% rescale to [0 1];
dataAll = (dataAll - repmat(min(dataAll,[],1),size(dataAll,1),1))*spdiags(1./(max(dataAll,[],1)-min(dataAll,[],1))',0,size(dataAll,2),size(dataAll,2));
dataAll = dataAll';
dataAll = reshape(dataAll, neurons, trials, stimuli);

% Make labels

labels      = ones(1,size(dataAll,2));
app_labels  = labels;
for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end
% labels = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2];
labels      = labels';

repetitions = 200;
trainingNumber = floor(0.8*(trials * stimuli));

%[mean_acc_svm, std_acc_svm, acc_svm] = odor_c_svm(dataAll, trainingNumber, labels, repetitions, classes, toFolder);
[mean_acc_svm, std_acc_svm, acc_svm] = odor_c_svm(dataAll, trainingNumber, labels, repetitions, classes, toFolder);
    
h = figure;
x = 2 : length(mean_acc_svm) + 1;
shadedErrorBar(x, mean_acc_svm, std_acc_svm, 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('c_svm linear discrimination -%s .eps', classes);
saveas(h,fullfile(toFolder,stringa_fig),'epsc')

save(fileSave, 'mean_acc_svm', 'std_acc_svm', 'acc_svm', '-append')

%% single odors classification, for every bin
for whichBin = 1:response_window/bin_size;
    classes = 'single odors, single bins';
    dataAll = best_populationPatternTrial{whichBin};
    neurons = size(dataAll,1);
    trials = size(dataAll,2);
    stimuli = size(dataAll,3);
    dataAll = reshape(dataAll, neurons, trials .* stimuli);
    dataAll = dataAll';
    % rescale to [0 1];
    dataAll = (dataAll - repmat(min(dataAll,[],1),size(dataAll,1),1))*spdiags(1./(max(dataAll,[],1)-min(dataAll,[],1))',0,size(dataAll,2),size(dataAll,2));
    dataAll = dataAll';
    dataAll = reshape(dataAll, neurons, trials, stimuli);
    
    % Make labels
    labels      = ones(1,size(dataAll,2));
    app_labels  = labels;
    for odor = 1:size(dataAll,3) - 1
        labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    end
    labels      = labels';
    
    repetitions = 200;
    trainingNumber = floor(0.8*(trials * stimuli));
    [mean_acc_svm_b, std_acc_svm_b, acc_svm_b] = odor_c_svm(dataAll, trainingNumber, labels, repetitions, classes, toFolder);
    meanAccuracy_svm(whichBin) = mean_acc_svm_b(end);
    sdAccuracy_svm(whichBin) = std_acc_svm_b(end);
end

h=figure('Name','Linear classification of odors - bins', 'NumberTitle','off');
shadedErrorBar(1:floor(response_window/bin_size), meanAccuracy_svm, sdAccuracy_svm, 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('c_svm linear discrimination -%s .eps', classes);
saveas(h,fullfile(toFolder,stringa_fig),'epsc')
save(fileSave, 'repetitions', 'meanAccuracy_svm', 'sdAccuracy_svm', '-append')
clear dataAll labels


%% single odors classification, trajectories 
classes = 'all-trajectories';

dataAllT = best_populationPatternTrial{1};
n_neurons = size(dataAllT,1);
for whichBin = 2:response_window./bin_size;
    dataAllT = [dataAllT; best_populationPatternTrial{whichBin}];
end
neurons = size(dataAllT,1);
trials = size(dataAllT,2);
stimuli = size(dataAllT,3);
dataAllT = reshape(dataAllT, neurons, trials .* stimuli);
dataAllT = dataAllT';
% rescale to [0 1];
dataAllT = (dataAllT - repmat(min(dataAllT,[],1),size(dataAllT,1),1))*spdiags(1./(max(dataAllT,[],1)-min(dataAllT,[],1))',0,size(dataAllT,2),size(dataAllT,2));
dataAllT = dataAllT';
dataAllT = reshape(dataAllT, neurons, trials, stimuli);

labels      = ones(1,size(dataAllT,2));
app_labels  = labels;
for odor = 1:size(dataAllT,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAllT,2))];
end
%labels = repmat(labels, 1, response_window./bin_size);
labels      = labels';

repetitions = 200;
trainingNumber = floor(0.8*(trials * stimuli));
[mean_acc_svmT, std_acc_svmT] = odor_c_svm_traj(dataAllT, n_neurons, trainingNumber, labels, repetitions, classes, toFolder);
meanAccuracy_svmT = mean_acc_svmT;
sdAccuracy_svmT = std_acc_svmT;

h = figure;
x = 2 : length(mean_acc_svmT) + 1;
shadedErrorBar(x, mean_acc_svmT, std_acc_svmT, 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('c_svm linear discrimination -%s .eps', classes);
saveas(h,fullfile(toFolder,stringa_fig),'epsc')


save(fileSave, 'repetitions', 'meanAccuracy_svmT', 'sdAccuracy_svmT', '-append')
clear dataAllT labels