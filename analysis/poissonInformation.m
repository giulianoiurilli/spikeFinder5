function I = poissonInformation(A) 

Aall = reshape(A, size(A,1)*size(A,2), 1);

if var(Aall) > 0
    l2All =  1 - sqrt(mean(Aall)./var(Aall));
else
    l2All = 0;
end
l1All = mean(Aall) * (1 - l2All);

px = zeros(size(A,2) .* size(A,1),1);
idx = 0;
for idxStim = 1:size(A,2)
    if var(A(:,idxStim)) > 0
        l2 = 1 - sqrt(mean(A(:,idxStim))./var(A(:,idxStim)));
    else
        l2 = 0;
    end
    l1 = mean(A(:,idxStim)) * (1 - l2);
    for idxTrial = 1:size(A,1)
        pxt = l1 * (l1 + A(idxTrial, idxStim) * l2)^(A(idxTrial, idxStim) - 1) * exp(-l1 -(A(idxTrial, idxStim) * l2)) ./ factorial(A(idxTrial, idxStim));
        pxt0 = l1All * (l1All + A(idxTrial, idxStim) * l2All)^(A(idxTrial, idxStim) - 1) * exp(-l1All -(A(idxTrial, idxStim) * l2All)) ./ factorial(A(idxTrial, idxStim));
        idx = idx + 1;
        px(idx) = log2(pxt ./ pxt0);
    end
end

px = px(px == real(px));
px = sum(px);
if px < 0
    px = 0;
end

if sum(Aall) > 1
    I = px ./ sum(Aall);
else
    I = 0;
end