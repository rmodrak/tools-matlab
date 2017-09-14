function tf = ispair(A)
%ISPAIR True for vectors with exactly two elements.

if isvector(A) && length(A) == 2
    tf = true;
else
    tf = false;
end
