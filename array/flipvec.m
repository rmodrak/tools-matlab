function vt = flipvec(v)
%FLIPVEC Flips vector.
%   FLIPVEC(V) flips V, regardless of whether it is a column or row vector.

if iscolumn(v)
    vt = flipud(v);
elseif isrow(v)
    vt = fliplr(v);
else
    error('V must be a vector.');
end
