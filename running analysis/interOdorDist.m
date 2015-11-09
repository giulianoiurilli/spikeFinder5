
stringa{1} = 'responses_3low.mat';
stringa{2} = 'responses_3mediumlow.mat';
stringa{3} = 'responses_3medium.mat';
stringa{4} = 'responses_3mediumhigh.mat';
stringa{5} = 'responses_3high.mat';
%%
dist4 = [];
dist300 = [];
for idxConc = 1:5
    load(stringa{idxConc});
    for idxExp = unique(trackExperiment4(:,1))'
        
        BBB = responses4MinusMean(trackExperiment4(:,1)==idxExp,:); %controllare dove va l'indice
        BBB = BBB';
        %BBB = bsxfun(@minus, BBB, nanmean(BBB)) ./  repmat(diag(sqrt(BBB'*BBB))', 3,1);
        %BBB = zscore(BBB);
        
        % n_rep = 500;
        % for idxRep = 1:n_rep
        %     idx = randperm(size(BBB,1));
        %     idx = idx(1:90);
        %     X = BBB(idx,:);
        %     D4 = pdist(X', 'correlation');
        %     dist4(idxRep) = mean(D4);
        % end
        app = nanmean(pdist(BBB, 'correlation'));
        dist4(idxExp) = app;
        
        BBB = responses300MinusMean(trackExperiment300(:,1)==idxExp,:); %controllare dove va l'indice;
        BBB = BBB';
        %BBB = bsxfun(@minus, BBB, nanmean(BBB)) ./  repmat(diag(sqrt(BBB'*BBB))', 3,1);
        %BBB = zscore(BBB);

        % n_rep = 500;
        % for idxRep = 1:n_rep
        %     idx = randperm(size(BBB,1));
        %     idx = idx(1:90);
        %     X = BBB(idx,:);
        %     D300 = pdist(X', 'correlation');
        %     dist300(idxRep) = nanmean(D300);
        % end
        app = nanmean(pdist(BBB, 'correlation'));
        dist300(idxExp) = app;
    end
    interOdorDist4(idxConc,:) = [nanmean(dist4), nanstd(dist4)/sqrt(length(dist4))];
    interOdorDist300(idxConc,:) = [nanmean(dist300), nanstd(dist300)/sqrt(length(dist300))];
end

% Ldist4_mean = mean(dist4);
% Ldist4_75 = prctile(dist4,75);
% Ldist4_25 = prctile(dist4,25);
% 
% Ldist300_mean = mean(dist300);
% Ldist300_75 = prctile(dist300,75);
% Ldist300_25 = prctile(dist300,25);

%%
% interOdorDist4 = zeros(3, 5);
% interOdorDist300 = zeros(3, 5);
% 
% interOdorDist4(1,1) = Ldist4_mean;
% interOdorDist4(1,2) = MLdist4_mean;
% interOdorDist4(1,3) = Mdist4_mean;
% interOdorDist4(1,4) = MHdist4_mean;
% interOdorDist4(1,5) = Hdist4_mean;
% 
% interOdorDist4(2,1) = Ldist4_75;
% interOdorDist4(2,2) = MLdist4_75;
% interOdorDist4(2,3) = Mdist4_75;
% interOdorDist4(2,4) = MHdist4_75;
% interOdorDist4(2,5) = Hdist4_75;
% 
% interOdorDist4(3,1) = Ldist4_25;
% interOdorDist4(3,2) = MLdist4_25;
% interOdorDist4(3,3) = Mdist4_25;
% interOdorDist4(3,4) = MHdist4_25;
% interOdorDist4(3,5) = Hdist4_25;
% 
% interOdorDist300(1,1) = Ldist300_mean;
% interOdorDist300(1,2) = MLdist300_mean;
% interOdorDist300(1,3) = Mdist300_mean;
% interOdorDist300(1,4) = MHdist300_mean;
% interOdorDist300(1,5) = Hdist300_mean;
% 
% interOdorDist300(2,1) = Ldist300_75;
% interOdorDist300(2,2) = MLdist300_75;
% interOdorDist300(2,3) = Mdist300_75;
% interOdorDist300(2,4) = MHdist300_75;
% interOdorDist300(2,5) = Hdist300_75;
% 
% interOdorDist300(3,1) = Ldist300_25;
% interOdorDist300(3,2) = MLdist300_25;
% interOdorDist300(3,3) = Mdist300_25;
% interOdorDist300(3,4) = MHdist300_25;
% interOdorDist300(3,5) = Hdist300_25;
%%
save('interOdorDist.mat', 'interOdorDist4', 'interOdorDist300', 'dist4', 'dist300')



