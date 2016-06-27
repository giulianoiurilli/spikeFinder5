wf = [];
all_wf = [];
X = espWCoa;
for idxExp = 1:length(X)
    for idxShank = 1:4
        for idxUnit = 1:length(X(idxExp).waveforms{idxShank}.unit)
             app = X(idxExp).waveforms{idxShank}.unit{idxUnit}.waveform;
             all_wf = [all_wf; app];
             if sum(isnan(app) == 1)
                 app1 = app(1:64);
             else
                app1 = app; 
             end
             big_wf = [repmat(app1(1),1,10), app1, repmat(app1(end),1,10)];
            [~, min_wf] = min(big_wf);
            wf = [wf; big_wf(min_wf-9:min_wf+23)];
        end
    end
end

Y = espWPcx;
for idxExp = 1:length(Y)
    for idxShank = 1:4
        for idxUnit = 1:length(Y(idxExp).waveforms{idxShank}.unit)
             app = Y(idxExp).waveforms{idxShank}.unit{idxUnit}.waveform;
             all_wf = [all_wf; app];
             if sum(isnan(app) == 1)
                 app1 = app(1:64);
             else
                 app1 = app;
             end
             big_wf = [repmat(app1(1),1,30), app1, repmat(app1(end),1,30)];
            [~, min_wf] = min(big_wf);
            wf = [wf; big_wf(min_wf-9:min_wf+23)];
        end
    end
end

%%
fs = 20000;
idxU = 0;
for idxUnit = 1:size(wf,1)
    if min(wf)<-0.4
        idxU = idxU+1;
    [pr(idxU),ppd(idxU), deltaT(idxU), had(idxU)] = spike_features(wf(idxUnit,6:25),fs);
    end
end

figure;
plot(pr, deltaT, 'k.')
axis square

figure;
histogram(had, 20)

deltaT1 = sort(deltaT);
figure;
histogram((deltaT(1:1239)+0.0001)*1000, 20)



    