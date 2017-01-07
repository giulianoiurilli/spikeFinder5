function ls = lifetime_sparseness(rspIntensity)



odors = size(rspIntensity,2);
A = rspIntensity;
A = mean(A);
A(A<0) = 0;
num = sum((A/odors))^2;
den = sum(A.^2/odors);

if sum(A) == 0
    ls = 1;
else
    ls = 1 - num/den;
end



