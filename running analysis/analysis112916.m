% %% valence l-svm - 10 odors
% n_comb = nchoosek(10,5)/2;
% odorsRearranged2Coa = nan*ones(n_comb,10);
% odorsRearranged2Pcx = nan*ones(n_comb,10);
% aa2CoaNoDecorr = nan*ones(n_comb,103);
% aa2PcxNoDecorr = nan*ones(n_comb,127);
% combinations = combnk(1:10, 5);
% combinations1 = combinations(1:size(combinations,1)/2, :);
% combinations2 = combinations(size(combinations,1)/2+1 : end, :);
% combinations2 = flipud(combinations2);
% combinations = [combinations1 combinations2];
% odorsRearrangedCoa = 1:10;
% odorsRearrangedPcx = 1:10;
% for idxRep = 1:n_comb
%     odorsRearranged2Coa(idxRep,:) = odorsRearrangedCoa(combinations(idxRep,:));
%     accuracyResponses2CoaAAaa = l_svmClassify_new(coaAA.esp, odorsRearranged2Coa(idxRep,:),2);
%     aa2CoaNoDecorr(idxRep,:) = mean(accuracyResponses2CoaAAaa);
%     odorsRearranged2Pcx(idxRep,:) = odorsRearrangedPcx(combinations(idxRep,:));
%     accuracyResponses2PcxAAaa = l_svmClassify_new(pcxAA.esp, odorsRearranged2Pcx(idxRep,:),2);
%     aa2PcxNoDecorr(idxRep,:) = mean(accuracyResponses2PcxAAaa);
% end
% accuracyResponses2CoaAAaaTrueNoDecorr = l_svmClassify_new(coaAA.esp, odorsRearrangedCoa,2);
% accuracyResponses2PcxAAaaTrueNoDecorr = l_svmClassify_new(pcxAA.esp, odorsRearrangedPcx,2);
% percentiles_CoaAA = prctile(aa2CoaNoDecorr, [2.5, 97.5], 2);
% percentiles_PcxAA = prctile(aa2PcxNoDecorr, [2.5, 97.5], 2);
% 
% %%
% figure
% plot(aa2CoaNoDecorr', 'color', [252,146,114]./255)
% hold on
% plot(aa2PcxNoDecorr', 'color', [189,189,189]./255)
% hold on
% plot(mean(accuracyResponses2CoaAAaaTrueNoDecorr), 'color', coaC, 'linewidth', 2)
% hold on
% plot(mean(accuracyResponses2PcxAAaaTrueNoDecorr), 'color', pcxC, 'linewidth', 2)
% 
% %%
accuracyResponses2CoaAAaaTrueNoDecorrXX = l_svmClassify_new(coa15.esp, 1:15,1);
accuracyResponses2PcxAAaaTrueNoDecorrXX = l_svmClassify_new(pcx15.esp, 1:15,1);
%%
figure
plot(mean(accuracyResponses2CoaAAaaTrueNoDecorrXX), 'color', coaC, 'linewidth', 2)
hold on
plot(mean(accuracyResponses2PcxAAaaTrueNoDecorrXX), 'color', pcxC, 'linewidth', 2)

%%
%%
CoaNoDecorr15_sim = nan(150, 136);
PcxNoDecorr15_sim = nan(150, 96);
lista = [];
odors = 1:15;
for k = 1:150
    app = odors;
    list = [];
    for j = 1:4
        idx = randperm(size(app,2));
        app = app(idx);
        list = [list app(1:3)];
        app = app(4:end);
    end
    list = [list app];
    lista(k,:) = list;
end
for idxRep = 1:150
    accuracyResponses2Coa15_sim = l_svmClassify_new(coa15.esp, lista(idxRep,:),6);
    CoaNoDecorr15_sim(idxRep,:) = mean(accuracyResponses2Coa15_sim);
    accuracyResponses2Pcx15_sim = l_svmClassify_new(pcx15.esp, lista(idxRep,:),6);
    PcxNoDecorr15_sim(idxRep,:) = mean(accuracyResponses2Pcx15_sim);
end

accuracyResponses2Coa15 = l_svmClassify_new(coa15.esp, 1:15,6);
accuracyResponses2Pcx15 = l_svmClassify_new(pcx15.esp, 1:15,6);

%%
figure
plot(CoaNoDecorr15_sim', 'color', [252,146,114]./255)
hold on
plot(PcxNoDecorr15_sim', 'color', [189,189,189]./255)
hold on
plot(mean(accuracyResponses2Coa15), 'color', coaC, 'linewidth', 2)
hold on
plot(mean(accuracyResponses2Pcx15), 'color', pcxC, 'linewidth', 2)