function n = ncol(M)
%NCOL Number of columns of a matrix.

if ~ismatrix(M)
    error('M must be a matrix.')
end

n = size(M,2);
