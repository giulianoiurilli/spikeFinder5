function auR = findAuROC(bslVect, rspVect)


%rspVect, bslVect: number of spikes in the bin for each trial


criterion = linspace(0,max([rspVect(:)' bslVect(:)']), 20);
criterion = criterion(end:-1:1);

criterion = [criterion -1]; %to reach 1

if numel(criterion) < 2
    auR = 0.5;
else
    
    tp = zeros(length(criterion),1);
    fp = zeros(length(criterion),1);
    
    counter = 1;
    for idxCrit = criterion
        tp(counter) = sum(rspVect > idxCrit)/numel(rspVect(:));
        fp(counter) = sum(bslVect > idxCrit)/numel(bslVect(:));
        counter = counter+1;
    end
    
    %if fp
    
    auR = trapz(fp, tp);
end