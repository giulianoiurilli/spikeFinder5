function [Y, P, V, mx]=getpca1(X)

%X: MxN matrix (M dimensions, N trials)
%Y: Y=P*X
%P: the transform matrix
%V: the variance vector

[M,N]=size(X);

mx=mean(X,2);
mx=repmat(mx,1,N);

X=X-mx;

CovX=X*X'/(N-1);

[P,V]=eig(CovX);

V=diag(V);
[t,ind]=sort(-V);
V=V(ind);
P=P(:,ind);
P=P';
Y=P*X;

return;
