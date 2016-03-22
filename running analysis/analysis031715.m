odorsRearranged = 1:15;

responsiveUnit = 0;
cells = 0;
for idxExp = 1: length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                cells = cells + 1;
            end
        end
    end
end

%%
allAuroc = nan*ones(cells,15);
allRespMean = nan*ones(cells,15);
allRespGvar = nan*ones(cells,15);
allBslGvar = nan*ones(cells,15);
allRespVar = nan*ones(cells,15);
pValue = nan*ones(cells,15);
cellLog = nan(cells,3);
infoOdorID = nan(cells,5);
allResp = nan(cells,15,10);

idxCell = 0;
for idxExp = 1: length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell = idxCell + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    allAuroc(idxCell,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms;
                    allResp(idxCell,idxO,:) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                    allRespMean(idxCell,idxO) = mean(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                    allRespVar(idxCell,idxO) = var(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                    allRespGvar(idxCell,idxO) = partNeuralVariance(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
                    allBslGvar(idxCell,idxO) = partNeuralVariance(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    pValue(idxCell,idxO) = abs(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                end
                for idx = 1:5
                    infoOdorID(idxCell,idx) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).concentration(idx).I1sOdor;
                end
                cellLog(idxCell,:) = [idxExp, idxShank, idxUnit];
            end
        end
    end
end

allAuroc(pValue==0) = 0.5;


%%
figure
plot(mean(zscore(infoOdorID')'));
hold on
A = zscore(allRespMean')';
A = allRespMean;
A1 = A(:,[1 6 11]);
A2 = A(:,[1 6 11]+1);
A3 = A(:,[1 6 11]+2);
A4 = A(:,[1 6 11]+3);
A5 = A(:,[1 6 11]+4);
M = [nanmean(A1(:)) nanmean(A2(:)) nanmean(A3(:)) nanmean(A4(:)) nanmean(A5(:))];
plot(M)

B = zscore(allRespVar')';
B = allRespVar;
B1 = B(:,[1 6 11]);
B2 = B(:,[1 6 11]+1);
B3 = B(:,[1 6 11]+2);
B4 = B(:,[1 6 11]+3);
B5 = B(:,[1 6 11]+4);
V = [nanmean(B1(:)) nanmean(B2(:)) nanmean(B3(:)) nanmean(B4(:)) nanmean(B5(:))];
plot(V)

C = zscore(allRespGvar')';
C = allRespGvar;
C1 = C(:,[1 6 11]);
C2 = C(:,[1 6 11]+1);
C3 = C(:,[1 6 11]+2);
C4 = C(:,[1 6 11]+3);
C5 = C(:,[1 6 11]+4);
G = [nanmean(C1(:)) nanmean(C2(:)) nanmean(C3(:)) nanmean(C4(:)) nanmean(C5(:))];
plot(G)
%%
clc
colors = [254,224,210;...
222,45,38]./255;
symbols = {'o', 's', '*'};
figure
hold on
clear X Y
c = 12
X(1,:) = A1(c,:);
X(2,:) = A5(c,:);
Y(1,:) = B1(c,:);
Y(2,:) = B5(c,:);
for k = 1:2
    for j = 1:3
    plot(X(k,j), Y(k,j), symbols{j}, 'MarkerSize', 8, 'MarkerEdgeColor', colors(k,:), 'MarkerFaceColor', colors(k,:))
    end
end
hold off
app = squeeze(allResp(c,:,:));
app1 = app([1 6 11], :)';
iL = poissonInformation(app1)
app2 = app([5 10 15], :)';
iH = poissonInformation(app2)
%%
clear X Y Z
X{1}  = A1(:);
X{2} = A4(:);
X{3}  = A5(:);
Y{1}  = B1(:);
Y{2}  = B4(:);
Y{3}  = B5(:);
Z{1}  = C1(:);
Z{2}  = C4(:);
Z{3}  = C5(:);
colors = flipud([254,224,210;...
252,146,114;...
222,45,38]./255);

figure
hold on
for k = [1 3]
    plot(X{k}, Y{k}, 'o', 'MarkerSize', 5, 'MarkerEdgeColor', colors(k,:), 'MarkerFaceColor', colors(k,:))
%     x = X{k};
%     y = Y{k};
%     z = Z{k};
%     [p,ErrorEst] = polyfit(X{k},Y{k},2);
%     tbl = table(x,y, z);
%     pop_fit = fitlm(tbl, 'y ~ x + x^2*z');
%     plot(x, pop_fit.Fitted, '-.', 'LineWidth', 2, 'Color', colors(k,:))
end
hold off
%%
figure
%clims = [0,10];
imagesc(infoOdorID)
colormap(brewermap([],'*RdBu')); axis tight
figure
imagesc(allAuroc)
colormap(brewermap([],'*RdBu')); axis tight



%%
figure;
plot(nanmean(infoOdorID))
title('information')

figure
A1 = allRespMean(:,[1 6 10]);
A2 = allRespMean(:,[1 6 10]+1);
A3 = allRespMean(:,[1 6 10]+2);
A4 = allRespMean(:,[1 6 10]+3);
A5 = allRespMean(:,[1 6 10]+4);
M = [nanmean(A1(:)) nanmean(A2(:)) nanmean(A3(:)) nanmean(A4(:)) nanmean(A5(:))];
plot(M)
title('mean (spikes)')

figure
B1 = allRespVar(:,[1 6 10]);
B2 = allRespVar(:,[1 6 10]+1);
B3 = allRespVar(:,[1 6 10]+2);
B4 = allRespVar(:,[1 6 10]+3);
B5 = allRespVar(:,[1 6 10]+4);
V = [nanmean(B1(:)) nanmean(B2(:)) nanmean(B3(:)) nanmean(B4(:)) nanmean(B5(:))];
plot(V)
title('variance (spikes)')

figure
C1 = allRespGvar(:,[1 6 10]);
C2 = allRespGvar(:,[1 6 10]+1);
C3 = allRespGvar(:,[1 6 10]+2);
C4 = allRespGvar(:,[1 6 10]+3);
C5 = allRespGvar(:,[1 6 10]+4);
G = [nanmean(C1(:)) nanmean(C2(:)) nanmean(C3(:)) nanmean(C4(:)) nanmean(C5(:))];
plot(G)
title('variance (spikes)')
%%
figure
A1 = allAuroc(:,1:5);
A2 = allAuroc(:,6:10);
A3 = allAuroc(:,11:15);
subplot(1,3,1)
imagesc(A1)

subplot(1,3,2)
imagesc(A2)

subplot(1,3,3)
imagesc(A3)

%%
figure
B = allRespMean;
B = zscore(B')';
imagesc(B)
figure
plot(mean(B))

figure
C = allRespGvar - allBslGvar;
%C = zscore(C')';
imagesc(C)
figure
plot(mean(C))

