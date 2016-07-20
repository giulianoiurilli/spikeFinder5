clear data
odors = 1:15;
params.boxwidth = 100;
params.alignTime = 15000;
esp = [];
espe = [];
esp = pcx15.esp;
espe = pcx151.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = odors
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
esp = pcxAA.esp;
espe = pcxAA1.espe;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = odors
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
c
ResultPcx1000 = VarVsMean(data, 14000:1000:19000, params);

%%
odors = 1:15;
esp = coa15.esp;
espe = coa151.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = odors
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
esp = coaAA.esp;
espe = coaAA1.espe;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = odors
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
c
ResultCoa1000 = VarVsMean(data, 14000:1000:19000, params);

%%
figure;
shadedErrorBar(ResultCoa1000.times, ResultCoa1000.FanoFactor, ResultCoa1000.Fano_95CIs, 'r');
hold on
shadedErrorBar(ResultPcx1000.times, ResultPcx1000.FanoFactor, ResultPcx1000.Fano_95CIs, 'k');
alpha('0.5')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
clear data
odors = 1:15;
params.boxwidth = 100;
params.alignTime = 15000;
esp = pcx15.esp;
espe = pcx151.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = odors
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
esp = pcxAA.esp;
espe = pcxAA1.espe;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = odors
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end

ResultPcx50 = VarVsMean(data, 13000:50:20000, params);

%%
odors = 1:15;
esp = coa15.esp;
espe = coa151.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = odors
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
esp = coaAA.esp;
espe = coaAA1.espe;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = odors
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end

ResultCoa50 = VarVsMean(data, 13000:50:20000, params);

%%
figure;
shadedErrorBar(ResultCoa50.times, ResultCoa50.FanoFactor, ResultCoa50.Fano_95CIs, 'r');
hold on
shadedErrorBar(ResultPcx50.times, ResultPcx50.FanoFactor, ResultPcx50.Fano_95CIs, 'k');
alpha('0.5')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
clear data
params.boxwidth = 200;
params.alignTime = 15000;
esp = pcx15.esp;
espe = pcx151.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = [4 9]
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
esp = pcxCS.esp;
espe = pcxCS1.espe;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = [5 10 15]
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
ResultPcx50Neut = VarVsMean(data, 14000:50:19000, params);

clear data
esp = pcxAA.esp;
espe = pcxAA1.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = [1:5]
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                       % end
                    end
                end
            end
        end
    end
end
ResultPcx50Ave = VarVsMean(data, 14000:50:19000, params);


clear data
esp = pcxAA.esp;
espe = pcxAA1.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = [6:10]
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                       % end
                    end
                end
            end
        end
    end
end
ResultPcx50Ape = VarVsMean(data, 14000:50:19000, params);

%%
clear data
esp = coa15.esp;
espe = coa151.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = [4 9]
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
esp = coaCS.esp;
espe = coaCS1.espe;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = [5 10 15]
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
Resultcoa50Neut = VarVsMean(data, 14000:50:19000, params);

clear data
esp = coaAA.esp;
espe = coaAA1.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = [1:5]
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
Resultcoa50Ave = VarVsMean(data, 14000:50:19000, params);


clear data
esp = coaAA.esp;
espe = coaAA1.espe;
c = 0;
for idxExp =  1:length(esp)
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good == 1
                for idxOdor = [6:10]
                    if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).DigitalResponse1000ms == 1;
                        %if esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).auROC1000ms > 0.5;
                            c = c + 1;
                            data(c).spikes = espe(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix;
                        %end
                    end
                end
            end
        end
    end
end
Resultcoa50Ape = VarVsMean(data, 14000:50:19000, params);

%%
figure
%shadedErrorBar(Resultcoa50Neut.times, Resultcoa50Neut.FanoFactor, Resultcoa50Neut.Fano_95CIs,  'b');
plot(Resultcoa50Neut.times, Resultcoa50Neut.FanoFactor,  'b');
hold on
%shadedErrorBar(Resultcoa50Ave.times, Resultcoa50Ave.FanoFactor, Resultcoa50Ave.Fano_95CIs,  'r');
plot(Resultcoa50Ave.times, Resultcoa50Ave.FanoFactor,  'r');
%alpha('0.5')
hold on
%shadedErrorBar(Resultcoa50Ape.times, Resultcoa50Ape.FanoFactor, Resultcoa50Ape.Fano_95CIs,  'g');
plot(Resultcoa50Ape.times, Resultcoa50Ape.FanoFactor,  'g');
%alpha('0.5')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)

figure
%shadedErrorBar(ResultPcx50Neut.times, ResultPcx50Neut.FanoFactor, ResultPcx50Neut.Fano_95CIs,  'b');
plot(ResultPcx50Neut.times, ResultPcx50Neut.FanoFactor,  'b');
hold on
%shadedErrorBar(ResultPcx50Ave.times, ResultPcx50Ave.FanoFactor, ResultPcx50Ave.Fano_95CIs,  'r');
plot(ResultPcx50Ave.times, ResultPcx50Ave.FanoFactor,  'r');
%alpha('0.5')
hold on
%shadedErrorBar(ResultPcx50Ape.times, ResultPcx50Ape.FanoFactor, ResultPcx50Ape.Fano_95CIs,  'g');
plot(ResultPcx50Ape.times, ResultPcx50Ape.FanoFactor,  'g');
%alpha('0.5')
set(gcf,'color','white', 'PaperPositionMode', 'auto');
set(gca, 'box', 'off', 'tickDir', 'out', 'fontname', 'avenir', 'fontsize', 14)
%%
% figure
% scatter(ResultCoa1000.scatterDataAll(3).mn, ResultCoa1000.scatterDataAll(3).var)
% numel(ResultCoa1000.scatterDataAll(3).mn)
% mean(ResultCoa1000.scatterDataAll(3).var)/mean(ResultCoa1000.scatterDataAll(3).mn)