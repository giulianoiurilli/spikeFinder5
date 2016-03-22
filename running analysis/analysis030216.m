%% valence l-svm - 10 odors
n_comb = nchoosek(10,5)/2;
odorsRearranged2Coa = nan*ones(n_comb,10);
odorsRearranged2Pcx = nan*ones(n_comb,10);
aa2Coa = nan*ones(n_comb,1);
aa2Pcx = nan*ones(n_comb,1);
combinations = combnk(1:10, 5);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = 1:10;
odorsRearrangedPcx = 1:10;
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
figure;
dataToPlot = {accuracyResponses2CoaAAaaTrue, accuracyResponses2PcxAAaaTrue, aa2Coa, aa2Pcx};
catIdx = [zeros(1000,1); ones(1000,1); 2*ones(n_comb,1); 3*ones(n_comb, 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)

%% valence l-svm - 8 odors
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
odorsRearrangedCoa = [2 3 4 5 7 8 9 10];
odorsRearrangedPcx = [2 3 4 5 7 8 9 10];
for idxRep = 1:n_comb
    odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
    accuracyResponses2CoaAAaa = l_svmClassify(coaAA.esp, odorsRearranged2Coa(idxRep,:),6);
    aa2Coa(idxRep) = mean(accuracyResponses2CoaAAaa);
    odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
    accuracyResponses2PcxAAaa = l_svmClassify(pcxAA.esp, odorsRearranged2Pcx(idxRep,:),6);
    aa2Pcx(idxRep) = mean(accuracyResponses2PcxAAaa);
end
accuracyResponses2CoaAAaaTrue8 = l_svmClassify(coaAA.esp, odorsRearrangedCoa,6);
accuracyResponses2PcxAAaaTrue8 = l_svmClassify(pcxAA.esp, odorsRearrangedPcx,6);
figure;
dataToPlot = {accuracyResponses2CoaAAaaTrue8, accuracyResponses2PcxAAaaTrue8, aa2Coa, aa2Pcx};
catIdx = [zeros(size(accuracyResponses2CoaAAaaTrue8,1),1); ones(size(accuracyResponses2PcxAAaaTrue8,1),1); 2*ones(n_comb,1); 3*ones(n_comb, 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)
%% valence auROC
odorsRearrangedCoa = 1:10;
odorsRearrangedPcx = 1:10;
aurocCatCoa = auROCcategorization(coaAA.esp, odorsRearrangedCoa, 5);
aurocCatPcx = auROCcategorization(pcxAA.esp, odorsRearrangedPcx, 5);
aurocCatCoa = abs(aurocCatCoa - 0.5) *2;
aurocCatPcx = abs(aurocCatPcx - 0.5) *2;

figure;
dataToPlot = {aurocCatCoa, aurocCatPcx};
catIdx = [zeros(size(aurocCatCoa,1),1); ones(size(aurocCatPcx,1),1)];
plotSpread(dataToPlot,'categoryIdx',catIdx, 'categoryMarkers',{'o', 'o'},'categoryColors',{'r','k'},'showMM', 4)

%% mix class l-svm 
n_comb = nchoosek(6,3)/2;
odorsRearranged2Coa = nan*ones(n_comb,6);
odorsRearranged2Pcx = nan*ones(n_comb,6);
aa2Coa = nan*ones(n_comb,1);
aa2Pcx = nan*ones(n_comb,1);
combinations = combnk(1:6, 3);
combinations1 = combinations(1:size(combinations,1)/2, :);
combinations2 = combinations(size(combinations,1)/2+1 : end, :);
combinations2 = flipud(combinations2);
combinations = [combinations1 combinations2];
odorsRearrangedCoa = [1 11 12 6 13 14];
odorsRearrangedPcx = [1 11 12 6 13 14];
for idxRep = 1:n_comb
    odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
    accuracyResponses2CoaAAaa = l_svmClassify(coaAA.esp, odorsRearranged2Coa(idxRep,:),4);
    aa2Coa(idxRep) = mean(accuracyResponses2CoaAAaa);
    odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
    accuracyResponses2PcxAAaa = l_svmClassify(pcxAA.esp, odorsRearranged2Pcx(idxRep,:),4);
    aa2Pcx(idxRep) = mean(accuracyResponses2PcxAAaa);
end
accuracyResponses2CoaAAaaTrue8 = l_svmClassify(coaAA.esp, odorsRearrangedCoa,4);
accuracyResponses2PcxAAaaTrue8 = l_svmClassify(pcxAA.esp, odorsRearrangedPcx,4);
figure;
dataToPlot = {accuracyResponses2CoaAAaaTrue8, accuracyResponses2PcxAAaaTrue8, aa2Coa, aa2Pcx};
catIdx = [zeros(size(accuracyResponses2CoaAAaaTrue8,1),1); ones(size(accuracyResponses2PcxAAaaTrue8,1),1); 2*ones(n_comb,1); 3*ones(n_comb, 1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)
%% mix class auROC
odorsRearrangedCoa = [1 11 12 6 13 14];
odorsRearrangedPcx = [1 11 12 6 13 14];
aurocCatCoa = auROCcategorization(coaAA.esp, odorsRearrangedCoa, 3);
aurocCatPcx = auROCcategorization(pcxAA.esp, odorsRearrangedPcx, 3);
aurocCatCoa = abs(aurocCatCoa - 0.5) *2;
aurocCatPcx = abs(aurocCatPcx - 0.5) *2;

figure;
dataToPlot = {aurocCatCoa, aurocCatPcx};
catIdx = [zeros(size(aurocCatCoa,1),1); ones(size(aurocCatPcx,1),1)];
plotSpread(dataToPlot,'categoryIdx',catIdx, 'categoryMarkers',{'o', 'o'},'categoryColors',{'r','k'},'showMM', 4)

%% 15 class l-svm 
odorsRearrangedCoa = 1:15;
odorsRearrangedPcx = 1:15;
accuracyResponses2CoaAAaaTrue8 = l_svmClassify(coa15.esp, odorsRearrangedCoa,1);
accuracyResponses2PcxAAaaTrue8 = l_svmClassify(pcx15.esp, odorsRearrangedPcx,1);
figure;
dataToPlot = {accuracyResponses2CoaAAaaTrue8, accuracyResponses2PcxAAaaTrue8};
catIdx = [zeros(size(accuracyResponses2CoaAAaaTrue8,1),1); ones(size(accuracyResponses2PcxAAaaTrue8,1),1)];
plotSpread(dataToPlot,'categoryIdx',catIdx,'showMM', 5)