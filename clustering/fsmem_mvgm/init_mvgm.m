function [M , S , P] = init_mvgm(Z , K)

%
% [M , S , P] = init_mvgm(Z , K);
%
%

% initialize parameters

N      = size(Z , 2);

P      = permute((1/K)*ones(1 , K) , [1 3 2]);

idx    = ceil(rand(1 , K)*N);

M      = permute(Z(: , idx) , [1 3 2]);

datvar = diag(var(Z , 0 , 2))/40; % a dxd diagonal matrix containing the data variance

S      = datvar(: , : , ones(1 , K));
