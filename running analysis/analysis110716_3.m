esp = coaCS.esp;
odors = 1:15;


odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        %resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell1 = idxCell1 + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            app = [];
                            app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                            app1 = [];
                            app1 = [app(1:5); app(6:10)];
                            app2 = [];
                            app2 = mean(app1);
                            responseCell1Mean(idxCell1, idxO) = mean(app);
                            responseCell1All(idxCell1,:,idxO) = app2;
                        end
                    end
                end
            end
        end
    end
end


%%
mean_acc_svm_BestConcCoa = [];
std_acc_svm_BestConcCoa = [];
dataAll = [];
for idxNeuron = 1:size(responseCell1All,1)
    dataAll = responseCell1All(idxNeuron,:,:);
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
    %     for odor = 1:size(dataAll,3) - 1
    %         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    %     end
    
    for odor = 1:size(dataAll,3) - 1
        if odor < 5
            labels  = [labels, app_labels];
        else
            if odor < 10
                labels  = [labels, app_labels + ones(1,size(dataAll,2))];
            else
                labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
            end
        end
    end
    labela = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 500);
    mean_acc_svm_BestConcCoa(idxNeuron) = mean_acc_svm(1);
    std_acc_svm_BestConcCoa(idxNeuron) = std_acc_svm(1);
end

%%
mean_acc_svmConcCoa = [];
std_acc_svmConcCoa = [];
dataAll = [];
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
%     for odor = 1:size(dataAll,3) - 1
%         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%     end

for odor = 1:size(dataAll,3) - 1
    if odor < 5
        labels  = [labels, app_labels];
    else
        if odor < 10
            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        else
            labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
        end
    end
end
labela = labels';
trainingN = floor(0.9*(trials * stimuli));
[mean_acc_svmConcCoa, std_acc_svmConcCoa, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 500);

%%

responseCell1All = [];
idxCell1 = 0;
for idxRow = 1:size(cellLogInvCoa,1)
    idxExp = cellLogInvCoa(idxRow,1);
    idxShank = cellLogInvCoa(idxRow,2);
    idxUnit = cellLogInvCoa(idxRow,3);
    idxCell1 = idxCell1 + 1;
    idxO = 0;
    for idxOdor = odorsRearranged
        idxO = idxO + 1;
        app = [];
        app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
        app1 = [];
        app1 = [app(1:5); app(6:10)];
        app2 = [];
        app2 = mean(app1);
        responseCell1All(idxCell1,:,idxO) = app2;
    end
end
%%
mean_acc_svmConcInvCoa = [];
std_acc_svmConcInvCoa = [];
dataAll = [];
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
%     for odor = 1:size(dataAll,3) - 1
%         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%     end

for odor = 1:size(dataAll,3) - 1
    if odor < 5
        labels  = [labels, app_labels];
    else
        if odor < 10
            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        else
            labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
        end
    end
end
labela = labels';
trainingN = floor(0.9*(trials * stimuli));
[mean_acc_svmConcInvCoa, std_acc_svmConcInvCoa, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 500);


%%

responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        %resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell1 = idxCell1 + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            app = [];
                            app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                            app1 = [];
                            app1 = [app(1:5); app(6:10)];
                            app2 = [];
                            app2 = mean(app1);
                            responseCell1All(idxCell1,:,idxO) = app2;
                        end
                        for idxRow = 1:size(cellLogInvCoa,1)
                            idxExpInv = cellLogInvCoa(idxRow,1);
                            idxShankInv = cellLogInvCoa(idxRow,2);
                            idxUnitInv = cellLogInvCoa(idxRow,3);
                            if idxExp == idxExpInv && idxShank == idxShankInv && idxUnit == idxUnitInv
                                responseCell1All(idxCell1,:,:) = [];
                                idxCell1 = idxCell1 - 1;
                            end
                        end
                    end
                end
            end
        end
    end
end
%%
mean_acc_svmConcNoInvCoa = [];
std_acc_svmConcNoInvCoa = [];
dataAll = [];
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
%     for odor = 1:size(dataAll,3) - 1
%         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%     end

for odor = 1:size(dataAll,3) - 1
    if odor < 5
        labels  = [labels, app_labels];
    else
        if odor < 10
            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        else
            labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
        end
    end
end
labela = labels';
trainingN = floor(0.9*(trials * stimuli));
[mean_acc_svmConcNoInvCoa, std_acc_svmConcNoInvCoa, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 500);

%%
esp = pcxCS.esp;
odors = 1:15;


odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        %resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell1 = idxCell1 + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            app = [];
                            app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                            app1 = [];
                            app1 = [app(1:5); app(6:10)];
                            app2 = [];
                            app2 = mean(app1);
                            responseCell1Mean(idxCell1, idxO) = mean(app);
                            responseCell1All(idxCell1,:,idxO) = app2;
                        end
                    end
                end
            end
        end
    end
end


%%
mean_acc_svm_BestConcPcx = [];
std_acc_svm_BestConcPcx = [];
dataAll = [];
for idxNeuron = 1:size(responseCell1All,1)
    dataAll = responseCell1All(idxNeuron,:,:);
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
    %     for odor = 1:size(dataAll,3) - 1
    %         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
    %     end
    
    for odor = 1:size(dataAll,3) - 1
        if odor < 5
            labels  = [labels, app_labels];
        else
            if odor < 10
                labels  = [labels, app_labels + ones(1,size(dataAll,2))];
            else
                labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
            end
        end
    end
    labela = labels';
    trainingN = floor(0.9*(trials * stimuli));
    [mean_acc_svm, std_acc_svm, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 500);
    mean_acc_svm_BestConcPcx(idxNeuron) = mean_acc_svm(1);
    std_acc_svm_BestConcPcx(idxNeuron) = std_acc_svm(1);
end

%%
mean_acc_svmConcPcx = [];
std_acc_svmConcPcx = [];
dataAll = [];
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
%     for odor = 1:size(dataAll,3) - 1
%         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%     end

for odor = 1:size(dataAll,3) - 1
    if odor < 5
        labels  = [labels, app_labels];
    else
        if odor < 10
            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        else
            labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
        end
    end
end
labela = labels';
trainingN = floor(0.9*(trials * stimuli));
[mean_acc_svmConcPcx, std_acc_svmConcPcx, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 500);

%%
responseCell1All = [];
idxCell1 = 0;
for idxRow = 1:size(cellLogInvPcx,1)
    idxExp = cellLogInvPcx(idxRow,1);
    idxShank = cellLogInvPcx(idxRow,2);
    idxUnit = cellLogInvPcx(idxRow,3);
    idxCell1 = idxCell1 + 1;
    idxO = 0;
    for idxOdor = odorsRearranged
        idxO = idxO + 1;
        app = [];
        app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
            esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
        app1 = [];
        app1 = [app(1:5); app(6:10)];
        app2 = [];
        app2 = mean(app1);
        responseCell1All(idxCell1,:,idxO) = app2;
    end
end
%%
mean_acc_svmConcInvPcx = [];
std_acc_svmConcInvPcx = [];
dataAll = [];
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
%     for odor = 1:size(dataAll,3) - 1
%         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%     end

for odor = 1:size(dataAll,3) - 1
    if odor < 5
        labels  = [labels, app_labels];
    else
        if odor < 10
            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        else
            labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
        end
    end
end
labela = labels';
trainingN = floor(0.9*(trials * stimuli));
[mean_acc_svmConcInvPcx, std_acc_svmConcInvPcx, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 500);


%%

responseCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxExp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    resp = zeros(1,15);
                    for idxOdor = 1:15
                        %resp(idxOdor) = abs(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms) == 1;
                        resp(idxOdor) = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                    end
                    if sum(resp) > 0
                        idxCell1 = idxCell1 + 1;
                        idxO = 0;
                        for idxOdor = odorsRearranged
                            idxO = idxO + 1;
                            app = [];
                            app = esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                            app1 = [];
                            app1 = [app(1:5); app(6:10)];
                            app2 = [];
                            app2 = mean(app1);
                            responseCell1All(idxCell1,:,idxO) = app2;
                        end
                        for idxRow = 1:size(cellLogInvPcx,1)
                            idxExpInv = cellLogInvPcx(idxRow,1);
                            idxShankInv = cellLogInvPcx(idxRow,2);
                            idxUnitInv = cellLogInvPcx(idxRow,3);
                            if idxExp == idxExpInv && idxShank == idxShankInv && idxUnit == idxUnitInv
                                responseCell1All(idxCell1,:,:) = [];
                                idxCell1 = idxCell1 - 1;
                            end
                        end
                    end
                end
            end
        end
    end
end
%%
mean_acc_svmConcNoInvPcx = [];
std_acc_svmConcNoInvPcx = [];
dataAll = [];
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
%     for odor = 1:size(dataAll,3) - 1
%         labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%     end

for odor = 1:size(dataAll,3) - 1
    if odor < 5
        labels  = [labels, app_labels];
    else
        if odor < 10
            labels  = [labels, app_labels + ones(1,size(dataAll,2))];
        else
            labels  = [labels, app_labels + 2*ones(1,size(dataAll,2))];
        end
    end
end
labela = labels';
trainingN = floor(0.9*(trials * stimuli));
[mean_acc_svmConcNoInvPcx, std_acc_svmConcNoInvPcx, best15_acc_svm_labeledLines_coa, prctile25, prctile75] = odor_c_svm_2leaveout(dataAll, trainingN, labela, 500);


%%
figure
shadedErrorBar(1:length(mean_acc_svmConcCoa), mean_acc_svmConcCoa, std_acc_svmConcCoa ./ sqrt(length(std_acc_svmConcCoa)-1), {'-r', 'linewidth', 1},0);
hold on
shadedErrorBar(1:length(mean_acc_svmConcPcx), mean_acc_svmConcPcx, std_acc_svmConcPcx ./ sqrt(length(std_acc_svmConcPcx)-1), {'-k', 'linewidth', 1},0);
hold on
plot(repmat(max(mean_acc_svm_BestConcCoa), 1, length(mean_acc_svmConcPcx)), ':r', 'linewidth', 1);
hold on
plot(repmat(max(mean_acc_svm_BestConcPcx), 1, length(mean_acc_svmConcPcx)), ':k', 'linewidth', 1);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
ylabel('accuracy %')

figure
shadedErrorBar(1:length(mean_acc_svmConcNoInvCoa), mean_acc_svmConcNoInvCoa, std_acc_svmConcNoInvCoa ./ sqrt(length(std_acc_svmConcNoInvCoa)-1), {'-r', 'linewidth', 1},0);
hold on
shadedErrorBar(1:length(mean_acc_svmConcNoInvPcx), mean_acc_svmConcNoInvPcx, std_acc_svmConcNoInvPcx ./ sqrt(length(std_acc_svmConcNoInvPcx)-1), {'-k', 'linewidth', 1},0);
hold on
plot(mean_acc_svmConcInvCoa, ':r', 'linewidth', 1)
hold on
plot(mean_acc_svmConcInvPcx, ':k', 'linewidth', 1)
% shadedErrorBar(1:length(mean_acc_svmConcInvCoa), mean_acc_svmConcInvCoa, std_acc_svmConcInvCoa ./ sqrt(length(std_acc_svmConcInvCoa)-1), ':r');
% hold on
% shadedErrorBar(1:length(mean_acc_svmConcInvPcx), mean_acc_svmConcInvPcx, std_acc_svmConcInvPcx ./ sqrt(length(std_acc_svmConcInvPcx)-1), ':k');
hold on
plot(repmat(max(mean_acc_svm_BestConcCoa), 1, length(mean_acc_svmConcNoInvPcx)), ':r', 'linewidth', 1);
hold on
plot(repmat(max(mean_acc_svm_BestConcPcx), 1, length(mean_acc_svmConcNoInvPcx)), ':k', 'linewidth', 1);
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
ylim([0 100]);
ylabel('accuracy %')
