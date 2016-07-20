function ls = lifetime_sparseness(rspIntensity)



%rspIntensity(rspIntensity(:)<0) = 0;
rep = size(rspIntensity,1);
ls = zeros(1,rep);
odors = size(rspIntensity,2);
A = rspIntensity(:);
A = A + abs(min(A));
A = reshape(A, rep,odors);

%A = rspIntensity + repmat(abs(min(rspIntensity)), rep,1);

for idxRep = 1:rep
    %idxTest = randsample(size(A,1),ceil(size(A,1)*0.8),1);
    %     Atest = A(idxTest,:);
    Atest = A;
    Atest(idxRep,:) = [];
    Atest = mean(Atest);
    %
%     a = 0;
%     b = 0;
%     for j = 1:odors
%         a = a + abs(Atest(j))/odors;
%         b = b + (Atest(j)^2)/odors;
%     end
%     
%     a = a.^2;
    
    ls(idxRep) = 1 - ((sum(abs(Atest))/odors)^2 / (sum(Atest.^2)/odors));
    
    %ls(idxRep) = 1 - (a./b); %(1 - (a/b)) / (1 - 1/odors); 
end

ls = mean(ls);

