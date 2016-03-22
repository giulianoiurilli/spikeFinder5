%odorsRearranged = [1 2 5 10 15 7 8];% pcxL
%odorsRearranged = [14 6 4 12 13 3 11 ];% pcxH
%odorsRearranged = [14 6 4 12 13 3 11 9];% pcxH8
%odorsRearranged = [6 1 3 13 12 7 5];% coaL
%odorsRearranged = [14 2 15 4 10 11 8];% coaH
%odorsRearranged = [14 2 15 4 10 11 8 9];% coaH8
odorsRearranged = 1:15;

folder = pwd;
simTun300 = [];
simTun1000 = [];
for idxShank = 1:4
    idxCell300ms = 0;
    A = [];
    A1 = [];
    B = [];
    xxx = 0;
    yyy = 0;
    for idxesp = 1: length(esp) %- 1
        yyy = normrnd(0,1,1,length(odorsRearranged));
        for idxUnit = 1:length(esp(idxesp).shankNowarp(idxShank).cell)
            if esp(idxesp).shankNowarp(idxShank).cell(idxUnit).good == 1
                idxCell300ms = idxCell300ms + 1;
                idxO = 0;               
                for idxOdor = odorsRearranged
                    idxO = idxO + 1;
                    A(idxCell300ms,idxO) = mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse300ms)- mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl300ms);
                    A1(idxCell300ms,idxO) = mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms)- mean(esp(idxesp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms);
                end
                B(idxCell300ms,:) = yyy;
            end
        end
    end
    sigCorr300 = [];
    sigCorr1000 = [];
    sigCorrB = [];
    if size(B,1) > 1;
        B = B';
        %B = zscore(B);
        B = B';
        rho = [];
        rho = pdist(B, 'correlation');
        rho = 1 - rho;
        sigCorrB =  rho;
    end
    if size(A,1) > 1;
        A = A';
        A = zscore(A);
        A = A';
        rho = [];
        rho = pdist(A, 'spearman');
        rho = 1 - rho;
        sigCorr300 = rho;
        sigCorr300(sigCorrB==1) = [];
    end
    if size(A1,1) > 1;    
        A1 = A1';
        A1 = zscore(A1);
        A1 = A1';
        rho = [];
        rho = pdist(A1, 'spearman');
        rho = 1 - rho;
        sigCorr1000 = rho;
        sigCorr1000(sigCorrB==1) = [];
%         figure; imagesc(A1);
%         figure; imagesc(squareform(sigCorr1000))
    end

    simTun300{idxShank} = sigCorr300;
    simTun1000{idxShank} = sigCorr1000;
end

cd(folder)
%save('responses.mat', 'simTun1000', 'simTun300','-append')
        