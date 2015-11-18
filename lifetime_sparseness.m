function ls = lifetime_sparseness(rspIntensity, num, odors);

rspIntensity(rspIntensity(:)<0) = 0;
ls = zeros(1,num);
for k = 1:num
    a = 0;
    b = 0;
    for j = 1:odors
        a = a + abs(rspIntensity(k,j))/odors;
        b = b + rspIntensity(k,j)^2/odors;
    end
    
    a = a^2;
    
    ls(k) = (1 - (a/b)) / (1 - 1/odors);
end
