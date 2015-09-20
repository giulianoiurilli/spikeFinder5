function ps = population_sparseness(rspIntensity, num, odors);

%rspIntensity(rspIntensity(:)<0) = 0;

for k = 1:odors
    a = 0;
    b = 0;
    for j = 1:num
        a = a + abs(rspIntensity(j,k))/num;
        b = b + rspIntensity(j,k)^2/num;
    end
    
    a = a^2;
    
    ps(k) = (1 - (a/b)) / (1 - 1/num);
end

