function y = mvnpdf_bis(x, mu, sigma)
%MVNPDF Multivariate normal probability density function.
%
%   Y = MVNPDF(X, MU, SIGMA) returns the multivariate normal probability
%   density.  X is an N-by-P matrix of values (each value is a 1-by-P
%   vector), MU is the 1-by-P mean parameter vector , and SIGMA is the
%   P-by-P covariance matrix.
%
%   If SIGMA is omitted, a P-by-P identity matrix is used for SIGMA.
%   If MU is omitted, a 1-by-P zero vector is used for MU.
%
%   Note that MU might be N-by-P to indicate that each value has a
%   different expectation.  In this case X might be either N-by-P or
%   1-by-P.  If X is 1-by-P, it will be replicated N times to match the
%   size of MU.

   nargsin = nargin;
   error(nargchk(1, 3, nargsin));

   if isempty(x) | ndims(x) ~= 2
      error('X must be a row vector or a matrix and can not be empty.');
   end

   [rx, cx] = size(x);
   p = cx;                      % number of dimensions

   if nargsin == 1

      % This is the multivariate normal distribution with zero mean vector
      % and identity variance matrix (i.e., standard multivariate normal).

      discrim = sum(x .* x, 2);
      y = exp(-0.5 * discrim) ./ sqrt((2*pi)^p);

   elseif nargsin > 1

      if isempty(mu) | ndims(mu) ~= 2
         error('MU must be a row vector or a matrix and can not be empty.');
      end

      [rm, cm] = size(mu);

      if cm ~= cx
         error('MU must have the same number of columns as X.');
      end

      if rx == 1
         if rm ~= 1
            % X has one row, MU has multiple rows, so replicate X.
            x = x(ones(rm,1),:);
         end
      else
         if rm == 1
            % MU has one row, X has multiple rows, so replicate MU.
            mu = mu(ones(rx,1),:);
         else
            if rx ~= rm
               % Both X and MU have multiple rows, but they don't have the
               % same number of rows.
               error(['When both X and MU are matrices, they must have' ...
                      ' the same number of rows.']);
            end
         end
      end

      if nargsin == 2

         % This is the multivariate normal distribution with possibly
         % non-zero mean vector, but with identity variance matrix.

         x = x - mu;
         discrim = sum(x .* x, 2);
         y = exp(-0.5 * discrim) ./ sqrt((2*pi)^p);

      elseif nargsin > 2

         if isempty(sigma) | ndims(sigma) ~= 2
            error('SIGMA must be a square non-empty matrix.');
         end

         [rs, cs] = size(sigma);

         if rs ~= cs
            error('SIGMA must be a square non-empty matrix.');
         end

         if rank(sigma) < p
            error('SIGMA must be a positive definite matrix.');
         end

         % This is the general multivariate normal distribution.

         R = chol(sigma);
         det_sigma = prod(diag(R)) .^ 2;
         x = (x - mu) / R;
         discrim = sum(x .* x, 2);
         y = exp(-0.5 * discrim) / sqrt(det_sigma * (2*pi)^p);

      end

   end