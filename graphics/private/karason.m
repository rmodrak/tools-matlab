function varargout = karason(d)
%KARASON Karason color map.
%   KARASON(D) returns color map with D+1 white values at center based on
%   red and blue color scheme designed by Karason.
%
%   fjsimons-at-alum.mit.edu

if ~nargin || isempty(d)
    d = 0;
end

try
  load('karason')
catch
  error('Could not open file ''karason''.')
end

if d > 0
  lk = length(c);
  c(round((lk-d)/2):round((lk+d)/2),:) = ones(d+1,3);
end

if ~nargout
  colormap(c)
end

fake=NaN;
varns={c,fake,fake};
varargout=varns(1:nargout);
