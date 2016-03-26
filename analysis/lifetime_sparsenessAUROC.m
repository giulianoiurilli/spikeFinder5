function ls = lifetime_sparsenessAUROC(rspIntensity)



odors = length(rspIntensity);

A = rspIntensity.*10;
a = 0;
b = 0;
for j = 1:odors
    a = a + abs(A(j))/odors;
    b = b + A(j)^2/odors;
end

a = a^2;

ls = (1 - (a/b)) / (1 - 1/odors);



