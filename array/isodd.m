function TF = isodd(X,tol)
%ISODD True for odd integers.
%   ISODD(X) indicates which elements of I are odd integers.

% check input arguments
error(nargchk(1,2,nargin))

if nargin == 1
    TF = myinteger(X) && (round(rem(X,2)) == 1);

elseif nargin == 2
    TF = myinteger(X,tol) && (round(rem(X,2)) == 1);
    
end
