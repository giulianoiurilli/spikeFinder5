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
for idxUnit = 1:size(wf,1)
    [pr(idxUnit),ppd(idxUnit), deltaT(idxUnit)] = spike_features(wf(idxUnit,:),fs);
end

figure;
plot(pr, deltaT, '.')
axis square




    