function n = nrow(M)
%NROW Number of rows of a matrix.

if ~ismatrix(M)
    error('M must be a matrix.')
end

n = size(M,1);
