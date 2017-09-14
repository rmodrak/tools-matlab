function B = inner(A,nt,nb,nl,nr)
%INNER Extracts inner entries of matrix.
%   INNER returns a matrix of same size as the original with zeros on the
%   boundary.

B=zeros(size(A));
B(1+nt:end-nb,1+nl:end-nr) = A(1+nt:end-nb,1+nl:end-nr);
