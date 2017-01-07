function labels = create_labels(trials, stimuli, option)

labels      = nan(trials*stimuli,1);
app_labels  = labels;


n_labels = unique(option.grouping);
label_names = option.grouping;

for idxStimulus = 1:stimuli
    labels(trials*(idxStimulus-1)+1:trials*(idxStimulus-1)+trials) = label_names(idxStimulus);
end

