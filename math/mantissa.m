function B = mantissa(A)
%MANTISSA Base ten mantissa.

% check input arguments
if ~numeric(A) || ~isreal(A)
    error('A must be a real numeric array.')
end

B = A.*10.^(-log10(A));
