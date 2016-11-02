c = 0;
allResp = [];
varGbsl = [];
varGrsp = [];
allMeanRsp = [];
allMeanBsl = [];

inhibitoryCoa = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                            c = c+1;
                app = 0;
                for idxOdor = 1:15
                    if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        app = app + 1;
                    end
                end
                if app == 1
                    for idxOdor = 1:15
                        if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            allResp = [allResp; mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) - ...
                                mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms), idxOdor];
                            varGbsl = [varGbsl; partNeuralVariance(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)];
                            varGrsp = [varGrsp; partNeuralVariance(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)];
                            allMeanRsp = [allMeanRsp; mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)];
                            allMeanBsl = [allMeanBsl; mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)];
                        end
                    end                   
                end
            end
        end
    end
end

app = [];
for idxOdor = 1:15
    [idx, ~, ~] = find(allResp(:,2) == idxOdor);
    app = allResp(idx,1);
    app_varGbsl = varGbsl(idx);
    app_varGrsp = varGrsp(idx);
    app_Rsp = allMeanRsp(idx);
    app_Bsl = allMeanBsl(idx);
    nOdor(idxOdor) = length(app);
    meanOdor(idxOdor) = mean(app);
    stdOdor(idxOdor) = std(app);
    mean_varGbsl(idxOdor) = mean(app_varGbsl);
    std_varGbsl(idxOdor) = std(app_varGbsl);
    mean_varGrsp(idxOdor) = mean(app_varGrsp);
    std_varGrsp(idxOdor) = std(app_varGrsp);
    meanRspOdor(idxOdor) = mean(app_Rsp);
    stdRspOdor(idxOdor) = std(app_Rsp);
    meanBslOdor(idxOdor) = mean(app_Bsl);
    stdBslOdor(idxOdor) = std(app_Bsl);
end

for idxOdor = 1:15
    if isnan(meanOdor(idxOdor))
        meanOdor(idxOdor) = nanmean(meanOdor);
        stdOdor(idxOdor) = nanmean(stdOdor);
    end
    if stdOdor(idxOdor) == 0
        stdOdor(idxOdor) = nanmean(stdOdor);
    end
end
for idxOdor = 1:15
    if isnan(meanRspOdor(idxOdor))
        meanRspOdor(idxOdor) = nanmean(meanRspOdor);
        stdRspOdor(idxOdor) = nanmean(stdRspOdor);
    end
    if stdRspOdor(idxOdor) == 0
        stdRspOdor(idxOdor) = nanmean(stdRspOdor);
    end
end
for idxOdor = 1:15
    if isnan(meanBslOdor(idxOdor))
        meanBslOdor(idxOdor) = nanmean(meanBslOdor);
        stdBslOdor(idxOdor) = nanmean(stdBslOdor);
    end
    if stdBslOdor(idxOdor) == 0
        stdBslOdor(idxOdor) = nanmean(stdBslOdor);
    end
end
%%
for idxOdor = 1:15
    if isnan(mean_varGbsl(idxOdor))
        mean_varGbsl(idxOdor) = nanmean(mean_varGbsl);
        std_varGbsl(idxOdor) = nanmean(std_varGbsl);
    end
    if std_varGbsl(idxOdor) == 0
        std_varGbsl(idxOdor) = nanmean(std_varGbsl);
    end
end
%%
for idxOdor = 1:15
    if isnan(mean_varGrsp(idxOdor))
        mean_varGrsp(idxOdor) = nanmean(mean_varGrsp);
        std_varGrsp(idxOdor) = nanmean(std_varGrsp);
    end
    if std_varGrsp(idxOdor) == 0
        std_varGrsp(idxOdor) = nanmean(std_varGrsp);
    end
end
%%
proportionOdors = nOdor ./ sum(nOdor);

nSelectiveClusters = floor(c./15);
for idxOdor = 1:15
    pSelectiveClusters(idxOdor) = floor(c * proportionOdors(idxOdor));
end
% %%
% responseCell1All = zeros(nSelectiveClusters*15, 5, 15);
% s = 1;
% for idxOdor = 1:15
%     app = normrnd(meanOdor(idxOdor), stdOdor(idxOdor), nSelectiveClusters, 1);
%     responseCell1All(s : s + nSelectiveClusters - 1,:,idxOdor) = repmat(app, 1, 5);
%     s = s + nSelectiveClusters;
% end
% %%
% %On responses
% dataAll = responseCell1All;
% neurons = size(dataAll,1);
% trials = size(dataAll,2);
% stimuli = size(dataAll,3);
% dataAll = reshape(dataAll, neurons, trials .* stimuli);
% dataAll = dataAll';
% dataAll = zscore(dataAll);
% dataAll = dataAll';
% dataAll(isinf(dataAll)) = 0;
% dataAll(isnan(dataAll)) = 0;
% dataAll = reshape(dataAll, neurons, trials, stimuli);
% dataAll = double(dataAll);
% labels      = ones(1,size(dataAll,2));
% app_labels  = labels;
% 
% 
% for odor = 1:size(dataAll,3) - 1
%     labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
% end
% 
% 
% labels      = labels';
% trainingN = floor(0.9*(trials * stimuli));
% repetitions = 1000;
% [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labels, repetitions);
% accuracyResponses = acc_svm;
% %%
% 
% responseCell1All = zeros(sum(pSelectiveClusters), 5, 15);
% s = 1;
% for idxOdor = 1:15
%     app = normrnd(meanOdor(idxOdor), stdOdor(idxOdor), pSelectiveClusters(idxOdor), 1);
%     responseCell1All(s : s + pSelectiveClusters(idxOdor) - 1,:,idxOdor) = repmat(app, 1, 5);
%     s = s + pSelectiveClusters(idxOdor);
% end
% %%
% %On responses
% dataAll = responseCell1All;
% neurons = size(dataAll,1);
% trials = size(dataAll,2);
% stimuli = size(dataAll,3);
% dataAll = reshape(dataAll, neurons, trials .* stimuli);
% dataAll = dataAll';
% dataAll = zscore(dataAll);
% dataAll = dataAll';
% dataAll(isinf(dataAll)) = 0;
% dataAll(isnan(dataAll)) = 0;
% dataAll = reshape(dataAll, neurons, trials, stimuli);
% dataAll = double(dataAll);
% labels      = ones(1,size(dataAll,2));
% app_labels  = labels;
% 
% 
% for odor = 1:size(dataAll,3) - 1
%     labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
% end
% 
% 
% labels      = labels';
% trainingN = floor(0.9*(trials * stimuli));
% repetitions = 1000;
% [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labels, repetitions);
% accuracyResponses = acc_svm;
% acc_svm_actualProportion_Rel100 = acc_svm;

%%
responseCell1All = zeros(sum(pSelectiveClusters), 5, 15);
k = 1;
for idxOdor = 1:15
    simVarGbsl = mean_varGbsl(idxOdor);
    simVarGrsp = mean_varGrsp(idxOdor);
    appBsl = normrnd(meanBslOdor(idxOdor), stdBslOdor(idxOdor), pSelectiveClusters(idxOdor), 1);
    appRsp = normrnd(meanRspOdor(idxOdor), stdRspOdor(idxOdor), pSelectiveClusters(idxOdor), 1);
    app1 = zeros(pSelectiveClusters(idxOdor),5);
    for j = 1:pSelectiveClusters(idxOdor)
        lambdaBsl = appBsl(j);
        lambdaRsp = appRsp(j);
        rb = 1/simVarGbsl;
        sb = simVarGbsl * lambdaBsl;
        rr = 1/simVarGrsp;
        sr = simVarGrsp * lambdaRsp;
        app = [];
        if simVarGbsl == 0
            for t = 1:10
                app(t) = poissrnd(lambdaRsp) - poissrnd(lambdaBsl);
            end
        else
            
            for t = 1:10
                app(t) = nbinrnd(rr, 1/(1+sr)) - nbinrnd(rb, 1/(1+sb));
            end
        end
        app(app<0) = 0;
        app = [app(1:5); app(6:10)];
        app = mean(app);
        app1(j,:) = app;
    end
    responseCell1All(k : k + pSelectiveClusters(idxOdor) - 1,:,idxOdor) = app1;
    k = k + pSelectiveClusters(idxOdor);
end

%%
%On responses
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;


for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end


labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 1000;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labels, repetitions);
accuracyResponses = acc_svm;
acc_svm_actualProportion_RelNegBin_coa = acc_svm;

    
%%
acc_svm_actualData = l_svmClassify2(coa15.esp, 1:15);
%%
c = 0;
info = 0
responseCell1All = nan(1,5,15);
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c+1;
                if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s > info
                    info = coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                    for idxOdor = 1:15
                        app = coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                            coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                        app1 = [];
                        app1 = [app(1:5); app(6:10)];
                        app2 = [];
                        app2 = mean(app1);
                        responseCell1All(1,:,idxOdor) = app2;
                    end
                end
            end
        end
    end
end

%%
%On responses
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;


for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end


labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 1000;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labels, repetitions);
accuracyResponses = acc_svm;
acc_svm_bestNeuron = acc_svm;

%%
c = 0;
allResp = [];
varGbsl = [];
varGrsp = [];
allMeanRsp = [];
allMeanBsl = [];

inhibitoryPcx = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                            c = c+1;
                app = 0;
                for idxOdor = 1:15
                    if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        app = app + 1;
                    end
                end
                if app == 1
                    for idxOdor = 1:15
                        if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                            allResp = [allResp; mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms) - ...
                                mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms), idxOdor];
                            varGbsl = [varGbsl; partNeuralVariance(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)];
                            varGrsp = [varGrsp; partNeuralVariance(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)];
                            allMeanRsp = [allMeanRsp; mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)];
                            allMeanBsl = [allMeanBsl; mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms)];
                        end
                    end                   
                end
            end
        end
    end
end

app = [];
for idxOdor = 1:15
    [idx, ~, ~] = find(allResp(:,2) == idxOdor);
    app = allResp(idx,1);
    app_varGbsl = varGbsl(idx);
    app_varGrsp = varGrsp(idx);
    app_Rsp = allMeanRsp(idx);
    app_Bsl = allMeanBsl(idx);
    nOdor(idxOdor) = length(app);
    meanOdor(idxOdor) = mean(app);
    stdOdor(idxOdor) = std(app);
    mean_varGbsl(idxOdor) = mean(app_varGbsl);
    std_varGbsl(idxOdor) = std(app_varGbsl);
    mean_varGrsp(idxOdor) = mean(app_varGrsp);
    std_varGrsp(idxOdor) = std(app_varGrsp);
    meanRspOdor(idxOdor) = mean(app_Rsp);
    stdRspOdor(idxOdor) = std(app_Rsp);
    meanBslOdor(idxOdor) = mean(app_Bsl);
    stdBslOdor(idxOdor) = std(app_Bsl);
end

for idxOdor = 1:15
    if isnan(meanOdor(idxOdor))
        meanOdor(idxOdor) = nanmean(meanOdor);
        stdOdor(idxOdor) = nanmean(stdOdor);
    end
    if stdOdor(idxOdor) == 0
        stdOdor(idxOdor) = nanmean(stdOdor);
    end
end
for idxOdor = 1:15
    if isnan(meanRspOdor(idxOdor))
        meanRspOdor(idxOdor) = nanmean(meanRspOdor);
        stdRspOdor(idxOdor) = nanmean(stdRspOdor);
    end
    if stdRspOdor(idxOdor) == 0
        stdRspOdor(idxOdor) = nanmean(stdRspOdor);
    end
end
for idxOdor = 1:15
    if isnan(meanBslOdor(idxOdor))
        meanBslOdor(idxOdor) = nanmean(meanBslOdor);
        stdBslOdor(idxOdor) = nanmean(stdBslOdor);
    end
    if stdBslOdor(idxOdor) == 0
        stdBslOdor(idxOdor) = nanmean(stdBslOdor);
    end
end
%%
for idxOdor = 1:15
    if isnan(mean_varGbsl(idxOdor))
        mean_varGbsl(idxOdor) = nanmean(mean_varGbsl);
        std_varGbsl(idxOdor) = nanmean(std_varGbsl);
    end
    if std_varGbsl(idxOdor) == 0
        std_varGbsl(idxOdor) = nanmean(std_varGbsl);
    end
end
%%
for idxOdor = 1:15
    if isnan(mean_varGrsp(idxOdor))
        mean_varGrsp(idxOdor) = nanmean(mean_varGrsp);
        std_varGrsp(idxOdor) = nanmean(std_varGrsp);
    end
    if std_varGrsp(idxOdor) == 0
        std_varGrsp(idxOdor) = nanmean(std_varGrsp);
    end
end
%%
proportionOdors = nOdor ./ sum(nOdor);

nSelectiveClusters = floor(c./15);
for idxOdor = 1:15
    pSelectiveClusters(idxOdor) = floor(c * proportionOdors(idxOdor));
end
% %%
% responseCell1All = zeros(nSelectiveClusters*15, 5, 15);
% s = 1;
% for idxOdor = 1:15
%     app = normrnd(meanOdor(idxOdor), stdOdor(idxOdor), nSelectiveClusters, 1);
%     responseCell1All(s : s + nSelectiveClusters - 1,:,idxOdor) = repmat(app, 1, 5);
%     s = s + nSelectiveClusters;
% end
% %%
% %On responses
% dataAll = responseCell1All;
% neurons = size(dataAll,1);
% trials = size(dataAll,2);
% stimuli = size(dataAll,3);
% dataAll = reshape(dataAll, neurons, trials .* stimuli);
% dataAll = dataAll';
% dataAll = zscore(dataAll);
% dataAll = dataAll';
% dataAll(isinf(dataAll)) = 0;
% dataAll(isnan(dataAll)) = 0;
% dataAll = reshape(dataAll, neurons, trials, stimuli);
% dataAll = double(dataAll);
% labels      = ones(1,size(dataAll,2));
% app_labels  = labels;
% 
% 
% for odor = 1:size(dataAll,3) - 1
%     labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
% end
% 
% 
% labels      = labels';
% trainingN = floor(0.9*(trials * stimuli));
% repetitions = 1000;
% [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labels, repetitions);
% accuracyResponses = acc_svm;
% %%
% 
% responseCell1All = zeros(sum(pSelectiveClusters), 5, 15);
% s = 1;
% for idxOdor = 1:15
%     app = normrnd(meanOdor(idxOdor), stdOdor(idxOdor), pSelectiveClusters(idxOdor), 1);
%     responseCell1All(s : s + pSelectiveClusters(idxOdor) - 1,:,idxOdor) = repmat(app, 1, 5);
%     s = s + pSelectiveClusters(idxOdor);
% end
% %%
% %On responses
% dataAll = responseCell1All;
% neurons = size(dataAll,1);
% trials = size(dataAll,2);
% stimuli = size(dataAll,3);
% dataAll = reshape(dataAll, neurons, trials .* stimuli);
% dataAll = dataAll';
% dataAll = zscore(dataAll);
% dataAll = dataAll';
% dataAll(isinf(dataAll)) = 0;
% dataAll(isnan(dataAll)) = 0;
% dataAll = reshape(dataAll, neurons, trials, stimuli);
% dataAll = double(dataAll);
% labels      = ones(1,size(dataAll,2));
% app_labels  = labels;
% 
% 
% for odor = 1:size(dataAll,3) - 1
%     labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
% end
% 
% 
% labels      = labels';
% trainingN = floor(0.9*(trials * stimuli));
% repetitions = 1000;
% [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labels, repetitions);
% accuracyResponses = acc_svm;
% acc_svm_actualProportion_Rel100 = acc_svm;

%%
responseCell1All = zeros(sum(pSelectiveClusters), 5, 15);
k = 1;
for idxOdor = 1:15
    simVarGbsl = mean_varGbsl(idxOdor);
    simVarGrsp = mean_varGrsp(idxOdor);
    appBsl = normrnd(meanBslOdor(idxOdor), stdBslOdor(idxOdor), pSelectiveClusters(idxOdor), 1);
    appRsp = normrnd(meanRspOdor(idxOdor), stdRspOdor(idxOdor), pSelectiveClusters(idxOdor), 1);
    app1 = zeros(pSelectiveClusters(idxOdor),5);
    for j = 1:pSelectiveClusters(idxOdor)
        lambdaBsl = appBsl(j);
        lambdaRsp = appRsp(j);
        rb = 1/simVarGbsl;
        sb = simVarGbsl * lambdaBsl;
        rr = 1/simVarGrsp;
        sr = simVarGrsp * lambdaRsp;
        app = [];
        if simVarGbsl == 0
            for t = 1:10
                app(t) = poissrnd(lambdaRsp) - poissrnd(lambdaBsl);
            end
        else
            
            for t = 1:10
                app(t) = nbinrnd(rr, 1/(1+sr)) - nbinrnd(rb, 1/(1+sb));
            end
        end
        app(app<0) = 0;
        app = [app(1:5); app(6:10)];
        app = mean(app);
        app1(j,:) = app;
    end
    responseCell1All(k : k + pSelectiveClusters(idxOdor) - 1,:,idxOdor) = app1;
    k = k + pSelectiveClusters(idxOdor);
end

%%
%On responses
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;


for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end


labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 1000;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labels, repetitions);
accuracyResponses = acc_svm;
acc_svm_actualProportion_RelNegBin_pcx = acc_svm;

    
%%
acc_svm_actualData = l_svmClassify2(pcx15.esp, 1:15);
%%
c = 0;
info = 0
responseCell1All = nan(1,5,15);
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c+1;
                if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s > info
                    info = pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).I1s;
                    for idxOdor = 1:15
                        app = pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                            pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                        app1 = [];
                        app1 = [app(1:5); app(6:10)];
                        app2 = [];
                        app2 = mean(app1);
                        responseCell1All(1,:,idxOdor) = app2;
                    end
                end
            end
        end
    end
end

%%
%On responses
dataAll = responseCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll';
dataAll = zscore(dataAll);
dataAll = dataAll';
dataAll(isinf(dataAll)) = 0;
dataAll(isnan(dataAll)) = 0;
dataAll = reshape(dataAll, neurons, trials, stimuli);
dataAll = double(dataAll);
labels      = ones(1,size(dataAll,2));
app_labels  = labels;


for odor = 1:size(dataAll,3) - 1
    labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
end


labels      = labels';
trainingN = floor(0.9*(trials * stimuli));
repetitions = 1000;
[mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labels, repetitions);
accuracyResponses = acc_svm;
acc_svm_bestNeuron = acc_svm;

%%
figure; plot(mean(acc_svm_equalProportion_Rel100))
hold on; plot(mean(acc_svm_actualProportion_Rel100))
hold on; plot(mean(acc_svm_actualProportion_RelNegBin))
hold on; plot(mean(acc_svm_actualData))
hold on; plot(repmat(mean(acc_svm_bestNeuron), 1, c));

