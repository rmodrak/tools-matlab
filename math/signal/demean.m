function B = demean(A)
%DEMEAN Subtracts the mean from an array.

B = A - mean(A(:));
