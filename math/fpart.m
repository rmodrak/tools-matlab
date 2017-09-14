function B = fpart(A)
%FPART  Fractional part.

% check input arguments
if ~isnumeric(A)
    error('A must be numeric.')
end

B = A - fix(A);