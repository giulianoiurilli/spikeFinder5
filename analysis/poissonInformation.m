function I = poissonInformation(A) 

Aall = reshape(A, size(A,1)*size(A,2), 1);

l2All =  1 - sqrt(mean(Aall)./var(Aall));
l1All = mean(Aall) * (1 - l2All);

px = 0;
for idxStim = 1:size(A,2)
    l2 = 1 - sqrt(mean(A(:,idxStim))./var(A(:,idxStim)));
    l1 = mean(A(:,idxStim)) * (1 - l2);
    for idxTrial = 1:size(A,1)
        pxt = l1 * (l1 + A(idxTrial, idxStim) * l2)^(A(idxTrial, idxStim) - 1) * exp(-l1 -(A(idxTrial, idxStim) * l2)) ./ factorial(A(idxTrial, idxStim));
        pxt0 = l1All * (l1All + A(idxTrial, idxStim) * l2All)^(A(idxTrial, idxStim) - 1) * exp(-l1All -(A(idxTrial, idxStim) * l2All)) ./ factorial(A(idxTrial, idxStim));
        px = px + log2(pxt ./ pxt0);
    end
end

I = px ./ sum(Aall);