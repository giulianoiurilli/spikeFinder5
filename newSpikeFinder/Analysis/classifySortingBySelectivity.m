esp = [];
esp = coa15.esp;

odors = 1:15;
odorsRearranged = odors;
odors = length(odorsRearranged);

lsCoa = [];
responseCellCoa = [];
idxCell1 = 0;
appIdxCell = 0;
idxCell2 = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxesp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
                if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    idxCell1 = idxCell1 + 1;
                    idxO = 0;
                    app = zeros(1,odors);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        app(idxO) = abs(esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms)==1;
                    end
                    responseCellCoa(idxCell1) = sum(app');
                    if sum(app)>0
                        idxCell2 = idxCell2 + 1;
                        lsCoa(idxCell2) = esp(idxesp).shank(idxShank).SUA.cell(idxUnit).ls1s;
                    end
                end
            end
        end
    end
end
%%
esp = [];
esp = pcx15.esp;

odors = 1:15;
odorsRearranged = odors;
odors = length(odorsRearranged);

lsPcx = [];
responseCellPcx = [];
idxCell1 = 0;
appIdxCell = 0;
idxCell2 = 0;
for idxesp = 1:length(esp)
    for idxShank = 1:4
        if ~isempty(esp(idxesp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
                if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                    idxCell1 = idxCell1 + 1;
                    idxO = 0;
                    app = zeros(1,odors);
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        app(idxO) = abs(esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms)==1;
                    end
                    responseCellPcx(idxCell1) = sum(app');
                    if sum(app) > 0
                        idxCell2 = idxCell2 + 1;
                        lsPcx(idxCell2) = esp(idxesp).shank(idxShank).SUA.cell(idxUnit).ls1s;
                    end
                end
            end
        end
    end
end
% %%
% for idxClass = 1:15
%     nCoa(idxClass) = numel(find(responseCellCoa==idxClass));
%     nPcx(idxClass) = numel(find(responseCellPcx==idxClass));
% end
% cumsumCoa = cumsum(nCoa);
% cumsumPcx = cumsum(nPcx);
% appCumSum = [cumsumCoa; cumsumPcx];
% minNclass = min(appCumSum);
%%
nCoa = [];
nPcx = [];
edges = [0:0.2:1.2];
nCoa = histcounts(lsCoa, edges);
nPcx = histcounts(lsPcx, edges);
nCoa = fliplr(nCoa);
nPcx = fliplr(nPcx);
cumsumCoa = cumsum(nCoa);
cumsumPcx = cumsum(nPcx);
appCumSum = [cumsumCoa; cumsumPcx];
minNclass = min(appCumSum);
edges = fliplr(edges);




% %%
% esp = [];
% esp = coa15.esp;
% cellMax  = [];
% for idxClass = 1:15
%     n = numel(find(responseCellCoa==idxClass));
%
%         cellMax = minNclass(idxClass);
%         %cellMax = cumsumCoa(idxClass);
%         odors = 1:15;
%         odorsRearranged = odors;
%         odors = length(odorsRearranged);
%         responseCell1Mean = [];
%         responseCell1All = [];
%         idxCell0 = 0;
%         idxCell1 = 0;
%         appIdxCell = 0;
%         for idxesp = 1:length(esp)
%             for idxShank = 1:4
%                 if ~isempty(esp(idxesp).shank(idxShank).SUA)
%                     for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
%                         if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
%                             idxCell0 = idxCell0 + 1;
%                             if responseCellCoa(idxCell0) > 0 && responseCellCoa(idxCell0) <= idxClass
%                                 idxCell1 = idxCell1 + 1;
%                                 idxO = 0;
%                                 for idxOdor = odorsRearranged
%                                     idxO = idxO + 1;
%                                     app = [];
%                                     app = double(esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
%                                         esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
%                                     app1 = [];
%                                     app1 = [app(1:5); app(6:10)];
%                                     app2 = [];
%                                     app2 = mean(app1);
%                                     responseCell1Mean(idxCell1, idxO) = mean(app);
%                                     responseCell1All(idxCell1,:,idxO) = app;
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%         dataAll = responseCell1All;
%         neurons = size(dataAll,1);
%         trials = size(dataAll,2);
%         stimuli = size(dataAll,3);
%         dataAll = reshape(dataAll, neurons, trials .* stimuli);
%         dataAll = dataAll';
%         dataAll = zscore(dataAll);
%         dataAll = dataAll';
%         dataAll(isinf(dataAll)) = 0;
%         dataAll(isnan(dataAll)) = 0;
%         dataAll = reshape(dataAll, neurons, trials, stimuli);
%         dataAll = double(dataAll);
%         labels      = ones(1,size(dataAll,2));
%         app_labels  = labels;
%
%
%         for odor = 1:size(dataAll,3) - 1
%             labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%         end
%
%
%         labels      = labels';
%         trainingN = floor(0.9*(trials * stimuli));
%         repetitions = 1000;
%         [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout_cellmax(dataAll, trainingN, labels, repetitions, cellMax);
%         accuracyResponsesCoa15(idxClass) = mean_acc_svm;
%         accuracyResponsesSemCoa15(idxClass) = std_acc_svm/sqrt(numel(acc_svm)-1);
%         accuracyResponsesSemCoa15(idxClass) = std_acc_svm;
%         conMatResponses = conMat;
%
% end
%
%
%
% %%
% esp = [];
% esp = pcx15.esp;
% cellMax = [];
% for idxClass = 1:15
%     n = numel(find(responseCellPcx==idxClass));
%         cellMax = minNclass(idxClass);
%         odors = 1:15;
%         odorsRearranged = odors;
%         odors = length(odorsRearranged);
%         responseCell1Mean = [];
%         responseCell1All = [];
%         idxCell0 = 0;
%         idxCell1 = 0;
%         appIdxCell = 0;
%         for idxesp = 1:length(esp)
%             for idxShank = 1:4
%                 if ~isempty(esp(idxesp).shank(idxShank).SUA)
%                     for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
%                         if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
%                             idxCell0 = idxCell0 + 1;
%                             if responseCellPcx(idxCell0) > 0 && responseCellPcx(idxCell0) <= idxClass
%                                 idxCell1 = idxCell1 + 1;
%                                 idxO = 0;
%                                 for idxOdor = odorsRearranged
%                                     idxO = idxO + 1;
%                                     app = [];
%                                     app = double(esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
%                                         esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
%                                     app1 = [];
%                                     app1 = [app(1:5); app(6:10)];
%                                     app2 = [];
%                                     app2 = mean(app1);
%                                     responseCell1Mean(idxCell1, idxO) = mean(app);
%                                     responseCell1All(idxCell1,:,idxO) = app;
%                                 end
%                             end
%                         end
%                     end
%                 end
%             end
%         end
%         dataAll = responseCell1All;
%         neurons = size(dataAll,1);
%         trials = size(dataAll,2);
%         stimuli = size(dataAll,3);
%         dataAll = reshape(dataAll, neurons, trials .* stimuli);
%         dataAll = dataAll';
%         dataAll = zscore(dataAll);
%         dataAll = dataAll';
%         dataAll(isinf(dataAll)) = 0;
%         dataAll(isnan(dataAll)) = 0;
%         dataAll = reshape(dataAll, neurons, trials, stimuli);
%         dataAll = double(dataAll);
%         labels      = ones(1,size(dataAll,2));
%         app_labels  = labels;
%
%
%         for odor = 1:size(dataAll,3) - 1
%             labels  = [labels, app_labels + odor .* ones(1,size(dataAll,2))];
%         end
%
%
%         labels      = labels';
%         trainingN = floor(0.9*(trials * stimuli));
%         repetitions = 500;
%         [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout_cellmax(dataAll, trainingN, labels, repetitions, cellMax);
%         accuracyResponsesPcx15(idxClass) = mean_acc_svm;
%         accuracyResponsesSemPcx15(idxClass) = std_acc_svm/sqrt(numel(acc_svm)-1);
%         accuracyResponsesSemPcx15(idxClass) = std_acc_svm;
%         conMatResponses = conMat;
%
% end


%%
    accuracyResponsesCoa15 = [];
    accuracyResponsesSemCoa15 = [];

esp = [];
esp = coa15.esp;
cellMax  = [];
for idxClass = 2:7
    %     n = numel(find(responseCellCoa==idxClass));
    %
    cellMax = minNclass(idxClass-1);
    %         cellMax = cumsumCoa(idxClass);
    odors = 1:15;
    odorsRearranged = odors;
    odors = length(odorsRearranged);
    responseCell1Mean = [];
    responseCell1All = [];
    idxCell0 = 0;
    idxCell1 = 0;
    idxCell2 = 0;
    appIdxCell = 0;
    for idxesp = 1:length(esp)
        for idxShank = 1:4
            if ~isempty(esp(idxesp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
                    if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                        idxCell0 = idxCell0 + 1;
                        if responseCellCoa(idxCell0) > 0
                            idxCell1 = idxCell1 + 1;
                            if lsCoa(idxCell1) >= edges(idxClass)
                                idxCell2 = idxCell2 + 1;
                                idxO = 0;
                                for idxOdor = odorsRearranged
                                    idxO = idxO + 1;
                                    app = [];
                                    app = double(esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                        esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                                    %                                     app1 = [];
                                    %                                     app1 = [app(1:5); app(6:10)];
                                    %                                     app2 = [];
                                    %                                     app2 = mean(app1);
                                    responseCell1Mean(idxCell2, idxO) = mean(app);
                                    responseCell1All(idxCell2,:,idxO) = app;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
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
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout_cellmax(dataAll, trainingN, labels, repetitions, cellMax);
    accuracyResponsesCoa15(idxClass) = mean_acc_svm;
    accuracyResponsesSemCoa15(idxClass) = std_acc_svm/sqrt(numel(acc_svm)-1);
    conMatResponses = conMat;
    
end




    accuracyResponsesPcx15 = [];
    accuracyResponsesSemPcx15 = [];

esp = [];
esp = pcx15.esp;
cellMax = [];
for idxClass = 2:7
    %     n = numel(find(responseCellPcx==idxClass));
    cellMax = minNclass(idxClass-1);
    odors = 1:15;
    odorsRearranged = odors;
    odors = length(odorsRearranged);
    responseCell1Mean = [];
    responseCell1All = [];
    idxCell0 = 0;
    idxCell1 = 0;
    idxCell2 = 0;
    appIdxCell = 0;
    for idxesp = 1:length(esp)
        for idxShank = 1:4
            if ~isempty(esp(idxesp).shank(idxShank).SUA)
                for idxUnit = 1:length(esp(idxesp).shank(idxShank).SUA.cell)
                    if esp(idxesp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxesp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < 1
                        idxCell0 = idxCell0 + 1;
                        if responseCellPcx(idxCell0) > 0 
                            idxCell1 = idxCell1 + 1;
                            if lsPcx(idxCell1) >= edges(idxClass)
                                idxCell2 = idxCell2 + 1;
                                idxO = 0;
                                for idxOdor = odorsRearranged
                                    idxO = idxO + 1;
                                    app = [];
                                    app = double(esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                                        esp(idxesp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                                    %                                     app1 = [];
                                    %                                     app1 = [app(1:5); app(6:10)];
                                    %                                     app2 = [];
                                    %                                     app2 = mean(app1);
                                    responseCell1Mean(idxCell2, idxO) = mean(app);
                                    responseCell1All(idxCell2,:,idxO) = app;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
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
    repetitions = 500;
    [mean_acc_svm, std_acc_svm, acc_svm, prctile25, prctile75, conMat] = odor_c_svm_1leaveout_cellmax(dataAll, trainingN, labels, repetitions, cellMax);
    accuracyResponsesPcx15(idxClass) = mean_acc_svm;
    accuracyResponsesSemPcx15(idxClass) = std_acc_svm/sqrt(numel(acc_svm)-1);
    conMatResponses = conMat;
    
end

