%% proportion of inhibitory responses

c = 0;
inhibitoryCoa = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:15
                    if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                        inhibitoryCoa = inhibitoryCoa + 1;
                    end
                end
            end
        end
    end
end
cells15Coa = c;

c = 0;
for idxExp = 1 : length(coaAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:10
                    if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                        inhibitoryCoa = inhibitoryCoa + 1;
                    end
                end
            end
        end
    end
end
cellsAACoa = c;


proportionInhibitoryCoa = inhibitoryCoa ./ (cells15Coa*15 + cellsAACoa*10)
sem_proportionInhibitoryCoa = sqrt(proportionInhibitoryCoa * (1 - proportionInhibitoryCoa) ./ (cells15Coa*15 + cellsAACoa*10))

c = 0;
inhibitoryPcx = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:15
                    if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                        inhibitoryPcx = inhibitoryPcx + 1;
                    end
                end
            end
        end
    end
end
cells15Pcx = c;

c = 0;
for idxExp = 1 : length(pcxAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:10
                    if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms < 0
                        inhibitoryPcx = inhibitoryPcx + 1;
                    end
                end
            end
        end
    end
end
cellsAAPcx = c;


proportionInhibitoryPcx = inhibitoryPcx ./ (cells15Pcx*15 + cellsAAPcx*10)
sem_proportionInhibitoryPcx = sqrt(proportionInhibitoryPcx * (1 - proportionInhibitoryPcx) ./ (cells15Pcx*15 + cellsAAPcx*10))

%% average response in early 5 and late 5 trials
c = 0;
u = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:15
                    if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        u = u + 1;
                    end
                end
            end
        end
    end
end

for idxExp = 1 : length(coaAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:10
                    if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        u = u + 1;
                    end
                end
            end
        end
    end
end

responsesEarlyLateCoa = nan(u,2);
responsesEarlyLatePCoa = zeros(u,2);
responsesCoa15 = nan(u,:);
c = 0;
u = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:15
                    if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        u = u + 1;
                        responsesEarlyLateCoa(u,1) = mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(1:5));
                        responsesEarlyLateCoa(u,2) = mean(coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(6:10));
                        responsesEarlyLatePCoa(u,1) = ttest2(responsesEarlyLateCoa(u,1), responsesEarlyLateCoa(u,2));
                        if responsesEarlyLatePCoa(u,1) < 0.05
                            if (responsesEarlyLateCoa(u,1) - responsesEarlyLateCoa(u,2)) > 0
                                responsesEarlyLatePCoa(u,2) = 1;
                            else
                                responsesEarlyLatePCoa(u,2) = -1;
                            end
                        end
                    end
                end
            end
        end
    end
end

for idxExp = 1 : length(coaAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:10
                    if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        u = u + 1;
                        responsesEarlyLateCoa(u,1) = mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(1:5));
                        responsesEarlyLateCoa(u,2) = mean(coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(6:10));
                        if responsesEarlyLatePCoa(u,1) < 0.05
                            if (responsesEarlyLateCoa(u,1) - responsesEarlyLateCoa(u,2)) > 0
                                responsesEarlyLatePCoa(u,2) = 1;
                            else
                                responsesEarlyLatePCoa(u,2) = -1;
                            end
                        end
                    end
                end
            end
        end
    end
end


c = 0;
u = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:15
                    if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        u = u + 1;
                    end
                end
            end
        end
    end
end

for idxExp = 1 : length(pcxAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:10
                    if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        u = u + 1;
                    end
                end
            end
        end
    end
end

responsesEarlyLatePcx = nan(u,2);
responsesEarlyLatePPcx = zeros(u,2);
c = 0;
u = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:15
                    if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        u = u + 1;
                        responsesEarlyLatePcx(u,1) = mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(1:4));
                        responsesEarlyLatePcx(u,2) = mean(pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(6:10));
                        if responsesEarlyLatePPcx(u,1) < 0.05
                            if (responsesEarlyLatePcx(u,1) - responsesEarlyLatePcx(u,2)) > 0
                                responsesEarlyLatePPcx(u,2) = 1;
                            else
                                responsesEarlyLatePPcx(u,2) = -1;
                            end
                        end
                    end
                end
            end
        end
    end
end

for idxExp = 1 : length(pcxAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:10
                    if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        u = u + 1;
                        responsesEarlyLatePcx(u,1) = mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(1:4));
                        responsesEarlyLatePcx(u,2) = mean(pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms(6:10));
                        if responsesEarlyLatePPcx(u,1) < 0.05
                            if (responsesEarlyLatePcx(u,1) - responsesEarlyLatePcx(u,2)) > 0
                                responsesEarlyLatePPcx(u,2) = 1;
                            else
                                responsesEarlyLatePPcx(u,2) = -1;
                            end
                        end
                    end
                end
            end
        end
    end
end

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
labels = {'1-5', '6-10'};
my_ttest2_boxplot(responsesEarlyLateCoa(:,1), responsesEarlyLateCoa(:,2), coaC, labels);
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)

[h, p, ci, stats] = ttest(responsesEarlyLateCoa(:,1), responsesEarlyLateCoa(:,2))
decreasingCoa = sum(responsesEarlyLatePCoa(:,2)>0)./size(responsesEarlyLatePCoa,1)
increasingCoa = sum(responsesEarlyLatePCoa(:,2)<0)./size(responsesEarlyLatePCoa,1)

figure
set(gcf,'color','white', 'PaperPositionMode', 'auto');
labels = {'1-5', '6-10'};
my_ttest2_boxplot(responsesEarlyLatePcx(:,1), responsesEarlyLatePcx(:,2), pcxC, labels);
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'arial', 'fontsize', 14)

[h, p, ci, stats] = ttest(responsesEarlyLatePcx(:,1), responsesEarlyLatePcx(:,2))
decreasingPcx = sum(responsesEarlyLatePPcx(:,2)>0)./size(responsesEarlyLatePPcx,1)
increasingPcx = sum(responsesEarlyLatePPcx(:,2)<0)./size(responsesEarlyLatePPcx,1)


%% proportion of neurons that respond to 2+ odors of the same valence VS 2+ odors of both valences 
c= 0;
for idxExp = 1 : length(coaAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end


responsesAll = nan(c,10);
c = 0;
for idxExp = 1 : length(coaAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:10
                    if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        responsesAll(c,idxOdor) = 1;
                    end
                end
            end
        end
    end
end

sumResponses = nansum(responsesAll,2);
twoPlusResponsiveNeuronsCoa = sumResponses > 1;
singleClassCoa = nan(size(twoPlusResponsiveNeuronsCoa,1),1);

for idxC = 1:size(twoPlusResponsiveNeuronsCoa,1)
    ave = [];
    att = [];
    ave = nansum(responsesAll(idxC,1:5),2);
    att = nansum(responsesAll(idxC,6:10),2);
    if twoPlusResponsiveNeuronsCoa(idxC) == 1
        if ave > 0 && att > 0
            singleClassCoa(idxC) = -1;
        else
            singleClassCoa(idxC) = 1;
        end
    end
end

proportionSingleClassCoa = nansum(singleClassCoa>0) ./ sum(twoPlusResponsiveNeuronsCoa>0);
proportionTwoClassesCoa = nansum(singleClassCoa<0) ./ sum(twoPlusResponsiveNeuronsCoa>0);

c = 0;
for idxExp = 1 : length(pcxAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end

responsesAll = nan(c,10);
c = 0;
for idxExp = 1 : length(pcxAA.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:10
                    if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        responsesAll(c,idxOdor) = 1;
                    end
                end
            end
        end
    end
end

sumResponses = nansum(responsesAll,2);
twoPlusResponsiveNeuronsPcx = sumResponses > 1;
singleClassPcx = nan(size(twoPlusResponsiveNeuronsPcx,1),1);
for idxC = 1:size(twoPlusResponsiveNeuronsPcx,1)
    ave = [];
    att = [];
    ave = nansum(responsesAll(idxC,1:5));
    att = nansum(responsesAll(idxC,6:10));
    if twoPlusResponsiveNeuronsPcx(idxC) == 1
        if ave > 0 && att > 0
            singleClassPcx(idxC) = -1;
        else
            singleClassPcx(idxC) = 1;
        end
    end
end

proportionSingleClassPcx = nansum(singleClassPcx>0) ./ sum(twoPlusResponsiveNeuronsPcx>0);
proportionTwoClassesPcx = nansum(singleClassPcx<0) ./ sum(twoPlusResponsiveNeuronsPcx>0);
            

%% number of odors for 4-classes neurons VS 5-classes neurons
c = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end


responsesAll = nan(c,15);
c = 0;
for idxExp = 1 : length(coa15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(coa15.esp(idxExp).shankNowarp(idxShank).cell)
            if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:15
                    if coa15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        responsesAll(c,idxOdor) = 1;
                    end
                end
            end
        end
    end
end

respClassesCoa = zeros(c,5);
app = 0;
for i = 1:5
    from = app + 1;
    to = from + 2;
    app = to;
    respClassesCoa(:,i) = nansum(responsesAll(:,from:to),2);
end

nResponsiveOdorsCoa = sum(respClassesCoa,2);
nResponsiveClassesCoa = respClassesCoa > 0;
nResponsiveClassesCoa = sum(nResponsiveClassesCoa,2);
idx4Coa = find(nResponsiveClassesCoa == 4);
idx5Coa = find(nResponsiveClassesCoa == 5);

nOdors4ClassesCoa = nResponsiveOdorsCoa(idx4Coa);
nOdors5ClassesCoa = nResponsiveOdorsCoa(idx5Coa);

mean_nOdors4ClassesCoa = mean(nOdors4ClassesCoa)
mean_nOdors5ClassesCoa = mean(nOdors5ClassesCoa)
[h, p] = ttest2(nOdors4ClassesCoa, nOdors5ClassesCoa)



c = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
end


responsesAll = nan(c,15);
c = 0;
for idxExp = 1 : length(pcx15.esp)
    for idxShank = 1:4
        for idxUnit = 1:length(pcx15.esp(idxExp).shankNowarp(idxShank).cell)
            if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
                for idxOdor = 1:15
                    if pcx15.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        responsesAll(c,idxOdor) = 1;
                    end
                end
            end
        end
    end
end

respClassesPcx = zeros(c,5);
app = 0;
for i = 1:5
    from = app + 1;
    to = from + 2;
    app = to;
    respClassesPcx(:,i) = nansum(responsesAll(:,from:to),2);
end

nResponsiveOdorsPcx = sum(respClassesPcx,2);
nResponsiveClassesPcx = respClassesPcx > 0;
nResponsiveClassesPcx = sum(nResponsiveClassesPcx,2);
idx4Pcx = find(nResponsiveClassesPcx == 4);
idx5Pcx = find(nResponsiveClassesPcx == 5);

nOdors4ClassesPcx = nResponsiveOdorsPcx(idx4Pcx);
nOdors5ClassesPcx = nResponsiveOdorsPcx(idx5Pcx);
mean_nOdors4ClassesPcx = mean(nOdors4ClassesPcx)
mean_nOdors5ClassesPcx = mean(nOdors5ClassesPcx)
[h, p] = ttest2(nOdors4ClassesPcx, nOdors5ClassesPcx)

%%

for idxExp = 1 : length(coaAA.esp)
    c = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
            if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
    totCellsCoa(idxExp) = c;
end
    
for idxOdor = 1:10
    for idxShank = 1:4
        responsiveCells = [];
        for idxExp = 1 : length(coaAA.esp)
            j = 0;
            for idxUnit = 1:length(coaAA.esp(idxExp).shankNowarp(idxShank).cell)
                if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                    if coaAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        j = j + 1;
                    end
                end
            end
            responsiveCells(idxExp) = j/totCellsCoa(idxExp);
        end
        meanResponsiveCellsCoa(idxOdor, idxShank) = mean(responsiveCells);
        semResponsiveCellsCoa(idxOdor, idxShank) = std(responsiveCells)./ sqrt(length(coaAA.esp)-1);
    end
end



for idxExp = 1 : length(pcxAA.esp)
    c = 0;
    for idxShank = 1:4
        for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
            if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                c = c + 1;
            end
        end
    end
    totCellsPcx(idxExp) = c;
end

for idxOdor = 1:10
    for idxShank = 1:4
        responsiveCells = [];
        for idxExp = 1 : length(pcxAA.esp)
            j = 0;
            for idxUnit = 1:length(pcxAA.esp(idxExp).shankNowarp(idxShank).cell)
                if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                    if pcxAA.esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms > 0
                        j = j + 1;
                    end
                end
            end
            responsiveCells(idxExp) = j/totCellsPcx(idxExp);
        end
        meanResponsiveCellsPcx(idxOdor, idxShank) = mean(responsiveCells);
        semResponsiveCellsPcx(idxOdor, idxShank) = std(responsiveCells)./ sqrt(length(pcxAA.esp)-1);
    end
end

