load('parameters.mat')
odorsRearranged = 1:15;
%odorsRearranged = [8 11 12 5 2 14 4 10]; %COA
% odorsRearranged = [3 8 10 1 13 11 9 14]; %PCX

odors = length(odorsRearranged);
c = 0;
rc = 0;
for idxExp =  1:length(esp) 
    for idxShank = 1:4
        for idxUnit = 1:length(esp(idxExp).shankNowarp(idxShank).cell)
            c = c + 1;
            R = zeros(n_trials, odors);
            B = zeros(n_trials, odors);
            X = zeros(n_trials, odors);
            idxO = 0;
            for idxOdor = odorsRearranged
                idxO = idxO + 1;
                R(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicResponse1000ms';
                B(:, idxO) = esp(idxExp).shankNowarp(idxShank).cell(idxUnit).odor(idxOdor).AnalogicBsl1000ms';
            end
            X = R - B;
            Xj = X(1:end-1,:); Xj = reshape(Xj, 1, size(Xj,1)*size(Xj,2));
            Xk = X(2:end,:); Xk = reshape(Xk, 1, size(Xk,1)*size(Xk,2));
            rho = corr(Xj', Xk');
            esp(idxExp).shankNowarp(idxShank).cell(idxUnit).reliability = rho;
%             if rho < 0.75
                rho_null = zeros(1,1000);
                for idx = 1:1000
                    z = randperm(size(Xk,2));
                    newXk = Xk(z);
                    rho_null(idx) = corr(Xj', newXk');
                end
                rho_big = abs(rho_null) > abs(rho);
                p = sum(rho_big) ./ 1000;
                if p < 0.05
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).isReliable = 1;
                    rc = rc + 1;
                else
                    esp(idxExp).shankNowarp(idxShank).cell(idxUnit).isReliable = 0;
                end
%             else
%                 esp(idxExp).shankNowarp(idxShank).cell(idxUnit).isReliable = 1;
%                 rc = rc + 1;
%             end
        end
    end
end
c
rc
rc/c
save('coa_15_2_2.mat', 'esp', '-append')
                
                    
                    
            
            
            