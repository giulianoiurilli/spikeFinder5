rep = 500;
odorsRearranged1Coa = nan*ones(rep,8);
odorsRearranged1Pcx = nan*ones(rep,8);
aaCoa = nan*ones(rep,1);
aaPcx = nan*ones(rep,1);
for idxRep = 1:rep
%     idxOd = randperm(8);
%     odorsRearranged = 1:8;
%     odorsRearranged1Coa(idxRep,:) = odorsRearranged(idxOd);
%     accuracyResponsesCoaAAaa = l_svmClassify(coaAA.esp, odorsRearranged1Coa(idxRep,:));
%     aaCoa(idxRep) = mean(accuracyResponsesCoaAAaa);
%     idxOd = randperm(8);
    odorsRearranged = 1:8;
    odorsRearranged1Pcx(idxRep,:) = odorsRearranged(idxOd);
    accuracyResponsesPcxAAaa = l_svmClassify(pcxAA.esp, odorsRearranged1Pcx(idxRep,:),2);
    aaPcx(idxRep) = mean(accuracyResponsesPcxAAaa);
end
% odorsRearranged = [1 7 3 15];
% accuracyResponsesCoaAAaaTrue = l_svmClassify(coa.esp, odorsRearranged);
% odorsRearranged = [7 6 10 9];
% accuracyResponsesPcxAAaaTrue = l_svmClassify(pcx.esp, odorsRearranged);
% figure;
% %dataToPlot = {accuracyResponsesCoaAAaaTrue, accuracyResponsesPcxAAaaTrue, aaCoa, aaPcx};
% dataToPlot = {aaCoa, aaPcx, accuracyResponsesCoaAAaaTrue, accuracyResponsesPcxAAaaTrue};
% catIdx = [zeros(500,1); ones(500,1); 2*ones(500,1); 3*ones(500, 1)];
% plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)

%%
n_comb = nchoosek(4,2)/2;
odorsRearranged1Coa = nan*ones(n_comb,4);
odorsRearranged1Pcx = nan*ones(n_comb,4);
aa1Coa = nan*ones(n_comb,1);
aa1Pcx = nan*ones(n_comb,1);
combinations = combnk(1:4, 2);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = 1:4; %[1 7 3 15];
odorsRearrangedPcx = 1:4; %[7 6 10 9];
for idxRep = 1:n_comb
    odorsRearranged1Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
    accuracyResponses1CoaAAaa = l_svmClassify(coa.esp, odorsRearranged1Coa(idxRep,:),3);
    aa1Coa(idxRep) = mean(accuracyResponses1CoaAAaa);
    odorsRearranged1Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
    accuracyResponses1PcxAAaa = l_svmClassify(pcx.esp, odorsRearranged1Pcx(idxRep,:),3);
    aa1Pcx(idxRep) = mean(accuracyResponses1PcxAAaa);
end
[accuracyResponses1CoaAAaaTrue] = l_svmClassify(coa.esp, odorsRearrangedCoa,3);
[accuracyResponses1PcxAAaaTrue] = l_svmClassify(pcx.esp, odorsRearrangedPcx,3);
accuracyNBCoa = naiveBayesClassify(coa.esp, odorsRearrangedCoa,3);
accuracyNBPcx = naiveBayesClassify(pcx.esp, odorsRearrangedPcx,3);
figure;
dataToPlot = {accuracyResponses1CoaAAaaTrue, accuracyResponses1PcxAAaaTrue, aa1Coa, aa1Pcx};
catIdx = [zeros(1000,1); ones(1000,1); 2*ones(n_comb,1); 3*ones(n_comb, 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)

%%
odorsRearrangedCoa = 1:4;
odorsRearrangedPcx = 1:4;
aurocCatCoa = auROCcategorization(coa.esp, odorsRearrangedCoa, 2);
aurocCatPcx = auROCcategorization(pcx.esp, odorsRearrangedPcx, 2);
aurocCatCoa = abs(aurocCatCoa - 0.5) *2;
aurocCatPcx = abs(aurocCatPcx - 0.5) *2;

figure;
dataToPlot = {aurocCatCoa, aurocCatPcx};
catIdx = [zeros(size(aurocCatCoa,1),1); ones(size(aurocCatPcx,1),1)];
plotSpread(dataToPlot,'categoryIdx',catIdx, 'categoryMarkers',{'o', 'o'},'categoryColors',{'r','k'},'showMM', 4)

figure;
distributionPlot(aurocCatCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(aurocCatPcx,'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')



%%
n_comb = nchoosek(8,4)/2;
odorsRearranged2Coa = nan*ones(n_comb,8);
odorsRearranged2Pcx = nan*ones(n_comb,8);
aa2Coa = nan*ones(n_comb,1);
aa2Pcx = nan*ones(n_comb,1);
combinations = combnk(1:8, 4);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = 1:8;
odorsRearrangedPcx = 1:8;
for idxRep = 1:n_comb
    odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
    accuracyResponses2CoaAAaa = l_svmClassify(coaAA.esp, odorsRearranged2Coa(idxRep,:),2);
    aa2Coa(idxRep) = mean(accuracyResponses2CoaAAaa);
    odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
    accuracyResponses2PcxAAaa = l_svmClassify(pcxAA.esp, odorsRearranged2Pcx(idxRep,:),2);
    aa2Pcx(idxRep) = mean(accuracyResponses2PcxAAaa);
end
accuracyResponses2CoaAAaaTrue = l_svmClassify(coaAA.esp, odorsRearrangedCoa,2);
accuracyResponses2PcxAAaaTrue = l_svmClassify(pcxAA.esp, odorsRearrangedPcx,2);
accuracyNBCoa2 = naiveBayesClassify(coaAA.esp, odorsRearrangedCoa,2);
accuracyNBPcx2 = naiveBayesClassify(pcxAA.esp, odorsRearrangedPcx,2);
figure;
dataToPlot = {accuracyResponses2CoaAAaaTrue, accuracyResponses2PcxAAaaTrue, aa2Coa, aa2Pcx};
catIdx = [zeros(1000,1); ones(1000,1); 2*ones(n_comb,1); 3*ones(n_comb, 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)
%%
odorsRearrangedCoa = 1:8;
odorsRearrangedPcx = 1:8;
aurocCatCoa = auROCcategorization(coaAA.esp, odorsRearrangedCoa, 4);
aurocCatPcx = auROCcategorization(pcxAA.esp, odorsRearrangedPcx, 4);
aurocCatCoa = abs(aurocCatCoa - 0.5) *2;
aurocCatPcx = abs(aurocCatPcx - 0.5) *2;

figure;
dataToPlot = {aurocCatCoa, aurocCatPcx};
catIdx = [zeros(size(aurocCatCoa,1),1); ones(size(aurocCatPcx,1),1)];
plotSpread(dataToPlot,'categoryIdx',catIdx, 'categoryMarkers',{'o', 'o'},'categoryColors',{'r','k'},'showMM', 4)

figure;
distributionPlot(aurocCatCoa(:),'histOri','right','color','r','widthDiv',[2 2],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
distributionPlot(aurocCatPcx,'histOri','left','color','k','widthDiv',[2 1],'showMM',6, 'globalNorm', 1, 'xyOri', 'flipped')
