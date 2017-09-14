function tf = myreal(X)
%MYREAL True for real numeric array.
%   MYREAL(X) requires that X is both real and numeric. Overloads the
%   built-in function, which counts character and logical arrays as real.

tf = builtin('isreal',X) && isnumeric(X);