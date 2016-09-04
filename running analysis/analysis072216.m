esp = pcx15.esp;
odors = 1:15;
option = 1;


odorsRearranged = odors;
odors = length(odorsRearranged);

responseCell1Mean = [];
responseCell1All = [];
baselineCell1All = [];
idxCell1 = 0;
appIdxCell = 0;
for idxesp = 1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1 = idxCell1 + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                    esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                    app1 = [];
                    app1 = [app(1:5); app(6:10)];
                    app2 = [];
                    app2 = mean(app1);
                    responseCell1Mean(idxCell1, idxO) = mean(app);
                    responseCell1All(idxCell1,:,idxO) = app2;
                    app = [];
                    app = double(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
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

%%
dataAllB = [];
dataAllB = baselineCell1All;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAllB = reshape(dataAllB, neurons, trials .* stimuli);
dataAllB = dataAllB';
dataAllB = zscore(dataAllB);
dataAllB = dataAllB';
dataAllB(isinf(dataAllB)) = 0;
dataAllB(isnan(dataAllB)) = 0;
dataAllB = reshape(dataAllB, neurons, trials, stimuli);
dataAllB = double(dataAllB);

% NUMCELLS x NUMBINS x NUMODORS x NUMTRIALS
X = nan(neurons, 2, stimuli, trials);
for idxN = 1:neurons
    for idxO = 1:stimuli
        for idxT = 1:trials
            X(idxN, 2, idxO, idxT) = dataAll(idxN, idxT, idxO);
        end
    end
end
for idxN = 1:neurons
    for idxO = 1:stimuli
        for idxT = 1:trials
            X(idxN, 1, idxO, idxT) = dataAllB(idxN, idxT, idxO);
        end
    end
end




%%
lambda = 1;
repN = 100;
acc_Rlsc = [];
nNeurons = size(X,1);
nBins = size(X,2);
nOdors = size(X,3);
nTrials = size(X,4);

for rep = 1:repN
    j = 0;
    for units = 10:10:150%2:size(data,2) %150 %size(data,2) %
        j                       = j + 1;
        idxUnits                = randsample(nNeurons, units);
        useX = X(idxUnits,:,:,:);
        [Results, Scores] = ClassifyOdorIdentityUsingRlsc(useX, lambda);
        acc_Rlsc{j}.units(:,rep) = Results(:,2);
    end
end
%%
xAccCoa = [];
for i = 1:15
    xAccCoa(i) = mean(acc_Rlsc{i}.units(:));
end
figure
plot(xAccCoa(1:15))
hold on
plot(xAccPcx(1:15))