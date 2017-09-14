function C = roundby(A,B)
%ROUNDBY Round to nearest multiple.
%   ROUNDBY(A,B) rounds each element of A to the nearest multiple of 
%   corresponding element of B.

% check input arguments
error(nargchk(2,2,nargin))

if ~isnumeric(A) || ~isreal(A)
    error('A must be numeric and real.')

elseif ~isnumeric(B) || ~isreal(B)
    error('B must be numeric and real.')
end

if isscalar(B)
    B = repmat(B,size(A));
end

if ~isequal(size(A),size(B))
    error('Array dimensions must agree.')
end

% round to nearest multiple
C = round(A./B).*B;
