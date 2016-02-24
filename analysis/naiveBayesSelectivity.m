function BS = naiveBayesSelectivity(A) 

rep = 200;
actualLabels = 1:size(A,2);
actualLabels = repmat(actualLabels, ceil(size(A,1)*0.2),1);
actualLabels = actualLabels(:);
l1 = zeros(1,size(A,2));
l2 = zeros(1,size(A,2));
pxt = zeros(1,size(A,2));
TP = nan * ones(rep,1);
for idxRep = 1:rep
    idxTest = randi(size(A,1),ceil(size(A,1)*0.2),1);
    Atest = A(idxTest,:);
    Atrain = A;
    Atrain(idxTest,:) = [];
    indMax = nan * ones(size(Atest,1) * size(Atest,2), 1);
    for idxStim = 1:size(A,2)
        if var(Atrain(:,idxStim)) > 0
            media = mean(Atrain(:,idxStim));
            varianza = var(Atrain(:,idxStim));
            l2(idxStim) = 1 - sqrt(media./varianza);
        else
            l2(idxStim) = 0;
        end
        l1(idxStim) = mean(Atrain(:,idxStim)) * (1 - l2(idxStim));
    end
    Atest = Atest(:);
    for idxTest = 1:size(Atest,1) * size(Atest,2)
        countToTest = Atest(idxTest);
        for idxStim = 1:size(A,2)
            pxt(idxStim) = l1(idxStim) .* (l1(idxStim) + countToTest .* l2(idxStim)) .^ (countToTest-1) .* exp(-l1(idxStim) - countToTest .* l2(idxStim)) ./ factorial(countToTest);
        end
        [~, indMax(idxTest)] = max(pxt);
    end
    
    TP(idxRep) = sum(~(actualLabels - indMax)) ./ (size(Atest,1) * size(Atest,2));
end
BS = mean(TP);
        
        
            
            