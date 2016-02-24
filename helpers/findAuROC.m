function [auR, significance] = findAuROC(bslVect, rspVect)

%rspVect, bslVect: number of spikes in the bin for each trial
% rspVect = [0, 0, 0, 2, 0, 0, 0, 0, 0, 0];
% bslVect = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
%auR = 0.5;
bslVect = double(bslVect);
rspVect = double(rspVect);
reps = 1000;
labels = [zeros(1,length(bslVect)) ones(1,length(rspVect))]';
scores = [bslVect'; rspVect'];
auR = fastAUC(labels, scores, 1);
my_auR_bs = nan*ones(1,reps);
for j = 1:reps
%     permScores = scores(randperm(length(scores)));
%     my_auR_bs(j) = fastAUC(labels, permScores, 1);
    permLabels = labels(randperm(length(scores)));
    my_auR_bs(j) = fastAUC(permLabels, scores, 1);
end
percentiles = prctile(my_auR_bs, [2.5 97.5]);
if auR > 0.5
    if auR > percentiles(2)
        significance = 1;
    else
        significance = 0;
    end
else
    if auR < percentiles(1)
        significance = -1;
    else
        significance = 0;
    end
end



%%
% auR = 0.5;
% bslVectT = bslVect;
% rspVectT = rspVect;
% criterion = linspace(0,max([rspVectT(:)' bslVectT(:)']), 20);
% criterion = criterion(end:-1:1);
% 
% criterion = [criterion -1]; %to reach 1
% 
% if numel(criterion) < 2
%     auR = 0.5;
% else
%     tp = zeros(length(criterion),1);
%     fp = zeros(length(criterion),1);
%     
%     counter = 1;
%     for idxCrit = criterion
%         tp(counter) = sum(rspVectT > idxCrit)/numel(rspVectT(:));
%         fp(counter) = sum(bslVectT > idxCrit)/numel(bslVectT(:));
%         counter = counter+1;
%     end
%     
%     auR = trapz(fp, tp);
% end
% 
% newVector = [bslVectT, rspVectT];



%% OLD - slower
% rep = 100;
% auR = 0.5 * ones(1,rep);
% 
% for idxRep = 1:rep
%     idxTestBsl = randi(size(bslVect,2),ceil(size(bslVect,2)*0.8),1);
%     idxTestRsp = randi(size(rspVect,2),ceil(size(rspVect,2)*0.8),1);
%     bslVectT = bslVect(idxTestBsl);
%     rspVectT = rspVect(idxTestRsp);
%     criterion = linspace(0,max([rspVectT(:)' bslVectT(:)']), 20);
%     criterion = criterion(end:-1:1);
%     
%     criterion = [criterion -1]; %to reach 1
%     
%     if numel(criterion) < 2
%         auR(idxRep) = 0.5;
%     else
%         
%         tp = zeros(length(criterion),1);
%         fp = zeros(length(criterion),1);
%         
%         counter = 1;
%         for idxCrit = criterion
%             tp(counter) = sum(rspVectT > idxCrit)/numel(rspVectT(:));
%             fp(counter) = sum(bslVectT > idxCrit)/numel(bslVectT(:));
%             counter = counter+1;
%         end
%         
%         auR(idxRep) = trapz(fp, tp);
%     end
% end
% 
% auR = median(auR);
