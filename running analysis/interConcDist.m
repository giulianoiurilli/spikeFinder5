
stringa{1} = 'responses_pen.mat';
stringa{2} = 'responses_etg.mat';
stringa{3} = 'responses_iaa.mat';

% stringa{1} = 'baselines_pen.mat';
% stringa{2} = 'baselines_etg.mat';
% stringa{3} = 'baselines_iaa.mat';

%%
dist4 = [];
dist300 = [];

for idxO = 1:3
    load(stringa{idxO});
    for idxExp = unique(trackExperiment4(:,1))'
        
        BBB = responses4MinusMean(trackExperiment4(:,1)==idxExp,:); %controllare dove va l'indice
        BBB = BBB';
        %BBB = bsxfun(@minus, BBB, nanmean(BBB)) ./  repmat(diag(sqrt(BBB'*BBB))', 5,1);
        BBB = zscore(BBB);
        
        % n_rep = 500;
        % for idxRep = 1:n_rep
        %     idx = randperm(size(BBB,1));
        %     idx = idx(1:90);
        %     X = BBB(idx,:);
        %     D4 = pdist(X', 'correlation');
        %     dist4(idxRep) = nanmean(D4);
        % end
        app = nanmean(pdist(BBB, 'correlation'));
        dist4 = [dist4 app];
        
        BBB = responses300(trackExperiment300(:,1)==idxExp,:); %controllare dove va l'indice;
        BBB = BBB';
        %BBB = bsxfun(@minus, BBB, nanmean(BBB)) ./  repmat(diag(sqrt(BBB'*BBB))', 5,1);
        BBB = zscore(BBB);

        % n_rep = 500;
        % for idxRep = 1:n_rep
        %     idx = randperm(size(BBB,1));
        %     idx = idx(1:90);
        %     X = BBB(idx,:);
        %     D300 = pdist(X', 'correlation');
        %     dist300(idxRep) = nanmean(D300);
        % end
        app = nanmean(pdist(BBB, 'correlation'));
        dist300 = [dist4 app];
    end
end
interConcDist4 = [nanmean(dist4), nanstd(dist4)/sqrt(length(dist4))];
interConcDist300 = [nanmean(dist300), nanstd(dist300)/sqrt(length(dist300))];

% Ldist4_nanmean = nanmean(dist4);
% Ldist4_75 = prctile(dist4,75);
% Ldist4_25 = prctile(dist4,25);
% 
% Ldist300_nanmean = nanmean(dist300);
% Ldist300_75 = prctile(dist300,75);
% Ldist300_25 = prctile(dist300,25);

%%
% interOdorDist4 = zeros(3, 5);
% interOdorDist300 = zeros(3, 5);
% 
% interOdorDist4(1,1) = Ldist4_nanmean;
% interOdorDist4(1,2) = MLdist4_nanmean;
% interOdorDist4(1,3) = Mdist4_nanmean;
% interOdorDist4(1,4) = MHdist4_nanmean;
% interOdorDist4(1,5) = Hdist4_nanmean;
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
% interOdorDist300(1,1) = Ldist300_nanmean;
% interOdorDist300(1,2) = MLdist300_nanmean;
% interOdorDist300(1,3) = Mdist300_nanmean;
% interOdorDist300(1,4) = MHdist300_nanmean;
% interOdorDist300(1,5) = Hdist300_nanmean;
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
save('interConcDist.mat', 'interConcDist4', 'interConcDist300', 'dist4', 'dist300')



