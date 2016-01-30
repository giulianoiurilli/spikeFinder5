odorsRearranged = 1:15;
%odorsRearranged = [14 2 15 4 10 11 8 9];% coaH8

folder = pwd;

for idxesp = 1: length(esp)
    T1 = [];
    for idxShank = 1:4
        idxCell300ms = 0;
        A = [];
        A1 = [];
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell300ms = idxCell300ms + 1;
                idxO = 0;

                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    A(idxCell300ms,idxO) = mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms)- mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    A1(idxCell300ms,idxO) = mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)- mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                end
            end
        end
        if isempty(A1)
            A1 = zeros(1,length(odorsRearranged));
        end
%         A = A';
%         A1 = A1';
%         A = zscore(A);
%         A1 = zscore(A1);
%         A = A';
%         A1 = A1';
        if size(A1,1)>1
        A1 = sum(A1);
        end
        T1 = [T1 A1'];
    end
    T1 = zscore(T1);
    mouse(idxesp).tun = T1;
    figure; imagesc(T1)
end


%%
%odorsRearranged = 1:8;
odorsRearranged = 1:15;
keepNewOrder = repmat(odorsRearranged,14,1);
idxExp = 0;
for idxesp = [1 2 3 4 5 6 7 9 10]
    idxExp = idxExp + 1;
    rankings = zeros(1,1000);
    odorOrder = repmat(odorsRearranged,1000,1);
    for idx = 1:1000
        newIdx = randperm(length(odorsRearranged));
%         newIdx = randperm(4) + 4;
%         fiss = 1:4;
%         newIdx = [fiss newIdx];
        odorOrder(idx,:) = odorOrder(idx,newIdx);
        copyT1  = mouse(idxesp).tun;
        newCopyT1  = copyT1(newIdx,:);
        rankings(idx) = corr2(newCopyT1, mouse(8).tun);
    end
    AAA = [odorOrder rankings'];
    AAA = sortrows(AAA, size(AAA,2));
    AAA(:,size(AAA,2)) = [];
    %keepNewOrder(idxExp,:) = AAA(size(AAA,1),:);
    keepNewOrder(idxExp,:) = AAA(1,:);
    copyT1  = mouse(idxesp).tun;
    vedi = copyT1(keepNewOrder(idxExp,:)',:);
    figure; imagesc(vedi)
end