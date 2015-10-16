%odorToUse = [8 10 11 12 13 7];
odorToUse = 1:15;

idxNeuron = 1;
for idxExp = 1:length(List)
    for idxShank = 1:4
        for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
            aur = [];
            digP = [];
            digSC = [];
            responsesSpiCo = [];
            responsesTiCo = [];
            indicatoreAur = [];
            indicatorePeak = [];
            indicatoreSC = [];
            idxOdorLoop = 1;
            responsesTiCo = zeros(n_trials, 4*cycleLengthDeg);
            for idxOdor = odorToUse
                aur(idxOdorLoop,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax(1:4);
                digP(idxOdorLoop,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1:4);
                digSC(idxOdorLoop,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1:4);
                responsesTiCo(:,(idxOdorLoop-1)*5*cycleLengthDeg + 1:idxOdorLoop*5*cycleLengthDeg) =...
                    exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).smoothedPsth(:,4*cycleLengthDeg+1:8*cycleLengthDeg);
                idxOdorLoop = idxOdorLoop + 1;
            end
            indicatoreAur = find(aur(:)>0.65); indicatorePeak = find(digP(:)>0); indicatoreSC = find(digSC(:)>0);
            if ~isempty(indicatoreAur) && ~isempty(indicatoreAur) || ~isempty(indicatoreAur) && ~isempty(indicatoreSC)
                popActivity(idxNeuron,:,:) = responsesTiCo;
                cellOdorLog(idxNeuron,:) = [idxExp, idxShank, idxUnit]; %keep a log
                idxNeuron = idxNeuron + 1;
            end
        end
    end
end

popActivityMean = squeeze(mean(popActivity,2));
popActivityMean = popActivityMean'; popActivityMean = zscore(popActivityMean); popActivityMean = popActivityMean';
figure; set(gcf,'Position',[831 378 444 420]); set(gcf,'Color','w');
imagesc(popActivityMean, [-2 6]); colormap(brewermap([],'*RdBu')); axis tight; title('response matrix'); colorbar
%%
dataAll = [];

dataAll = popActivity;
neurons = size(dataAll,1);
trials = size(dataAll,2);
stimuli = size(dataAll,3);
dataAll = reshape(dataAll, neurons, trials .* stimuli);
dataAll = dataAll'; dataAll = zscore(dataAll); dataAll = dataAll';


app = [];
app = reshape(popActivity, neurons, trials .* stimuli);
for idxUnit = 1:size(app,1)
    unitActivity = app(idxUnit,:);
    unitActivity = reshape(unitActivity,10, floor(length(unitActivity)./10));
    meanBinnedActivity(idxUnit,:) = mean(unitActivity);
end
meanBinnedActivity = meanBinnedActivity'; meanBinnedActivity = zscore(meanBinnedActivity); meanBinnedActivity = meanBinnedActivity';
    
figure; set(gcf,'Position',[831 378 444 420]); set(gcf,'Color','w');
imagesc(meanBinnedActivity, [-2 6]); colormap(brewermap([],'*RdBu')); axis tight; title('response matrix'); colorbar
%%
  opts.Patterns.method = 'ICA';
  opts.threshold.method = 'binshuffling';
  opts.threshold.number_of_permutations = 100;
  opts.threshold.permutations_percentile = 95;
  opts.Patterns.number_of_iterations = 500;
  
  patterns = assembly_patterns(meanBinnedActivity,opts);
patternsActivities = assembly_activity(patterns,meanBinnedActivity);
figure; set(gcf,'Position',[831 378 444 420]); set(gcf,'Color','w');
imagesc(patternsActivities, [-2 6]); colormap(brewermap([],'*RdBu')); axis tight; title('response matrix'); colorbar

singlePAtternActivityMean = [];
for idxPattern = 1:size(patternsActivities,1)
    singlePattern = [];
    singlePattern = patternsActivities(idxPattern,:);
    singlePattern = reshape(singlePattern,36*4*15,5);
    singlePAtternActivityMean(:,idxPattern) = mean(singlePattern,2);
end
singlePAtternActivityMean = singlePAtternActivityMean';
figure; set(gcf,'Position',[831 378 444 420]); set(gcf,'Color','w');
imagesc(singlePAtternActivityMean, [-2 6]); colormap(brewermap([],'*RdBu')); axis tight; title('response matrix'); colorbar


