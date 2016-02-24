tic
% X = esp(1).shankNowarp(1).cell(3).odor(8).AnalogicResponse1000ms;
% Y = esp(1).shankNowarp(1).cell(3).odor(8).AnalogicBsl1000ms;

Y = [5 8 3 9 3 0 8 9 3 6];
X = [0 0 1 0 3 0 0 1 1 0];
labels = [zeros(1,10) ones(1,10)]';
resp = [X'; Y'];
%my_auR = findAuROC(Y, X)
%[~,~,~,my_auR] = perfcurve(labels, resp, 1)
my_auR = fastAUC(labels, resp, 1)

n = length(resp);
my_auR_bs = nan*ones(1,500);
for i = 1:500
    Z1 = resp(randperm(n));
%     Y1 = Z1(6:10);
%     X1 = Z1(1:5);
%     my_auR_bs(i) = findAuROC(Y1, X1);
    %[~,~,~,my_auR_bs(i)] = perfcurve(labels, Z1, 1);
    my_auR_bs(i) = fastAUC(labels, Z1, 1);
end



    
    
percentiles = prctile(my_auR_bs, [2.5 97.5]);
if my_auR > 0.5
    if my_auR > percentiles(2)
        disp('1')
    else
        disp('0')
    end
else
    if my_auR < percentiles(1)
        disp('1')
    else
        disp('0')
    end
end
toc