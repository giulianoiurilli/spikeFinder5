function [varGHat, rHat, sHat, mN_empirical, mN_Hat, varN_empirical, varN_Hat, varGFraction ] = partNeuralVariance(Nnp)
 

% lambda = 12;
% 
% varG = 1;
% r = 1/varG;
% s = varG * lambda;
% 
% T = 1000;
% Np = nan(1,T);
% Nnp = nan(1,T);
% for k = 1:T
%     Np(k) = poissrnd(lambda);
%     Nnp(k) = nbinrnd(r, 1/(1+s));
% end
% 
% figure;
% histogram(Np,0:1:30)
% hold on
% histogram(Nnp,0:1:30)
 
 
Nnp = double(Nnp);

if mean(Nnp) < var(Nnp)
    parmHat = nbinfit(Nnp);
    rHat = parmHat(1);
    pHat = parmHat(2);
    sHat = 1/pHat - 1;
    
    varGHat = 1/rHat; %predicted variance of the state
    mN_empirical = mean(Nnp); %observed mean of the spike count
    mN_Hat = rHat * sHat; %fitted mean of the spike count
    varN_empirical = var(Nnp); %observed variance of the spike count
    varN_Hat = rHat * sHat  + rHat * sHat^2; %fitted variance of the spike count
    varGFraction =  varGHat ./ (varGHat + mN_empirical); %fraction of the variance explained by fluctuations in the excitability
    %varGFraction =  varGHat ./ varN_Hat;
else
    parmHat = poissfit(Nnp);
    varGHat = 0;
    rHat = inf;
    sHat = inf;
    mN_empirical = mean(Nnp);
    mN_Hat = parmHat;
    varN_empirical = var(Nnp);
    varN_Hat = mN_Hat;
    varGFraction = 0;
end
    
    
    
    
    

    

