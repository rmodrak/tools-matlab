function B = ipart(A)
%IPART Integer part.

% check input arguments
if ~isnumeric(A)
    error('A must be numeric.')
end

B = fix(A);