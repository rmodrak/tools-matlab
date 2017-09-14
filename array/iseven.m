function TF = iseven(X,tol)
%ISEVEN True for even integers.
%   ISEVEN(X) indicates which elements of X are even integers.

% check input arguments
error(nargchk(1,2,nargin))

if nargin == 1
    TF = myinteger(X) & (round(rem(X,2)) == 0);

elseif nargin == 2
    TF = myinteger(X,tol) & (round(rem(X,2)) == 0);
    
end
