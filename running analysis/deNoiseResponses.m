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

popActivitySpCoMean = [];
popActivitySpCoMean = squeeze(mean(popActivitySpCo,2));
[coeff, score, latent,~,explained] = pca(zscore(popActivitySpCoMean'));
labels = {'TMT', 'MMT', 'IBA', 'IAA', 'EDN', 'BDN'};
%labels = {'TMT3', 'DMT3', 'MMT3', 'IBA3', 'IAA3', 'EDN3', 'BDN3',...
    %'TMT1', 'DMT1', 'MMT1', 'IBA1', 'IAA1', 'EDN1', 'BDN1',};
%%
Xfig = 400;
Yfig = 900;
figure;
p = panel();
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')

c = [102,194,165; 102,194,165;...
252,141,98; 252,141,98;...
141,160,203;141,160,203]/255;



p.pack('v',{1/3 1/3 1/3})
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
p.margin = [5 10 5 4];
p.select('all')




%%
A = popActivitySpCoMean';
[n,m] = size(A);
AMean = mean(A);
AStd = std(A);
B = (A - repmat(AMean,[n 1])) ./ repmat(AStd, [n, 1]);
Bnans = sum(B);
B(:,isnan(Bnans)) = [];
cellOdorLog(isnan(Bnans),:) = [];

[V, D] = eig(cov(B));
VDenoise = V;
VDenoise(:,1:size(VDenoise,1)-3) = 0;

VDenoise = VDenoise * VDenoise';

BDenoised = B * VDenoise;
BDenoised = BDenoised';


for idxTrial =1:n_trials
    app = [];
    app = squeeze(popActivitySpCo(:,idxTrial,:));
    app = app';
    app(:,isnan(Bnans)) = [];
    app = zscore(app);
    app = app * VDenoise;
    app = app';
    popActivitySpCo1(:,idxTrial,:) = app;
end

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

data        = reshape(data, size(data,1), size(data,2) .* size(data,3));
data        = data';
numInst     = size(data,1);
numTrain    = trainingN; 
numTest     = numInst - numTrain;
numLabels   = max(labels);

shankSort = cellOdorLog(:,2);
appData = data';
appData = [appData shankSort];
appData = sortrows(appData, size(appData,2));
appData(:,size(appData,2)) = [];

figure;
imagesc(appData); colormap(brewermap([],'*RdBu')); axis tight
Xfig = 600;
Yfig = 900;
set(gcf, 'Position',[1,5,Xfig,Yfig]);
set(gcf,'Color','w')
set(gca,'FontName','Arial','Fontsize',14,'FontWeight','normal','TickDir','out','Box','off');
xlabel('trials'); ylabel('units');