function B = scale(A,lim)
%SCALE scales array.
%   B = SCALE(A,LIM) scales each element of A in such a way that
%   MIN(B(:)) = LIM(1), MAX(B(:)) = LIM(2). 

% check input arguments
error(nargchk(1,2,nargin))

if numel(lim) ~= 2
    error('Argument must be a 2-element vector.')
end

if nargin < 2
    lim = [-1 1];
end

B = lim(1) + (A-min(A(:)))*diff(lim)/diff(minmax(A));
