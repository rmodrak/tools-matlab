function w = correlate(u,v)
%CORRELATE Cross correlates two vectors.

% check input arguments
error(nargchk(2,2,nargin));

if ~isvector(u)
    error('U must be a vector.');

elseif ~isvector(v)
    error('V must be a vector.');
end

w = conv(u,flipvec(v));
