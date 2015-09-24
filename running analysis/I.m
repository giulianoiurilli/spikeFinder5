% data high
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


odor_list = {'tmt3', 'dmt3', 'mmt3', 'iba3', 'iaa3',...
    'hed3', 'but3', 'tmt1', 'dmt1', 'mmt1',...
    'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};

odor_list = { 'tmt1', 'dmt1', 'mmt1',...
            'iba1', 'iaa1', 'hed1', 'btd1', 'rose'};



cycleLength = 360;
odorList = [8:15];

idxTrial = 1;
idxOdor = 1;
for idxTrialOdor=1:n_trials * length(odorList)
    idxUnit=0;
    for idxExp = 1:length(List)
        for idxShank = 1:4
            for idxNeuron = 1:length(exp(idxExp).shank(idxShank).cell)
                idxUnit = idxUnit + 1;
                D(idxTrialOdor).data(idxUnit,:) =  exp(idxExp).shank(idxShank).cell(idxNeuron).odor(idxOdor).spikeMatrix(idxTrial, 3*cycleLength:6*cycleLength);
            end
        end
    end
%     label = sprintf('reach%d', k);
%     D(i).condition = label;
    D(idxTrialOdor).condition = odor_list{idxOdor};
    idxTrial = idxTrial + 1;
    if idxTrial > n_trials
        idxTrial = 1;
        idxOdor = idxOdor + 1;
    end
    %D(i).epochStarts = [1 ante+1 ante+1+window]; 
end

DataHigh(D, 'DimReduce')


a=[];
b=[];
s=[];
for m = 1:40
    a = sum(D(m).data);
    b = spikeDensityRad(a,10);
    s(m,:) = b;
end

c = []; c = mean(s(6:10,:));
figure; plot(c)