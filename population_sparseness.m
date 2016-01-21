function ps = population_sparseness(rspIntensity);

rspIntensity(rspIntensity(:)<0) = 0;
rep = 200;
ps = zeros(1,rep);
cells = size(rspIntensity,2);

A = rspIntensity;

for idxRep = 1:rep
    idxTest = randi(size(A,1),ceil(size(A,1)*0.8),1);
    Atest = A(idxTest,:);
    Atest = mean(Atest);


    a = 0;
    b = 0;
    for j = 1:cells
        a = a + abs(Atest(j))/cells;
        b = b + Atest(j)^2/cells;
    end
    
    a = a^2;
    
    ps(idxRep) = (1 - (a/b)) / (1 - 1/cells);
end

ps = mean(ps);

