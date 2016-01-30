odorsRearranged = 1:15;
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
                odorsRearranged = keepNewOrder(idxesp,:);
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
for idxShank = 1:4
%     for idxRep = 1:1000
%         idx = randperm(length(esp),10);
        app = zeros(length(odorsRearranged), length(esp));
        idxespe = 0;
        for idxesp = 1:length(esp)
            idxespe = idxespe+1;
            app(:,idxespe) = mouse(idxesp).tun(:,idxShank);
        end
        app1 = pdist(app', 'spearman');
        rho = 1 - app1;
        shankCorr{idxShank} = rho;
        shankCorrMean(idxShank) = nanmean(rho);
        shankCorrSem(idxShank) = nanstd(rho)./sqrt(length(esp)-1);
%     end
end
    