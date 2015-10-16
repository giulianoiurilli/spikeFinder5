function varargout=nshape(X,f)

%NSHAPE rearrange a multi-way array
%
% [Xf,DimXf] = nshape(X,f);

ord       = ndims(X);
DimX      = size(X);
varargout = [];
if nargin < 2
   f     = 0;
   do_it = ones(1,nargout);
else
   if length(f) == 1
      do_it = [1:ord] == f;
   end
end
if length(f) == 1
   for i = 1:ord
      if do_it(i)
         varargout{end+1} = reshape(permute(X,[i 1:i-1 i+1:ord]),DimX(i),prod(DimX([1:i-1 i+1:ord])));
      end
   end
   if nargin == 2
      varargout{2} = [DimX(f) DimX([1:f-1 f+1:ord])];
   end
else
   if length(f)==ord
      DimX         = DimX(f);
      varargout{1} = reshape(permute(X,f),DimX(1),prod(DimX(2:end)));
      if nargin == 2
         varargout{2} = DimX;
      end
   else
      error(['f can either be the dimension to be put first or',char(10),...
            'a vector containing the new order of the dimensions']);
   end
end