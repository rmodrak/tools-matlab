function B = outer(A,nt,nb,nl,nr)
%OUTER Extracts outer entries of matrix.
%   Returns a matrix of same size as the original with zeros in the
%   interior.

B = A;
B(1+nt:end-nb,1+nl:end-nr) = 0;
