function T = tridiag(a,b,c,N)
%TRIDIAG  Creates tridiagonal matrix.
%   TRIDIAG(A,B,C) creates a tridiagonal matrix with superdiagonal, main
%   diagonal, and subdiagonal given by vectors A, B, C.
%
%   TRIDIAG(A,B,C,N) creates an N-by-N tridiagonal matrix with 
%   superdiagonal, main diagonal, and subdiagonal given by scalars A, B, C.

% check input arguments
if isscalar(a) && isscalar(b) && isscalar(c)
    a =  repmat(a,N-1,1);
    b =  repmat(b,N,1);
    c =  repmat(a,N-1,1);
elseif isvector(a) && isvector(b) && isvector(c)
    if  ~isequal( length(a), length(b)-1, length(c) )
        error('Vectors not of expected length.');
    end
else
    error('Arguments not of expected type.')
end

% create tridiagonal matrix
T = diag(a,1) + diag(b,0) + diag(c,-1);
