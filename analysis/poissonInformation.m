function I = poissonInformation(A) 

Aall = reshape(A, size(A,1)*size(A,2), 1);

if var(Aall) > 0
    mediaAll = mean(Aall);
    varianzaAll = var(Aall);
    l2All =  1 - sqrt(mediaAll./varianzaAll);
else
    l2All = 0;
end
l1All = mean(Aall) * (1 - l2All);

px = zeros(size(A,2) .* ceil(size(A,1)*0.2),1);

rep = 100;
steps = 10;
I = zeros(steps,rep);
idxa = 0;
for a = linspace(0,1,steps)
    idxa = idxa + 1;
    
    for idxRep = 1:rep
        idxTest = randi(size(A,1),ceil(size(A,1)*0.2),1);
        Atest = A(idxTest,:);
        Atrain = A;
        Atrain(idxTest,:) = [];
        idx = 0;
        for idxStim = 1:size(A,2)
            if var(Atrain(:,idxStim)) > 0
                media = (1-a) * mean(Atrain(:,idxStim)) + a * mediaAll;
                varianza = (1-a) * var(Atrain(:,idxStim)) + a * varianzaAll;
                l2 = 1 - sqrt(media./varianza);
            else
                l2 = 0;
            end
            l1 = mean(Atrain(:,idxStim)) * (1 - l2);
            for idxTrial = 1:size(Atest,1)
                pxt = l1 * (l1 + Atest(idxTrial, idxStim) * l2)^(Atest(idxTrial, idxStim) - 1) * exp(-l1 -(Atest(idxTrial, idxStim) * l2)) ./ factorial(Atest(idxTrial, idxStim));
                pxt0 = l1All * (l1All + Atest(idxTrial, idxStim) * l2All)^(Atest(idxTrial, idxStim) - 1) * exp(-l1All -(Atest(idxTrial, idxStim) * l2All)) ./ factorial(Atest(idxTrial, idxStim));
                idx = idx + 1;
                px(idx) = log2(pxt ./ pxt0);
            end
        end
        
        px(isnan(px)) = 0;
        px = px(px == real(px));
        px = sum(px);
        if px < 0
            px = 0;
        end
        
        if sum(Atest(:)) > 1
            I(idxa,idxRep) = px ./ sum(Atest(:));
        else
            I(idxa,idxRep) = 0;
        end
    end
end
% I = mean(I,2);
% I = max(I);