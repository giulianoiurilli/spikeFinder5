%%
% combinations = combnk(1:7, 3);
% lista = [0 0 0 0 0 0];
% for j = 1:size(combinations,1)
%     source = combinations(j,:);
%     app = combinations;
%     app(j,:) = [];
%     for k = 1:size(app,1)
%         target = app(k,:);
%         confronto = intersect(source, target);
%         if isempty(confronto)
%             new  = [source target];
%             bene = nan * ones(size(lista,1),1);
%             for l = 1:size(lista,1)
%                 target2 = lista(l,[4,5,6,1,2,3]);
%                 confronto = isequal(new, target2);
%                 if confronto == 0
%                     bene(l) = 0;
%                 else
%                     bene(l) = 1;
%                 end
%             end
%             if sum(bene) == 0
%                 lista = [lista; new];
%             end
%         end
%     end
% end
% lista(1,:) = [];
%%
% aaCoa = nan*ones(size(lista,1),1);
% aaPcx = nan*ones(size(lista,1),1);
% for idxRep = 1:size(lista,1)
%     idxOd = lista(idxRep,:);
%     odorsRearranged = [4 6 7 9 10 11 14];
%     accuracyResponsesPcxMixaa = l_svmClassify(pcxMix.esp, odorsRearranged(idxOd),4);
%     aaPcx(idxRep) = mean(accuracyResponsesPcxMixaa);
% end

%% Trova i due gruppi massimmamente discriminabili
% aurocCatPcx = nan*ones(size(lista,1),1);
% for idxRep = 1:size(lista,1)
%     idxOd = lista(idxRep,:);
%     odorsRearranged = [4 6 7 9 10 11 14];
%     app = auROCcategorization(pcxMix.esp, odorsRearranged(idxOd), 3);
%     app = abs(app - 0.5) *2;
%     aurocCatPcx(idxRep) = mean(app);
% end
%% Dei 2 gruppi tovati trova i due odori massimamente discriminabili (un odore per gruppo)
% [~, idxMaxPcx] = max(aurocCatPcx);
% odorsRearranged = odorsRearranged(lista(idxMaxPcx,:));
% listaNeiGruppi = [1 4; 1 5; 1 6; 2 4; 2 5; 2 6; 3 4; 3 5; 3 6];
% aurocCatNeiGruppiPcx = nan*ones(size(listaNeiGruppi,1),1);
% for idxRep = 1:size(listaNeiGruppi,1)
%     idxOd = listaNeiGruppi(idxRep,:);
%     app = auROCcategorization(pcxMix.esp, odorsRearranged(idxOd), 1);
%     app = abs(app - 0.5) *2;
%     aurocCatNeiGruppiPcx(idxRep) = mean(app);
% end
% [~, idxMaxNeiGruppiPcx] = max(aurocCatNeiGruppiPcx);


%%
% odorsRearranged = [1 3 6 7 9 13 15];
% combinations = combnk(1:7, 2);
% aurocCatNeiGruppiCoa = nan*ones(size(combinations,1),1);
% for idxRep = 1:size(combinations,1)
%     idxOd = combinations(idxRep,:);
%     app = auROCcategorization(coaMix.esp, odorsRearranged([idxOd]), 1);
%     app = abs(app - 0.5) *2;
%     aurocCatNeiGruppiCoa(idxRep) = mean(app);
% end
% [maxNeiGruppiCoa, idxMaxNeiGruppiCoa] = max(aurocCatNeiGruppiCoa);

%%
% odorsRearranged = [1 4 7 2 5 6 ];
% accuracyResponsesPcxMixaa = l_svmClassify(pcxMix.esp, odorsRearranged,4);
% mean(accuracyResponsesPcxMixaa)

%% auROC
odorsRearrangedCoa = [7 6 13 15 3 9];
% odorsRearrangedPcx = [7 1 9 3 13 15];
 odorsRearrangedPcx = [4 6 7 9 10 11]; %pcx Mix
% odorsRearrangedCoa = 1:6;
% odorsRearrangedPcx = 1:6;
[app app1] = auROCcategorization(coaMix.esp, odorsRearrangedCoa([1 4]), 1);
app1(:,app1==0) = [];
app = abs(app - 0.5) *2;
aurocSingleCoa = app;
[app app1] = auROCcategorization(pcxMix.esp, odorsRearrangedPcx([1 4]), 1);
app1(:,app1==0) = [];
aurocSinglePcx = app;
[app app1] = auROCcategorization(coaMix.esp, odorsRearrangedCoa, 3);
app1(:,app1==0) = [];
app = abs(app - 0.5) *2;
aurocMixCoa = app;
[app app1] = auROCcategorization(pcxMix.esp, odorsRearrangedPcx, 3);
app1(:,app1==0) = [];
app = abs(app - 0.5) *2;
aurocMixPcx = app;

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
dataToPlot = {aurocSingleCoa(:,1), aurocSinglePcx(:,1), aurocMixCoa(:,1), aurocMixPcx(:,1)};
catIdx = [zeros(size(aurocSingleCoa,1),1); ones(size(aurocSinglePcx,1),1); 2*ones(size(aurocMixCoa,1),1); 3*ones(size(aurocMixPcx,1), 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)
title('auROC Discrimination Between Mix')
%% l-SVM

accuracyResponsesSingleCoa = l_svmClassify(coaMix.esp, odorsRearrangedCoa([1 4]),1); 
accuracyResponsesSinglePcx = l_svmClassify(pcxMix.esp, odorsRearrangedPcx([1 4]),1);
accuracyResponsesMixCoa = l_svmClassify(coaMix.esp, odorsRearrangedCoa,4); 
accuracyResponsesMixPcx = l_svmClassify(pcxMix.esp, odorsRearrangedPcx,4); 
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
dataToPlot = {accuracyResponsesSingleCoa, accuracyResponsesSinglePcx, accuracyResponsesMixCoa, accuracyResponsesMixPcx};
catIdx = [zeros(size(accuracyResponsesSingleCoa,1),1); ones(size(accuracyResponsesSinglePcx,1),1); 2*ones(size(accuracyResponsesMixCoa,1),1); 3*ones(size(accuracyResponsesMixPcx,1), 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)
title('Linear Discrimination Between Mix')

accuracyResponsesCoa = l_svmClassify(coaMix.esp, odorsRearrangedCoa,1); 
accuracyResponsesPcx = l_svmClassify(pcxMix.esp, odorsRearrangedPcx,1); 
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
dataToPlot = {accuracyResponsesCoa, accuracyResponsesPcx};
catIdx = [zeros(size(accuracyResponsesCoa,1),1); ones(size(accuracyResponsesPcx,1),1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)
title('One vs All Odor Linear Discrimination');

%% Plot coding space
odors = length(odorsRearrangedCoa);

responseCell1MeanCoa = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(coaMix.esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(coaMix.esp(idxesp).shankNowarp(idxShank).cell)
            if coaMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearrangedCoa
                    idxO = idxO + 1;
                    app = [];
                    app = double(coaMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                    coaMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1MeanCoa(idxCell1, idxO) = mean(app);
                    responseCellauRocCoa(idxCell1, idxO) = coaMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = double(coaMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    baselineCell1All(idxCell1,:,idxO) = app2;
                end
            end
        end
    end
end

dataAll = [];

dataAll = responseCell1MeanCoa;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;

distancesCoa = pdist(responseCell1MeanCoa', 'euclidean');
YCoa = cmdscale(distancesCoa);
% figure; plot(YCoa(:,1), YCoa(:,2), 'ok', 'Linewidth', 2);
% figure; plot3(YCoa(:,1), YCoa(:,2), YCoa(:,3), 'ok', 'Linewidth', 2);


odors = length(odorsRearrangedPcx);

responseCell1MeanPcx = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(pcxMix.esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(pcxMix.esp(idxesp).shankNowarp(idxShank).cell)
            if pcxMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearrangedPcx
                    idxO = idxO + 1;
                    app = [];
                    app = double(pcxMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                    pcxMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1MeanPcx(idxCell1, idxO) = mean(app);
                    responseCellauRocPcx(idxCell1, idxO) = pcxMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = double(pcxMix.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    baselineCell1All(idxCell1,:,idxO) = app2;
                end
            end
        end
    end
end

dataAll = [];

dataAll = responseCell1MeanPcx;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;

distancesPcx = pdist(responseCell1MeanPcx', 'euclidean');
YPcx = cmdscale(distancesPcx);
figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
plot3(YCoa(:,1), YCoa(:,2), YCoa(:,3),'or', 'Linewidth', 2);
hold on; plot3(YPcx(:,1), YPcx(:,2), YPcx(:,3),'ok', 'Linewidth', 2);
title('Coding Space')

%% Tuning curves
APcx = responseCellauRocPcx(:,[1 2 3 6 5 4]);
APcx = (APcx - repmat(min(APcx,[],2), 1, size(APcx,2))) ./ (repmat(max(APcx,[],2), 1, size(APcx,2)) - repmat(min(APcx,[],2), 1, size(APcx,2)));
APcx = [sum(APcx(:,1:3),2) sum(APcx(:,4:6),2)];
TPcx1 = APcx(:,1);
% XPcx1 = pdist(APcx, 'euclidean');
% ZPcx1 = linkage(XPcx1);
% [H, TPcx1, outperm] = dendrogram(ZPcx1);
app = [];
app = [responseCellauRocPcx(:,[1 2 3 6 5 4]) TPcx1];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesPcx1 = app;

% XPcx2 = pdist(responseCellauRocPcx(:,[6 5 4]), 'euclidean');
% ZPcx2 = linkage(XPcx2);
% [H, TPcx2, outperm] = dendrogram(ZPcx2);
% app = [];
% app = [responseCellauRocPcx(:,[6 5 4]) TPcx2];
% app = sortrows(app, size(app,2));
% app(:,size(app,2)) = [];
% tuningCurvesPcx2 = app;

ACoa = responseCellauRocCoa(:,[1 2 3 6 5 4]);
ACoa = (ACoa - repmat(min(ACoa,[],2), 1, size(ACoa,2))) ./ (repmat(max(ACoa,[],2), 1, size(ACoa,2)) - repmat(min(ACoa,[],2), 1, size(ACoa,2)));
ACoa = [sum(ACoa(:,1:3),2) sum(ACoa(:,4:6),2)];
TCoa1 = ACoa(:,1);
% XCoa1 = pdist(ACoa, 'euclidean');
% ZCoa1 = linkage(XCoa1);
% [H, TCoa1, outperm] = dendrogram(ZCoa1);
app = [];
app = [responseCellauRocCoa(:,[1 2 3 6 5 4]) TCoa1];
app = sortrows(app, size(app,2));
app(:,size(app,2)) = [];
tuningCurvesCoa1 = app;

figure;
set(gcf,'color','white', 'PaperPositionMode', 'auto');
subplot(1,2,1)
imagesc(tuningCurvesCoa1); colormap(brewermap([],'*RdBu')); axis tight
subplot(1,2,2)
imagesc(tuningCurvesPcx1); colormap(brewermap([],'*RdBu')); axis tight





            
        
        
    