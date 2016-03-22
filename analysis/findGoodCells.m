odorsRearranged = 1:15;
%odorsRearranged = [2 3 1 4 5 6 7 8 9 10 11 12 13 14 15];%concseries
odors = length(odorsRearranged);
c = 0;
g = 0;
for idxExp =  1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            c = c + 1;
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                R = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                R = R > 0;
                appR(idxO) = sum(R);
                B = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
                B = B > 0;
                appB(idxO) = sum(B);
            end
            appR = appR > length(R)./2;
            appR = sum(appR);
            appB = appB > length(B)./2;
            appB = sum(appB);
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good = 0;
            if appR > 0 || appB > odors-1
                esp(idxExp).shankNowarp(idxShank).cell(idxUnit).good = 1;
                g = g + 1;
            end 
        end
    end
end

c
g
g/c

save('plCoA_concseries_AreaNew2.mat', 'esp', '-append')