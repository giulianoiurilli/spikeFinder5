responses = [];
totUnits = 0;
responsiveUnits = 0;
cellsInShank = [0 0 0 0];
for idxExp = 1:length(List)
    idxCell = 0;
    for idxShank = [1 3 4]
        for idxUnit = 1:length(exp(idxExp).shank(idxShank).cell)
            exc = [];
            for idxOdor = 1:odors
                app1 = [];
                app1 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax > 0.75);
                app2 = [];
                app2 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1:4) > 0);
                app3 = [];
                app3 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1:4) > 0);
                app4 = [];
                app4 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).aurocMax < 0.4);
                %app5 = [];
                %app5 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).peakDigitalResponsePerCycle(1:4) < 0);
                app6 = [];
                app6 = find(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleDigitalResponsePerCycle(1:4) < 0);
                if (~isempty(app1) && ~isempty(app2)) || (~isempty(app1) && ~isempty(app3))%~isempty(app1)%
                    exc = 1;
                end
            end
            if ~isempty(exc)
                responsiveUnits = responsiveUnits + 1;
                cellsInShank(idxShank) = cellsInShank(idxShank) + 1;
                for idxOdor = 1:odors
                responses(idxOdor,responsiveUnits) = max(exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).fullCycleAnalogicResponsePerCycle(1:4));
%                 for idxTrial = 1:5
%                     ncycles(1).D(idxTrial).data(responsiveUnits,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,360*4 + 1:360*5);
%                     ncycles(2).D(idxTrial).data(responsiveUnits,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,360*5 + 1:360*6);
%                     ncycles(3).D(idxTrial).data(responsiveUnits,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,360*6 + 1:360*7);
%                     ncycles(5).D(idxTrial).data(responsiveUnits,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,360*7 + 1:360*8);
%                     ncycles(5).D(idxTrial).data(responsiveUnits,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,360*8 + 1:360*9);
%                     ncycles(6).D(idxTrial).data(responsiveUnits,:) = exp(idxExp).shank(idxShank).cell(idxUnit).odor(idxOdor).spikeMatrix(idxTrial,360*3 + 1:360*7);
%                 end
                end
            end
            totUnits = totUnits + 1;
        end
    end
end



%%

responses = responses';
listOdors = {'TMT^-4', 'DMT^-4','MT^-4','IBA^-4','IAA^-4','HXD^-4','BTD^-4',...
    'TMT^-2',  'DMT^-2',  'MT^-2','IBA^-2',  'IAA^-2',  'HXD^-2',  'BTD^-2', 'rose'};
figure()
boxplot(responses, 'orientation', 'horizontal', 'labels', listOdors)
c = corr(responses, responses); figure; imagesc(c); axis square

w = 1./var(responses);
%[wcoeff, score, latent, tsquared, explained] = pca(responses, 'VariableWeights', w);
[wcoeff, score, latent, tsquared, explained] = pca(responses);
figure()
pareto(explained)
%coefforth = diag(sqrt(w))*wcoeff;
coefforth = wcoeff;
cscores = zscore(responses)*coefforth;



             
figure()
biplot(coefforth(:,1:2), 'scores', score(:,1:2), 'varlabels', listOdors, 'markersize', 15);

%% 
zresponses = responses';
zresponses = zscore(zresponses);
c = corr(zresponses, zresponses); figure; imagesc(c); axis square


%%

[loadings, specificVars, T, stats] = factoran(responses, 2, 'rotate', 'none');
stats.p

