


odorRates = [2 4 7; 5 8 15];
Gvar = [0.7 0.7];
for c = 1:2
    varG = Gvar(c);
    A = [];
    for odor = 1:3
        lambda = odorRates(c,odor);
        r = 1/varG;
        s = varG;
        T = 200;
        Np = nan(1,T);
        Nnp = nan(1,T);
        for k = 1:T
            g = gamrnd(r, s);
            fr = g*lambda;
            Nnp(k) = poissrnd(fr);
        end
        A(:,odor) = Nnp(:);
        countMean(c,odor) = mean(Nnp);
        countVar(c,odor) = var(Nnp);
    end
    
    poissonInformation(A)
end



colors = [254,224,210;...
222,45,38]./255;
figure
hold on
clear X Y
for k = 1:2
    X = countMean(k,:);
    Y = countVar(k,:);
    plot(X, Y, 'o', 'MarkerSize', 5, 'MarkerEdgeColor', colors(k,:), 'MarkerFaceColor', colors(k,:))
end
hold off
