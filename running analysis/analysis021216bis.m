n_trials = 10;
odors = length(odorsRearranged);
tuningCell1000ms = [];
noiseCorrW1000ms = [];
noiseCorrB1000ms = [];
sc1 = [];
sc2 = [];
sc3 = [];
sc4 = [];
sc5 = [];
sc6 = [];
for idxesp = 1: length(pcx2.esp) 
    for idxShank = 1:4
        idxCell1000ms = 0;
        tuningCell1000ms(idxShank).shank = [];
        for idxUnit = 1:length(pcx2.esp(idxesp).shankNowarp(idxShank).cell)
            if pcx2.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1 
                idxCell1000ms = idxCell1000ms + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCell1000ms(idxShank).shank(idxCell1000ms,:,idxO) = pcx2.esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
                end
            end
        end
        if size(tuningCell1000ms(idxShank).shank,1) > 1;
            tuningCell1000ms(idxShank).shank = reshape(tuningCell1000ms(idxShank).shank, size(tuningCell1000ms(idxShank).shank,1), n_trials * odors);
            tuningCell1000ms(idxShank).shank = tuningCell1000ms(idxShank).shank';
            tuningCell1000ms(idxShank).shank = zscore(tuningCell1000ms(idxShank).shank);
            tuningCell1000ms(idxShank).shank = tuningCell1000ms(idxShank).shank';
            rho = [];
            rho = pdist(tuningCell1000ms(idxShank).shank, 'correlation');
            rho = 1 - rho;
            noiseCorrW1000ms = [noiseCorrW1000ms rho];
        end 
    end
    pair = 0;
    for probe = 1:3
        for next = probe+1 : 4
            pair = pair + 1;
            if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
                app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                noiseCorrB1000ms{pair} = apppp(:)';
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                noiseCorrB1000ms{pair} = apppp(:)';
            end
        end
    end
    sc1 = [sc1 noiseCorrB1000ms{1}];
    sc2 = [sc2 noiseCorrB1000ms{2}];
    sc3 = [sc3 noiseCorrB1000ms{3}];
    sc4 = [sc4 noiseCorrB1000ms{4}];
    sc5 = [sc5 noiseCorrB1000ms{5}];
    sc6 = [sc6 noiseCorrB1000ms{6}];
end

dist1 = [sc1 sc4 sc6];
dist2 = [sc2 sc5];
dist3 = [sc3];



