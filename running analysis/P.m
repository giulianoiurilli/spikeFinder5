%odorToUse = 1:14;
%odorToUse = [7 9 10 11 12 13];
%odorToUse = [7 8 10 11 12 13];
%odorToUse = [7 8 9 11 12 13];
odorToUse = [8 10 11 12 13 7];

idxNeuron = 1;
for idxExp = 1:length(List)
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
            aur = [];
            responsesSpiCo = [];
            responsesTiCo = [];
            indicatore = [];
            idxOdorLoop = 1;
            for idxOdor = odorToUse
                aur(idxOdorLoop) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax(1);
                rspOn(idxOdorLoop) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1);
                responsesSpiCo(:,idxOdorLoop) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleAnalogicResponsePerCycleAllTrials(:,1);
                responsesSpiCo(:,idxOdorLoop) = responsesSpiCo(:,idxOdorLoop) - exp(idxExp).shank(idxShank).cell(idxUnit).bslSpikeRate(1);
                responsesTiCo(:,:,idxOdorLoop) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth(:,4*cycleLengthDeg:5*cycleLengthDeg);
                idxOdorLoop = idxOdorLoop + 1;
            end
            indicatore = find(aur>=0.5);
            %indicatore = find(rspOn > 0);
            if ~isempty(indicatore) %...zscore
                
                popActivitySpCoNoZ(idxNeuron,:,:) = responsesSpiCo;
                [dim1, dim2] = size(responsesSpiCo);
                responsesSpiCo = responsesSpiCo(:); responsesSpiCo = zscore(responsesSpiCo); responsesSpiCo = reshape(responsesSpiCo, dim1, dim2);
                [dim1, dim2, dim3] = size(responsesTiCo);
                responsesTiCo = responsesTiCo(:); responsesTiCo = zscore(responsesTiCo); responsesTiCo = reshape(responsesTiCo, dim1, dim2, dim3);
                popActivitySpCo(idxNeuron,:,:) = responsesSpiCo;
                popActivityTiCo{idxNeuron} = responsesTiCo;
                cellOdorLog(idxNeuron,:) = [idxExp, idxShank, idxUnit];
                idxNeuron = idxNeuron + 1;
            end
        end
    end
end

%% PCA score
allResponses = [];
for idxNeuron = 1:length(popActivityTiCo)
    for idxOdor = 1:size(popActivityTiCo{1},3)
        allResponses = [allResponses; popActivityTiCo{idxNeuron}(:,:,idxOdor)];
    end
end
[coeff, score, latent,~,explained] = pca(zscore(allResponses));



%% prepare for classification
popActivityScore = zeros(length(popActivityTiCo), n_trials, length(odorToUse));
for idxNeuron = 1:length(popActivityTiCo)
    for idxOdor = 1:length(odorToUse)
        appResp = [];
        appRespDenoised = [];
        appResp = popActivityTiCo{idxNeuron}(:,:,idxOdor);
        appResp = squeeze(appResp);
        appRespDenoised = appResp * coeff(:,1);
        appRespDenoised = appRespDenoised';
        popActivityScore(idxNeuron,:,idxOdor) = appRespDenoised;
    end
end

% popActivityScoreTraj = zeros(length(popActivityTiCo)*10, n_trials, length(odorToUse));
% for idxNeuron = 1:length(popActivityTiCo)
%     for idxOdor = 1:length(odorToUse)
%         appResp = [];
%         appRespDenoised = [];
%         appResp = popActivityTiCo{idxNeuron}(:,:,idxOdor);
%         appResp = squeeze(appResp);
%         appRespDenoised = appResp * coeff(:,1:10);
%         appRespDenoised = appRespDenoised';
%         popActivityScore(idxNeuron,:,idxOdor) = appRespDenoised;
%     end
% end


%% single odors classification, full response window

classes = 'single odors, full response';
dataAll = popActivitySpCo1;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
% app = sum(dataAll); n_Zeros = numel(find(app == 0));
% neurons = neurons - n_Zeros;
% dataAll(:,app==0) = [];

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

repetitions = 1000;
trainingN = floor(0.8*(trials * stimuli));
data = dataAll;


[mean_acc_svm, std_acc_svm, acc_svm] = odor_c_svm(dataAll, trainingN, labels, repetitions);
    
h = figure;
x = 2 : length(mean_acc_svm) + 1;
shadedErrorBar(x, mean_acc_svm, std_acc_svm./sqrt(repetitions), 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('c_svm linear discrimination -%s .eps', classes);
%saveas(h,fullfile(toFolder,stringa_fig),'epsc')

%save(fileSave, 'mean_acc_svm', 'std_acc_svm', 'acc_svm', '-append')

dataAll = popActivitySpCoNew;
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

repetitions = 1000;
trainingNumber = floor(0.8*(trials * stimuli));


[mean_acc_svmNew, std_acc_svmNew, acc_svmNew] = odor_c_svm(dataAll, trainingNumber, labels, repetitions);
    
h = figure;
x = 2 : length(mean_acc_svmNew) + 1;
shadedErrorBar(x, mean_acc_svmNew, std_acc_svmNew./sqrt(repetitions), 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');
stringa_fig=sprintf('c_svm linear discrimination -%s new .eps', classes); 

save('classifier_results.mat', 'acc_svm', 'acc_svmNew')


%%

% Xapp = popActivitySpCo;
% Xapp(:,:,7) = popActivitySpCo(:,:,1);
% Xapp(:,:,1) = [];
% popActivitySpCo = Xapp;

popActivitySpCoMean = [];
% for i = 1:6
%    popActivitySpCoMean = [popActivitySpCoMean;popActivitySpCo(:,:,i)];
% end
popActivitySpCoMean = squeeze(mean(popActivitySpCo,2));
figure; imagesc(popActivitySpCoMean); colormap(brewermap([],'*RdBu')); axis tight
[coeff, score, latent,~,explained] = pca(zscore(popActivitySpCoMean'));
cumsum(explained)
%labels = {'TMT', 'DMT', 'MMT', 'IBA', 'IAA', 'EDN', 'BDN', 'ROS'};
%labels = {'TMT', 'DMT', 'MMT', 'IBA', 'IAA', 'EDN', 'BDN'};
labels = {'TMT', 'MMT', 'IBA', 'IAA', 'EDN', 'BDN'};
%labels = {'TMT3', 'DMT3', 'MMT3', 'IBA3', 'IAA3', 'EDN3', 'BDN3',...
    %'TMT1', 'DMT1', 'MMT1', 'IBA1', 'IAA1', 'EDN1', 'BDN1',};
%%
Xfig = 600;
Yfig = 900;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')

c = [102,194,165; 102,194,165;...
252,141,98; 252,141,98;...
141,160,203;141,160,203]/255;



p.pack('h',{1/3 1/3 1/3})
p(1).select()
scatter(score(:,1), score(:,2), 50, c, 'filled'); xlim([-12 12]); ylim([-12 12]); axis square
xlabel('PC1'); ylabel('PC2')
h= labelpoints(score(:,1), score(:,2),labels,'NE',0.2); 
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p(2).select()
scatter(score(:,2), score(:,3), 50, c, 'filled'); xlim([-12 12]); ylim([-12 12]); axis square
xlabel('PC2'); ylabel('PC3')
h= labelpoints(score(:,2), score(:,3),labels,'NE',0.2); 
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p(3).select()
scatter(score(:,1), score(:,3), 50, c, 'filled'); xlim([-12 12]); ylim([-12 12]); axis square
xlabel('PC1'); ylabel('PC3')
h= labelpoints(score(:,1), score(:,3),labels,'NE',0.2); 
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
p.de.margin = 10;
p.margin = [20 4 4 4];
p.select('all')
%%

XApp = [];
Xapp = popActivitySpCoNoZ;
Xapp(:,:,7) = popActivitySpCoNoZ(:,:,1);stepSize = 10;
bestLog2c = 1;
bestLog2g = -1;
epsilon = 0.005;
bestcv = 0;
Ncv = 3; % Ncv-fold cross validation cross validation
deltacv = 10^6;

while abs(deltacv) > epsilon
    bestcv_prev = bestcv;
    prevStepSize = stepSize;
    stepSize = prevStepSize/2;
    log2c_list = bestLog2c-prevStepSize:stepSize/2:bestLog2c+prevStepSize;
    log2g_list = bestLog2g-prevStepSize:stepSize/2:bestLog2g+prevStepSize;
    
    numLog2c = length(log2c_list);
    numLog2g = length(log2g_list);
    cvMatrix = zeros(numLog2c,numLog2g);
    
    for i = 1:numLog2c
        log2c = log2c_list(i);
        for j = 1:numLog2g
            log2g = log2g_list(j);
            cmd = ['-q -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
            cv = get_cv_ac(trainLabel, trainData, cmd, Ncv);
            if (cv >= bestcv),
                bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
            end
        end
    end
    deltacv = bestcv - bestcv_prev;
    
end
disp(['The best parameters, yielding Accuracy=',num2str(bestcv*100),'%, are: C=',num2str(bestc),', gamma=',num2str(bestg)]);stepSize = 10;
bestLog2c = 1;
bestLog2g = -1;
epsilon = 0.005;
bestcv = 0;
Ncv = 3; % Ncv-fold cross validation cross validation
deltacv = 10^6;

while abs(deltacv) > epsilon
    bestcv_prev = bestcv;
    prevStepSize = stepSize;
    stepSize = prevStepSize/2;
    log2c_list = bestLog2c-prevStepSize:stepSize/2:bestLog2c+prevStepSize;
    log2g_list = bestLog2g-prevStepSize:stepSize/2:bestLog2g+prevStepSize;
    
    numLog2c = length(log2c_list);
    numLog2g = length(log2g_list);
    cvMatrix = zeros(numLog2c,numLog2g);
    
    for i = 1:numLog2c
        log2c = log2c_list(i);
        for j = 1:numLog2g
            log2g = log2g_list(j);
            cmd = ['-q -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
            cv = get_cv_ac(trainLabel, trainData, cmd, Ncv);
            if (cv >= bestcv),
                bestcv = cv; bestc = 2^log2c; bestg = 2^log2g;
            end
        end
    end
    deltacv = bestcv - bestcv_prev;
    
end
disp(['The best parameters, yielding Accuracy=',num2str(bestcv*100),'%, are: C=',num2str(bestc),', gamma=',num2str(bestg)]);
Xapp(:,:,1) = [];
popActivitySpCoNoZ = Xapp;
% 
popActivitySpCoNoZMean = squeeze(mean(popActivitySpCoNoZ,2));
figure; imagesc(popActivitySpCoNoZMean); colormap(brewermap([],'*RdBu')); axis tight
[coeff, score, latent,~,explained] = pca(zscore(popActivitySpCoNoZMean'));
cumsum(explained)
%labels = {'TMT', 'DMT', 'MMT', 'IBA', 'IAA', 'EDN', 'BDN', 'ROS'};
%labels = {'TMT', 'DMT', 'MMT', 'IBA', 'IAA', 'EDN', 'BDN'};
labels = {'DMT', 'MMT', 'IBA', 'IAA', 'EDN', 'BDN'};
figure; scatter(score(:,1), score(:,2), 'filled'); axis square; 
h= labelpoints(score(:,1), score(:,2),labels,'NE',0.2); 

%%






% 
% XApp = [];
% XApp = popActivitySpCo;
% 
% for idxUnit = 1:size(popActivitySpCoNoZ,1)
%     R = [];
%     R = popActivitySpCoNoZ(idxUnit,:,:);
%     R = binr(R, n_trials, 6, 'eqspace');
%     opts.nt = repmat(n_trials, 1, size(R,3));
%     opts.method = 'dr';
%     opts.bias = 'pt';
%     I6(idxUnit) = information(R, opts, 'I');
% end
% 
% popActivitySpCo = reshape(popActivitySpCo,size(popActivitySpCo,1),size(popActivitySpCo,2)*size(popActivitySpCo,3));
% popActivitySpCo = [popActivitySpCo I6'];
% popActivitySpCo = sortrows(popActivitySpCo,size(popActivitySpCo,2));
% popActivitySpCo = flipud(popActivitySpCo);
% popActivitySpCo(:,size(popActivitySpCo,2)) = [];
% popActivitySpCo = reshape(popActivitySpCo,size(popActivitySpCo,1),n_trials,length(odorToUse));








% popActivitySpCo = XApp;

thiazoles = popActivitySpCo(:,:,1:2);
acetate = popActivitySpCo(:,:,3:4);
dione = popActivitySpCo(:,:,5:6);

thiazoles = reshape(thiazoles,size(popActivitySpCo,1),10,[]);
acetate = reshape(acetate,size(popActivitySpCo,1),10,[]);
dione = reshape(dione,size(popActivitySpCo,1),10,[]);

popActivitySpCoNew(:,:,1) = thiazoles;
popActivitySpCoNew(:,:,2) = acetate;
popActivitySpCoNew(:,:,3) = dione;



thiazolesnoz = popActivitySpCoNoZ(:,:,1:2);
acetatenoz = popActivitySpCoNoZ(:,:,3:4);
dionenoz = popActivitySpCoNoZ(:,:,5:6);

thiazolesnoz = reshape(thiazolesnoz,size(popActivitySpCoNoZ,1),10,[]);
acetatenoz = reshape(acetatenoz,size(popActivitySpCoNoZ,1),10,[]);
dionenoz = reshape(dionenoz,size(popActivitySpCoNoZ,1),10,[]);

popActivitySpCoNoZNew(:,:,1) = thiazolesnoz;
popActivitySpCoNoZNew(:,:,2) = acetatenoz;
popActivitySpCoNoZNew(:,:,3) = dionenoz;



% for idxUnit = 1:size(popActivitySpCoNoZ,1)
%     R = [];
%     R = popActivitySpCoNoZ(idxUnit,:,:);
%     R = binr(R, n_trials, 3, 'eqspace');
%     opts.nt = repmat(n_trials, 1, size(R,3));
%     opts.method = 'dr';
%     opts.bias = 'pt';
%     I3(idxUnit) = information(R, opts, 'I');
% end
% popActivitySpCoNew = reshape(popActivitySpCoNew,size(popActivitySpCoNew,1),size(popActivitySpCoNew,2)*size(popActivitySpCoNew,3));
% popActivitySpCoNew = [popActivitySpCoNew I3'];
% popActivitySpCoNew = sortrows(popActivitySpCoNew,size(popActivitySpCoNew,2));
% popActivitySpCoNew = flipud(popActivitySpCoNew);
% popActivitySpCoNew(:,size(popActivitySpCoNew,2)) = [];
% popActivitySpCoNew = reshape(popActivitySpCoNew,size(popActivitySpCoNew,1),n_trials,length(odorToUse));


%%
corrD = [];
distanceMatrix = [];
for i = 1:1000
    idxUnits = randsample(size(popActivitySpCoNoZ,1), 35);
    sample = popActivitySpCoNoZ(idxUnits,:,:);
    sampleMean = squeeze(mean(sample,2));
    corrD(i,:) = pdist(sampleMean', 'correlation');
    distanceMatrix(:,:,i) = squareform(corrD(i,:));
end

distanceMatrixMean = squeeze(mean(distanceMatrix,3));
    
    

                
                




