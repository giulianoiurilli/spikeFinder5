function auR = findAuROC(bslVect, rspVect)


%rspVect, bslVect: number of spikes in the bin for each trial


rep = 200;
auR = 0.5 * ones(1,rep);

for idxRep = 1:rep
    idxTestBsl = randi(size(bslVect,1),ceil(size(bslVect,1)*0.2),1);
    idxTestRsp = randi(size(rspVect,1),ceil(size(rspVect,1)*0.2),1);
    bslVectT = bslVect(idxTestBsl);
    rspVectT = rspVect(idxTestRsp);
    criterion = linspace(0,max([rspVectT(:)' bslVectT(:)']), 20);
    criterion = criterion(end:-1:1);
    
    criterion = [criterion -1]; %to reach 1
    
    if numel(criterion) < 2
        auR(idxRep) = 0.5;
    else
        
        tp = zeros(length(criterion),1);
        fp = zeros(length(criterion),1);
        
        counter = 1;
        for idxCrit = criterion
            tp(counter) = sum(rspVectT > idxCrit)/numel(rspVectT(:));
            fp(counter) = sum(bslVectT > idxCrit)/numel(bslVectT(:));
            counter = counter+1;
        end
        
        auR(idxRep) = trapz(fp, tp);
    end
end

auR = median(auR);