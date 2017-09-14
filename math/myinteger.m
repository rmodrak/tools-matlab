function TF = myinteger(X,tol)
%MYINTEGER True for floats sufficiently close to integers.
%   MYINTEGER(X,TOL) returns an array indicating which elements of X are
%   within TOL of the nearest integer.

% check input arguments
if nargin < 1
    error('Not enough input arguments.')
end

if nargin < 2
    if ~isinteger(X)
        tol = 0.5*eps(max(X(:)-min(X(:))))^(1/3);
    end
end

if isinteger(X)
    TF = true(size(X));

elseif isnumeric(X) && isreal(X)
    TF = (abs(X - round(X)) < tol);
    
else
    error('X must be numeric and real.')
    
end
