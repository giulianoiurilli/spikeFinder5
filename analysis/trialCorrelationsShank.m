function [noiseCorr300ms, noiseCorr1000ms, noiseCorrBsl] = trialCorrelationsShank(esp, odors)

%odors = 1:15;

odorsRearranged = odors;
odors = length(odorsRearranged);
n_trials = 10;

%% 300 ms
noiseCorr_0_300ms = [];
noiseCorr_1_300ms = [];
noiseCorr_2_300ms = [];
noiseCorr_3_300ms = [];
for idxesp = 1: length(esp)
    for idxShank = 1:4
        idxCell300ms = 0;
        tuningCell300ms(idxShank).shank = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell300ms = idxCell300ms + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCell300ms(idxShank).shank(idxCell300ms,:,idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms;
                end
            end
        end
        if size(tuningCell300ms(idxShank).shank,1) > 1;
            tuningCell300ms(idxShank).shank = reshape(tuningCell300ms(idxShank).shank, size(tuningCell300ms(idxShank).shank,1), n_trials * odors);
            tuningCell300ms(idxShank).shank = tuningCell300ms(idxShank).shank';
            tuningCell300ms(idxShank).shank = zscore(tuningCell300ms(idxShank).shank);
            tuningCell300ms(idxShank).shank = tuningCell300ms(idxShank).shank';
            rho = [];
            rho = pdist(tuningCell300ms(idxShank).shank, 'correlation');
            rho = 1 - rho;
            noiseCorr_0_300ms = [noiseCorr_0_300ms rho];
        end
    end
    for probe = 1:3
        next = probe+1;
        if (size(tuningCell300ms(probe).shank,1) > 1) && (size(tuningCell300ms(next).shank,1) > 1)
            app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseCorr_1_300ms = [noiseCorr_1_300ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseCorr_1_300ms = [noiseCorr_1_300ms apppp(:)'];
        end
    end
    
    for probe = 1:2
        next = probe+2;
        if (size(tuningCell300ms(probe).shank,1) > 1) && (size(tuningCell300ms(next).shank,1) > 1)
            app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseCorr_2_300ms = [noiseCorr_2_300ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseCorr_2_300ms = [noiseCorr_2_300ms apppp(:)'];
        end
    end
    
    probe = 1;
    next = 4;
    if (size(tuningCell300ms(probe).shank,1) > 1) && (size(tuningCell300ms(next).shank,1) > 1)
        app = corr(tuningCell300ms(probe).shank', tuningCell300ms(next).shank');
        index = find(triu(ones(size(app))));
        appp = app(index);
        apppp = appp(~isnan(appp));
        noiseCorr_3_300ms = [noiseCorr_3_300ms apppp(:)'];
        clear app
        clear appp
        clear apppp
        clear index
    else
        apppp = [];
        noiseCorr_3_300ms = [noiseCorr_3_300ms apppp(:)'];
    end
end

noiseCorr300ms{1} = noiseCorr_0_300ms;
noiseCorr300ms{2} = noiseCorr_1_300ms;
noiseCorr300ms{3} = noiseCorr_2_300ms;
noiseCorr300ms{4} = noiseCorr_3_300ms;
%% 1000 ms

noiseCorr_0_1000ms = [];
noiseCorr_1_1000ms = [];
noiseCorr_2_1000ms = [];
noiseCorr_3_1000ms = [];
for idxesp = 1: length(esp)
    for idxShank = 1:4
        idxCell1000ms = 0;
        tuningCell1000ms(idxShank).shank = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell1000ms = idxCell1000ms + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCell1000ms(idxShank).shank(idxCell1000ms,:,idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms;
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
            noiseCorr_0_1000ms = [noiseCorr_0_1000ms rho];
        end
    end
    for probe = 1:3
        next = probe+1;
        if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
            app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseCorr_1_1000ms = [noiseCorr_1_1000ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseCorr_1_1000ms = [noiseCorr_1_1000ms apppp(:)'];
        end
    end
    
    for probe = 1:2
        next = probe+2;
        if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
            app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseCorr_2_1000ms = [noiseCorr_2_1000ms apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseCorr_2_1000ms = [noiseCorr_2_1000ms apppp(:)'];
        end
    end
    
    probe = 1;
    next = 4;
    if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
        app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
        index = find(triu(ones(size(app))));
        appp = app(index);
        apppp = appp(~isnan(appp));
        noiseCorr_3_1000ms = [noiseCorr_3_1000ms apppp(:)'];
        clear app
        clear appp
        clear apppp
        clear index
    else
        apppp = [];
        noiseCorr_3_1000ms = [noiseCorr_3_1000ms apppp(:)'];
    end
end

noiseCorr1000ms{1} = noiseCorr_0_1000ms;
noiseCorr1000ms{2} = noiseCorr_1_1000ms;
noiseCorr1000ms{3} = noiseCorr_2_1000ms;
noiseCorr1000ms{4} = noiseCorr_3_1000ms;
%% Baseline
noiseCorr_0_Bsl = [];
noiseCorr_1_Bsl = [];
noiseCorr_2_Bsl = [];
noiseCorr_3_Bsl = [];
for idxesp = 1: length(esp)
    for idxShank = 1:4
        idxCellBsl = 0;
        tuningCellBsl(idxShank).shank = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCellBsl = idxCellBsl + 1;
                idxO = 0;
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    tuningCellBsl(idxShank).shank(idxCellBsl,:,idxO) = esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms;
                end
            end
        end
        if size(tuningCellBsl(idxShank).shank,1) > 1;
            tuningCellBsl(idxShank).shank = reshape(tuningCellBsl(idxShank).shank, size(tuningCellBsl(idxShank).shank,1), n_trials * odors);
            tuningCellBsl(idxShank).shank = tuningCellBsl(idxShank).shank';
            tuningCellBsl(idxShank).shank = zscore(tuningCellBsl(idxShank).shank);
            tuningCellBsl(idxShank).shank = tuningCellBsl(idxShank).shank';
            rho = [];
            rho = pdist(tuningCellBsl(idxShank).shank, 'correlation');
            rho = 1 - rho;
            noiseCorr_0_Bsl = [noiseCorr_0_Bsl rho];
        end
    end
    for probe = 1:3
        next = probe+1;
        if (size(tuningCellBsl(probe).shank,1) > 1) && (size(tuningCellBsl(next).shank,1) > 1)
            app = corr(tuningCellBsl(probe).shank', tuningCellBsl(next).shank');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseCorr_1_Bsl = [noiseCorr_1_Bsl apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseCorr_1_Bsl = [noiseCorr_1_Bsl apppp(:)'];
        end
    end
    
    for probe = 1:2
        next = probe+2;
        if (size(tuningCellBsl(probe).shank,1) > 1) && (size(tuningCellBsl(next).shank,1) > 1)
            app = corr(tuningCellBsl(probe).shank', tuningCellBsl(next).shank');
            index = find(triu(ones(size(app))));
            appp = app(index);
            apppp = appp(~isnan(appp));
            noiseCorr_2_Bsl = [noiseCorr_2_Bsl apppp(:)'];
            clear app
            clear appp
            clear apppp
            clear index
        else
            apppp = [];
            noiseCorr_2_Bsl = [noiseCorr_2_Bsl apppp(:)'];
        end
    end
    
    probe = 1;
    next = 4;
    if (size(tuningCellBsl(probe).shank,1) > 1) && (size(tuningCellBsl(next).shank,1) > 1)
        app = corr(tuningCellBsl(probe).shank', tuningCellBsl(next).shank');
        index = find(triu(ones(size(app))));
        appp = app(index);
        apppp = appp(~isnan(appp));
        noiseCorr_3_Bsl = [noiseCorr_3_Bsl apppp(:)'];
        clear app
        clear appp
        clear apppp
        clear index
    else
        apppp = [];
        noiseCorr_3_Bsl = [noiseCorr_3_Bsl apppp(:)'];
    end
end

noiseCorrBsl{1} = noiseCorr_0_Bsl;
noiseCorrBsl{2} = noiseCorr_1_Bsl;
noiseCorrBsl{3} = noiseCorr_2_Bsl;
noiseCorrBsl{4} = noiseCorr_3_Bsl;