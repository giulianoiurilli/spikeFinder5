function  [noiseCorrW1000ms, noiseCorrB1000ms, noiseCorrW1000msSig, noiseCorrB1000msSig] = findNoiseCorrelation_new(esp, odorsRearranged,lratio)

n_trials = 10;
odors = numel(odorsRearranged);
%%

noiseCorrW1000ms = [];
noiseCorrB1000ms = [];
for idxExp = 1: length(esp) %- 1
    for idxShank = 1:4
        idxCell1000ms = 0;
        tuningCell1000ms(idxShank).shank = [];
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    idxCell1000ms = idxCell1000ms + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        tuningCell1000ms(idxShank).shank(idxCell1000ms,:,idxO) = (esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                            mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms));% ./ std(esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms);
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
    end
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell1000ms(probe).shank,1) > 1) && (size(tuningCell1000ms(next).shank,1) > 1)
                app = corr(tuningCell1000ms(probe).shank', tuningCell1000ms(next).shank');
                index = find(triu(ones(size(app))));
                appp = app(index);
                apppp = appp(~isnan(appp));
                noiseCorrB1000ms = [noiseCorrB1000ms apppp(:)'];
                clear app
                clear appp
                clear apppp
                clear index
            else
                apppp = [];
                noiseCorrB1000ms = [noiseCorrB1000ms apppp(:)'];
            end
        end
    end
end
%%
noiseCorrW1000msSig = [];
noiseCorrB1000msSig = [];
for idxExp = 1: length(esp) 
    for idxShank = 1:4
        idxCell1000ms = 0;
        idxCell = 0;
        tuningCell1000ms(idxShank).shank = [];
        tuningCell1000msSig(idxShank).shank = [];
        if ~isempty(esp(idxExp).shank(idxShank).SUA)
            for idxUnit = 1:length(esp(idxExp).shank(idxShank).SUA.cell)
                if esp(idxExp).shank(idxShank).SUA.cell(idxUnit).good == 1 && esp(idxExp).shank(idxShank).SUA.cell(idxUnit).L_Ratio < lratio
                    idxCell1000ms = idxCell1000ms + 1;
                    idxO = 0;
                    for idxOdor = odorsRearranged
                        idxO = idxO + 1;
                        tuningCell1000ms(idxShank).shank(idxCell1000ms,:,idxO) = (esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms -...
                            mean(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms));
                        app(idxO) = ~(esp(idxExp).shank(idxShank).SUA.cell(idxUnit).odor(idxOdor).DigitalResponse1000ms==0);
                    end
                    if sum(app)>0
                        idxCell = idxCell + 1;
                        tuningCell1000msSig(idxShank).shank(idxCell,:,:) = tuningCell1000ms(idxShank).shank(idxCell1000ms,:,:);
                    end
                end
            end
            if size(tuningCell1000msSig(idxShank).shank,1) > 1;
                tuningCell1000msSig(idxShank).shank = reshape(tuningCell1000msSig(idxShank).shank, size(tuningCell1000msSig(idxShank).shank,1), n_trials * odors);
                tuningCell1000msSig(idxShank).shank = tuningCell1000msSig(idxShank).shank';
                tuningCell1000msSig(idxShank).shank = zscore(tuningCell1000msSig(idxShank).shank);
                tuningCell1000msSig(idxShank).shank = tuningCell1000msSig(idxShank).shank';
                rho = [];
                rho = pdist(tuningCell1000msSig(idxShank).shank, 'correlation');
                rho = 1 - rho;
                noiseCorrW1000msSig = [noiseCorrW1000msSig rho];
            end
        end
    end
    for probe = 1:3
        for next = probe+1 : 4
            if (size(tuningCell1000msSig(probe).shank,1) > 1) && (size(tuningCell1000msSig(next).shank,1) > 1)
                app = corr(tuningCell1000msSig(probe).shank', tuningCell1000msSig(next).shank');
                app = app(~isnan(app));
                noiseCorrB1000msSig = [noiseCorrB1000msSig app(:)'];
            else
                app = [];
                noiseCorrB1000msSig = [noiseCorrB1000msSig app(:)'];
            end
        end
    end
end

