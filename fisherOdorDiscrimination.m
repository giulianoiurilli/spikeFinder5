odorants = ones(1,10);
odorant = odorants;
for k=1:6
    odorants = [odorants, odorant + k .* ones(1,10)];
end
odorants = odorants';


repetitions = 10;

for k = 1 : repetitions
    for nSamples = 2 : size(populatioPatternTrials,1) - 1
        
        for odor = 1:size(populatioPatternTrials,3)
            trainingUnits(:,:,odor) = populatioPatternTrials(randsample(size(populatioPatternTrials,1), nSamples), :, odor);
        end
        
        reshaped_trainingUnits = reshape(trainingUnits, size(trainingUnits,1), size(trainingUnits,2) .* size(trainingUnits,3));
        rppt = reshaped_trainingUnits';
        
        obj = fitcdiscr(rppt,odorants);
        resuberror(k, nSamples - 1) = resubLoss(obj);
        R (:,:,nSamples-1) = confusionmat(obj.Y,resubPredict(obj));
        clear trainingUnits
        clear reshaped_trainingUnits
        clear rppt
        clear obj
    end
end

avgResuberror = mean(resuberror);
stdResuberror = std(resuberror);

x = 2 : size(populatioPatternTrials,1) - 1;
figure
shadedErrorBar(1:100, avgResuberror(1:100), stdResuberror(1:100), 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');



% only two odors now
chooseOdor1 = 1;
chooseOdor2 = 5;
odorants = ones(1,10);
odorant = odorants;
for k=1:1
    odorants = [odorants, odorant + k .* ones(1,10)];
end
odorants = odorants';

repetitions = 10;
for k = 1 : repetitions
    for nSamples = 2 : size(populatioPatternTrials,1) - 1
        
        
        trainingUnits(:,:,1) = populatioPatternTrials(randsample(size(populatioPatternTrials,1), nSamples), :, chooseOdor1);
        trainingUnits(:,:,2) = populatioPatternTrials(randsample(size(populatioPatternTrials,1), nSamples), :, chooseOdor2);
        
        
        reshaped_trainingUnits = reshape(trainingUnits, size(trainingUnits,1), size(trainingUnits,2) .* size(trainingUnits,3));
        rppt = reshaped_trainingUnits';
        
        obj = fitcdiscr(rppt,odorants, 'discrimType','pseudoLinear');
        resuberror(k, nSamples - 1) = resubLoss(obj);
        R (:,:,nSamples-1) = confusionmat(obj.Y,resubPredict(obj));
        clear trainingUnits
        clear reshaped_trainingUnits
        clear rppt
        clear obj
    end
end

x = 2 : size(populatioPatternTrials,1) - 1;
figure
shadedErrorBar(1:100, avgResuberror(1:100), stdResuberror(1:100), 'r');
set(gca,'FontName','Arial','Fontsize',12, 'FontWeight', 'normal');
set(h,'color','white', 'PaperPositionMode', 'auto');



