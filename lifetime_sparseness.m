function ls = lifetime_sparseness(rspIntensity)



rspIntensity(rspIntensity(:)<0) = 0;
rep = 100;
ls = zeros(1,rep);
odors = size(rspIntensity,2);

A = rspIntensity;

for idxRep = 1:rep
    idxTest = randi(size(A,1),ceil(size(A,1)*0.8),1);
    Atest = A(idxTest,:);
    Atest = mean(Atest);

    a = 0;
    b = 0;
    for j = 1:odors
        a = a + abs(Atest(j))/odors;
        b = b + Atest(j)^2/odors;
    end
    
    a = a^2;
    
    ls(idxRep) = (1 - (a/b)) / (1 - 1/odors);
end

ls = mean(ls);
