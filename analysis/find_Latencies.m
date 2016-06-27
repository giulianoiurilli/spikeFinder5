function L = find_Latencies(esp, odors)

n_trials = 10;

%%
c = 0;
t = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            t = t + 1;
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end



L.onset = nan(c,length(odors));
L.peak = nan(c,length(odors));
L.hw = nan(c,length(odors));
L.sig = zeros(c,length(odors));
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                idxO = 0;
                for idxOdor = odors
                    idxO = idxO + 1;
                    
                    
                    if ~isempty(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).onsetLatency)
                        L.onset(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).onsetLatency;
                    end
                    if ~isempty(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).peakLatency)
                        L.peak(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).peakLatency;
                    end
                    if ~isempty(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).halfWidth)
                        L.hw(c,idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).halfWidth;
                    end
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse300ms == 1 || esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxO).DigitalResponse1000ms == 1
                        L.sig(c,idxO) = 1;
                    end
                end
            end
        end
    end
end
